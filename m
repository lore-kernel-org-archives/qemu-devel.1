Received: from eggs.gnu.org ([2001:4830:134:3::10]:37894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvl4x-0005ig-Fu
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 11:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fvkzF-0003sr-An
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 11:05:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50370 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fvkzC-0003py-KJ
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 11:05:23 -0400
References: <1535644031-848-1-git-send-email-Liam.Merwick@oracle.com>
	<1535644031-848-9-git-send-email-Liam.Merwick@oracle.com>
	<f8b68066-8427-ba2f-9205-a9b316a926b5@redhat.com>
	<ac300921-251a-7b9b-c097-150196fce7fe@oracle.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f19e373e-a6e5-62f8-f489-52605e5545d0@redhat.com>
Date: Fri, 31 Aug 2018 10:05:19 -0500
MIME-Version: 1.0
In-Reply-To: <ac300921-251a-7b9b-c097-150196fce7fe@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 8/8] qcow2: Read outside array bounds in
 qcow2_pre_write_overlap_check()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>, qemu-devel@nongnu.org

On 08/31/2018 08:32 AM, Liam Merwick wrote:

>>
>> The fix looks correct, but to prevent the problem from happening=20
>> again, I'd suggest you also add a compile-time BUG_ON that fails if=20
>> the array size gets out of sync again due to another addition of=20
>> another overlap detection bit.
>>
>=20
> Good idea. There is no generic BUG_ON in QEMU (just a few private=20
> copies) or BUILD_BUG_ON. I can add a commit that introduces a copy of=20
> include/linux/build_bug.h from the Linux kernel and use BUILD_BUG_ON in=
=20
> this commit.=C2=A0 Is there any reason not to do that?

We already have the generic QEMU_BUILD_BUG_ON() used throughout the=20
tree; that's the one to use here, rather than adding yet another macro=20
with a similar functionality.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
