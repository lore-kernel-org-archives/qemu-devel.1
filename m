Received: from eggs.gnu.org ([2001:4830:134:3::10]:45847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dCn6E-0000TP-Pl
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:10:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dCn6A-0003kf-Oe
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:10:14 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1dCn6A-0003jz-IS
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:10:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id d127so33143264wmf.1
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 06:10:10 -0700 (PDT)
Received: from [192.168.178.23] (pD9E8386D.dip0.t-ipconnect.de.
	[217.232.56.109]) by smtp.gmail.com with ESMTPSA id
	y190sm34443753wmy.15.2017.05.22.06.10.07 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 May 2017 06:10:07 -0700 (PDT)
References: <CAGKXQyf0A+hoBdzU3BD16v1LoWNVnuf++U4d1bt1q3UZotdMSQ@mail.gmail.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <9f5a4067-2d87-9844-655b-d1dacec2446b@tuxfamily.org>
Date: Mon, 22 May 2017 15:10:06 +0200
MIME-Version: 1.0
In-Reply-To: <CAGKXQyf0A+hoBdzU3BD16v1LoWNVnuf++U4d1bt1q3UZotdMSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] TARGET_PAGE_BITS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 22.05.2017 14:54, ali saeedi wrote:
> Hello
> What is TARGET_PAGE_BITS in ram.c?

12, on average, see:

grep TARGET_PAGE_BITS target/*/cpu.h

> thanks a lot

You're welcome.

 Thomas
