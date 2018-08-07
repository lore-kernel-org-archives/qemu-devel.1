Received: from eggs.gnu.org ([2001:4830:134:3::10]:47815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fn1dZ-0000RK-Hp
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fn1dT-0005pR-SR
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:02:57 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fn1dT-0005pF-Jv
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:02:51 -0400
Received: by mail-wm0-x242.google.com with SMTP id t25-v6so18004299wmi.3
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 06:02:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180807125558.2g7nl5zhgrdblrwh@sirius.home.kraxel.org>
References: <20180803153235.4134-1-marcandre.lureau@redhat.com>
	<20180807125558.2g7nl5zhgrdblrwh@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 7 Aug 2018 15:02:49 +0200
Message-ID: <CAJ+F1C+cU-LKd_t-tn9jW86A8aV4CnQXUpA1NM+SPkB1rbrfoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: fix crashes upon warm reboot
 with vga mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>

Hi

On Tue, Aug 7, 2018 at 2:55 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> On Fri, Aug 03, 2018 at 05:32:35PM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> With vga=3D775 on the Linux command line a first boot of the VM running
>> Linux works fine. After a warm reboot it crashes during Linux boot.
>>
>> Before that, valgrind points out bad memory write to console
>> surface. The VGA code is not aware that virtio-gpu got a message
>> surface scanout when the display is disabled. Let's reset VGA graphic
>> mode when it is the case, so that a new display surface is created
>> when doing further VGA operations.
>
> I guess we should simply call vga_common_reset() in virtio_vga_reset()
> instead, can you try that?
>
Yes I tried, and it still fails. However I think the call is missing
and I was planning to send it for 3.1 later, since I don't think it's
RC material.
The ordering of events is not completely obvious to me, but it's still
crashing/corrupting memory after the reset occurs. The scanout get's
disable after it iirc.


--=20
Marc-Andr=C3=A9 Lureau
