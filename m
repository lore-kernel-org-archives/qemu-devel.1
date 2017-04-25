Received: from eggs.gnu.org ([2001:4830:134:3::10]:38622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <igor.rubinov@gmail.com>) id 1d35xK-00063j-86
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <igor.rubinov@gmail.com>) id 1d35xJ-00010E-Ih
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:16:58 -0400
Received: from mail-vk0-x22c.google.com ([2607:f8b0:400c:c05::22c]:33450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <igor.rubinov@gmail.com>)
	id 1d35xJ-0000zc-Dt
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:16:57 -0400
Received: by mail-vk0-x22c.google.com with SMTP id j127so60290536vkh.0
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 12:16:57 -0700 (PDT)
MIME-Version: 1.0
Sender: igor.rubinov@gmail.com
In-Reply-To: <CAJhHMCCZh7hvQT8x9Bks9k6=ka4G1Oybv1MrkKJ9_VZ_eRZBfQ@mail.gmail.com>
References: <CAPnv1PJeMRPKv9UUSmSWxyn=GFOPaWY8eUgH8ZeL=ZBMDJpbdg@mail.gmail.com>
	<CAJhHMCCZh7hvQT8x9Bks9k6=ka4G1Oybv1MrkKJ9_VZ_eRZBfQ@mail.gmail.com>
From: Igor R <boost.lists@gmail.com>
Date: Tue, 25 Apr 2017 22:16:26 +0300
Message-ID: <CAPnv1PL7-BAt36BvTxP7G8J8990Ur9MJJbr-QPccWziD4sy28g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] What is the best commit for record-replay?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani+qemu@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

>> Hi,
>>
>> I'm trying to use the deterministic record/replay feature, and I would
>> like to know which commit I should take to get it work.
>> In RC0 it seems to be broken. I tried pre-MTTCG commit 2421f381dc, as

> Can you retry with the latest rc? There were some fixes regarding rr since rc0.


I've taken 2.9 release, and RR does not seem to work there.
I recorded the boot process of x86 Fedora-21 linux and the replay got
stuck almost immediately.
