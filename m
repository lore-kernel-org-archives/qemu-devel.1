Received: from eggs.gnu.org ([2001:4830:134:3::10]:41352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXMBR-0003B6-ME
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 03:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXMBQ-0001mI-Fm
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 03:45:09 -0400
References: <20180615142108.27814-1-kwolf@redhat.com>
	<20180615142108.27814-26-kwolf@redhat.com>
	<7a310b92-f8cb-b68b-d882-9b2959794347@de.ibm.com>
	<20180622125502.GF4366@localhost.localdomain>
	<ea6a2d92-8f69-d02e-e62b-0e71ed5e25f2@de.ibm.com>
	<20180622142513.GH4366@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <badca223-5398-58ac-af48-04c34dc98729@redhat.com>
Date: Mon, 25 Jun 2018 09:44:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180622142513.GH4366@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 25/26] block: Remove deprecated -drive
 option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, qemu-block@nongnu.org, libvir-list@redhat.com, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, pkrempa@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>

On 22.06.2018 16:25, Kevin Wolf wrote:
> Am 22.06.2018 um 15:36 hat Christian Borntraeger geschrieben:
>>
>>
>> On 06/22/2018 02:55 PM, Kevin Wolf wrote:
>>> Am 22.06.2018 um 13:38 hat Christian Borntraeger geschrieben:
>>>>
>>>> On 06/15/2018 04:21 PM, Kevin Wolf wrote:
>>>>> The -drive option serial was deprecated in QEMU 2.10. It's time to
>>>>> remove it.
>>>>>
>>>>> Tests need to be updated to set the serial number with -global inst=
ead
>>>>> of using the -drive option.
>>>>
>>>> libvirt 4.5 still creates those (at least on s390x)
>>>>
>>>>     <disk type=3D'file' device=3D'disk'>
>>>>       <driver name=3D'qemu' type=3D'qcow2' cache=3D'none' io=3D'nati=
ve' iothread=3D'1'/>
>>>>       <source file=3D'/var/lib/libvirt/qemu/image.zhyp137'/>
>>>>       <target dev=3D'hda' bus=3D'virtio'/>
>>>>       <serial>skel</serial>
>>>>       <boot order=3D'1'/>
>>>>       <address type=3D'ccw' cssid=3D'0xfe' ssid=3D'0x0' devno=3D'0x0=
000'/>
>>>>     </disk>
>>>>
>>>>
>>>> ->=20
>>>> [...]
>>>> -drive file=3D/var/lib/libvirt/qemu/image.zhyp137,format=3Dqcow2,if=3D=
none,id=3Ddrive-virtio-disk0,serial=3Dskel,cache=3Dnone,aio=3Dnative -dev=
ice virtio-blk-ccw,iothread=3Diothread1,scsi=3Doff,devno=3Dfe.0.0000,driv=
e=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1,write-cache=3Don=20
>>>> [...]
>>>>
>>>> 2018-06-22T11:25:20.946024Z qemu-system-s390x: -drive file=3D/var/li=
b/libvirt/qemu/image.zhyp137,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-d=
isk0,serial=3Dskel,cache=3Dnone,aio=3Dnative: Block format 'qcow2' does n=
ot support the option 'serial'
>>>> 2018-06-22 11:25:21.098+0000: shutting down, reason=3Dfailed
>>>>
>>>> So it seems that this breaks s390x.
>>
>> To me it seems that this is also broken on x86.
>>>
>>> Thanks for bringing this up. libvirt should fix this before QEMU 3.0 =
is
>>> released.
>>
>> I think this is definitely too short notice. We should not break exist=
ing
>> setups just by insisting that users have to update libvirt when they u=
pdate
>> QEMU. Yes, this might be our policy, but doing so "just because we can=
"
>> is certainly a very bad attitude. I see no fundamental technical reaso=
n why
>> we should not revert this change.
>=20
> This was in fact one release longer than our deprecation policy says.

Actually, if we assume that the chapter in qemu-doc.texi is the
"official" way to deprecate things, these options are only officially
deprecated since QEMU v2.12, since we missed to add them to the
deprecation chapter earlier:

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dc08d46a9

(We've mentioned them in
https://wiki.qemu.org/ChangeLog/2.10#Deprecated_options already, though)

 Thomas
