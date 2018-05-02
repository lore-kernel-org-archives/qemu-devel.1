Received: from eggs.gnu.org ([2001:4830:134:3::10]:41114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDtXL-00041c-4m
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDtXK-0002rw-5t
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:19:19 -0400
References: <1525268093-531-1-git-send-email-ivanren@tencent.com>
	<44cdffb1-e5f5-d324-8880-1ee2e07c3954@redhat.com>
	<69c3123f-4ef2-7bdc-6042-1271fc8689e6@redhat.com>
	<34320941-dbea-8499-d342-7df967e4c23f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4ca76bd5-4b9a-636f-aa64-4f1aa02de4cf@redhat.com>
Date: Wed, 2 May 2018 10:19:03 -0500
MIME-Version: 1.0
In-Reply-To: <34320941-dbea-8499-d342-7df967e4c23f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-img: return allocated size for block
 device with qcow2 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Ivan Ren <renyime@gmail.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

On 05/02/2018 10:13 AM, Max Reitz wrote:

>> We also recently added 'qemu-img measure', which DOES report how many
>> clusters are in use.=C2=A0 Is any of that reusable here?
>=20
> It only tells you that information for a hypothetical new image, though=
,
> doesn't it?

It has two uses: with just a size, estimate the overhead needed to=20
create a file with the given format and exposing the given size to the=20
guest (both sparse and fully allocated sizes are estimated); and with a=20
pre-existing image, compute the exact overhead needed for 'qemu-img=20
convert' to create a new image with the given format and the same=20
guest-visible contents.  The latter use, where it uses an existing guest=20
image as the starting point to measure, indeed only tells you what a=20
hypothetical new image will occupy (the used cluster count, not the=20
wr_highest_offset count) - but isn't that what you want?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
