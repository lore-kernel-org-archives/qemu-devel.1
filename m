Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BDDC32771
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 07:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8BE82071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 07:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ss4MqTA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BE82071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iut09-0002zu-Sd
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 02:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iuszW-0002YB-Nc
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 02:02:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iuszU-0008OM-NG
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 02:02:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46851
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iuszU-0008No-An
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 02:02:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579849370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=nTvyo5T0ITqZUAfdHD3tdng88BeIADnZmGQcET1/iyI=;
 b=Ss4MqTA4GVdgYmKDSuMn8PuRBgSj6jwxkbn5RdOTmJ3gBrTG/uxGtnbu4hjxPIBwoc5yA/
 uEQR0KpCPBH2bYH+L6S4LDOctwPpV0fNxTIN8BPnVHzwV1auuLm5Qe2HhqXFpJlStEOJIk
 qi76W8MIPZMAyOoJvsJGcneeO5JMDfs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-hg1hfBtVP5y0XxLoKfkWDw-1; Fri, 24 Jan 2020 02:02:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76B51DBA3;
 Fri, 24 Jan 2020 07:02:47 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-156.ams2.redhat.com [10.36.116.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EFCFA8CCE2;
 Fri, 24 Jan 2020 07:02:42 +0000 (UTC)
Subject: Re: [PATCH] tests/boot-serial-test: Allow the HPPA machine to shudown
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20200123003603.11610-1-f4bug@amsat.org>
 <a71b6c89-b36c-ebb6-3ff4-c3866309125c@redhat.com>
 <0deda7d0-78a1-6618-e2b5-9b92b301557a@redhat.com>
 <1c474db4-a9b6-1103-b34d-c37a5338a91e@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0e5d2965-4249-2499-db5e-ee6dd88afb54@redhat.com>
Date: Fri, 24 Jan 2020 08:02:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1c474db4-a9b6-1103-b34d-c37a5338a91e@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: hg1hfBtVP5y0XxLoKfkWDw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On 23/01/2020 22.37, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/23/20 7:29 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 1/23/20 5:39 AM, Thomas Huth wrote:
>>> On 23/01/2020 01.36, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> The boot-serial test uses SeaBIOS on HPPA, and expects to read the
>>>> "SeaBIOS wants SYSTEM HALT" string, see [*]:
>>>>
>>>> =C2=A0 122 void __VISIBLE __noreturn hlt(void)
>>>> =C2=A0 123 {
>>>> =C2=A0 124=C2=A0=C2=A0=C2=A0=C2=A0 if (pdc_debug)
>>>> =C2=A0 125=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("HAL=
T initiated from %p\n",=C2=A0
>>>> __builtin_return_address(0));
>>>> =C2=A0 126=C2=A0=C2=A0=C2=A0=C2=A0 printf("SeaBIOS wants SYSTEM HALT.\=
n\n");
>>>> =C2=A0 127=C2=A0=C2=A0=C2=A0=C2=A0 asm volatile("\t.word 0xfffdead0": =
: :"memory");
>>>> =C2=A0 128=C2=A0=C2=A0=C2=A0=C2=A0 while (1);
>>>> =C2=A0 129 }
>>>>
>>>> A 'SYSTEM HALT' would really halts the CPU, but SeaBIOS implements
>>>> it as an infinite loop.
>>>>
>>>> If SeaBIOS does not use the expected serial port but another device,
>>>> we might poll the console indefinitely while the machine is halted.
>>>>
>>>> Allow the HPPA machine to 'shutdown'. When it does, we'll get
>>>> a qtest error:
>>>>
>>>> =C2=A0=C2=A0 $ make check-qtest-hppa
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 TEST=C2=A0=C2=A0=C2=A0 check-qtest-hppa: test=
s/qtest/boot-serial-test
>>>> =C2=A0=C2=A0 ** (tests/qtest/boot-serial-test:31924): ERROR **: 01:12:=
37.604:
>>>> Failed to find expected string. Please check
>>>> '/tmp/qtest-boot-serial-sjxoM6Q'
>>>> =C2=A0=C2=A0 ERROR - Bail out! FATAL-ERROR: Failed to find expected st=
ring.
>>>> Please check '/tmp/qtest-boot-serial-sjxoM6Q'
>>>> =C2=A0=C2=A0 make: *** [tests/Makefile.include:628: check-qtest-hppa] =
Error 1
>>>
>>> The tests are run with -no-shutdown. Why does qemu exit in that case?
>>
>> Because the HPPA firmware called HALT.
>>
>>> Sounds like a bug in another place, and not in the boot-serial-test.
>>
>> Yes, the bug is elsewhere, but with the bug the boot-serial-test hangs
>> forever.... No output on the console, qtest waiting indefinitely.
>=20
> Richard explained me on IRC what you probably meant, which was not
> obvious to me at first.

I think I also did not really understand what you tried to do here ;-)

The -no-shutdown is required, too, otherwise you could get a race
between the test reading the serial output and the termination of QEMU,
see commit 7150d34a1d60851d73d6ab6783b12b1d25e68f86, and I think we need
that for HPPA, too.

> Now I found in check_guest_output():
>=20
> =C2=A0=C2=A0=C2=A0 /* Poll serial output... */
> =C2=A0=C2=A0=C2=A0 while (1) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Wait at most 360 seconds.=
=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 now =3D time(NULL);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (now - start >=3D 360) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_usleep(10000);
> =C2=A0=C2=A0=C2=A0 }
>=20
> $ QTEST_QEMU_BINARY=3Dhppa-softmmu/qemu-system-hppa \
> =C2=A0 time tests/qtest/boot-serial-test -k
> /hppa/boot-serial/hppa:
> ** (tests/qtest/boot-serial-test:18604): ERROR **: 22:33:25.010: Failed
> to find expected string. Please check '/tmp/qtest-boot-serial-sZq7ljM'
> Command terminated by signal 5
> 0.31user 0.66system 6:00.07elapsed 0%CPU
>=20
> Indeed the test fails after 6min, I guess I didn't expect that much
> while testing interactively.

Yeah, the huge timeout is ugly, but it is required for very slow hosts,
see commit 627fce617868df87b3757375a2a0318ad2beb381.

So if you want to "fix" your problem, I think you could maybe add a
check for the QEMU events here instead. Or add a check to see whether
the registers of the guest change between iterations to make sure that
the guest is still alive (that way you also handle the case that the
guest crashed and loops forever in a "branch self" instruction). Or
simply continue with the 360s timeout, it's long, but it should trigger
only in case of other bugs, so it's maybe not worth the effort to add
more logic here.

 Thomas


