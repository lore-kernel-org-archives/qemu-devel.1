Received: from eggs.gnu.org ([2001:4830:134:3::10]:41454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCmHS-0003ZR-GC
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCmHP-0004Zp-AG
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:54:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gCmHP-0004Xt-1a
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:54:31 -0400
References: <20181008131924.7377-1-d.csapak@proxmox.com>
	<1f00827b-4c94-e10c-ab57-4ceb5223bee9@proxmox.com>
	<d2f89cb6-0ea5-75bc-1bb1-3f0ce6509ec4@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a8739a07-0675-5e16-b357-6bb2179aed11@redhat.com>
Date: Wed, 17 Oct 2018 08:54:23 -0500
MIME-Version: 1.0
In-Reply-To: <d2f89cb6-0ea5-75bc-1bb1-3f0ce6509ec4@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

On 10/17/18 5:58 AM, Paolo Bonzini wrote:

>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qapi_event_send_shutdown(s=
hutdown_caused_by_guest(request));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qapi_event_send_shutdown(s=
hutdown_caused_by_guest(request),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shutdown_was_reset);
>=20
> So the problem with shutdown_caused_by_guest is that you get the same
> value for both guest reset and guest shutdown.  Could we instead just
> pass the ShutdownCause in the event (similar to what was proposed even
> when discussing commit 08fba7ac9b618516a5f1d096f78a7e2837fe0594)?

Indeed, it sounds like we are now at the point where we want to do=20
precisely that - expose more fine-grained details by adding=20
ShutdownCause as a QAPI enum, rather than just adding another bool per=20
reason.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
