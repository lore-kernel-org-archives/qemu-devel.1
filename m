Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DC4C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 15:39:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8223821D56
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 15:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkJgBcbp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8223821D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8nA7-0003a3-O6
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 10:39:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j8n9L-0002ux-Md
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j8n9K-0007CV-Fr
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:38:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59611
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j8n9K-0007CC-Ck
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583163509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DWQ8gVvLLfQqfvHdzuWOMq7qS+YwT8W0uOt+xC5r3bk=;
 b=XkJgBcbp1a7s3gHjoqiUpkcMp0gKBHTJOqxoNJGpO0FqhdnCvoF4ezO00qDSyg7VyYDVJq
 I9O+r9Qdy48QHBGfxNKAJXKNamg5izj2Sozj7rkqjPA5qzOjvLcgMtaCcFklmhck29T+lB
 InQLQNl0Rk2kDEffcKhn2k2wiN4IavY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-NlgYS08yPJS-NPFTTnbEkg-1; Mon, 02 Mar 2020 10:38:27 -0500
X-MC-Unique: NlgYS08yPJS-NPFTTnbEkg-1
Received: by mail-wr1-f70.google.com with SMTP id o9so5979548wrw.14
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 07:38:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RQmfvm3+nvHt5Hq2exc3URwpZ39pGImLm5jyIC2zN5o=;
 b=UtQ0nuaE+DNZHUyCEzh7A8WbAQ9kvPViV/n2/4+lzL+uxSKfWsfkmZ0gElDjgINT2r
 fkab4h+OpNn9E9ZdBzugy97VJCf8cnxKmyae5lId4XKqQJk/crqOJbwHSe3/AwtvI/QI
 NoAC/2A4Exito6CE3EhJt8CvpUFA+4qAtPU9j2o3kz/l/rD6XwdKY7RuXfXHXYX1auUV
 W0p1oF5O+GHmcqOhcDGpwFbwqV4Aw8g//pWT+x3sxZgziPjnmGKzHZU2E2h+N1xd/29K
 Z7MKItn1jSK1z1dhviKtuWl/fAGaKkmvvIDpUkgYx2hHh9hXy+g6RbF9LgkdkOenWKDX
 JsBg==
X-Gm-Message-State: ANhLgQ2PRDwwa7exkz/3qRI1RXWZAwJvVqbWwy7LKrcUgqzHYTN3wYDQ
 8OT66omVMyWuvY9fFUIdP/2B0SPLz0WjvP5Ggoe6kTbKwg3ZOpkGn9fyF7L9E7Gqh/1SOXb9S53
 oe7Yf+8BuNqyOFtw=
X-Received: by 2002:adf:ce8c:: with SMTP id r12mr176075wrn.189.1583163506303; 
 Mon, 02 Mar 2020 07:38:26 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuQsDd9FkShwrDw46rjZX27kS1IZtmNKk9ByYWO1Hff4KaJxPI/yoJoiueINp3/LjH5btkhCw==
X-Received: by 2002:adf:ce8c:: with SMTP id r12mr176050wrn.189.1583163505909; 
 Mon, 02 Mar 2020 07:38:25 -0800 (PST)
Received: from [192.168.178.40] ([151.30.85.6])
 by smtp.gmail.com with ESMTPSA id s5sm27055572wru.39.2020.03.02.07.38.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 07:38:25 -0800 (PST)
Subject: Re: [PATCH] scsi/qemu-pr-helper: Fix out-of-bounds access to
 trnptid_list[]
To: Christophe de Dinechin <dinechin@redhat.com>, qemu-devel@nongnu.org
References: <20200228150059.2644362-1-dinechin@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eb3c95c3-6576-c75b-456b-2996c1a42654@redhat.com>
Date: Mon, 2 Mar 2020 16:38:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200228150059.2644362-1-dinechin@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, qemu-stable <qemu-stable@nongnu.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/02/20 16:00, Christophe de Dinechin wrote:
> Compile error reported by gcc 10.0.1:
>=20
> scsi/qemu-pr-helper.c: In function =E2=80=98multipath_pr_out=E2=80=99:
> scsi/qemu-pr-helper.c:523:32: error: array subscript <unknown> is outside=
 array bounds of =E2=80=98struct transportid *[0]=E2=80=99 [-Werror=3Darray=
-bounds]
>   523 |             paramp.trnptid_list[paramp.num_transportid++] =3D id;
>       |             ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from scsi/qemu-pr-helper.c:36:
> /usr/include/mpath_persist.h:168:22: note: while referencing =E2=80=98trn=
ptid_list=E2=80=99
>   168 |  struct transportid *trnptid_list[];
>       |                      ^~~~~~~~~~~~
> scsi/qemu-pr-helper.c:424:35: note: defined here =E2=80=98paramp=E2=80=99
>   424 |     struct prout_param_descriptor paramp;
>       |                                   ^~~~~~

Ouch.  Very nice new warning.

Cc: qemu-stable@nongnu.org

Queued, thanks.

> This highlights an actual implementation issue in function multipath_pr_o=
ut.
> The variable paramp is declared with type `struct prout_param_descriptor`=
,
> which is a struct terminated by an empty array in mpath_persist.h:
>=20
>         struct transportid *trnptid_list[];
>=20
> That empty array was filled with code that looked like that:
>=20
>         trnptid_list[paramp.descr.num_transportid++] =3D id;
>=20
> This is an actual out-of-bounds access.
>=20
> The fix is to replace `paramp` with an anonymous struct that adds
> additional space for the data, called `trnptid_list_storage`.
> That space provides MATH_MX_TIDS entries, and is not accessed directly
> but through a pointer to `descr.trnptid_list`, in the unlikely case a
> future compiler inserts some padding between the two structs.
>=20
> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
> ---
>  scsi/qemu-pr-helper.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
> index 0659ceef09..01013221b3 100644
> --- a/scsi/qemu-pr-helper.c
> +++ b/scsi/qemu-pr-helper.c
> @@ -421,7 +421,12 @@ static int multipath_pr_out(int fd, const uint8_t *c=
db, uint8_t *sense,
>      int rq_servact =3D cdb[1];
>      int rq_scope =3D cdb[2] >> 4;
>      int rq_type =3D cdb[2] & 0xf;
> -    struct prout_param_descriptor paramp;
> +    struct
> +    {
> +        struct prout_param_descriptor descr;
> +        struct transportid *trnptid_list_storage[MPATH_MX_TIDS];
> +    } paramp;
> +    struct transportid **trnptid_list =3D paramp.descr.trnptid_list;
>      char transportids[PR_HELPER_DATA_SIZE];
>      int r;
> =20
> @@ -455,9 +460,9 @@ static int multipath_pr_out(int fd, const uint8_t *cd=
b, uint8_t *sense,
>       * do the opposite).
>       */
>      memset(&paramp, 0, sizeof(paramp));
> -    memcpy(&paramp.key, &param[0], 8);
> -    memcpy(&paramp.sa_key, &param[8], 8);
> -    paramp.sa_flags =3D param[20];
> +    memcpy(&paramp.descr.key, &param[0], 8);
> +    memcpy(&paramp.descr.sa_key, &param[8], 8);
> +    paramp.descr.sa_flags =3D param[20];
>      if (sz > PR_OUT_FIXED_PARAM_SIZE) {
>          size_t transportid_len;
>          int i, j;
> @@ -520,12 +525,13 @@ static int multipath_pr_out(int fd, const uint8_t *=
cdb, uint8_t *sense,
>                  return CHECK_CONDITION;
>              }
> =20
> -            paramp.trnptid_list[paramp.num_transportid++] =3D id;
> +            assert(paramp.descr.num_transportid < MPATH_MX_TIDS);
> +            trnptid_list[paramp.descr.num_transportid++] =3D id;
>          }
>      }
> =20
>      r =3D mpath_persistent_reserve_out(fd, rq_servact, rq_scope, rq_type=
,
> -                                     &paramp, noisy, verbose);
> +                                     &paramp.descr, noisy, verbose);
>      return mpath_reconstruct_sense(fd, r, sense);
>  }
>  #endif
>=20


