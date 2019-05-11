Return-Path: <SRS0=nJ0+=TL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BA1C04AB1
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 12:48:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49A0121841
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 12:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYbCclxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A0121841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58468 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPRQ3-0006IL-GD
	for qemu-devel@archiver.kernel.org; Sat, 11 May 2019 08:48:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hPRPD-0005zj-Qd
	for qemu-devel@nongnu.org; Sat, 11 May 2019 08:47:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hPRPC-0006E7-Oy
	for qemu-devel@nongnu.org; Sat, 11 May 2019 08:47:11 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hPRPC-0006DU-I6
	for qemu-devel@nongnu.org; Sat, 11 May 2019 08:47:10 -0400
Received: by mail-oi1-x244.google.com with SMTP id w144so881830oie.12
	for <qemu-devel@nongnu.org>; Sat, 11 May 2019 05:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=hgG7cQlxNr5O/sNft0LqiL5+KSA7wdJgK4jTSKQjL1E=;
	b=hYbCclxoCalDUEVpvtIVpeNA6RjpVxIDVRt0hn8m+a5XCBjBUdkBYJrO5OWceFigwd
	tO5xrle5rhspu1IG0lho009sHb4qqO+Ia2iU3pM++/z4SDkTF1wNHF60KP2JsnvuHDOl
	yrvmgF/Mpyovsn/34Ak1/+I3UA1RjY/YjRp/lrxwpprN+io4QqhcbzyEhiLsX13iY4wR
	poBkTsxHhKiE9l9K7/upgli1EWC9S0k+S5a+HRdMZLzWQ0lki/K5OpU5HWsq+6BXKOnC
	Rqz76WKwh3KB7cMNYbuTinSme4byNGplOTrFs0aiM1HGAZkUGkGHjRcTOvu6iD79jdgB
	ovKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=hgG7cQlxNr5O/sNft0LqiL5+KSA7wdJgK4jTSKQjL1E=;
	b=J2Z/DQKDBp0AS66TAsCKwFYnYrUL4KPkeGmawWJUc/JfMqFhBYs3ikAzM5Z03duiVM
	CfvgL/XyoJRvZnzJnFSA28b4FWAzcsfc5sgRGmjVL6QlMVkzJPp8UGkcM7a2I1OpGYgd
	Y0Fho9TpzGc9Z3eDZoSF5wYz+OccDFDhV4Pd9IoNACIOxhu5S/TxukTV1A3rzIJr8yzH
	QwAfL30dQXevTLMy3sTjwQ6zuqzUx14JPn0s1vtnysAp6cItZe0SdVjqSrNd5FpD7EcS
	x/McgVHfdc/L2MQx3SPgM75U5ZvMs+hmgr7M93q5coZRWGvZzPc2rR3r2PdB0Bnbo6Kg
	10xw==
X-Gm-Message-State: APjAAAWWipb5tFvGj37fyfiEgXtwVMTyj7v6aPSYDWNxwdGIX0ZDPr7b
	A2oc5SN5HwT8n9TjV55jW9zGiRzjb2+Kiq+b97g=
X-Google-Smtp-Source: APXvYqzb6CQziAf7ZXD9DxScHY3zX6/RUFy5ZLdF6us5ALCAeJOQq+jHGUYmyEqk/FUvj6yyo7WN9Wp2FY7WiGxRKp4=
X-Received: by 2002:aca:6086:: with SMTP id u128mr7539306oib.79.1557578828713; 
	Sat, 11 May 2019 05:47:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Sat, 11 May 2019 05:47:07
	-0700 (PDT)
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Sat, 11 May 2019 05:47:07
	-0700 (PDT)
In-Reply-To: <20190510203452.11870-1-richard.henderson@linaro.org>
References: <20190510203452.11870-1-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 11 May 2019 14:47:07 +0200
Message-ID: <CAL1e-=hE4zMwDewsbD6=Kc32Ss9wcB-AyOtY-G=HhDKS9YMOoQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] configure: Disable slirp if
 --disable-system
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: samuel.thibault@ens-lyon.org, qemu-devel@nongnu.org,
	marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 10, 2019 10:36 PM, "Richard Henderson" <richard.henderson@linaro.org=
>
wrote:
>
> For linux-user, there is no need to add slirp to the set of
> git modules checked out, nor build it.
>
> This also avoids a makefile bug wrt insufficient dependencies
> on subdir-slirp.  If slirp/ is not initially present, the
> dependencies that check it out are associated with softmmu,
> which then generates a build error on slirp/ not present.
>

Hi,

Does this work if only user mode targets are specified via =CB=8A--target-l=
ist=CB=8A
switch? If no, the patch shoud be amended. If yes, the commit message
should be extended.

Thanks,
Aleksandar

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  configure | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/configure b/configure
> index 63f312bd1f..9de7e43a80 100755
> --- a/configure
> +++ b/configure
> @@ -5878,6 +5878,10 @@ fi
>  ##########################################
>  # check for slirp
>
> +if test "$softmmu" =3D "no"; then
> +    slirp=3Dno
> +fi
> +
>  case "$slirp" in
>    "" | yes)
>      if $pkg_config slirp; then
> --
> 2.17.1
>
>
