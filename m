Received: from eggs.gnu.org ([2001:4830:134:3::10]:59857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhunxun@gmail.com>) id 1egqmL-0004MI-Hh
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 06:42:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhunxun@gmail.com>) id 1egqmK-0000gT-Gk
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 06:42:13 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:37828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhunxun@gmail.com>) id 1egqmK-0000fa-CA
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 06:42:12 -0500
Received: by mail-ot0-x232.google.com with SMTP id a24so13078224otd.4
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 03:42:12 -0800 (PST)
MIME-Version: 1.0
From: "jack.chen" <zhunxun@gmail.com>
Date: Wed, 31 Jan 2018 19:42:10 +0800
Message-ID: <CADUDsAo6ku+WT1+DTG6u6CUjdg6xzG6LwBt8RwHK4eR_UWY=Jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] vhost-user question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu <qemu-devel@nongnu.org>

hello,I am confused when I read vhost-user source code in qemu.I know
vhost-user app shared memory with qemu by mmap,but why it can use fd which
is belong to qemu?
relative code:
 qemu code in function vhost_user_set_mem_table
fd =3D memory_region_get_fd(mr);
        if (fd > 0) {
            msg.payload.memory.regions[fd_num].userspace_addr =3D
reg->userspace_addr;
            msg.payload.memory.regions[fd_num].memory_size  =3D
reg->memory_size;
            msg.payload.memory.regions[fd_num].guest_phys_addr =3D
reg->guest_phys_addr;
            msg.payload.memory.regions[fd_num].mmap_offset =3D offset;
            assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
            fds[fd_num++] =3D fd;
        }

=E2=80=A6=E2=80=A6
DPDK code in vhost_user_set_mem_table

mmap_addr =3D mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
MAP_SHARED | MAP_POPULATE, fd, 0);
=E2=80=A6=E2=80=A6

thanks a lot!
