Received: from eggs.gnu.org ([2001:4830:134:3::10]:54362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <d.csapak@proxmox.com>) id 1gErTi-00061l-N7
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <d.csapak@proxmox.com>) id 1gErTf-0000z5-Fz
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:51:50 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:21901)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <d.csapak@proxmox.com>)
	id 1gErTf-0000j8-7C
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:51:47 -0400
References: <20181008131924.7377-1-d.csapak@proxmox.com>
	<1f00827b-4c94-e10c-ab57-4ceb5223bee9@proxmox.com>
	<d2f89cb6-0ea5-75bc-1bb1-3f0ce6509ec4@redhat.com>
	<a8739a07-0675-5e16-b357-6bb2179aed11@redhat.com>
	<9659efd3-3f39-c880-745e-8561e1989f82@redhat.com>
From: Dominik Csapak <d.csapak@proxmox.com>
Message-ID: <10c48083-769c-1f29-deca-a359b598912f@proxmox.com>
Date: Tue, 23 Oct 2018 09:51:22 +0200
MIME-Version: 1.0
In-Reply-To: <9659efd3-3f39-c880-745e-8561e1989f82@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

On 10/17/18 4:43 PM, Paolo Bonzini wrote:
> On 17/10/2018 15:54, Eric Blake wrote:
>>>
>>> So the problem with shutdown_caused_by_guest is that you get the same
>>> value for both guest reset and guest shutdown.=C2=A0 Could we instead=
 just
>>> pass the ShutdownCause in the event (similar to what was proposed eve=
n
>>> when discussing commit 08fba7ac9b618516a5f1d096f78a7e2837fe0594)?
>>
>> Indeed, it sounds like we are now at the point where we want to do
>> precisely that - expose more fine-grained details by adding
>> ShutdownCause as a QAPI enum, rather than just adding another bool per
>> reason.
>=20
> So should we split HOST_QMP into HOST_QMP_{SYSTEM_RESET,QUIT} and add
> the ShutdownCause instead of was-reset?
>=20
> Paolo
>=20
>=20

this would work for us, should i send patches for this?
i would (roughly) do this:

move shutdowncause to qapi json
split host_qmp into system_reset and quit
and add the shutdowncause to the shutdown event
fix iotests

with kind regards
Dominik
