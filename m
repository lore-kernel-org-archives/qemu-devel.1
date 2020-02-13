Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D8AC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 20:29:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100A124684
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 20:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWSChvHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100A124684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2L7U-00067I-1u
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 15:29:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1j2L6h-0005iB-D5
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:29:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1j2L6g-0000Tx-22
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:29:07 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23747
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1j2L6f-0000Rj-TU
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581625744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h0jrHRmyKXESYC21YjJBCQbKdMN66qCn5iecIaWEg+4=;
 b=gWSChvHbniCQc5M+yOjTNMPvNzEQ5zBOVtnCd2sug+s7Y3kPFmhuRpof6vf+dZ2ojwKt2e
 o5yH/3Lspog3swhvJuFaYWstdlXQetM04r4aZDxdlV8JFRpVCDvFINXnbF13e24ATzWtR5
 y8ZMuKDTOpsnN3Z1O6ROhqfe8rSV/8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-It0bUXmMOtiKTd2cb5hWyw-1; Thu, 13 Feb 2020 15:28:56 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6364618B5FAA;
 Thu, 13 Feb 2020 20:28:55 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-24.gru2.redhat.com
 [10.97.116.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2F606E40A;
 Thu, 13 Feb 2020 20:28:49 +0000 (UTC)
Subject: Re: [PATCH v2] tests/acceptance/machine_sparc_leon3: Do not run
 HelenOS test by default
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200212203627.16592-1-philmd@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <c588253f-a205-a309-6983-09607c1e61e6@redhat.com>
Date: Thu, 13 Feb 2020 18:28:47 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200212203627.16592-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: It0bUXmMOtiKTd2cb5hWyw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Fabien Chouteau <chouteau@adacore.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2/12/20 6:36 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> The www.helenos.org server is slow and downloading the Leon3 binary
> takes too long [*]. Do not include this test in the default suite.
>
> Similarly to commit 471c97a69b:
>
>    Currently the Avocado framework does not distinct the time spent
>    downloading assets vs. the time spent running a test. With big
>    assets (like a full VM image) the tests likely fail.
>
>    This is a limitation known by the Avocado team.
>    Until this issue get fixed, do not run this tests automatically.
>
>    Tests can still be run setting the AVOCADO_TIMEOUT_EXPECTED
>    environment variable.
>
> [*] https://travis-ci.org/stsquad/qemu/jobs/649599880#L4198
>
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: Add missing staged hunk...
> ---
>   tests/acceptance/machine_sparc_leon3.py | 4 ++++
>   1 file changed, 4 insertions(+)

LGTM.

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


>
> diff --git a/tests/acceptance/machine_sparc_leon3.py b/tests/acceptance/m=
achine_sparc_leon3.py
> index f77e210ccb..27e4717a51 100644
> --- a/tests/acceptance/machine_sparc_leon3.py
> +++ b/tests/acceptance/machine_sparc_leon3.py
> @@ -5,6 +5,9 @@
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later. See the COPYING file in the top-level directory.
>  =20
> +import os
> +
> +from avocado import skipUnless
>   from avocado_qemu import Test
>   from avocado_qemu import wait_for_console_pattern
>  =20
> @@ -13,6 +16,7 @@ class Leon3Machine(Test):
>  =20
>       timeout =3D 60
>  =20
> +    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeo=
ut')
>       def test_leon3_helenos_uimage(self):
>           """
>           :avocado: tags=3Darch:sparc


