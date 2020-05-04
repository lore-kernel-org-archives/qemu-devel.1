Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEB5C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85BFB20752
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VT7dzljG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85BFB20752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbLM-0006Ok-K1
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 09:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jVbKc-0005tQ-RF
 for qemu-devel@nongnu.org; Mon, 04 May 2020 09:40:26 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38415)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jVbKb-00063x-Uv
 for qemu-devel@nongnu.org; Mon, 04 May 2020 09:40:26 -0400
Received: by mail-wm1-x344.google.com with SMTP id g12so9069142wmh.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 06:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=cAbivncbEAo9S3xiviP7VEpg83f1JQxDekJn0sK5cks=;
 b=VT7dzljGuWz0/8OaJqFz8YY03bUOnG+eAqubcIm+7As4V3GSaBubBdG9X8+5GvmGpd
 /ftxRdHJXb/R2RM3mXbJRgagcO8CRXdL6pLek9pfLm3Pgs8TuiS3fQcBXwEL+9GDTjcG
 MUF9oLG8q/e25FcXLeNeFEA7lpy3Cg8+jVjhWi8dvke3AUlvHDc+11H/tSQ8205bZsWv
 1TkEjd3I1e/BXewTHTO6Tr4jGvB4hEfG5ObmpQ1QB0pE4O6F4L1X0JDvArEtF0B3lWdZ
 8IMJRIWBTpWzL33sUh3VjSHuLGUlvg40sn1AnCMJE7n9b/OM5vqzNdt/xy3uNuf6RYFn
 WY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cAbivncbEAo9S3xiviP7VEpg83f1JQxDekJn0sK5cks=;
 b=UYx6FaqQPpcIyFZ5ptVEFdAl6A929qIe4GyU+BI52bS2UiWab/xmniqDMWe5Bk480Q
 SkbNxQWdrahB4q78bLW46gLUu+97eT+1TImfIQV+LGJVKxWku46DN7cnXBpiQWi5ScyP
 G9nvBSl0Q6GhPoA8iVfAHFQFSS6E6HYeSAY5LTwqpWd3tMOJJFsOsvP2HZfybJgcX/Da
 8+fpol3nQIfV7rqlShkfdk1ZzzIoHl3GWNO6iGvrPOiA2bkZFyUp5cJRaqkqfJ9gvrZG
 pUXoSJLVZnO1swBWMjDa4p5Yiui2tCSy9F6Vo7Q760Lt4vBsnKuhJoNdeWhffF4xGs2b
 gmZA==
X-Gm-Message-State: AGi0PubnJ8n9F3A6tbceBiVel3y2S6vNTwbnJ2dIoFIljMuUZYqXVDlq
 HUDZEnHo+bioF75cwT9/4dM=
X-Google-Smtp-Source: APiQypLvjmkb3p5o8VgSyXJUzJCPS3VHXoC2/KQF0z5Nb3tM8F+r8Pd22ODVNf0QzCpz05wfenTvgw==
X-Received: by 2002:a05:600c:2f17:: with SMTP id
 r23mr14047894wmn.81.1588599624521; 
 Mon, 04 May 2020 06:40:24 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id n9sm6541933wrv.43.2020.05.04.06.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 06:40:23 -0700 (PDT)
Date: Mon, 4 May 2020 14:40:21 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH] chardev: enable distinct input for -chardev file
Message-ID: <20200504134021.GH354891@stefanha-x1.localdomain>
References: <20200501172559.6470-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1EKig6ypoSyM7jaD"
Content-Disposition: inline
In-Reply-To: <20200501172559.6470-1-alxndr@bu.edu>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--1EKig6ypoSyM7jaD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2020 at 01:25:59PM -0400, Alexander Bulekov wrote:
> char-file already supports distinct paths for input/output but it was
> only possible to specify a distinct input through QMP. With this change,
> we can also specify a distinct input with the -chardev file argument:
>     qemu -chardev file,id=3Dchar1,path=3D/out/file,in=3D/in/file
>=20
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  chardev/char-file.c | 5 +++++
>  chardev/char.c      | 3 +++
>  qemu-options.hx     | 7 +++++--
>  3 files changed, 13 insertions(+), 2 deletions(-)
>=20
> The naming here is awkward, with path=3D really turning into "out" when
> in=3D is specified, though i'm not sure about what is a good solution.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--1EKig6ypoSyM7jaD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6wG0UACgkQnKSrs4Gr
c8gIGwf/YWyKGguPwOvWnUynz4X6w+62Gf7IsKmIJZ8mx4C/GBhnLInVqtV9oxXM
GYv0AX66Ucu4dSAK+Nrmg+V7y0OHVC+Pcpmxvuem3sYiUMN3dsNX+ppgcO/kO0Gv
Muuj+5ee7zcEIomRKz+z1aBakyoACjhXWbPzWPyRR8BaWusx54OYZS60SWiWDMss
ScLulzY1FIkfsdGA48jf8j0ydx7OQjxUfRAQc/Rd2Fnfh5bHtGym6KaBFPYgcb/I
vApsfqNOIDczZPi/rBGk9/HHXwHkWhZSuqQN9cV5FGg3z9CSDOviAl/pEX8ATLO0
2f4MGyNSZOIwdFVU32/wdjgHcWKroA==
=ElV+
-----END PGP SIGNATURE-----

--1EKig6ypoSyM7jaD--

