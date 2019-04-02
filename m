Received: from eggs.gnu.org ([209.51.188.92]:58988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jean-louis.solatges@wanadoo.fr>) id 1hBIor-0001tD-HF
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jean-louis.solatges@wanadoo.fr>) id 1hBIop-0004og-Pf
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:47:13 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:49306
	helo=smtp.smtpout.orange.fr)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jean-louis.solatges@wanadoo.fr>)
	id 1hBIoo-0004fL-3K
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:47:10 -0400
Date: Tue, 2 Apr 2019 14:47:25 +0200
From: Jean-Louis SOLATGES <jean-louis.solatges@wanadoo.fr>
Message-Id: <20190402144725.fc998797b28431d714cbacfc@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Unknown X11 keycode mapping  report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Bonjour, par tightvnc server sur clipper depuis un linux connect=E9 en vncv=
iewer,

je lance :
qemu-system-x86_64 -m 16G -cpu kvm64 -accel kvm,thread=3Dmulti -smp 6,maxcp=
us=3D12 -net nic -net tap -net socket,listen=3D127.0.0.1:1234 -vga cirrus -=
boot c -hda uis1.img



root@clipper:/home/jls/data# ** (qemu-system-x86_64:16384): WARNING **: Unk=
nown X11 keycode mapping '<null>'.
bash: syntax error near unexpected token `qemu-system-x86_64:16384'

--=20
jls** (qemu-system-x86_64:16384): WARNING **: Unknown X11 keycode mapping '=
<null>'.
Please report to qemu-devel@nongnu.org
including the following information:

  - Operating system
  - X11 Server
  - xprop -root
  - xdpyinfo

::::
Linux clipper 4.4.14 #2 SMP Fri Jun 24 13:38:27 CDT 2016 x86_64 Intel(R) Xe=
on(R) CPU           E5645  @ 2.40GHz GenuineIntel GNU/Linux



X.Org X Server 1.18.3
Release Date: 2016-04-04
X Protocol Version 11, Revision 0
Build Operating System: Slackware 14.2 Slackware Linux Project
Current Operating System: Linux clipper 4.4.14 #2 SMP Fri Jun 24 13:38:27 C=
DT 2016 x86_64
Kernel command line: auto BOOT_IMAGE=3DLinux ro root=3D801 vt.default_utf8=
=3D0
Build Date: 15 April 2016  11:05:21AM
=20
Current version of pixman: 0.34.0
        Before reporting problems, check http://wiki.x.org
        to make sure that you have the latest version.



root@clipper:/home/jls/data# xprop -root
CUT_BUFFER0(STRING) =3D "root@clipper:/home/jls/data# xprop -root\nCUT_BUFF=
ER0(STRING) =3D \"root@clipper:/home/jls/data# name of display:    :1\\nbas=
h: name: command not found\\nroot@clipper:/home/jls/data# version number:  =
  11.0\\nbash: version: command not found\\n\""

root@clipper:/home/jls/data# xdpyinfo=20
name of display:    :1
version number:    11.0
vendor string:    AT&T Laboratories Cambridge
vendor release number:    3332
maximum request size:  4194300 bytes
motion buffer size:  256
bitmap unit, bit order, padding:    32, LSBFirst, 32
image byte order:    LSBFirst
number of supported pixmap formats:    2
supported pixmap formats:supported pixmap formats:
    depth 1, bits_per_pixel 1, scanline_pad 32
    depth 24, bits_per_pixel 32, scanline_pad 32
keycode range:    minimum 8, maximum 255
focus:  PointerRoot
number of extensions:    7
    BIG-REQUESTS
    MIT-SHM
    MIT-SUNDRY-NONSTANDARD
    SHAPE
    SYNC
    XC-MISC
    XTEST
default screen number:    0
number of screens:    1

screen #0:
  dimensions:    1024x768 pixels (347x260 millimeters)
  resolution:    75x75 dots per inch
  depths (1):    24
  root window id:    0x25
  depth of root window:    24 planes
  number of colormaps:    minimum 1, maximum 1
  default colormap:    0x21
    depth 1, bits_per_pixel 1, scanline_pad 32
    depth 24, bits_per_pixel 32, scanline_pad 32
keycode range:    minimum 8, maximum 255
focus:  PointerRoot
number of extensions:    7
    BIG-REQUESTS
    MIT-SHM
    MIT-SUNDRY-NONSTANDARD
    SHAPE
    SYNC
    XC-MISC
    XTEST
default screen number:    0
number of screens:    1

screen #0:
  dimensions:    1024x768 pixels (347x260 millimeters)
  resolution:    75x75 dots per inch
  depths (1):    24
  root window id:    0x25
  depth of root window:    24 planes
  number of colormaps:    minimum 1, maximum 1
  default colormap:    0x21
 default number  default number of colormap cells:    256
  preallocated pixels:    black 0, white 16777215
  options:    backing-store YES, save-unders YES
  largest cursor:    1024x768
  current input event mask:    0x0
  number of visuals:    1
  default visual id:  0x22
  visual:
    visual id:    0x22
    class:    TrueColor
    depth:    24 planes
    available colormap entries:    256 per subfield
    red, green, blue masks:    0xff0000, 0xff00, 0xff
    significant bits in color specification:    8 bits


--------

Emul=E9 :Linux useit1 3.16.0-0.bpo.4-amd64 #1 SMP Debian 3.16.39-1+deb8u1~b=
po70+1 (2017-02-24) x86_64 GNU/Linux


X.Org X Server 1.12.4
Release Date: 2012-08-27
X Protocol Version 11, Revision 0
Build Operating System: Linux 3.16.0-4-amd64 x86_64 Debian
Current Operating System: Linux useit1 3.16.0-0.bpo.4-amd64 #1 SMP Debian 3=
.16.39-1+deb8u1~bpo70+1 (2017-02-24) x86_64
Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-3.16.0-0.bpo.4-amd64 root=
=3DUUID=3D73c0ba43-33c1-42b3-9aac-45f8ad9951d0 ro quiet splash
Build Date: 09 February 2015  09:46:52AM
xorg-server 2:1.12.4-6+deb7u6 (Julien Cristau <jcristau@debian.org>)=20
Current version of pixman: 0.26.0
        Before reporting problems, check http://wiki.x.org
        to make sure that you have the latest version.

-----


Merci.
