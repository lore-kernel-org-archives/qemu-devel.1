Received: from eggs.gnu.org ([2001:4830:134:3::10]:60815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNreg-0004Sj-4m
	for qemu-devel@nongnu.org; Tue, 29 May 2018 23:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNreb-0006RG-GG
	for qemu-devel@nongnu.org; Tue, 29 May 2018 23:20:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33186 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fNreb-0006R2-Cv
	for qemu-devel@nongnu.org; Tue, 29 May 2018 23:20:01 -0400
References: <20180530030109.22404-1-chen_han_xiao@126.com>
	<38cf2387-bbac-e4e8-4c7f-d7ba9bdcd0e2@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2c1d1ac1-9f00-7469-b36b-2bb62de87b9a@redhat.com>
Date: Tue, 29 May 2018 22:20:00 -0500
MIME-Version: 1.0
In-Reply-To: <38cf2387-bbac-e4e8-4c7f-d7ba9bdcd0e2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qga: add mountpoint usage to
 GuestFilesystemInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chen Hanxiao <chen_han_xiao@126.com>, qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>

On 05/29/2018 10:19 PM, Eric Blake wrote:

>> @@ -846,13 +846,14 @@
>> =C2=A0 # @name: disk name
>> =C2=A0 # @mountpoint: mount point path
>> =C2=A0 # @type: file system type string
>> +# @usage: file system usage
>=20
> Needs more details.=C2=A0 As written, it is an integer between 0 and 10=
0; but=20
> if you use floating point, a better description would be a fraction=20
> between 0 and 1.

Also, missing a '(since 3.0)' designation.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
