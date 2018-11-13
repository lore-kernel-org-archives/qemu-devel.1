Received: from eggs.gnu.org ([2001:4830:134:3::10]:43497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gMVl0-0003tv-MK
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:17:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiezhide@huawei.com>) id 1gMVku-0003Lv-73
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:17:16 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:49702 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiezhide@huawei.com>) id 1gMVkt-0003LH-PC
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:17:12 -0500
From: xiezhide <xiezhide@huawei.com>
Date: Tue, 13 Nov 2018 10:17:06 +0000
Message-ID: <A02D6AA901860840B46E751C5E9E38B43CC96FEC@DGGEML532-MBX.china.huawei.com>
References: <A02D6AA901860840B46E751C5E9E38B42AFDB13F@DGGEML532-MBX.china.huawei.com>
	<A02D6AA901860840B46E751C5E9E38B43CC96A5B@DGGEML532-MBX.china.huawei.com>
	<20181112111357.5f60be3c@bahia.lan>
In-Reply-To: <20181112111357.5f60be3c@bahia.lan>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/2] virtio-9p: qmp interface for set/query
 io throttle for fsdev devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "berto@igalia.com" <berto@igalia.com>, "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>


> These patches provide the qmp interface, to set/query the io throttle=20
> status of the all fsdev devices that are present in a vm.
> Some of the patches also remove the
> duplicate code that was present in block and fsdev files.
>=20
> Zhide Xie (2):
>   fsdev-qmp: qmp interface for set/query io throttle for fsdev devices.
>   fsdev-qmp: fix coding style issue
>=20

Hi Zhide Xie,

This series seems to have some formatting issues, like the broken indention=
 in the diffstat below for example. Also, no message threading, weird Sob l=
ines:

Signed-off-by: x00390961 <xiezhide@huawei.com<mailto:xiezhide@huawei.com>>

and finally I couldn't even apply patch 1:

$ pwclient git-am 996225
Applying patch #996225 using 'git am'
Description: [1/2] virtio-9p: qmp interface to set/query io throttle for fs=
dev devices
Applying: virtio-9p: qmp interface to set/query io throttle for fsdev devic=
es

error: corrupt patch at line 36 <=3D=3D this confirms that the patch has fo=
rmatting issues.

Patch failed at 0001 virtio-9p: qmp interface to set/query io throttle for =
fsdev devices Use 'git am --show-current-patch' to see the failed patch Whe=
n you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
'git am' failed with exit status 128


Not sure what mail client was used to send this (I don't see any indication=
 in the mail headers), but if it's not the case already, I suggest you use =
git format-patch and git send-email.

I don't have much time, so I'll wait for the well-formatted v2 before start=
ing review :-)



Email client is outlook,  should be copy and paste issue, will fix in v2,  =
thanks

Thanks
Kidd
