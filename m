Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635A5C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3260321848
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5Aaobxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3260321848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT1bv-0004Zq-Bc
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 05:35:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iT1ax-00045y-QM
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:34:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iT1aw-0008Gj-QN
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:34:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27133
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iT1aw-0008GT-Lv
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573209261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8G1PM5EQl8J6qArYsLyc5k/Nhp/n08PjiD1bbXohHdU=;
 b=I5AaobxqPdbKMcU7Fl/l+8zqYu5XhnSgwNncUfuj5jQ7aZB5UPinJz8kCc4jncb5/ID5R1
 Qg8CRF/oOtKSdLBG8ePOse6lROmmcO8T5ltceSbTxDL1ra3XWSHsBwTA8b4aGuEBtigVAm
 v3VnO5tFny1akQMMcg3vUkSZjy/09Mo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-_pV603xUOwOfk8nJVFkazw-1; Fri, 08 Nov 2019 05:34:20 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65903800C72;
 Fri,  8 Nov 2019 10:34:18 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-167.ams2.redhat.com
 [10.36.116.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E1435DA7E;
 Fri,  8 Nov 2019 10:34:11 +0000 (UTC)
Subject: Re: [PATCH] configure: Check bzip2 is available
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
References: <20191108102805.8258-1-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b6005d59-c5d2-1844-db94-a67e258c2867@redhat.com>
Date: Fri, 8 Nov 2019 11:34:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191108102805.8258-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: _pV603xUOwOfk8nJVFkazw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: qemu-trivial@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/11/2019 11.28, Philippe Mathieu-Daud=C3=A9 wrote:
> The bzip2 tool is not included in default installations.
> On freshly installed systems, ./configure succeeds but 'make'
> might fail later:
>=20
>      BUNZIP2 pc-bios/edk2-i386-secure-code.fd.bz2
>    /bin/sh: bzip2: command not found
>    make: *** [Makefile:305: pc-bios/edk2-i386-secure-code.fd] Error 127
>    make: *** Deleting file 'pc-bios/edk2-i386-secure-code.fd'
>    make: *** Waiting for unfinished jobs....
>=20
> Add a check in ./configure to warn the user if bzip2 is missing.
>=20
> Fixes: 536d2173b2b
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   configure | 7 +++++++
>   1 file changed, 7 insertions(+)
>=20
> diff --git a/configure b/configure
> index efe165edf9..9957e913e8 100755
> --- a/configure
> +++ b/configure
> @@ -1851,6 +1851,13 @@ python_version=3D$($python -c 'import sys; print("=
%d.%d.%d" % (sys.version_info[0]
>   # Suppress writing compiled files
>   python=3D"$python -B"
>  =20
> +# Some firmware binaries are compressed with bzip2
> +if has bzip2; then
> +  :
> +else
> +  error_exit "bzip2 program not found. Please install it"
> +fi

It's only required for the edk2 binaries, isn't it? So should this maybe=20
also check whether we build any of the i386-softmmu, x86_64-softmmu=20
arm-softmmu or aarch64-softmmu targets and pass otherwise?

  Thomas


