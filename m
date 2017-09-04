Received: from eggs.gnu.org ([2001:4830:134:3::10]:40017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dokhb-0000JN-6V
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 02:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dokhZ-0006Dc-JT
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 02:17:43 -0400
Received: from mail-qt0-x229.google.com ([2607:f8b0:400d:c0d::229]:36421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <batmanustc@gmail.com>)
	id 1dokhZ-0006CD-Cl
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 02:17:41 -0400
Received: by mail-qt0-x229.google.com with SMTP id v20so19237874qtg.3
	for <qemu-devel@nongnu.org>; Sun, 03 Sep 2017 23:17:40 -0700 (PDT)
MIME-Version: 1.0
From: Sam <batmanustc@gmail.com>
Date: Mon, 4 Sep 2017 14:17:39 +0800
Message-ID: <CAOE=1Z3xuudQenX+Oe11fPDZfrC_d02S50HQ9mJ=RfnJ0B5DUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] How to use monitor socket in python to connect VM?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

Hi all,

I'm using python socket to connect VM's monitor socket like this:

[root@yf-mos-test-net09 tests]# python
> Python 2.7.5 (default, Jun 24 2015, 00:41:19)
> [GCC 4.8.3 20140911 (Red Hat 4.8.3-9)] on linux2
> Type "help", "copyright", "credits" or "license" for more information.
> >>> from socket import *
> >>> sock =3D socket(AF_INET, SOCK_STREAM, 0)
> >>> sock.connect(('127.0.0.1', 55902))
> >>> sock.recv(1024)
> "QEMU 2.6.0 monitor - type 'help' for more information\r\n(qemu) "
> >>> sock.recv(1024)
> ^CTraceback (most recent call last):
>   File "<stdin>", line 1, in <module>
> KeyboardInterrupt
> >>> sock.send('chardev-add
> socket,id=3Dchar-vhost_test_intf1,path=3D/usr/local/var/run/openvswitch/v=
host_test_intf1,server=3Don')
> 106
> >>> sock.send('netdev_add
> vhost-user,id=3Dvhost_test_intf1,chardev=3Dchar-vhost_test_intf1,vhostfor=
ce=3Don')
> 85
> >>> sock.send('device_add
> virtio-net-pci,netdev=3Dvhost_test_intf1,mac=3D00:22:79:29:d2:6c,id=3Dnet=
dev-vhost_test_intf1')
> 98
> >>> sock.recv(1024)
> 'c\x1b[K\x1b[Dch\x1b[K\x1b[D\x1b[Dcha\x1b[K\x1b[D\x1b[D\x1b[Dchar\x1b[K\x=
1b[D\x1b[D\x1b[D\x1b[Dchard\x1b[K\x1b[D\x1b[D\x1b[D\x1b[D\x1b[Dcharde\x1b[K=
\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[Dchardev\x1b[K\x1b[D\x1b[D\x1b[D\x1b[D\x=
1b[D\x1b[D\x1b[Dchardev-\x1b[K\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1=
b[Dchardev-a\x1b[K\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[Dcha=
rdev-ad\x1b[K\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[Dch=
ardev-add\x1b[K\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D=
\x1b[Dchardev-add
> \x1b[K\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\=
x1b[Dchardev-add
> s\x1b[K\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D=
\x1b[D\x1b[Dchardev-add
> so\x1b[K\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[=
D\x1b[D\x1b[D\x1b[Dchardev-add
> soc\x1b[K\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b=
[D\x1b[D\x1b[D\x1b[D\x1b[Dchardev-add
> sock\x1b[K\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1=
b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[Dchardev-add
> socke\x1b[K\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x=
1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[Dchardev-add
> socket\x1b[K\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\=
x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[Dchardev-add
> socket,\x1b[K\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D=
\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[Dchardev-add
> socket,i\x1b[K\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[=
D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[Dchardev-add
> socket,id\x1b[K\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b=
[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[D\x1b[Dchardev=
-add
> socket,id=3D\x1b[K\x1b[D\x1b[D\x1b[D\x1b[D'
> >>>


But as we see, there are problems:
1. commands like '>>> sock.send('chardev-add
socket,id=3Dchar-vhost_test_intf1,path=3D/usr/local/var/run/openvswitch/vho=
st_test_intf1,server=3Don')
106'  does not work, this I'm very sure and I use some method to verify it.
2. commands like '>>> sock.recv(1024)' got a lot of unknown characters.

So is there some one who use python(or shell) to connect monitor socket of
VM? Could you please share the code or tell me the way to operate?

For example, should I send command with '(qemu) ' before my command? Should
I recv result by the end of '\r\n' or something?

Thank you~
