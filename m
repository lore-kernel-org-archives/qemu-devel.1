Received: from eggs.gnu.org ([2001:4830:134:3::10]:60704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fengli@smartx.com>) id 1fVr2u-0003ip-Cz
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 00:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fengli@smartx.com>) id 1fVr2t-0001BM-9Z
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 00:18:08 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:34598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fengli@smartx.com>) id 1fVr2s-0001B0-Tc
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 00:18:07 -0400
Received: by mail-wr0-x22e.google.com with SMTP id a12-v6so1594009wro.1
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 21:18:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHckoCxGZAeryX6zOp2=w4YZk1Bd3NWDT3xB9MaoEMiKeVPUtQ@mail.gmail.com>
References: <CAHckoCxGZAeryX6zOp2=w4YZk1Bd3NWDT3xB9MaoEMiKeVPUtQ@mail.gmail.com>
From: Li Feng <fengli@smartx.com>
Date: Thu, 21 Jun 2018 12:18:04 +0800
Message-ID: <CAHckoCzw6XgexWQV4PQMLwFbi6gjSqQoWPO+HSDwi-AY5=sP7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Fwd: port forward not work when using with macvtap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi all,

I create a vm with a macvtap network and a nat network.

```
netdev user,id=3Dfl.1,hostfwd=3Dtcp::5555-:22 \
-device e1000,netdev=3Dfl.1 \
-net nic,model=3Dvirtio,macaddr=3D$(< /sys/class/net/macvtap0/address) \
-net tap,fd=3D3 3<>/dev/tap$(< /sys/class/net/macvtap0/ifindex)
```
I create two network cards because the macvtap ip is got from dhcp, and I
have to login from vnc to get it.
So I add a nat card to use as port forward to login from ssh.

The macvtap works well with a dhcp ip.
However, the port forwd on nat isn't work. If I delete the macvtap from
qemu command, the port forwd works well.

On host, the port 5555 is listenning.
tcp        0      0 0.0.0.0:5555            0.0.0.0:*               LISTEN
    13218/qemu-system-x

But I couldn't login in ssh with using ` ssh -p 5555 192.168.17.61`, it
will hang.
 `ssh -p 5555 127.0.0.1 ` could success.

Anyone know how to fix this issue?

Millions of thanks.

Thanks,

--=20
The SmartX email address is only for business purpose. Any sent message=20
that is not related to the business is not authorized or permitted by=20
SmartX.
=E6=9C=AC=E9=82=AE=E7=AE=B1=E4=B8=BA=E5=8C=97=E4=BA=AC=E5=BF=97=E5=87=8C=E6=
=B5=B7=E7=BA=B3=E7=A7=91=E6=8A=80=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=EF=BC=
=88SmartX=EF=BC=89=E5=B7=A5=E4=BD=9C=E9=82=AE=E7=AE=B1. =E5=A6=82=E6=9C=AC=
=E9=82=AE=E7=AE=B1=E5=8F=91=E5=87=BA=E7=9A=84=E9=82=AE=E4=BB=B6=E4=B8=8E=E5=
=B7=A5=E4=BD=9C=E6=97=A0=E5=85=B3,=E8=AF=A5=E9=82=AE=E4=BB=B6=E6=9C=AA=E5=
=BE=97=E5=88=B0=E6=9C=AC=E5=85=AC=E5=8F=B8=E4=BB=BB=E4=BD=95=E7=9A=84=E6=98=
=8E=E7=A4=BA=E6=88=96=E9=BB=98=E7=A4=BA=E7=9A=84=E6=8E=88=E6=9D=83.
