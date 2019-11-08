Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF125C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:03:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9C69206BA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKF+hAnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C69206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT239-0006NS-PZ
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 06:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iT21I-0005Ba-4K
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:01:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iT21C-00041j-Rd
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:01:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32410
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iT21C-00041G-LU
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573210888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zHotrVHEOJS7m1LBA5pkIhUuJtFPdGlBpbSXJbVsF8o=;
 b=iKF+hAnCk9OJph7oVcdjzVpLtZg4LMHKJHFHnQZge6OiFCLMGkWnWEtT59kdpfX6OrZrsH
 tMvVlNv33Ds7R3F7JZeRwrjhRhRBqC8XnYb/6zkP5Cv8QQocKW/pswoFHaoU1QshLxt5JG
 L70EABuyFglA3uBY3jpBY2l1owHOeL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-2OaCWWXiONWy2BBSgdULoQ-1; Fri, 08 Nov 2019 06:01:25 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 330A51005500;
 Fri,  8 Nov 2019 11:01:24 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-227.ams2.redhat.com
 [10.36.117.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E2E84271B2;
 Fri,  8 Nov 2019 11:01:16 +0000 (UTC)
Subject: Re: [PATCH] configure: Check bzip2 is available
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191108102805.8258-1-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <862eb773-609d-4250-b46b-d922fc5a86a7@redhat.com>
Date: Fri, 8 Nov 2019 12:01:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191108102805.8258-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 2OaCWWXiONWy2BBSgdULoQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/08/19 11:28, Philippe Mathieu-Daud=C3=A9 wrote:
> The bzip2 tool is not included in default installations.
> On freshly installed systems, ./configure succeeds but 'make'
> might fail later:
>=20
>     BUNZIP2 pc-bios/edk2-i386-secure-code.fd.bz2
>   /bin/sh: bzip2: command not found
>   make: *** [Makefile:305: pc-bios/edk2-i386-secure-code.fd] Error 127
>   make: *** Deleting file 'pc-bios/edk2-i386-secure-code.fd'
>   make: *** Waiting for unfinished jobs....
>=20
> Add a check in ./configure to warn the user if bzip2 is missing.

We've come full circle. Let me explain:

>=20
> Fixes: 536d2173b2b

So this makes me kinda grumpy. If you look at the v3 posting of the patch t=
hat would later become commit 536d2173b2b:

  http://mid.mail-archive.com/20190321113408.19929-8-lersek@redhat.com

you see the following note in the changelog:

    - compress FD files with bzip2 rather than xz, so that decompression at
      "make install" time succeed on older build OSes too [Peter]

So I couldn't use xz because that was "too new" for some build OSes, but no=
w we also can't take bzip2 for granted because that's "too old" for some ot=
her build OSes? This is ridiculous.

To be clear, my disagreement is only with the "Fixes" tag. For me, "Fixes" =
stands for something that, in retrospect, can be proven to have been a bug =
at the time the code was *originally* committed. But, at the time, taking "=
bzip2" for granted was *not* a bug. The conditions / circumstances have cha=
nged more recently, and the assumption about bzip2 has been invalidated *af=
ter* adding a dependency on bzip2.

Nonetheless, thank you for adapting the code to the potential absence of bz=
ip2. Can you perhaps go in some details in the commit message, near "not in=
cluded in default installations" and "freshly installed systems"? If we can=
, we should identify the exact distro release where this problem has been e=
ncountered (and I wouldn't mind a link to the BZ or ticket under which peop=
le agreed to remove bzip2 from the default package set).

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo

> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  configure | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/configure b/configure
> index efe165edf9..9957e913e8 100755
> --- a/configure
> +++ b/configure
> @@ -1851,6 +1851,13 @@ python_version=3D$($python -c 'import sys; print("=
%d.%d.%d" % (sys.version_info[0]
>  # Suppress writing compiled files
>  python=3D"$python -B"
> =20
> +# Some firmware binaries are compressed with bzip2
> +if has bzip2; then
> +  :
> +else
> +  error_exit "bzip2 program not found. Please install it"
> +fi
> +
>  # Check that the C compiler works. Doing this here before testing
>  # the host CPU ensures that we had a valid CC to autodetect the
>  # $cpu var (and we should bail right here if that's not the case).
>=20


