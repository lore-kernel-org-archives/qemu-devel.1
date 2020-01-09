Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81337C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 16:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FDEA20721
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 16:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQOfh+1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDEA20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipalZ-0000h1-E4
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 11:34:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ipakc-00080n-5w
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 11:33:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ipaka-0004qi-55
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 11:33:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48197
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ipakZ-0004ms-QI
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 11:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578587611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=ju1N1JnNydnUtdovHLvXkrBQkKDs4pRw0/f9Q0JbCxE=;
 b=LQOfh+1akfNbIeIRp6a8ZPtjmb8jJDd0zUr7nIV4faYKjFfwVWaLPi1waXFBUNsu/MEGoS
 xlPT9MDNCLKlj1xG2zYFEU0CB6z5mqWiJ34tq/Kx06bYqadNE+72ABIsH9cijc9Z5lnCWO
 Rxi6skqPHK8E5yJjoomO5PSScgQ+DRo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-L7ejZpu6MECVcu_EoIQFPQ-1; Thu, 09 Jan 2020 11:33:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E97218A2623;
 Thu,  9 Jan 2020 16:33:27 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-32.ams2.redhat.com [10.36.117.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82A8880609;
 Thu,  9 Jan 2020 16:33:23 +0000 (UTC)
Subject: Re: [PATCH 1/4] configure: Do not build libfdt is not required
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200109153939.27173-1-philmd@redhat.com>
 <20200109153939.27173-2-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <565ad81b-6bd2-246c-1303-39de53cd9fe3@redhat.com>
Date: Thu, 9 Jan 2020 17:33:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200109153939.27173-2-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: L7ejZpu6MECVcu_EoIQFPQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/01/2020 16.39, Philippe Mathieu-Daud=C3=A9 wrote:
> We only require libfdt for system emulation, in a small set
> of architecture:
>=20
> 4077  # fdt support is mandatory for at least some target architectures,
> 4078  # so insist on it if we're building those system emulators.
> 4079  fdt_required=3Dno
> 4080  for target in $target_list; do
> 4081    case $target in
> 4082      aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|=
mips64el-softmmu|riscv*-softmmu)
> 4083        fdt_required=3Dyes
>=20
> Do not build libfdt if we did not manually specified --enable-fdt.

I suggest to add:

"... or have one of the platforms that require it in our target list."

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  configure | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/configure b/configure
> index 0ce2c0354a..266a8386d1 100755
> --- a/configure
> +++ b/configure
> @@ -4092,6 +4092,8 @@ if test "$fdt_required" =3D "yes"; then
>        "targets which need it (by specifying a cut down --target-list)."
>    fi
>    fdt=3Dyes
> +elif test "$fdt" !=3D "yes" ; then
> +  fdt=3Dno
>  fi
> =20
>  if test "$fdt" !=3D "no" ; then
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>


