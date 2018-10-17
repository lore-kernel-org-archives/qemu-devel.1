Received: from eggs.gnu.org ([2001:4830:134:3::10]:55350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCn2k-00072M-Ts
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCn2f-0005Ct-26
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:43:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gCn2d-00059p-29
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:43:19 -0400
References: <20181008131924.7377-1-d.csapak@proxmox.com>
	<1f00827b-4c94-e10c-ab57-4ceb5223bee9@proxmox.com>
	<d2f89cb6-0ea5-75bc-1bb1-3f0ce6509ec4@redhat.com>
	<a8739a07-0675-5e16-b357-6bb2179aed11@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9659efd3-3f39-c880-745e-8561e1989f82@redhat.com>
Date: Wed, 17 Oct 2018 16:43:06 +0200
MIME-Version: 1.0
In-Reply-To: <a8739a07-0675-5e16-b357-6bb2179aed11@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qapi: add info about reset to SHUTDOWN
 event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

On 17/10/2018 15:54, Eric Blake wrote:
>>
>> So the problem with shutdown_caused_by_guest is that you get the same
>> value for both guest reset and guest shutdown.=C2=A0 Could we instead =
just
>> pass the ShutdownCause in the event (similar to what was proposed even
>> when discussing commit 08fba7ac9b618516a5f1d096f78a7e2837fe0594)?
>=20
> Indeed, it sounds like we are now at the point where we want to do
> precisely that - expose more fine-grained details by adding
> ShutdownCause as a QAPI enum, rather than just adding another bool per
> reason.

So should we split HOST_QMP into HOST_QMP_{SYSTEM_RESET,QUIT} and add
the ShutdownCause instead of was-reset?

Paolo
