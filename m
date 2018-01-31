Received: from eggs.gnu.org ([2001:4830:134:3::10]:46335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deniz.eren@icloud.com>) id 1egjgb-0007vT-MU
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 23:07:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deniz.eren@icloud.com>) id 1egjgY-0001DW-4v
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 23:07:49 -0500
Received: from st13p11im-asmtp004.me.com ([17.164.40.219]:59930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deniz.eren@icloud.com>)
	id 1egjgX-0001DI-S8
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 23:07:46 -0500
Received: from process-dkim-sign-daemon.st13p11im-asmtp004.me.com by
	st13p11im-asmtp004.me.com
	(Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built
	Jun 7 2017)) id <0P3E00700JCTD900@st13p11im-asmtp004.me.com> for
	qemu-devel@nongnu.org; Wed, 31 Jan 2018 04:07:45 +0000 (GMT)
From: Deniz Eren <deniz.eren@icloud.com>
Date: Wed, 31 Jan 2018 04:07:34 +0000 (GMT)
Message-id: <eb7fd59f-f460-4a6e-a474-dc2ac6074eb5@me.com>
MIME-version: 1.0
Content-Type: text/plain;
    charset=utf-8;
    format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCH_V4_0/7=5D_CAN_bus_support_for_QE?=
 =?utf-8?q?MU_=28SJA1000_PCI_so_far=29?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Stefan Hajnoczi <stefanha@gmail.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Oleksij Rempel <o.rempel@pengutronix.de>, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

Hi Paolo,=0A=0A=0A=0AThank you for the correction! Greatly appreciated and=
 it worked.=0A=0A=0A=0AI tested all combinations of Linux host using virtu=
al Socket-CAN and pcm3680 and mioe3680 client QEmu Linux environments usin=
g Linux Socket-CAN drivers, sending and receiving from each-other (all com=
binations; host-to-client, client-to-client, etc).=0A=0A=0AAll tests passe=
d!=0A=0A=0A=0ADetails:=0A=0A=0A=0ASetup virtual Socket-CAN from host Linux=
 system:=0A=0A=C2=A0=C2=A0=C2=A0 $ sudo ip link add dev vcan0 type vcan=0A=
=C2=A0=C2=A0=C2=A0 $ sudo ip link set up vcan0=0A=C2=A0=C2=A0=C2=A0 $ sudo=
 ip link add dev vcan1 type vcan=0A=C2=A0=C2=A0=C2=A0 $ sudo ip link set u=
p vcan1=0A=0A=C2=A0=C2=A0=C2=A0 $ sudo ip link set vcan0 txqueuelen 15=0A=C2=
=A0=C2=A0=C2=A0 $ sudo ip link set vcan1 txqueuelen 15=0A=0A=0AStarting 2 =
x QEmu sessions from host Linux; one for pcm3680 and other for mioe3680:=0A=
=0A=C2=A0=C2=A0=C2=A0 $ ./qemu-local/bin/qemu-system-i386 -hda sdd2gb-uno1=
483-16.04-2.0-dev.img -boot d -k en-us -object can-bus,id=3Dcanbus0 -objec=
t can-bus,id=3Dcanbus1 -object can-host-socketcan,id=3Dcanhost0,canbus=3Dc=
anbus0,if=3Dvcan0 -object can-host-socketcan,id=3Dcanhost1,canbus=3Dcanbus=
1,if=3Dvcan1 -device mioe3680_pci,canbus0=3Dcanbus0,canbus1=3Dcanbus1 -m s=
ize=3D2048 -netdev user,id=3Duser.0 -device e1000,netdev=3Duser.0 -redir t=
cp:5022::22 -enable-kvm &=0A=0A=C2=A0=C2=A0=C2=A0 $ ./qemu-local/bin/qemu-=
system-i386 -hda sdd2gb-uno1483-16.04-2.0-dev-copy.img -boot d -k en-us -o=
bject can-bus,id=3Dcanbus0 -object can-bus,id=3Dcanbus1 -object can-host-s=
ocketcan,id=3Dcanhost0,canbus=3Dcanbus0,if=3Dvcan0 -object can-host-socket=
can,id=3Dcanhost1,canbus=3Dcanbus1,if=3Dvcan1 -device pcm3680_pci,canbus0=3D=
canbus0,canbus1=3Dcanbus1 -m size=3D2048 -netdev user,id=3Duser.0 -device =
e1000,netdev=3Duser.0 -redir tcp:6022::22 -enable-kvm &=0A=0A=C2=A0=C2=A0 =
=C2=A0=0ALogin to client QEmu instances and setup CAN networks:=0A=0A=C2=A0=
=C2=A0=C2=A0 $ ssh -Yp5022 user@localhost=0A=0A=C2=A0=C2=A0=C2=A0 $ sudo i=
p link set can0 type can bitrate 250000=0A=C2=A0=C2=A0=C2=A0 $ sudo ip lin=
k set can1 type can bitrate 250000=0A=C2=A0=C2=A0=C2=A0 $ sudo ip link set=
 up can0=0A=C2=A0=C2=A0=C2=A0 $ sudo ip link set up can1=0A=C2=A0=C2=A0=C2=
=A0 $ sudo ip link set can0 txqueuelen 15=0A=C2=A0=C2=A0=C2=A0 $ sudo ip l=
ink set can1 txqueuelen 15=0A=0A=C2=A0=C2=A0=C2=A0 $ ssh -Yp6022 user@loca=
lhost=0A=0A=C2=A0=C2=A0=C2=A0 $ ... similarly ...=0A=0AThen tried all comb=
inations of "candump vcan0/1" from host and "candump can0/1" from clients =
for transmission and reception to and from host to client and client to cl=
ient.=0A=0Auser@:~$ candump can1=0A=C2=A0 can1=C2=A0 123=C2=A0=C2=A0 [8]=C2=
=A0 11 22 33 44 55 66 77 88=0A=C2=A0 can1=C2=A0 123=C2=A0=C2=A0 [8]=C2=A0 =
11 22 33 44 55 66 77 88=0A=C2=A0 can1=C2=A0 123=C2=A0=C2=A0 [8]=C2=A0 11 2=
2 33 44 55 66 77 88=0A=0Ahost:$ candump vcan0=0A=C2=A0 vcan0=C2=A0 123=C2=A0=
=C2=A0 [8]=C2=A0 11 22 33 44 55 66 77 88=0A=C2=A0 vcan0=C2=A0 123=C2=A0=C2=
=A0 [8]=C2=A0 11 22 33 44 55 66 77 88=0A=C2=A0 vcan0=C2=A0 123=C2=A0=C2=A0=
 [8]=C2=A0 11 22 33 44 55 66 77 88=0A=C2=A0 vcan0=C2=A0 123=C2=A0=C2=A0 [8=
]=C2=A0 11 22 33 44 55 66 77 88=0A=0AAll successful.=0A=0A=0A=0A=0A=0A=0A=0A=
Best regards,=0ADeniz=0A=0AOn Jan 31, 2018, at 12:10 PM, Paolo Bonzini <pb=
onzini@redhat.com> wrote:=0A=0A=0AOn 30/01/2018 20:08, Paolo Bonzini wrote=
:=0A=0AOn 30/01/2018 19:13, Deniz Eren wrote:=0AHi Pavel, Paolo,=0A=0A=0AI=
 tried to rerun my environment to test however it seems the interface has =
changed a little and my standard program options cause complaints. Unfortu=
nately I don=E2=80=99t have too much time to dig through at the moment.=0A=
=0A=0AMy standard startup command is:=0A=0A=0A$ ./qemu-local/bin/qemu-syst=
em-i386 -hda sdd2gb-uno1483-16.04-2.0-dev.img -boot d -k en-us -device mio=
e3680_pci,canbus1=3Dcanbus0,host1=3Dvcan0,canbus2=3Dcanbus1,host2=3Dvcan1 =
-m size=3D2048 -netdev user,id=3Duser.0 -device e1000,netdev=3Duser.0 -red=
ir tcp:5022::22 -enable-kvm &=0A=0A=0AYep, it's now like this:=0A=0A=0A./q=
emu-local/bin/qemu-system-i386 \=0A-hda sdd2gb-uno1483-16.04-2.0-dev.img -=
boot d -k en-us \=0A-object can-bus,id=3Dcanbus0 \=0A-object can-bus,id=3D=
canbus1 \=0A-object can-host-socketcan,id=3Dcanhost0,canbus=3Dcanbus0,ifna=
me=3Dvcan0 \=0A-object can-host-socketcan,id=3Dcanhost1,canbus=3Dcanbus1,i=
fname=3Dvcan1 \=0A-device mioe3680_pci,canbus0=3Dcanbus0,canbus1=3Dcanbus1=
 \=0A-m size=3D2048 -netdev user,id=3Duser.0 -device e1000,netdev=3Duser.0=
 \=0A-redir tcp:5022::22 -enable-kvm=0A=0ASorry, all "ifname" are "if".=0A=
=0APaolo=0A=0A=0AThanks,=0A=0A=0APaolo=0A=0A=0A=0A=0A=0A=0A=0A=0ABest rega=
rds,=0ADeniz=0A=0A=0ASent from my iPhone=0A=0A=0ADeniz Eren=0A+61 400 307 =
762=0A=0A=0AOn 31 Jan 2018, at 9:12 am, Pavel Pisa <pisa@cmp.felk.cvut.cz>=
 wrote:=0A=0A=0AHello Paolo,=0A=0A=0Athanks much for conversion to accepta=
ble QOM model.=0A=0A=0AOn Tuesday 30 of January 2018 15:15:22 Paolo Bonzin=
i wrote:=0AOn 25/01/2018 22:33, Pavel Pisa wrote:=0AHello Paolo,=0A=0A=0At=
hanks for suggestions. I understand and fully agree with your=0Arequest to=
 switch to QOM. I have succeed with that for CAN devices=0Asome time ago. =
It worth to be done for the rest of the objects=0Abut I fear that I do not=
 find time to complete QOMification=0Ain reasonable future. Contributions/=
suggestions from other=0Aare welcomed. I can look for students for GSoC at=
 our university=0Aor under other funding.=0A=0A=0APlease take a look at br=
anch can-pci-qom of github.com/bonzini/qemu.git.=0AApart from QOMification=
 of the backend include, I simplified the IRQ=0Ahandling in can_kvaser_pci=
 (fixing bugs too I think), and removed an=0Aunnecessary mutex. I also mov=
ed the files to net/can and hw/net/can so=0Athat in the future Jason (netw=
orking maintainer) can take care of pull=0Arequests.=0A=0A=0AI might have =
broken something, and the top commit in particular is=0Acompletely unteste=
d.=0A=0A=0AI have run basic test with Linux kernel on both sides=0Afor one=
 kavser_pci card on guest side and vcan (no real interface)=0Aon host side=
.=0A=0A=0AMesages exchange tests passed and looks OK.=0A=0A=0AI have used =
next parameters=0A=0A=0A-object can-bus,id=3Dcanbus0 \=0A-device kvaser_pc=
i,canbus=3Dcanbus0 \=0A-object can-host-socketcan,if=3Dcan0,canbus=3Dcanbu=
s0,id=3Dcanbus0-socketcan=0A=0A=0AThe id parameter is required for "can-ho=
st-socketcan" object.=0AElse next error is printed=0A=0A=0Aqemu-system-x86=
_64: -object can-host-socketcan,if=3Dcan0,canbus=3Dcanbus0: Parameter 'id'=
 is missing=0A=0A=0AIf "-object can-bus,id=3Dcanbus0" is missing then next=
 error is reported=0A=0A=0Aqemu-system-x86_64: -object can-host-socketcan,=
if=3Dcan0,canbus=3Dcanbus0,id=3Dcanbus0-socketcan: Device 'canbus0' not fo=
und=0A=0A=0AI have inspected through monitor the state of objects=0A=0A=0A=
(qemu) qom-list /objects=0Acanbus0-socketcan (child<can-host-socketcan>)=0A=
type (string)=0Acanbus0 (child<can-bus>)=0A=0A=0A(qemu) info qom-tree=0A/m=
achine (pc-i440fx-2.12-machine)=0A...=0A/peripheral-anon (container)=0A/de=
vice[1] (kvaser_pci)=0A/bus master[0] (qemu:memory-region)=0A/kvaser_pci-x=
ilinx[0] (qemu:memory-region)=0A/kvaser_pci-s5920[0] (qemu:memory-region)=0A=
/kvaser_pci-sja[0] (qemu:memory-region)=0A/bus master container[0] (qemu:m=
emory-region)=0A...=0A=0A=0A=0A=0A(qemu) qom-list /objects=0Acanbus0-socke=
tcan (child<can-host-socketcan>)=0Atype (string)=0Acanbus0 (child<can-bus>=
)=0A=0A=0A(qemu) qom-list /machine/peripheral-anon/device[1]=0Abus master =
container[0] (child<qemu:memory-region>)=0Acanbus (link<can-bus>)=0Arombar=
 (uint32)=0Ahotpluggable (bool)=0Ax-pcie-lnksta-dllla (bool)=0Akvaser_pci-=
sja[0] (child<qemu:memory-region>)=0Amultifunction (bool)=0Ahotplugged (bo=
ol)=0Aparent_bus (link<bus>)=0Aromfile (str)=0Akvaser_pci-s5920[0] (child<=
qemu:memory-region>)=0Ax-pcie-extcap-init (bool)=0Acommand_serr_enable (bo=
ol)=0Aaddr (int32)=0Atype (string)=0Alegacy-addr (str)=0Akvaser_pci-xilinx=
[0] (child<qemu:memory-region>)=0Arealized (bool)=0Abus master[0] (child<q=
emu:memory-region>)=0A=0A=0AFrom the user point of view, it would be nice =
if "can-bus"=0Acan be populated when required automatically.=0A=0A=0AI am =
not sure, but may it be that it would worth to=0Apush can-bus objects unde=
r some category/specific=0Acontainer. The path /objects is quite wide.=0AI=
nto something like /object/can-bus or /net/can.=0A=0A=0ABut generally than=
ks much, the progress you have made=0Ain one day is really great. I hope t=
hat others check=0Ayour branch. I have pushed your unmodified version into=
=0A"can-pci-qom" branch of my repo=0A=0A=0Ahttps://gitlab.fel.cvut.cz/canb=
us/qemu-canbus/tree/can-pci-qom=0A=0A=0A=0AIt would be great if others can=
 check that everything=0Aworks in their setup. I think that then it can be=
 pushed=0Ainto mainline and some usability improvements can be=0Adone/expe=
riment with later.=0A=0A=0AThanks much,=0A=0A=0A=0A=0APavel Pisa=0A=0A=0A=0A
