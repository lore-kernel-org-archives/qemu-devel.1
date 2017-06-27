Received: from eggs.gnu.org ([2001:4830:134:3::10]:48190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPyT8-0005RK-RO
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 17:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPyT5-0005Cm-OP
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 17:56:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dPyT5-0005CM-Ji
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 17:56:19 -0400
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
	<589b8e71-b025-a0ad-0621-d6827e31c90d@suse.de>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b4bba4e4-0d69-095e-5fe2-0042bc414093@redhat.com>
Date: Tue, 27 Jun 2017 23:56:12 +0200
MIME-Version: 1.0
In-Reply-To: <589b8e71-b025-a0ad-0621-d6827e31c90d@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 00/14] Implement network booting
 directly into the s390-ccw BIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Jens Freimann <jfreiman@redhat.com>, Eric Farman <farman@linux.vnet.ibm.com>

On 27.06.2017 23:15, Alexander Graf wrote:
>=20
> On 27.06.17 13:48, Thomas Huth wrote:
[...]
>> - The code only supports TFTP (via UDP) ... I think that is OK for
>>    most use-cases, but if we ever want to support network booting
>>    via HTTP or something else that is based on TCP, we would need to
>>    use something else instead... Should we maybe rather head towards
>>    grub2, petitboot or something different instead?
>=20
> IMHO the only viable next step would be to support UEFI and build on to=
p
> of that - either by porting edk2 or U-Boot to s390x.

I can't speak of U-Boot, but you certainly don't want to port edk2 to a
big endian machine. Been there, seen that.

> The problem with solutions like petitboot or home grown grub2 targets i=
s
> that it becomes a documentation and knowledge sharing nightmare down th=
e
> road. The less we're different from everyone else, the easier it become=
s
> to maintain s390x.

petitboot is basically a Linux system (with a shell, too). And grub2 is
also a common boot loader on x86 nowadays ... so not sure whether they
would really be a knowledge sharing nightmare? I think they would be
more common for "server" people than the U-Boot loader, which is likely
only familiar to "embedded" folks.

 Thomas
