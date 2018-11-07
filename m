Received: from eggs.gnu.org ([2001:4830:134:3::10]:56743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gKUKc-0001S2-Jo
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 15:21:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gKUKZ-00061o-Bh
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 15:21:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gKUKZ-00061R-5A
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 15:21:39 -0500
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
	<1539894735-14232-4-git-send-email-pbonzini@redhat.com>
	<01124fd1-83b2-c0c8-21d7-1f031a21ff3b@redhat.com>
	<329ff5d5-77a2-66ba-8930-cce79f4b8085@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <35765094-e6ff-1542-6b37-27a0515f0b09@redhat.com>
Date: Wed, 7 Nov 2018 14:21:36 -0600
MIME-Version: 1.0
In-Reply-To: <329ff5d5-77a2-66ba-8930-cce79f4b8085@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 03/48] qemu-timer: introduce timer attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Artem Pisarenko <artem.k.pisarenko@gmail.com>

On 11/6/18 3:45 AM, Paolo Bonzini wrote:
> On 06/11/2018 00:16, Eric Blake wrote:
>> On 10/18/18 3:31 PM, Paolo Bonzini wrote:
>>> From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
>>>
>>> Attributes are simple flags, associated with individual timers for th=
eir
>>> whole lifetime.=C2=A0 They intended to be used to mark individual tim=
ers for
>>> special handling when they fire.

>> git bisect points to this patch as the reason that 'make check' is
>> failing for me with:
>=20
> I think you have a stale file somewhere, because "git grep timer_init_t=
l
> 89a603a0c80ae3d6a8711571550b2ae9a01ea909" shows no occurrences.

Indeed a stale file, as 'find -name "*.o' -delete' cleared up the issue=20
- but it means we have a missing makefile dependency such that=20
incremental builds weren't able to notice that a .o needed to be rebuilt=20
to lose the stale reference.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
