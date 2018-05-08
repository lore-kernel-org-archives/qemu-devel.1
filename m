Received: from eggs.gnu.org ([2001:4830:134:3::10]:43782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fG3oa-0001Pw-5C
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fG3oX-0002Dl-21
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:42:04 -0400
References: <1514187226.13662.28.camel@intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6e792b9f-2281-e8db-0410-c4c3468ffc90@redhat.com>
Date: Tue, 8 May 2018 09:41:40 -0500
MIME-Version: 1.0
In-Reply-To: <1514187226.13662.28.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Some question about savem/qcow2 incremental
 snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: He Junyan <junyan.he@intel.com>, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, qemu block <qemu-block@nongnu.org>

On 12/25/2017 01:33 AM, He Junyan wrote:
> hi all:
>=20
> I am now focusing on snapshot optimization for Intel NVDimm kind
> memory. Different from the normal memory, the NVDimm may be 128G, 256G
> or even more for just one guest, and its speed is slower than the
> normal memory. So sometimes it may take several minutes to complete
> just one snapshot saving. Even with compression enabled, the=C2=A0snaps=
hot
> point may consume more than 30G disk space.
> We decide to add incremental kind snapshot saving to resolve this. Just
> store difference between snapshot points to save time and disk space.
> But the current snapshot/save_vm framework seems not to support this.
> We need to add snapshot dependency and extra operations when we LOAD
> and DELETE the snapshot point.
> Is that possible to modify the savevm framework and add some
> incremental snapshot support to QCOW2 format?

In general, the list has tended to focus on external snapshots rather=20
than internal; where persistent bitmaps have been the proposed mechanism=20
for tracking incremental differences between snapshots.  But yes, it is=20
certainly feasible that patches to improve internal snapshots to take=20
advantage of incremental relationships may prove useful.  You will need=20
to document all enhancements to the qcow2 file format and get that=20
approved first, as interoperability demands that others reading the same=20
spec would be able to interpret the image you create that is utilizing=20
an internal snapshot with an incremental diff.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
