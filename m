Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02EDC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F96B22314
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F96B22314
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itusW-0003o1-Qj
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:51:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1itu8t-0006bQ-5R
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:04:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1itu8o-0007ao-U8
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:04:30 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:37904)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1itu8o-0007a5-2f
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:04:26 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id EDD8B7482CE;
 Tue, 21 Jan 2020 15:04:23 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BFCF07482CB; Tue, 21 Jan 2020 15:04:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BE1F47475F8;
 Tue, 21 Jan 2020 15:04:23 +0100 (CET)
Date: Tue, 21 Jan 2020 15:04:23 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [Qemu-devel] What should a virtual board emulate?
In-Reply-To: <877e1lml18.fsf@dusky.pond.sub.org>
Message-ID: <alpine.BSF.2.21.99999.352.2001211453440.60630@zero.eik.bme.hu>
References: <20190319144013.26584-1-pbonzini@redhat.com>
 <alpine.BSF.2.21.9999.1903192350550.11467@zero.eik.bme.hu>
 <87imwe847x.fsf_-_@dusky.pond.sub.org>
 <CAAdtpL5Z1OXqZ_zzA0RLq9soydNtTFt2oCOEfui1rq19bLKUgA@mail.gmail.com>
 <d9d5ac96-c0f5-dd83-d305-10e20c745dd1@redhat.com>
 <9b92b3c4-c5d5-9a51-7b96-50dcf113ee5a@redhat.com>
 <6b5459b5-deb2-e70c-deab-fa7246b43e38@redhat.com>
 <877e1lml18.fsf@dusky.pond.sub.org>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-694431362-1579615463=:60630"
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-694431362-1579615463=:60630
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Jan 2020, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>
>> On 04/01/20 22:16, Philippe Mathieu-Daud=C3=A9 wrote:
>>> 1/ the Radeon chip is soldered on the motherboard,
>>>
>>> 2/ the default BIOS expects the Radeon chip to be
>>> =C2=A0=C2=A0 unconditionally present,
>>>
>>> I insist this patch is incorrect for the particular case of the
>>> Fuloong2e board. I plan to revert it when I post the test.
>>>
>>> BTW I'm not using --nodefault, I'm running default ./configure:
>>>
>>> qemu-system-mips64el -M fulong2e -bios pmon_2e.bin \
>>> -display none -vga none -serial stdio
>>
>> But if you're not specifying -nodefaults, why are you specifying a
>> configuration that your BIOS does not support?  You should just remove
>> -vga none and leave in -display none.
>
> Is there any use for -vga none with this machine?  If no, then rejectin=
g
> it cleanly would be nicer than having the machine hang.

https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg00330.html

Regards,
BALATON Zoltan
--3866299591-694431362-1579615463=:60630--

