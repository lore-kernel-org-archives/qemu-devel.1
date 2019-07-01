Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A0EC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E4A20659
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puh4ab4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E4A20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhyCV-000371-8x
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 11:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38889)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liq3ea@gmail.com>) id 1hhyAD-0001RL-Er
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1hhyAC-0005ms-6D
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:24:17 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37284)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hhyAB-0005mK-Vd
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:24:16 -0400
Received: by mail-ot1-x344.google.com with SMTP id s20so13886098otp.4
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 08:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qqurb8aC0cVgVmsJ3PVcbWsIjutLeguCZwrglig7VYs=;
 b=puh4ab4y5t4XJoSSvSW87gzKN1VSNbDWK0gzrOY+QPA2V5Sk3Vk3lED2xd8oXVtwjy
 DcO9DRj6Q0AkWJEokNdfqSwsr1jLunpPrIAfY7dirHgoAyr+LLCwZu6w0EeiOXzuGoMb
 3l4NpRD5+VsFm6uYHqwdqMBbc/twckBIyP05B3DlK73wJUm3QO1cNnLe1AdEeXTpy47+
 h5UdOgs8C+xrX5GPPe1ncwnmCOKZ9AQHRIvWq4mTbWwMJhfisLPQZU6icPhAtGaDwMKa
 H1eedSHbaY82PZb+Sgbtm7NZtsUPoPEKeLnqk9PiIh459goI4yH3aq1beatIy76nrBrI
 PWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qqurb8aC0cVgVmsJ3PVcbWsIjutLeguCZwrglig7VYs=;
 b=n8xCf5in68hcyHvQDsvzeG2vbIp0PtkqCYJZWjjvtNZIka9D/WS+KgK8zGMJuDP42B
 JmflKxauGnjre1t4yxbsb84xqzfp4PH0LbP6pHrKrefuIY4P7oXe9Aa/QsZcn2osUcwn
 WsbET7d2dl4dr8QUpLd/+GnpalX0S5AKkW5XZCfVKNGTJHm5pS/GHOcy2BH+Vy1lFTte
 3ivcyc18gOFhb2XZy1d+HtObJnxr+G6tCtOR7Sh5flDnAquKsVlKGxmDSXvKMpyJ+rza
 Xx8O3e95/KkmDsfCNaa3LobNMv1I3xAyG9PZAjIhwJihvPwUxexj5WCuZa6cJMeKQ7dE
 /sQw==
X-Gm-Message-State: APjAAAWSWmS7QeJGBM62Rv5RnatJMROojMghQOlQ4M9+0LvdRKiFPpr0
 vkyroyYAX3yYuCTdhBO0zesruHQmqwhGVX+Mdz0=
X-Google-Smtp-Source: APXvYqyo/M+1biuCq+HPdue3r2ukqZvgES6mhBsc2CA5GiTTk6ExSyx47+6bVhtbQkQgAJhyKXO38rVF5xIbw4JHvrk=
X-Received: by 2002:a05:6830:1141:: with SMTP id
 x1mr19612442otq.333.1561994655128; 
 Mon, 01 Jul 2019 08:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190701123558.30512-1-ppandit@redhat.com>
 <20190701123558.30512-3-ppandit@redhat.com>
In-Reply-To: <20190701123558.30512-3-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 1 Jul 2019 23:23:39 +0800
Message-ID: <CAKXe6SKx8OS__u_VywZ8fe9EXWQbbE5XRhh5NLhPOLJkV+2+Yw@mail.gmail.com>
To: P J P <ppandit@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v3 2/3] qemu-bridge-helper: move repeating
 code in parse_acl_file
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
 Qemu Developers <qemu-devel@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

P J P <ppandit@redhat.com> =E4=BA=8E2019=E5=B9=B47=E6=9C=881=E6=97=A5=E5=91=
=A8=E4=B8=80 =E4=B8=8B=E5=8D=888:38=E5=86=99=E9=81=93=EF=BC=9A

> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Move repeating error handling sequence in parse_acl_file routine
> to an 'err' label.
>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>

Reviewed-by: Li Qiang <liq3ea@gmail.com>




> ---
>  qemu-bridge-helper.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/qemu-bridge-helper.c b/qemu-bridge-helper.c
> index e90c22f07d..91a02f9611 100644
> --- a/qemu-bridge-helper.c
> +++ b/qemu-bridge-helper.c
> @@ -92,9 +92,7 @@ static int parse_acl_file(const char *filename, ACLList
> *acl_list)
>
>          if (arg =3D=3D NULL) {
>              fprintf(stderr, "Invalid config line:\n  %s\n", line);
> -            fclose(f);
> -            errno =3D EINVAL;
> -            return -1;
> +            goto err;
>          }
>
>          *arg =3D 0;
> @@ -111,9 +109,7 @@ static int parse_acl_file(const char *filename,
> ACLList *acl_list)
>
>          if (!g_str_equal(cmd, "include") && strlen(arg) >=3D IFNAMSIZ) {
>              fprintf(stderr, "name `%s' too long: %zu\n", arg,
> strlen(arg));
> -            fclose(f);
> -            errno =3D EINVAL;
> -            return -1;
> +            goto err;
>          }
>
>          if (strcmp(cmd, "deny") =3D=3D 0) {
> @@ -139,15 +135,18 @@ static int parse_acl_file(const char *filename,
> ACLList *acl_list)
>              parse_acl_file(arg, acl_list);
>          } else {
>              fprintf(stderr, "Unknown command `%s'\n", cmd);
> -            fclose(f);
> -            errno =3D EINVAL;
> -            return -1;
> +            goto err;
>          }
>      }
>
>      fclose(f);
> -
>      return 0;
> +
> +err:
> +    fclose(f);
> +    errno =3D EINVAL;
> +    return -1;
> +
>  }
>
>  static bool has_vnet_hdr(int fd)
> --
> 2.21.0
>
>
