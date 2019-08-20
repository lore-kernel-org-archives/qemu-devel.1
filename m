Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AE2C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F2122CE3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F2122CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i05To-0004XN-BE
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 10:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1i05Sw-0003hY-9i
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:50:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1i05Su-0004rN-Fn
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:50:29 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:27382)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1i05Su-0004nm-9J
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:50:28 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E856E7456E2;
 Tue, 20 Aug 2019 16:50:25 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 67EFC7456D5; Tue, 20 Aug 2019 16:50:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 598977456B4;
 Tue, 20 Aug 2019 16:50:25 +0200 (CEST)
Date: Tue, 20 Aug 2019 16:50:25 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
In-Reply-To: <e72fd744-3440-a684-38c4-75d6d604cddb@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1908201648370.56910@zero.eik.bme.hu>
References: <alpine.BSF.2.21.9999.1811292101280.5887@zero.eik.bme.hu>
 <alpine.BSF.2.21.9999.1901151926320.72972@zero.eik.bme.hu>
 <e72fd744-3440-a684-38c4-75d6d604cddb@redhat.com>
User-Agent: Alpine 2.21.9999 (BSF 287 2018-06-16)
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] Booting Raspbian on RPi emulation
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Philippe,

On Tue, 15 Jan 2019, Philippe Mathieu-Daud=E9 wrote:
> On 1/15/19 7:29 PM, BALATON Zoltan wrote:
>> On Thu, 29 Nov 2018, BALATON Zoltan wrote:
>>> Then I've tried the same with the pll patches posted by Philippe
>>> Mathieu-Daud=E9 here:
>>>
>>> http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg00191.html
>>>
>>> on top of v3.1.0-rc3 which helped to get rid of the cprman warnings
>>
>> Will these patches be merged eventually? These seem to at least get ri=
d
>> of some annoying warnings in Linux boot dmesg.
>
> I'll respin this series addressing Peter's comments.
>
> Thanks for reminding me ;)
>
> Phil.

While you're at raspi patches maybe I remind you again of the above :-)
I think I haven't seen these being merged yet but correct me if I'm wrong=
.

Regards,
BALATON Zoltan
