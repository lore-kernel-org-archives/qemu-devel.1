Received: from eggs.gnu.org ([2001:4830:134:3::10]:34355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1ckuPb-0000Mu-U7
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:19:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1ckuPW-0000Gq-FE
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:18:59 -0500
Received: from mail-it0-x235.google.com ([2607:f8b0:4001:c0b::235]:38225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1ckuPW-0000GT-Ar
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 10:18:54 -0500
Received: by mail-it0-x235.google.com with SMTP id m27so51973306iti.1
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 07:18:54 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <1488791436.18653.22.camel@redhat.com>
Date: Mon, 6 Mar 2017 10:18:51 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <0DFFD63A-FC17-44D7-9452-2EEE7A89D2B7@gmail.com>
References: <38265DF9-8C55-4B4E-9222-F75C5E675ABB@gmail.com>
	<1488791436.18653.22.camel@redhat.com>
Subject: Re: [Qemu-devel] Patch causes Mac OS X to print dead controller
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Li Qiang <liqiang6-s@360.cn>, qemu-devel qemu-devel <qemu-devel@nongnu.org>


On Mar 6, 2017, at 4:10 AM, Gerd Hoffmann wrote:

> On Mi, 2017-03-01 at 23:08 -0500, Programmingkid wrote:
>> commit 95ed56939eb2eaa4e2f349fe6dcd13ca4edfd8fb
>> usb: ohci: limit the number of link eds
>>=20
>> This patch causes Mac OS X to continuously print this message:
>> USBF: 35.508 AppleUSBOHCI[0x1187000] Watchdog detected dead =
controller (hcca #: 0, hc#: 863)
>>=20
>> I used git bisect to find this patch. None of the USB devices work =
when connected to the OHCI USB controller.
>=20
> Hmm, ok, appearently the limit is too strict for macos.  Can you try =
to
> increase ED_LINK_LIMIT ?

I used the value of 20 and it worked.=20=
