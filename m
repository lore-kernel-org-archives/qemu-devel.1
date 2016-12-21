Received: from eggs.gnu.org ([2001:4830:134:3::10]:52294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <holger@fam-schranz.de>) id 1cJgCB-0007Wd-Jy
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 07:40:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <holger@fam-schranz.de>) id 1cJgC8-0007Ke-3W
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 07:40:35 -0500
Received: from smtp2-2.goneo.de ([85.220.129.34]:49290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <holger@fam-schranz.de>)
	id 1cJgC7-0007Ja-OC
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 07:40:32 -0500
References: <c532ac07-fd54-eedb-b3f0-548aeacf0a04@fam-schranz.de>
	<3dce9a63-6472-54c2-3455-52521a0a3651@redhat.com>
	<89d9fe09-3bdc-3c84-3ddf-f9462adb2068@fam-schranz.de>
	<20161220234738.GB2994@lemon>
	<3512163a-f8c7-f4b7-7bd1-89675c74a1ac@fam-schranz.de>
	<274b8510-26a0-ce0d-4690-f9680ab59fba@fam-schranz.de>
From: Holger Schranz <holger@fam-schranz.de>
Message-ID: <9be92244-63ce-f0d6-c684-1d00c02ce2bc@fam-schranz.de>
Date: Wed, 21 Dec 2016 13:39:47 +0100
MIME-Version: 1.0
In-Reply-To: <274b8510-26a0-ce0d-4690-f9680ab59fba@fam-schranz.de>
Content-Type: multipart/mixed; boundary="------------60F24FCD5848CBCD683E01E8"
Subject: Re: [Qemu-devel] Strange/wrong behavior with iSCSI Tape devices in
 QEMU 2.8.0-rc4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: mueller-ralf@t-online.de, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org

This is a multi-part message in MIME format.
--------------60F24FCD5848CBCD683E01E8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

sorry for an additional mail.

Attached is the iscsiadm information which Fam requested.

Best regards

Holger

Am 21.12.2016 um 12:51 schrieb Holger Schranz:
> Hi Fam, John,
>
> meanwhile i have installed the 2.8.0 from the official wiki.qemu.org
> (tarball says rc4 ??).
>
> About dmesg, I have attached the dmesg from both version. In a short
> view ... in 2.6.2 you see the target stx/sgx and the controller for
> it. In the 2.8.0. nothing to see ... not controller nor devices.
>
> "git bisect" isn't fit to me :(. I never use it.
>
> The request for testing with iscsiadm host side to pass it to QEMU
> I haven't done related to the fact a can't see the controller for the
> iscsi devices in the VM guest. Should I do this in any cases?
>
> Best regards
>
> Holger
>
> Am 21.12.2016 um 05:44 schrieb Holger Schranz:
>> Hi Fam,
>>
>> meanwhile I have sent the requested QEMU CLI direct to John. Your=20
>> request
>> I will try after the reinstall with the released version.So please wai=
t
>> for a while.
>>
>> Best regards
>>
>> Holger
>>
>> Am 21.12.2016 um 00:47 schrieb Fam Zheng:
>>> On Tue, 12/20 17:53, Holger Schranz wrote:
>>>> Hi John,
>>>>
>>>> sorry or late. I will reproduce it and send you the QEMU command lin=
e
>>>> instruction.
>>>>
>>>> About the guest system: LINUX SuSE SLES11 SP4.
>>>>
>>>> About 2.7.0 Release: it doesn't run without the patches for the issu=
e:
>>>> [Qemu-devel] [PATCH] iscsi: Fix divide-by-zero regression on raw SG=20
>>>> devices
>>>>
>>>> (I can't find the issue number).
>>> Are there any related message showing up in guest dmesg?
>>>
>>> Is it possible to do a git bisect?
>>>
>>> Also, does it work if you login with host side iscsi client=20
>>> (iscsiadm) and pass
>>> the /dev/sgX to QEMU?
>>>
>>> Fam
>>>
>>>> Best regards
>>>>
>>>> Holger
>>>>
>>>> Am 19.12.2016 um 18:30 schrieb John Snow:
>>>>> On 12/19/2016 04:05 AM, Holger Schranz wrote:
>>>>>> # Strange/wrong behavior in QEMU 2.8.0-rc4
>>>>>>
>>>>>> After update from QEMU 2.6.2 to 2.8.0-rc4 the tape devices
>>>>>> and the corresponding medium changer are no longer available
>>>>>> in the VM quest system.
>>>>>>
>>>>>> The tape devices and the media changer are declared in the
>>>>>> xml-file for libvirt. Both, tape drives and medium changer
>>>>>> are avalilable via iSCSI.
>>>>>>
>>>>>> In a first rough investigation the login in iSCSI runs well
>>>>>> but in QEMU, it seems the devices doesn't reported to the VM-Quest=
.
>>>>>>
>>>>>> ------------------
>>>>>>
>>>>>> Best regards
>>>>>>
>>>>>> Holger
>>>>>>
>>>>> Hi, thanks for the report; do you have a QEMU command line that we=20
>>>>> can
>>>>> use to help reproduce the problem? It's easiest if we can cut libvi=
rt
>>>>> out of the loop.
>>>>>
>>>>> What is the architecture and version of the guest?
>>>>>
>>>>> Lastly, it looks like this worked in our 2.7 release if I'm=20
>>>>> reading you
>>>>> correctly, so this is a change for the 2.8 release as far as you ca=
n
>>>>> tell, right?
>>>>>
>>>>> --js
>>>>>
>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
>>>>>>
>>>>>>
>>>>>> XML-Declration:
>>>>>>
>>>>>> .
>>>>>> .
>>>>>> .
>>>>>>
>>>>>> <!-- SCSI 2 -->
>>>>>>       <controller type=3D'scsi' model=3D'virtio-scsi' index=3D'1'>
>>>>>>         <alias name=3D'scsi1'/>
>>>>>>       </controller>
>>>>>>
>>>>>> <!-- 2 x LTO5 -->
>>>>>>       <hostdev mode=3D'subsystem' type=3D'scsi' managed=3D'no'=20
>>>>>> rawio=3D'yes'>
>>>>>>         <source protocol=3D'iscsi'
>>>>>> name=3D'iqn.2008-09.net.fsc:server.LT260_61003/4'>
>>>>>>         <host name=3D'etcsvms2.abg.fsc.net' port=3D'3260'/>
>>>>>>         </source>
>>>>>>         <address type=3D'drive' controller=3D'1' bus=3D'0' target=3D=
'2'=20
>>>>>> unit=3D'1'/>
>>>>>>       </hostdev>
>>>>>>
>>>>>>       <hostdev mode=3D'subsystem' type=3D'scsi' managed=3D'no'=20
>>>>>> rawio=3D'yes'>
>>>>>>         <source protocol=3D'iscsi'
>>>>>> name=3D'iqn.2008-09.net.fsc:server.LT260_61003/5'>
>>>>>>         <host name=3D'etcsvms2.abg.fsc.net' port=3D'3260'/>
>>>>>>         </source>
>>>>>>         <address type=3D'drive' controller=3D'1' bus=3D'0' target=3D=
'2'=20
>>>>>> unit=3D'2'/>
>>>>>>       </hostdev>
>>>>>>
>>>>>> <!-- Virtual media changer Fujitsu LT260 -->
>>>>>>       <hostdev mode=3D'subsystem' type=3D'scsi' managed=3D'no'=20
>>>>>> rawio=3D'yes'>
>>>>>>         <source protocol=3D'iscsi'
>>>>>> name=3D'iqn.2008-09.net.fsc:server.LT260_61003/6'>
>>>>>>         <host name=3D'etcsvms2.abg.fsc.net' port=3D'3260'/>
>>>>>>         </source>
>>>>>>         <address type=3D'drive' controller=3D'1' bus=3D'0' target=3D=
'2'=20
>>>>>> unit=3D'3'/>
>>>>>>       </hostdev>
>>>>>>
>>>>>> <!-- 2 x LTO6 (via PLP(LAN-attached library)) -->
>>>>>>       <hostdev mode=3D'subsystem' type=3D'scsi' managed=3D'no'=20
>>>>>> rawio=3D'yes'>
>>>>>>         <source protocol=3D'iscsi'
>>>>>> name=3D'iqn.2008-09.net.fsc:server.LT60_61005/3'>
>>>>>>         <host name=3D'etcsvms2.abg.fsc.net' port=3D'3260'/>
>>>>>>         </source>
>>>>>>         <address type=3D'drive' controller=3D'1' bus=3D'0' target=3D=
'2'=20
>>>>>> unit=3D'4'/>
>>>>>>       </hostdev>
>>>>>>
>>>>>>       <hostdev mode=3D'subsystem' type=3D'scsi' managed=3D'no'=20
>>>>>> rawio=3D'yes'>
>>>>>>         <source protocol=3D'iscsi'
>>>>>> name=3D'iqn.2008-09.net.fsc:server.LT60_61005/4'>
>>>>>>         <host name=3D'etcsvms2.abg.fsc.net' port=3D'3260'/>
>>>>>>         </source>
>>>>>>         <address type=3D'drive' controller=3D'1' bus=3D'0' target=3D=
'2'=20
>>>>>> unit=3D'5'/>
>>>>>>       </hostdev>
>>>>>> .
>>>>>> .
>>>>>> .
>>>>>>
>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=20
>>>>>>
>>>>>>
>>>>>>
>>>>>> correct behavior/Result inside the VM-Quest together with=20
>>>>>> QEMU/KVM 2.6.2
>>>>>> / 2.7.0
>>>>>> --=20
>>>>>> (VCSTCS82:A)IUP1:~ # lsscsi -g
>>>>>> [0:2:0:0]    disk    FTS      PRAID EP420i     4.25 /dev/sda=20
>>>>>> /dev/sg0
>>>>>> [3:0:0:0]    cd/dvd  QEMU     QEMU DVD-ROM     2.5+ /dev/sr0=20
>>>>>> /dev/sg1
>>>>>> [8:0:2:1]    tape    HP       Ultrium 5-SCSI   0001 /dev/st3=20
>>>>>> /dev/sg6
>>>>>> [8:0:2:2]    tape    HP       Ultrium 5-SCSI   0001 /dev/st2=20
>>>>>> /dev/sg5
>>>>>> [8:0:2:3]    mediumx FUJITSU  ETERNUS LT260    6.20  - /dev/sg4
>>>>>> [8:0:2:4]    tape    HP       Ultrium 6-SCSI   23AB /dev/st1=20
>>>>>> /dev/sg3
>>>>>> [8:0:2:5]    tape    HP       Ultrium 6-SCSI   23AB /dev/st0=20
>>>>>> /dev/sg2
>>>>>> [11:0:0:0]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdb=20
>>>>>> /dev/sg7
>>>>>> [11:0:0:2]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdh=20
>>>>>> /dev/sg13
>>>>>> [11:0:0:3]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdg=20
>>>>>> /dev/sg12
>>>>>> [11:0:0:4]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdf=20
>>>>>> /dev/sg11
>>>>>> [11:0:0:5]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sde=20
>>>>>> /dev/sg10
>>>>>> [11:0:0:6]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdd=20
>>>>>> /dev/sg9
>>>>>> [11:0:0:7]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdc=20
>>>>>> /dev/sg8
>>>>>> [11:0:0:15]  disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdi=20
>>>>>> /dev/sg14
>>>>>> (VCSTCS82:A)IUP1:~ #
>>>>>>
>>>>>>
>>>>>>
>>>>>> Wrong behavior/Result inside the VM-Quest together with QEMU/KVM=20
>>>>>> 2.8.0-RC4
>>>>>> --=20
>>>>>> (VCSTCS82:A)IUP1:~ # lsscsi -g
>>>>>> [0:2:0:0]    disk    FTS      PRAID EP420i     4.25 /dev/sda=20
>>>>>> /dev/sg0
>>>>>> [3:0:0:0]    cd/dvd  QEMU     QEMU DVD-ROM     2.5+ /dev/sr0=20
>>>>>> /dev/sg1
>>>>>> [11:0:1:0]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdj=20
>>>>>> /dev/sg10
>>>>>> [11:0:1:2]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdp=20
>>>>>> /dev/sg16
>>>>>> [11:0:1:3]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdo=20
>>>>>> /dev/sg15
>>>>>> [11:0:1:4]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdn=20
>>>>>> /dev/sg14
>>>>>> [11:0:1:5]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdm=20
>>>>>> /dev/sg13
>>>>>> [11:0:1:6]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdl=20
>>>>>> /dev/sg12
>>>>>> [11:0:1:7]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdk=20
>>>>>> /dev/sg11
>>>>>> [11:0:1:15]  disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdq=20
>>>>>> /dev/sg17
>>>>>> (VCSTCS82:A)IUP1:~ #
>>>>>>
>>>>
>>>> ---
>>>> Diese E-Mail wurde von Avast Antivirus-Software auf Viren gepr=C3=BC=
ft.
>>>> https://www.avast.com/antivirus
>>>>
>>>>
>>
>>
>> ---
>> Diese E-Mail wurde von Avast Antivirus-Software auf Viren gepr=C3=BCft=
.
>> https://www.avast.com/antivirus
>>
>>
>
>
>
> ---
> Diese E-Mail wurde von Avast Antivirus-Software auf Viren gepr=C3=BCft.
> https://www.avast.com/antivirus



---
Diese E-Mail wurde von Avast Antivirus-Software auf Viren gepr=C3=BCft.
https://www.avast.com/antivirus

--------------60F24FCD5848CBCD683E01E8
Content-Type: text/plain; charset=UTF-8;
 name="iscsi-show.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="iscsi-show.txt"

VGFyZ2V0IDYxMDAzOiBpcW4uMjAwOC0wOS5uZXQuZnNjOnNlcnZlci5MVDI2MF82MTAwMwog
ICAgU3lzdGVtIGluZm9ybWF0aW9uOgogICAgICAgIERyaXZlcjogaXNjc2kKICAgICAgICBT
dGF0ZTogcmVhZHkKICAgIElfVCBuZXh1cyBpbmZvcm1hdGlvbjoKICAgICAgICBJX1QgbmV4
dXM6IDIKICAgICAgICAgICAgSW5pdGlhdG9yOiBpcW4uMjAwOC0xMS5vcmcubGludXgta3Zt
OjA0MmIwMjY4LTQzYWQtNDUxOS1iOWE0LTE4YjY4NTc5Yzk5MCBhbGlhczogbm9uZQogICAg
ICAgICAgICBDb25uZWN0aW9uOiAwCiAgICAgICAgICAgICAgICBJUCBBZGRyZXNzOiAxNzIu
MTcuMzYuNjQKICAgICAgICBJX1QgbmV4dXM6IDMKICAgICAgICAgICAgSW5pdGlhdG9yOiBp
cW4uMjAwOC0xMS5vcmcubGludXgta3ZtOjA0MmIwMjY4LTQzYWQtNDUxOS1iOWE0LTE4YjY4
NTc5Yzk5MCBhbGlhczogbm9uZQogICAgICAgICAgICBDb25uZWN0aW9uOiAwCiAgICAgICAg
ICAgICAgICBJUCBBZGRyZXNzOiAxNzIuMTcuMzYuNjQKICAgICAgICBJX1QgbmV4dXM6IDQK
ICAgICAgICAgICAgSW5pdGlhdG9yOiBpcW4uMjAwOC0xMS5vcmcubGludXgta3ZtOjA0MmIw
MjY4LTQzYWQtNDUxOS1iOWE0LTE4YjY4NTc5Yzk5MCBhbGlhczogbm9uZQogICAgICAgICAg
ICBDb25uZWN0aW9uOiAwCiAgICAgICAgICAgICAgICBJUCBBZGRyZXNzOiAxNzIuMTcuMzYu
NjQKICAgICAgICBJX1QgbmV4dXM6IDcKICAgICAgICAgICAgSW5pdGlhdG9yOiBpcW4uMjAw
OC0xMS5vcmcubGludXgta3ZtOjA0MmIwMjY4LTQzYWQtNDUxOS1iOWE0LTE4YjY4NTc5Yzk5
MSBhbGlhczogbm9uZQogICAgICAgICAgICBDb25uZWN0aW9uOiAwCiAgICAgICAgICAgICAg
ICBJUCBBZGRyZXNzOiAxNzIuMTcuMzYuNjQKICAgICAgICBJX1QgbmV4dXM6IDgKICAgICAg
ICAgICAgSW5pdGlhdG9yOiBpcW4uMjAwOC0xMS5vcmcubGludXgta3ZtOjA0MmIwMjY4LTQz
YWQtNDUxOS1iOWE0LTE4YjY4NTc5Yzk5MSBhbGlhczogbm9uZQogICAgICAgICAgICBDb25u
ZWN0aW9uOiAwCiAgICAgICAgICAgICAgICBJUCBBZGRyZXNzOiAxNzIuMTcuMzYuNjQKICAg
ICAgICBJX1QgbmV4dXM6IDkKICAgICAgICAgICAgSW5pdGlhdG9yOiBpcW4uMjAwOC0xMS5v
cmcubGludXgta3ZtOjA0MmIwMjY4LTQzYWQtNDUxOS1iOWE0LTE4YjY4NTc5Yzk5MSBhbGlh
czogbm9uZQogICAgICAgICAgICBDb25uZWN0aW9uOiAwCiAgICAgICAgICAgICAgICBJUCBB
ZGRyZXNzOiAxNzIuMTcuMzYuNjQKICAgIExVTiBpbmZvcm1hdGlvbjoKICAgICAgICBMVU46
IDAKICAgICAgICAgICAgVHlwZTogY29udHJvbGxlcgogICAgICAgICAgICBTQ1NJIElEOiBJ
RVQgICAgIGVlNGIwMDAwCiAgICAgICAgICAgIFNDU0kgU046IGJlYWY2MTAwMzAKICAgICAg
ICAgICAgU2l6ZTogMCBNQiwgQmxvY2sgc2l6ZTogMQogICAgICAgICAgICBPbmxpbmU6IFll
cwogICAgICAgICAgICBSZW1vdmFibGUgbWVkaWE6IE5vCiAgICAgICAgICAgIFByZXZlbnQg
cmVtb3ZhbDogTm8KICAgICAgICAgICAgUmVhZG9ubHk6IE5vCiAgICAgICAgICAgIFNXUDog
Tm8KICAgICAgICAgICAgVGhpbi1wcm92aXNpb25pbmc6IE5vCiAgICAgICAgICAgIEJhY2tp
bmcgc3RvcmUgdHlwZTogbnVsbAogICAgICAgICAgICBCYWNraW5nIHN0b3JlIHBhdGg6IE5v
bmUKICAgICAgICAgICAgQmFja2luZyBzdG9yZSBmbGFnczogCiAgICAgICAgTFVOOiAxCiAg
ICAgICAgICAgIFR5cGU6IHRhcGUKICAgICAgICAgICAgU0NTSSBJRDogSFAgVWx0cml1bSA1
LVNDU0kKICAgICAgICAgICAgU0NTSSBTTjogNjEwMDMwMDAKICAgICAgICAgICAgU2l6ZTog
MCBNQiwgQmxvY2sgc2l6ZTogMQogICAgICAgICAgICBPbmxpbmU6IFllcwogICAgICAgICAg
ICBSZW1vdmFibGUgbWVkaWE6IFllcwogICAgICAgICAgICBQcmV2ZW50IHJlbW92YWw6IE5v
CiAgICAgICAgICAgIFJlYWRvbmx5OiBObwogICAgICAgICAgICBTV1A6IE5vCiAgICAgICAg
ICAgIFRoaW4tcHJvdmlzaW9uaW5nOiBObwogICAgICAgICAgICBCYWNraW5nIHN0b3JlIHR5
cGU6IHNzYwogICAgICAgICAgICBCYWNraW5nIHN0b3JlIHBhdGg6IC9rdm0vQ1M4MjAwL0NT
VC9UQVBFTElCL0xUMjYwXzYxMDAzL1BWcy9ub3RhcGUxCiAgICAgICAgICAgIEJhY2tpbmcg
c3RvcmUgZmxhZ3M6IAogICAgICAgIExVTjogMgogICAgICAgICAgICBUeXBlOiB0YXBlCiAg
ICAgICAgICAgIFNDU0kgSUQ6IEhQIFVsdHJpdW0gNS1TQ1NJCiAgICAgICAgICAgIFNDU0kg
U046IDYxMDAzMDAxCiAgICAgICAgICAgIFNpemU6IDAgTUIsIEJsb2NrIHNpemU6IDEKICAg
ICAgICAgICAgT25saW5lOiBZZXMKICAgICAgICAgICAgUmVtb3ZhYmxlIG1lZGlhOiBZZXMK
ICAgICAgICAgICAgUHJldmVudCByZW1vdmFsOiBObwogICAgICAgICAgICBSZWFkb25seTog
Tm8KICAgICAgICAgICAgU1dQOiBObwogICAgICAgICAgICBUaGluLXByb3Zpc2lvbmluZzog
Tm8KICAgICAgICAgICAgQmFja2luZyBzdG9yZSB0eXBlOiBzc2MKICAgICAgICAgICAgQmFj
a2luZyBzdG9yZSBwYXRoOiAva3ZtL0NTODIwMC9DU1QvVEFQRUxJQi9MVDI2MF82MTAwMy9Q
VnMvbm90YXBlMgogICAgICAgICAgICBCYWNraW5nIHN0b3JlIGZsYWdzOiAKICAgICAgICBM
VU46IDMKICAgICAgICAgICAgVHlwZTogdGFwZQogICAgICAgICAgICBTQ1NJIElEOiBIUCBV
bHRyaXVtIDUtU0NTSQogICAgICAgICAgICBTQ1NJIFNOOiA2MTAwMzAwMgogICAgICAgICAg
ICBTaXplOiAwIE1CLCBCbG9jayBzaXplOiAxCiAgICAgICAgICAgIE9ubGluZTogWWVzCiAg
ICAgICAgICAgIFJlbW92YWJsZSBtZWRpYTogWWVzCiAgICAgICAgICAgIFByZXZlbnQgcmVt
b3ZhbDogTm8KICAgICAgICAgICAgUmVhZG9ubHk6IE5vCiAgICAgICAgICAgIFNXUDogTm8K
ICAgICAgICAgICAgVGhpbi1wcm92aXNpb25pbmc6IE5vCiAgICAgICAgICAgIEJhY2tpbmcg
c3RvcmUgdHlwZTogc3NjCiAgICAgICAgICAgIEJhY2tpbmcgc3RvcmUgcGF0aDogL2t2bS9D
UzgyMDAvQ1NUL1RBUEVMSUIvTFQyNjBfNjEwMDMvUFZzL25vdGFwZTMKICAgICAgICAgICAg
QmFja2luZyBzdG9yZSBmbGFnczogCiAgICAgICAgTFVOOiA0CiAgICAgICAgICAgIFR5cGU6
IHRhcGUKICAgICAgICAgICAgU0NTSSBJRDogSFAgVWx0cml1bSA1LVNDU0kKICAgICAgICAg
ICAgU0NTSSBTTjogNjEwMDMwMDMKICAgICAgICAgICAgU2l6ZTogMCBNQiwgQmxvY2sgc2l6
ZTogMQogICAgICAgICAgICBPbmxpbmU6IFllcwogICAgICAgICAgICBSZW1vdmFibGUgbWVk
aWE6IFllcwogICAgICAgICAgICBQcmV2ZW50IHJlbW92YWw6IE5vCiAgICAgICAgICAgIFJl
YWRvbmx5OiBObwogICAgICAgICAgICBTV1A6IE5vCiAgICAgICAgICAgIFRoaW4tcHJvdmlz
aW9uaW5nOiBObwogICAgICAgICAgICBCYWNraW5nIHN0b3JlIHR5cGU6IHNzYwogICAgICAg
ICAgICBCYWNraW5nIHN0b3JlIHBhdGg6IC9rdm0vQ1M4MjAwL0NTVC9UQVBFTElCL0xUMjYw
XzYxMDAzL1BWcy9ub3RhcGU0CiAgICAgICAgICAgIEJhY2tpbmcgc3RvcmUgZmxhZ3M6IAog
ICAgICAgIExVTjogNQogICAgICAgICAgICBUeXBlOiB0YXBlCiAgICAgICAgICAgIFNDU0kg
SUQ6IEhQIFVsdHJpdW0gNS1TQ1NJCiAgICAgICAgICAgIFNDU0kgU046IDYxMDAzMDA0CiAg
ICAgICAgICAgIFNpemU6IDAgTUIsIEJsb2NrIHNpemU6IDEKICAgICAgICAgICAgT25saW5l
OiBZZXMKICAgICAgICAgICAgUmVtb3ZhYmxlIG1lZGlhOiBZZXMKICAgICAgICAgICAgUHJl
dmVudCByZW1vdmFsOiBObwogICAgICAgICAgICBSZWFkb25seTogTm8KICAgICAgICAgICAg
U1dQOiBObwogICAgICAgICAgICBUaGluLXByb3Zpc2lvbmluZzogTm8KICAgICAgICAgICAg
QmFja2luZyBzdG9yZSB0eXBlOiBzc2MKICAgICAgICAgICAgQmFja2luZyBzdG9yZSBwYXRo
OiAva3ZtL0NTODIwMC9DU1QvVEFQRUxJQi9MVDI2MF82MTAwMy9QVnMvbm90YXBlNQogICAg
ICAgICAgICBCYWNraW5nIHN0b3JlIGZsYWdzOiAKICAgICAgICBMVU46IDYKICAgICAgICAg
ICAgVHlwZTogY2hhbmdlcgogICAgICAgICAgICBTQ1NJIElEOiBGVUpJVFNVIEVURVJOVVMg
TFQyNjAKICAgICAgICAgICAgU0NTSSBTTjogNDQyMgogICAgICAgICAgICBTaXplOiAwIE1C
LCBCbG9jayBzaXplOiAxCiAgICAgICAgICAgIE9ubGluZTogWWVzCiAgICAgICAgICAgIFJl
bW92YWJsZSBtZWRpYTogWWVzCiAgICAgICAgICAgIFByZXZlbnQgcmVtb3ZhbDogTm8KICAg
ICAgICAgICAgUmVhZG9ubHk6IE5vCiAgICAgICAgICAgIFNXUDogTm8KICAgICAgICAgICAg
VGhpbi1wcm92aXNpb25pbmc6IE5vCiAgICAgICAgICAgIEJhY2tpbmcgc3RvcmUgdHlwZTog
cmR3cgogICAgICAgICAgICBCYWNraW5nIHN0b3JlIHBhdGg6IC9rdm0vQ1M4MjAwL0NTVC9U
QVBFTElCL0xUMjYwXzYxMDAzL3NtYwogICAgICAgICAgICBCYWNraW5nIHN0b3JlIGZsYWdz
OiAKICAgIEFjY291bnQgaW5mb3JtYXRpb246CiAgICBBQ0wgaW5mb3JtYXRpb246CiAgICAg
ICAgQUxMClRhcmdldCA2MTAwNTogaXFuLjIwMDgtMDkubmV0LmZzYzpzZXJ2ZXIuTFQ2MF82
MTAwNQogICAgU3lzdGVtIGluZm9ybWF0aW9uOgogICAgICAgIERyaXZlcjogaXNjc2kKICAg
ICAgICBTdGF0ZTogcmVhZHkKICAgIElfVCBuZXh1cyBpbmZvcm1hdGlvbjoKICAgICAgICBJ
X1QgbmV4dXM6IDEKICAgICAgICAgICAgSW5pdGlhdG9yOiBpcW4uMjAwOC0xMS5vcmcubGlu
dXgta3ZtOjU3YzY0NTZmLWU1MzgtNGJlOS1hZWViLWIzYjMyY2QwY2YxMyBhbGlhczogbm9u
ZQogICAgICAgICAgICBDb25uZWN0aW9uOiAwCiAgICAgICAgICAgICAgICBJUCBBZGRyZXNz
OiAxNzIuMTcuMzYuNjQKICAgICAgICBJX1QgbmV4dXM6IDUKICAgICAgICAgICAgSW5pdGlh
dG9yOiBpcW4uMjAwOC0xMS5vcmcubGludXgta3ZtOjA0MmIwMjY4LTQzYWQtNDUxOS1iOWE0
LTE4YjY4NTc5Yzk5MCBhbGlhczogbm9uZQogICAgICAgICAgICBDb25uZWN0aW9uOiAwCiAg
ICAgICAgICAgICAgICBJUCBBZGRyZXNzOiAxNzIuMTcuMzYuNjQKICAgICAgICBJX1QgbmV4
dXM6IDYKICAgICAgICAgICAgSW5pdGlhdG9yOiBpcW4uMjAwOC0xMS5vcmcubGludXgta3Zt
OjA0MmIwMjY4LTQzYWQtNDUxOS1iOWE0LTE4YjY4NTc5Yzk5MCBhbGlhczogbm9uZQogICAg
ICAgICAgICBDb25uZWN0aW9uOiAwCiAgICAgICAgICAgICAgICBJUCBBZGRyZXNzOiAxNzIu
MTcuMzYuNjQKICAgICAgICBJX1QgbmV4dXM6IDEwCiAgICAgICAgICAgIEluaXRpYXRvcjog
aXFuLjIwMDgtMTEub3JnLmxpbnV4LWt2bTowNDJiMDI2OC00M2FkLTQ1MTktYjlhNC0xOGI2
ODU3OWM5OTEgYWxpYXM6IG5vbmUKICAgICAgICAgICAgQ29ubmVjdGlvbjogMAogICAgICAg
ICAgICAgICAgSVAgQWRkcmVzczogMTcyLjE3LjM2LjY0CiAgICAgICAgSV9UIG5leHVzOiAx
MQogICAgICAgICAgICBJbml0aWF0b3I6IGlxbi4yMDA4LTExLm9yZy5saW51eC1rdm06MDQy
YjAyNjgtNDNhZC00NTE5LWI5YTQtMThiNjg1NzljOTkxIGFsaWFzOiBub25lCiAgICAgICAg
ICAgIENvbm5lY3Rpb246IDAKICAgICAgICAgICAgICAgIElQIEFkZHJlc3M6IDE3Mi4xNy4z
Ni42NAogICAgTFVOIGluZm9ybWF0aW9uOgogICAgICAgIExVTjogMAogICAgICAgICAgICBU
eXBlOiBjb250cm9sbGVyCiAgICAgICAgICAgIFNDU0kgSUQ6IElFVCAgICAgZWU0ZDAwMDAK
ICAgICAgICAgICAgU0NTSSBTTjogYmVhZjYxMDA1MAogICAgICAgICAgICBTaXplOiAwIE1C
LCBCbG9jayBzaXplOiAxCiAgICAgICAgICAgIE9ubGluZTogWWVzCiAgICAgICAgICAgIFJl
bW92YWJsZSBtZWRpYTogTm8KICAgICAgICAgICAgUHJldmVudCByZW1vdmFsOiBObwogICAg
ICAgICAgICBSZWFkb25seTogTm8KICAgICAgICAgICAgU1dQOiBObwogICAgICAgICAgICBU
aGluLXByb3Zpc2lvbmluZzogTm8KICAgICAgICAgICAgQmFja2luZyBzdG9yZSB0eXBlOiBu
dWxsCiAgICAgICAgICAgIEJhY2tpbmcgc3RvcmUgcGF0aDogTm9uZQogICAgICAgICAgICBC
YWNraW5nIHN0b3JlIGZsYWdzOiAKICAgICAgICBMVU46IDEKICAgICAgICAgICAgVHlwZTog
dGFwZQogICAgICAgICAgICBTQ1NJIElEOiBIUCBVbHRyaXVtIDYtU0NTSQogICAgICAgICAg
ICBTQ1NJIFNOOiBIVUo2MTAwNTAKICAgICAgICAgICAgU2l6ZTogMCBNQiwgQmxvY2sgc2l6
ZTogMQogICAgICAgICAgICBPbmxpbmU6IFllcwogICAgICAgICAgICBSZW1vdmFibGUgbWVk
aWE6IFllcwogICAgICAgICAgICBQcmV2ZW50IHJlbW92YWw6IE5vCiAgICAgICAgICAgIFJl
YWRvbmx5OiBObwogICAgICAgICAgICBTV1A6IE5vCiAgICAgICAgICAgIFRoaW4tcHJvdmlz
aW9uaW5nOiBObwogICAgICAgICAgICBCYWNraW5nIHN0b3JlIHR5cGU6IHNzYwogICAgICAg
ICAgICBCYWNraW5nIHN0b3JlIHBhdGg6IC9rdm0vQ1M4MjAwL0NTVC9UQVBFTElCL0xUNjBf
NjEwMDUvUFZzL25vdGFwZTEKICAgICAgICAgICAgQmFja2luZyBzdG9yZSBmbGFnczogCiAg
ICAgICAgTFVOOiAyCiAgICAgICAgICAgIFR5cGU6IHRhcGUKICAgICAgICAgICAgU0NTSSBJ
RDogSFAgVWx0cml1bSA2LVNDU0kKICAgICAgICAgICAgU0NTSSBTTjogSFVKNjEwMDUxCiAg
ICAgICAgICAgIFNpemU6IDAgTUIsIEJsb2NrIHNpemU6IDEKICAgICAgICAgICAgT25saW5l
OiBZZXMKICAgICAgICAgICAgUmVtb3ZhYmxlIG1lZGlhOiBZZXMKICAgICAgICAgICAgUHJl
dmVudCByZW1vdmFsOiBObwogICAgICAgICAgICBSZWFkb25seTogTm8KICAgICAgICAgICAg
U1dQOiBObwogICAgICAgICAgICBUaGluLXByb3Zpc2lvbmluZzogTm8KICAgICAgICAgICAg
QmFja2luZyBzdG9yZSB0eXBlOiBzc2MKICAgICAgICAgICAgQmFja2luZyBzdG9yZSBwYXRo
OiAva3ZtL0NTODIwMC9DU1QvVEFQRUxJQi9MVDYwXzYxMDA1L1BWcy9ub3RhcGUyCiAgICAg
ICAgICAgIEJhY2tpbmcgc3RvcmUgZmxhZ3M6IAogICAgICAgIExVTjogMwogICAgICAgICAg
ICBUeXBlOiB0YXBlCiAgICAgICAgICAgIFNDU0kgSUQ6IEhQIFVsdHJpdW0gNi1TQ1NJCiAg
ICAgICAgICAgIFNDU0kgU046IEhVSjYxMDA1MgogICAgICAgICAgICBTaXplOiAwIE1CLCBC
bG9jayBzaXplOiAxCiAgICAgICAgICAgIE9ubGluZTogWWVzCiAgICAgICAgICAgIFJlbW92
YWJsZSBtZWRpYTogWWVzCiAgICAgICAgICAgIFByZXZlbnQgcmVtb3ZhbDogTm8KICAgICAg
ICAgICAgUmVhZG9ubHk6IE5vCiAgICAgICAgICAgIFNXUDogTm8KICAgICAgICAgICAgVGhp
bi1wcm92aXNpb25pbmc6IE5vCiAgICAgICAgICAgIEJhY2tpbmcgc3RvcmUgdHlwZTogc3Nj
CiAgICAgICAgICAgIEJhY2tpbmcgc3RvcmUgcGF0aDogL2t2bS9DUzgyMDAvQ1NUL1RBUEVM
SUIvTFQ2MF82MTAwNS9QVnMvbm90YXBlMwogICAgICAgICAgICBCYWNraW5nIHN0b3JlIGZs
YWdzOiAKICAgICAgICBMVU46IDQKICAgICAgICAgICAgVHlwZTogdGFwZQogICAgICAgICAg
ICBTQ1NJIElEOiBIUCBVbHRyaXVtIDYtU0NTSQogICAgICAgICAgICBTQ1NJIFNOOiBIVUo2
MTAwNTMKICAgICAgICAgICAgU2l6ZTogMCBNQiwgQmxvY2sgc2l6ZTogMQogICAgICAgICAg
ICBPbmxpbmU6IFllcwogICAgICAgICAgICBSZW1vdmFibGUgbWVkaWE6IFllcwogICAgICAg
ICAgICBQcmV2ZW50IHJlbW92YWw6IE5vCiAgICAgICAgICAgIFJlYWRvbmx5OiBObwogICAg
ICAgICAgICBTV1A6IE5vCiAgICAgICAgICAgIFRoaW4tcHJvdmlzaW9uaW5nOiBObwogICAg
ICAgICAgICBCYWNraW5nIHN0b3JlIHR5cGU6IHNzYwogICAgICAgICAgICBCYWNraW5nIHN0
b3JlIHBhdGg6IC9rdm0vQ1M4MjAwL0NTVC9UQVBFTElCL0xUNjBfNjEwMDUvUFZzL25vdGFw
ZTQKICAgICAgICAgICAgQmFja2luZyBzdG9yZSBmbGFnczogCiAgICAgICAgTFVOOiA1CiAg
ICAgICAgICAgIFR5cGU6IGNoYW5nZXIKICAgICAgICAgICAgU0NTSSBJRDogSUVUICAgICBl
ZTRkMDAwNQogICAgICAgICAgICBTQ1NJIFNOOiBMVERFNjU0NDQ5ODJfTEwwCiAgICAgICAg
ICAgIFNpemU6IDAgTUIsIEJsb2NrIHNpemU6IDEKICAgICAgICAgICAgT25saW5lOiBZZXMK
ICAgICAgICAgICAgUmVtb3ZhYmxlIG1lZGlhOiBZZXMKICAgICAgICAgICAgUHJldmVudCBy
ZW1vdmFsOiBObwogICAgICAgICAgICBSZWFkb25seTogTm8KICAgICAgICAgICAgU1dQOiBO
bwogICAgICAgICAgICBUaGluLXByb3Zpc2lvbmluZzogTm8KICAgICAgICAgICAgQmFja2lu
ZyBzdG9yZSB0eXBlOiByZHdyCiAgICAgICAgICAgIEJhY2tpbmcgc3RvcmUgcGF0aDogL2t2
bS9DUzgyMDAvQ1NUL1RBUEVMSUIvTFQ2MF82MTAwNS9zbWMKICAgICAgICAgICAgQmFja2lu
ZyBzdG9yZSBmbGFnczogCiAgICBBY2NvdW50IGluZm9ybWF0aW9uOgogICAgQUNMIGluZm9y
bWF0aW9uOgogICAgICAgIEFMTAo=
--------------60F24FCD5848CBCD683E01E8--
