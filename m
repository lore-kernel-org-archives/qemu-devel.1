Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420C2C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 15:08:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E049218F0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 15:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMncO6vX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E049218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpwOW-0007KG-9o
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 11:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41154)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liq3ea@gmail.com>) id 1hpwOL-0006vY-9N
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:07:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1hpwOJ-0003ks-Up
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:07:49 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33818)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hpwOJ-0003jq-Op
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:07:47 -0400
Received: by mail-ot1-x343.google.com with SMTP id n5so44411986otk.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 08:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2k85w/C7di/Tw9Z13nrvDOkx+BZUmfSkhO0PlJuEc7Q=;
 b=dMncO6vX4a3H2iQSsTwzyxRvKY90vbUbVfS+ut+YFr4Kz/NmuzByzslqKk7b0YwKm8
 81fr9QWizGv1jgB8eStFiHeQPYqqpTOE8mE5GwvFtByckoepVuBv8uq7CR2dZfER2iGe
 LnXyU6hTlq4MrcozPOuESlNbc2HUyuSJw8iHU6Of/Du4RCHopiZ1h1d2hlaog6PnW8YB
 QuyuVwzeXOZnZE/Ia0eBo/q0uk89A4hCVuJEsjnwkdCdQv5nJXmwYzSLskFPE2nGGS2I
 ztGkXnJZRXlrnyQynqXOHtM0mO2N36D0MnoOD46+zutTzNlcEdtTYxJ8mxA0N8g7Vw5Q
 crzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2k85w/C7di/Tw9Z13nrvDOkx+BZUmfSkhO0PlJuEc7Q=;
 b=Hx7MdQjO2mCjBs8Bbi1ItchGs4H+pNrO/1sI6bQ1WML6z6U3Xi/v5Mxay3KUzjOxcs
 ZEpIs5CnscdRDhu2/bf1ExLoH7Py9wet3jrhus+2NkW1p/ZD67GbcK12lG163XB+844L
 fa/RlSM2bXG3D+SUCXydhVW+vLXlGeNXpYGgPhTJUOOXg375kTUdgpUGE4UsP38gRmeK
 lNRzKrnVqI7xDXZlRoGJ4p5D9QDr8v9WQXvR/4yadvVdd2KR1b5iaqY/BzX59EIXscl/
 qW1HycWqB4FTf31M9CNuuDT/8wsY2O4Q9b6S4eh4oBNrQ2Oosz/ay8uIxVJYZuclHTIG
 zcRA==
X-Gm-Message-State: APjAAAUKMNIYehZQXvxjjpPOOIP061yQ4CPZgPluGE8rtCKK4k3ih6f0
 AuXjzT5MNkd8GzCtLopmqTmPqkx2Gjh+WADtFtU=
X-Google-Smtp-Source: APXvYqxnGnAPcON3HykWYNoBlTBXEbICBu+qxwmVNTr5hZkqa0f6ye4mw/j/fYM19ePe56cYewPkUmRM8uOep470Mvs=
X-Received: by 2002:a9d:6194:: with SMTP id g20mr4424788otk.149.1563894466463; 
 Tue, 23 Jul 2019 08:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190723104754.29324-1-ppandit@redhat.com>
 <20190723104754.29324-2-ppandit@redhat.com>
In-Reply-To: <20190723104754.29324-2-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 23 Jul 2019 23:07:10 +0800
Message-ID: <CAKXe6SKW+VsqoGzPPDwG5nubjKvOGtBnUY6+s1WZ=vpYwwVFEg@mail.gmail.com>
To: P J P <ppandit@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v4 1/3] qemu-bridge-helper: restrict
 interface name to IFNAMSIZ
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Riccardo Schirone <rschiron@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

P J P <ppandit@redhat.com> =E4=BA=8E2019=E5=B9=B47=E6=9C=8823=E6=97=A5=E5=
=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=886:50=E5=86=99=E9=81=93=EF=BC=9A

> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> The network interface name in Linux is defined to be of size
> IFNAMSIZ(=3D16), including the terminating null('\0') byte.
> The same is applied to interface names read from 'bridge.conf'
> file to form ACL rules. If user supplied '--br=3Dbridge' name
> is not restricted to the same length, it could lead to ACL bypass
> issue. Restrict interface name to IFNAMSIZ, including null byte.
>
> Reported-by: Riccardo Schirone <rschiron@redhat.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>


Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  qemu-bridge-helper.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> Reviewed v3
>   ->
> https://lists.nongnu.org/archive/html/qemu-devel/2019-07/msg00245.html
>
> diff --git a/qemu-bridge-helper.c b/qemu-bridge-helper.c
> index f9940deefd..e90c22f07d 100644
> --- a/qemu-bridge-helper.c
> +++ b/qemu-bridge-helper.c
> @@ -109,6 +109,13 @@ static int parse_acl_file(const char *filename,
> ACLList *acl_list)
>          }
>          *argend =3D 0;
>
> +        if (!g_str_equal(cmd, "include") && strlen(arg) >=3D IFNAMSIZ) {
> +            fprintf(stderr, "name `%s' too long: %zu\n", arg,
> strlen(arg));
> +            fclose(f);
> +            errno =3D EINVAL;
> +            return -1;
> +        }
> +
>          if (strcmp(cmd, "deny") =3D=3D 0) {
>              acl_rule =3D g_malloc(sizeof(*acl_rule));
>              if (strcmp(arg, "all") =3D=3D 0) {
> @@ -259,6 +266,10 @@ int main(int argc, char **argv)
>          usage();
>          return EXIT_FAILURE;
>      }
> +    if (strlen(bridge) >=3D IFNAMSIZ) {
> +        fprintf(stderr, "name `%s' too long: %zu\n", bridge,
> strlen(bridge));
> +        return EXIT_FAILURE;
> +    }
>
>      /* parse default acl file */
>      QSIMPLEQ_INIT(&acl_list);
> --
> 2.21.0
>
>
