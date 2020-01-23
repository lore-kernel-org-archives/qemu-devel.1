Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8528C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 04:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E62B21835
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 04:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2N04nIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E62B21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuUHf-0007Pt-OZ
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 23:39:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iuUGt-0006ev-E0
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 23:39:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iuUGr-0004SV-56
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 23:39:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46439
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iuUGq-0004Rq-Qg
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 23:39:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579754347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=UQsZxcpdnCNeHd3KA/ELe7S3/cKSUxDUBxtbDCASd+g=;
 b=a2N04nIjvEqxyk8hehM10xtsBhdnWywCLZwgJ3P8mQzgUTgbQAYpSk2wJVTvqpKEWYVR++
 scOvAnWK8kB60ODTrSNBoz4vTTYrIGEuaNyXyTd6nQjkMFYeMlU1fM2tpVVPO6eKnvRD1Y
 AwGL5Qmo5Lw7IdS8YKc7kfIKT5b1oKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-sLY0mKK6OVmMHlFl9-hvDA-1; Wed, 22 Jan 2020 23:39:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDBB1107ACC5;
 Thu, 23 Jan 2020 04:39:04 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D224858BE;
 Thu, 23 Jan 2020 04:39:02 +0000 (UTC)
Subject: Re: [PATCH] tests/boot-serial-test: Allow the HPPA machine to shudown
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20200123003603.11610-1-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a71b6c89-b36c-ebb6-3ff4-c3866309125c@redhat.com>
Date: Thu, 23 Jan 2020 05:39:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200123003603.11610-1-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: sLY0mKK6OVmMHlFl9-hvDA-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/01/2020 01.36, Philippe Mathieu-Daud=C3=A9 wrote:
> The boot-serial test uses SeaBIOS on HPPA, and expects to read the
> "SeaBIOS wants SYSTEM HALT" string, see [*]:
>=20
>  122 void __VISIBLE __noreturn hlt(void)
>  123 {
>  124     if (pdc_debug)
>  125         printf("HALT initiated from %p\n",  __builtin_return_address=
(0));
>  126     printf("SeaBIOS wants SYSTEM HALT.\n\n");
>  127     asm volatile("\t.word 0xfffdead0": : :"memory");
>  128     while (1);
>  129 }
>=20
> A 'SYSTEM HALT' would really halts the CPU, but SeaBIOS implements
> it as an infinite loop.
>=20
> If SeaBIOS does not use the expected serial port but another device,
> we might poll the console indefinitely while the machine is halted.
>=20
> Allow the HPPA machine to 'shutdown'. When it does, we'll get
> a qtest error:
>=20
>   $ make check-qtest-hppa
>     TEST    check-qtest-hppa: tests/qtest/boot-serial-test
>   ** (tests/qtest/boot-serial-test:31924): ERROR **: 01:12:37.604: Failed=
 to find expected string. Please check '/tmp/qtest-boot-serial-sjxoM6Q'
>   ERROR - Bail out! FATAL-ERROR: Failed to find expected string. Please c=
heck '/tmp/qtest-boot-serial-sjxoM6Q'
>   make: *** [tests/Makefile.include:628: check-qtest-hppa] Error 1

The tests are run with -no-shutdown. Why does qemu exit in that case?
Sounds like a bug in another place, and not in the boot-serial-test.

 Thomas


