Received: from eggs.gnu.org ([209.51.188.92]:48617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gz6eg-0000hK-Vo
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 16:22:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gz6eg-00058w-4Q
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 16:22:18 -0500
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a]:37522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1gz6ef-00057l-Qv
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 16:22:18 -0500
Received: by mail-io1-xd2a.google.com with SMTP id v10so14855396iop.4
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 13:22:17 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20190227052755.3lgo3265kaa6bzmi@sirius.home.kraxel.org>
Date: Wed, 27 Feb 2019 16:22:13 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <601C46CD-AA96-4E51-A3E9-003153BA30AD@gmail.com>
References: <CAKyx-3Paa6_RreGZw3sT+qmwu1=_DLnR_RDxa_gN20vwD1EnLw@mail.gmail.com>
	<20190225152618.r3epnypkpu6fyokt@sirius.home.kraxel.org>
	<A17B6D30-F428-48E5-B9D0-6F6E7DEE3778@gmail.com>
	<20190226064347.i5kvwazmz3xcupkj@sirius.home.kraxel.org>
	<CAKyx-3OOkkdSQ=UAucP_ZpormrEczwNhEpAnVtFeQOSOrnD7Vg@mail.gmail.com>
	<20190227052755.3lgo3265kaa6bzmi@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] Questions about EDID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>


> On Feb 27, 2019, at 12:27 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> On Tue, Feb 26, 2019 at 04:11:06PM -0500, G 3 wrote:
>> When I use edid=3Don, I do see a lot of extra resolutions available =
in Mac OS
>> 9 and Mac OS X, just not the resolution I want to use. Is there some =
kind
>> of rule like the resolution value has to be divisible by a certain =
number?
>=20
> qemu doesn't have such a requirement.
> Might be the guest drivers have.
> Try making width/height multiple of 8 or 16.


I counted 10 more added resolutions when using your edid feature on Mac =
OS 9.2 and on Mac OS 10.4. But when I tried adding one using the =
xres/yres properties, it didn't work. What operating system do you see =
success on? What is your command line you use?

I did try your suggestion by using 800x800 (16*50) resolution. It didn't =
work.'

Thank you.=
