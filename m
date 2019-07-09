Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00AAC73C41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 14:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 922312080C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 14:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922312080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkqm6-0006eD-L7
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 10:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53817)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hkqlc-0006E5-Ny
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 10:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hkqlb-0006z4-NZ
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 10:06:48 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:46797)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hkqlb-0006yA-E4
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 10:06:47 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MAwPf-1heYDP1Oif-00BMyE; Tue, 09 Jul 2019 16:01:34 +0200
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <156262578461.2222.11301272429426949561.malonedeb@wampee.canonical.com>
 <156267329906.2764.88840211247289671.malone@wampee.canonical.com>
 <06bf8be7-c97e-9a42-06c4-82f303dc1a76@physik.fu-berlin.de>
 <3e3ac1b4-dd46-988a-9801-cd1353e81714@vivier.eu>
 <b88a6279-8e7a-32b6-4fc1-98be496aaaf0@physik.fu-berlin.de>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <30e7b9fe-a99d-a83c-e4b6-7021a076332d@vivier.eu>
Date: Tue, 9 Jul 2019 16:01:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b88a6279-8e7a-32b6-4fc1-98be496aaaf0@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yB+XWCPmw4pLR6KPdADLcYtpY3biHPXevyLn3Pv72NKqs1BQ/RF
 ex5fjDjU6egigPRHwwuZ4aRqxxZjNG5aqymSAwg9eAxLRO6xT5kc/F/Fl4w9H7s4yZRksmB
 1ySi+JTfsjU9vACU5qXWOhsde2QGfPiGkTSt7dSjlQW/Broy6GsSQyCD4uqhLJ0q/kHU4kp
 6FO7UkMio7mMS0+xE54+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0JRddLvBQUQ=:c6P9pSx9QEI9W2dJtARol0
 CaOey/+jIBsQP4ItMF03OrDULdNrBqkjFfYOAZS/5rPkDzbTM73jlFklTatM7e34QRnIm5vX6
 ywYDZj3Pyeq53ioBihbQgbjnRS5kViGvLFB4ZVVFMmgFMYRvzkCGbzm3Zv/Vsln2ratwYTA8Z
 JRPCy30s4JXY1BXpe1zm2IIzbe6mHNnDdhgEz1Ccz5UDMpPi/DSwTtFIhVlgKXINtkAjuNNw9
 kwhyfIf3f4Pxceh3ujg7AMFjO3GHCV7kE2hwlH6l7OzTZGYODo2gifN9KMXFlBgC44XRiszDP
 P9lPB9DekFO1CfMYSt2+ZpDKnBYs3ppsYV1Egv/Dpdpdg4AfMHT3Le9UyIAGbaSqUIqBlhrSl
 rh3ccaDsYpeWUE4uWrmMnMzjAYw/Df4ClBZP6pqfhy0hSpEvfQg4MzamymytuUw5AjiwIdqIF
 V1SIWZTcVSZkRObeovidyU31QDN36cYiNBE0B8EHEhjbK0/31lJ79JudGu2v3H6mZRA4aa4o+
 ZYZcq15GAW7MS62PqHPfTBfz3cFDDzIuGvqNUWdcLIl6zp0qMnVkTwVr7a1F9TdKq+xOD8TXn
 C6+ipRGnzEamFw7Xl/TjuuJVb69pMR1xrdVSY/ygkCAnbKRTNfSi8HRWOLkHfkFAKUg6C+swA
 +7r3fU/HI0IFVxZ9I47huFy2jtoabDyr7VFMrPw3aZYZgnhEMOc8Pr3p/6aynoqs03rdhUQKR
 UxFPpKEzwnZttEgLHW4AlIUdjRYaQ8MkeND7qa40ObYxdxSZwCeDEplxpWs=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: Re: [Qemu-devel] [Bug 1835839] Re: qemu-user: $0 incorrectly always
 reports absolute path
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
Cc: Bug 1835839 <1835839@bugs.launchpad.net>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 09/07/2019 à 15:07, John Paul Adrian Glaubitz a écrit :
> On 7/9/19 2:51 PM, Laurent Vivier wrote:
>> if you use systemctl, the parameter of "./scripts/qemu-binfmt-conf.sh"
>> must be "--systemd m68k" rather than "--debian".
> 
> I tried that and I now get:
> 
> root@nofan:/local_scratch/sid-m68k-sbuild> chroot .
> chroot: failed to run command ‘/bin/bash’: No such file or directory
> root@nofan:/local_scratch/sid-m68k-sbuild>

What is the content of:

/etc/binfmt.d/qemu-m68k.conf
/proc/sys/fs/binfmt_misc/qemu-m68k

what is the result of "file sid-m68k-sbuild/usr/bin/qemu-m68k-static"?

Bonus: if you don't want to copy qemu-m68k-static into the chroot, you
can use "--persistent" with qemu-binfmt-conf.sh.

Thanks,
Laurent

