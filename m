Received: from eggs.gnu.org ([2001:4830:134:3::10]:56125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deniz.eren@icloud.com>) id 1egiqZ-0004qo-7S
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 22:14:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deniz.eren@icloud.com>) id 1egiqW-0003GJ-1a
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 22:14:03 -0500
Received: from st13p11im-asmtp003.me.com ([17.164.40.218]:16852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deniz.eren@icloud.com>)
	id 1egiqV-0003Dz-T4
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 22:13:59 -0500
Received: from process-dkim-sign-daemon.st13p11im-asmtp003.me.com by
	st13p11im-asmtp003.me.com
	(Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built
	Jun 7 2017)) id <0P3E00E008JKJW00@st13p11im-asmtp003.me.com> for
	qemu-devel@nongnu.org; Wed, 31 Jan 2018 00:13:58 +0000 (GMT)
Content-type: text/plain; charset=utf-8
MIME-version: 1.0 (1.0)
From: Deniz Eren <deniz.eren@icloud.com>
In-reply-to: <201801302312.59762.pisa@cmp.felk.cvut.cz>
Date: Wed, 31 Jan 2018 11:13:49 +1100
Content-transfer-encoding: quoted-printable
Message-id: <650E61A4-F6BF-46A4-B63D-6D935925F5AE@icloud.com>
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
	<201801252233.45477.pisa@cmp.felk.cvut.cz>
	<fe13d005-de44-fea3-6102-e9723aac398a@redhat.com>
	<201801302312.59762.pisa@cmp.felk.cvut.cz>
Subject: Re: [Qemu-devel] [PATCH V4 0/7] CAN bus support for QEMU (SJA1000
 PCI so far)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Stefan Hajnoczi <stefanha@gmail.com>, =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Oleksij Rempel <o.rempel@pengutronix.de>, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>, =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>

Hi Pavel, Paolo,

I tried to rerun my environment to test however it seems the interface has c=
hanged a little and my standard program options cause complaints. Unfortunat=
ely I don=E2=80=99t have too much time to dig through at the moment.

My standard startup command is:

$ ./qemu-local/bin/qemu-system-i386 -hda sdd2gb-uno1483-16.04-2.0-dev.img -b=
oot d -k en-us -device mioe3680_pci,canbus1=3Dcanbus0,host1=3Dvcan0,canbus2=3D=
canbus1,host2=3Dvcan1 -m size=3D2048 -netdev user,id=3Duser.0 -device e1000,=
netdev=3Duser.0 -redir tcp:5022::22 -enable-kvm &



Best regards,
Deniz

Sent from my iPhone

Deniz Eren
+61 400 307 762

> On 31 Jan 2018, at 9:12 am, Pavel Pisa <pisa@cmp.felk.cvut.cz> wrote:
>=20
> Hello Paolo,
>=20
> thanks much for conversion to acceptable QOM model.
>=20
>> On Tuesday 30 of January 2018 15:15:22 Paolo Bonzini wrote:
>>> On 25/01/2018 22:33, Pavel Pisa wrote:
>>> Hello Paolo,
>>>=20
>>> thanks for suggestions. I understand and fully agree with your
>>> request to switch to QOM. I have succeed with that for CAN devices
>>> some time ago. It worth to be done for the rest of the objects
>>> but I fear that I do not find time to complete QOMification
>>> in reasonable future. Contributions/suggestions from other
>>> are welcomed. I can look for students for GSoC at our university
>>> or under other funding.
>>=20
>> Please take a look at branch can-pci-qom of github.com/bonzini/qemu.git.
>> Apart from QOMification of the backend include, I simplified the IRQ
>> handling in can_kvaser_pci (fixing bugs too I think), and removed an
>> unnecessary mutex.  I also moved the files to net/can and hw/net/can so
>> that in the future Jason (networking maintainer) can take care of pull
>> requests.
>>=20
>> I might have broken something, and the top commit in particular is
>> completely untested.
>=20
> I have run basic test with Linux kernel on both sides
> for one kavser_pci card on guest side and vcan (no real interface)
> on host side.
>=20
> Mesages exchange tests passed and looks OK.
>=20
> I have used next parameters
>=20
>      -object can-bus,id=3Dcanbus0 \
>      -device kvaser_pci,canbus=3Dcanbus0 \
>      -object can-host-socketcan,if=3Dcan0,canbus=3Dcanbus0,id=3Dcanbus0-so=
cketcan
>=20
> The id parameter is required for "can-host-socketcan" object.
> Else next error is printed
>=20
>  qemu-system-x86_64: -object can-host-socketcan,if=3Dcan0,canbus=3Dcanbus0=
: Parameter 'id' is missing
>=20
> If "-object can-bus,id=3Dcanbus0" is missing then next error is reported
>=20
>  qemu-system-x86_64: -object can-host-socketcan,if=3Dcan0,canbus=3Dcanbus0=
,id=3Dcanbus0-socketcan: Device 'canbus0' not found
>=20
> I have inspected through monitor the state of objects
>=20
>  (qemu) qom-list /objects
>  canbus0-socketcan (child<can-host-socketcan>)
>  type (string)
>  canbus0 (child<can-bus>)
>=20
>  (qemu) info qom-tree
>  /machine (pc-i440fx-2.12-machine)
>    ...
>    /peripheral-anon (container)
>      /device[1] (kvaser_pci)
>        /bus master[0] (qemu:memory-region)
>        /kvaser_pci-xilinx[0] (qemu:memory-region)
>        /kvaser_pci-s5920[0] (qemu:memory-region)
>        /kvaser_pci-sja[0] (qemu:memory-region)
>        /bus master container[0] (qemu:memory-region)
>    ...
>=20
>=20
>  (qemu) qom-list /objects
>  canbus0-socketcan (child<can-host-socketcan>)
>  type (string)
>  canbus0 (child<can-bus>)
>=20
>  (qemu) qom-list /machine/peripheral-anon/device[1]
>  bus master container[0] (child<qemu:memory-region>)
>  canbus (link<can-bus>)
>  rombar (uint32)
>  hotpluggable (bool)
>  x-pcie-lnksta-dllla (bool)
>  kvaser_pci-sja[0] (child<qemu:memory-region>)
>  multifunction (bool)
>  hotplugged (bool)
>  parent_bus (link<bus>)
>  romfile (str)
>  kvaser_pci-s5920[0] (child<qemu:memory-region>)
>  x-pcie-extcap-init (bool)
>  command_serr_enable (bool)
>  addr (int32)
>  type (string)
>  legacy-addr (str)
>  kvaser_pci-xilinx[0] (child<qemu:memory-region>)
>  realized (bool)
>  bus master[0] (child<qemu:memory-region>)
>=20
> =46rom the user point of view, it would be nice if "can-bus"
> can be populated when required automatically.
>=20
> I am not sure, but may it be that it would worth to
> push can-bus objects under some category/specific
> container. The path /objects is quite wide.
> Into something like /object/can-bus or /net/can.
>=20
> But generally thanks much, the progress you have made
> in one day is really great. I hope that others check
> your branch. I have pushed your unmodified version into
> "can-pci-qom" branch of my repo
>=20
>  https://gitlab.fel.cvut.cz/canbus/qemu-canbus/tree/can-pci-qom
>=20
> It would be great if others can check that everything
> works in their setup. I think that then it can be pushed
> into mainline and some usability improvements can be
> done/experiment with later.
>=20
> Thanks much,
>=20
>=20
>                Pavel Pisa
