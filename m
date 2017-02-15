Received: from eggs.gnu.org ([2001:4830:134:3::10]:51535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sebastien.fremal@gmail.com>) id 1ce1Yb-0005B7-8a
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:31:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sebastien.fremal@gmail.com>) id 1ce1YV-0006vm-J7
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:31:49 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:34395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sebastien.fremal@gmail.com>)
	id 1ce1YV-0006ue-Dz
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:31:43 -0500
Received: by mail-ot0-x22a.google.com with SMTP id t47so33001197ota.1
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 07:31:41 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?U8OpYmFzdGllbiBGcsOpbWFs?= <sebastien.fremal@gmail.com>
Date: Wed, 15 Feb 2017 16:31:20 +0100
Message-ID: <CAOV6k-Am5hxdjueMMzaOVygtq16L7KJur_jkDi5snjeLJqDU2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] How to access to ivshmem device in VM ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello !

I searched for a forum or a place where questions about QEMU can be asked,
but I found nothing except mailing lists. If there is a more appropriate
place for my question, do not hesitate to indicate it to me !!

So, I'm trying to use ivshmem to share memory pages between several VM. I
found many webpages documenting the set up of this device. I successfully
installed the mechanism in the host. I launched ivshmem-clients which
successfully connected to the server. The problem is that I can't
understand how to access to the shared memory pages in a VM. I launched my
VM with this command line :
sudo qemu-system-x86_64 -show-cursor -enable-kvm -drive
format=raw,file=/var/lib/libvirt/images/theRise.img -m 4096 -machine q35
-show-cursor -device ivshmem-doorbell,vectors=4,chardev=ivshmem -chardev
socket,path=/tmp/ivshmem_socket,id=ivshmem
(the server was launched with : sudo ivshmem-server -p
/var/run/ivshmem-server.pid -S /tmp/ivshmem_socket -M ivshmem -l 4K -n 4).

The VM executes properly (I just don't have a visible mouse cursor despite
the "-show-cursor" option, but it could be worse) but I have absolutely no
idea on how to access the ivshmem device. I firstly thought that the option
would add a new device in /dev but there is nothing special. I ran an
updatedb/locate ivshmem to check if there was something interesting on the
machine, but there is no results. I don't know which socket path I must
give to my ivshmem client in my VM so it can connect to my server. I
searched for this particular information on the web, but I found nothing.

Can someone indicate me how to connect to the ivshmem-server from a VM
please ?

Best regards,

Sebastien Fremal
