Received: from eggs.gnu.org ([2001:4830:134:3::10]:48077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ceeAL-0001qw-UJ
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:45:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ceeAK-0004XZ-8H
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:45:21 -0500
Received: from mail-lf0-x22b.google.com ([2a00:1450:4010:c07::22b]:35720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ceeAJ-0004Vj-R8
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:45:20 -0500
Received: by mail-lf0-x22b.google.com with SMTP id z127so19394103lfa.2
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 00:45:19 -0800 (PST)
MIME-Version: 1.0
References: <CAOV6k-Am5hxdjueMMzaOVygtq16L7KJur_jkDi5snjeLJqDU2w@mail.gmail.com>
In-Reply-To: <CAOV6k-Am5hxdjueMMzaOVygtq16L7KJur_jkDi5snjeLJqDU2w@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 17 Feb 2017 08:45:06 +0000
Message-ID: <CAJ+F1CLmHPAVJhmgEDMOrbUmWCn2FqSWa4aUJNA9csfy_Yu54w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] How to access to ivshmem device in VM ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?U8OpYmFzdGllbiBGcsOpbWFs?= <sebastien.fremal@gmail.com>, qemu-devel@nongnu.org

Hi

On Thu, Feb 16, 2017 at 12:02 AM S=C3=A9bastien Fr=C3=A9mal <
sebastien.fremal@gmail.com> wrote:

> Hello !
>
> I searched for a forum or a place where questions about QEMU can be asked=
,
> but I found nothing except mailing lists. If there is a more appropriate
> place for my question, do not hesitate to indicate it to me !!
>
> So, I'm trying to use ivshmem to share memory pages between several VM. I
> found many webpages documenting the set up of this device. I successfully
> installed the mechanism in the host. I launched ivshmem-clients which
> successfully connected to the server. The problem is that I can't
> understand how to access to the shared memory pages in a VM. I launched m=
y
> VM with this command line :
> sudo qemu-system-x86_64 -show-cursor -enable-kvm -drive
> format=3Draw,file=3D/var/lib/libvirt/images/theRise.img -m 4096 -machine =
q35
> -show-cursor -device ivshmem-doorbell,vectors=3D4,chardev=3Divshmem -char=
dev
> socket,path=3D/tmp/ivshmem_socket,id=3Divshmem
> (the server was launched with : sudo ivshmem-server -p
> /var/run/ivshmem-server.pid -S /tmp/ivshmem_socket -M ivshmem -l 4K -n 4)=
.
>
> The VM executes properly (I just don't have a visible mouse cursor despit=
e
> the "-show-cursor" option, but it could be worse) but I have absolutely n=
o
> idea on how to access the ivshmem device. I firstly thought that the opti=
on
> would add a new device in /dev but there is nothing special. I ran an
>

There is no guest driver for ivshmem, it's left deliberately open for any
usage.


> updatedb/locate ivshmem to check if there was something interesting on th=
e
> machine, but there is no results. I don't know which socket path I must
> give to my ivshmem client in my VM so it can connect to my server. I
>

You give the socket path of the server, in your example /tmp/ivshmem_socket
is fine.


> searched for this particular information on the web, but I found nothing.
>
> Did you read http://nairobi-embedded.org/linux_pci_device_driver.html ?

Can someone indicate me how to connect to the ivshmem-server from a VM
> please ?
>
>
Your example should work.

Note that ivshmem is not well regarded by the qemu community, what are you
trying to accomplish?

cheers
--=20
Marc-Andr=C3=A9 Lureau
