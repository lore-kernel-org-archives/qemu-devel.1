Received: from eggs.gnu.org ([2001:4830:134:3::10]:54600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWFBf-00030F-Dc
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 01:37:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWFBc-0003H9-8P
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 01:37:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gWFBc-0003Gh-2R
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 01:37:00 -0500
Date: Mon, 10 Dec 2018 07:36:57 +0100
From: "kraxel@redhat.com" <kraxel@redhat.com>
Message-ID: <20181210063657.2lqj7vkqwdaobp7e@sirius.home.kraxel.org>
References: <RO1P152MB14839E480D046B4052F0ADC797A40@RO1P152MB1483.LAMP152.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <RO1P152MB14839E480D046B4052F0ADC797A40@RO1P152MB1483.LAMP152.PROD.OUTLOOK.COM>
Subject: Re: [Qemu-devel] Guests are crashing on startup,
 seem related to usb-audio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonardo Soares =?utf-8?Q?M=C3=BCller?= <leozinho29_eu@hotmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

  Hi,

> #3  0x00007ffff01be412 in __GI___assert_fail (assertion=0x555555fb8738
> "p->actual_length + bytes <= iov->size", file=0x555555fb8456
> "hw/usb/core.c", line=592, function=0x555555fb8980
> <__PRETTY_FUNCTION__.26351> "usb_packet_copy") at assert.c:101
> #4  0x0000555555bd5ed7 in usb_packet_copy (p=0x7fffc4722ea8,
> ptr=0x7fffbc053ee0, bytes=192) at hw/usb/core.c:592

Can you "print *p" here?

thanks,
  Gerd
