Received: from eggs.gnu.org ([2001:4830:134:3::10]:50569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1ei2S7-0006WP-6J
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 13:22:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1ei2S5-0003Cb-LM
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 13:22:14 -0500
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:38613
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1ei2S5-00039P-FQ
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 13:22:13 -0500
References: <CAE+d=qYwHiguvVD4+akOvQ2NYx=OQgSUGv14S6tFsb6bFfCBsQ@mail.gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <fa403bd1-283f-a643-63df-e31333a380a6@adacore.com>
Date: Sat, 3 Feb 2018 19:22:05 +0100
MIME-Version: 1.0
In-Reply-To: <CAE+d=qYwHiguvVD4+akOvQ2NYx=OQgSUGv14S6tFsb6bFfCBsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] How to make memory mapped controller receive data?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fangda Cai <fdtsaid@gmail.com>
Cc: qemu-devel@nongnu.org, Pavel Pisa <pisa@cmp.felk.cvut.cz>

Hi,

There are no CAN bus support in QEMU yet but there is some work
going on about CAN from Pavel (added in CC):
https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg00104.html

He knows better than me what it does but basically the device
will be able to be contacted by other CAN devices on the bus even
outside QEMU.

If you have an SPI master _inside_ QEMU connected to your memory
mapped SPI controller you can create a qemu_timer in the device
which will send data to the SPI controller.

Fred

On 02/02/2018 09:26 AM, Fangda Cai wrote:
> Hi, I have built a virtual arm board that includes onboard memory-mapped
> SPI controller and CAN controller. I also built a bare metal program that
> can run on the virtual arm board. Is it possible to make the SPI/CAN
> receive data during the bare-metal program running on the board? I don't
> know how to achieve it, any ideas?
> 
