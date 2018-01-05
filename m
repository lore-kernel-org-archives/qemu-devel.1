Received: from eggs.gnu.org ([2001:4830:134:3::10]:50018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXQZ5-00048u-F0
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 06:53:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXQZ4-0003Lw-Pb
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 06:53:35 -0500
Received: from mail-io0-x230.google.com ([2607:f8b0:4001:c06::230]:40847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXQZ4-0003LH-Jz
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 06:53:34 -0500
Received: by mail-io0-x230.google.com with SMTP id v30so5544256iov.7
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 03:53:34 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <04819f44-5df0-04f7-4dc2-6c66fe6a7aec@redhat.com>
References: <20171229142922.31701-1-hpoussin@reactos.org>
	<04819f44-5df0-04f7-4dc2-6c66fe6a7aec@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Fri, 5 Jan 2018 08:53:33 -0300
Message-ID: <CAAdtpL7UNko1AvgWA8j03J_1w7AnzQLFyxy6_g5q5_3OPPN6Bg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/16] piix4: cleanup and improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S . Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

>> This patchset is a cleanup of the PIIX4 PCI-ISA bridge. Lots of devices
>> are moved from MIPS Malta board (which has a PIIX4) to PIIX4, where devi=
ces
>> belong. This lets us reuse PIIX4 in other machines, while not loosing an=
y
>> functionality.
>>
>> Last patch allows adding a new PIIX4 device directly from command line.
>> Note that this will work only as long no other ISA bus already exist on =
the
>> machine.
>
> Thanks, I think this is the right place to draw the line.  The more
> "correct" one would be like pc87312, where the serial and parallel ports
> are e.g. also included in the SuperI/O chip, but then you get

Yes, this is how I did in my "remove 'i386/pc.h' dependency" series ...

>
>             /* FIXME use a qdev chardev prop instead of serial_hds[] */
>             chr =3D serial_hds[i];
>
> so you have to mark the bridge as not user-creatable.

... using qdev chardev and getting ride of this serial_hds[] limitation.

I suggested Herv=C3=A9 we have an IRC meeting today at 7PM GMT+1 to talk
about sharing common efforts.
