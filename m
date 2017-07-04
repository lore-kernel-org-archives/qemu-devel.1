Received: from eggs.gnu.org ([2001:4830:134:3::10]:37250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSX4n-0002NB-MV
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 19:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSX4j-0003sX-LB
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 19:17:49 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:32800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dSX4j-0003sQ-ER
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 19:17:45 -0400
Received: by mail-pg0-x243.google.com with SMTP id u62so28893349pgb.0
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 16:17:45 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <149903601307.6257.7341525830619997074.malonedeb@gac.canonical.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4f8ac443-60c4-b833-9fb9-b399137c0e96@twiddle.net>
Date: Tue, 4 Jul 2017 13:17:38 -1000
MIME-Version: 1.0
In-Reply-To: <149903601307.6257.7341525830619997074.malonedeb@gac.canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1701971] [NEW] multithreading not working
 right under qemu user mode for sh4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1701971 <1701971@bugs.launchpad.net>, qemu-devel@nongnu.org

On 07/02/2017 12:53 PM, Bruno Haible wrote:
> In a multithreaded program running under qemu-sh4 (version 2.9.0),
> thread termination and/or pthread_join is not working right.

QEMU does not support the roll-back atomic sequences used by linux on most 
uniprocessor SH.

Nor do we support the ll/sc form used by SH4A, although fixing that should be 
trivial.


r~
