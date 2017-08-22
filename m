Received: from eggs.gnu.org ([2001:4830:134:3::10]:52813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkBze-00082p-3t
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 12:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkBza-0005rS-42
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 12:25:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkBzZ-0005rN-TX
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 12:25:26 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-52-marcandre.lureau@redhat.com>
	<20170822162400.51f07d89.cohuck@redhat.com>
	<d1574f35-ebe5-8ede-180a-e584834e9d9a@redhat.com>
	<87d17n61cr.fsf@dusky.pond.sub.org>
	<1dfa5fc1-5981-4283-eb36-eb29194bdb8a@redhat.com>
Date: Tue, 22 Aug 2017 18:25:19 +0200
In-Reply-To: <1dfa5fc1-5981-4283-eb36-eb29194bdb8a@redhat.com> (David
	Hildenbrand's message of "Tue, 22 Aug 2017 18:01:59 +0200")
Message-ID: <87k21v36z4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 51/54] qapi: make s390 commands depend
 on TARGET_S390X
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, "Dr. David
	Alan Gilbert" <dgilbert@redhat.com>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>

David Hildenbrand <david@redhat.com> writes:

>> Yes, but Marc-Andr=C3=A9's patch makes the "not supported yet" informati=
on
>> available in query-qmp-schema.  Carrying such information is pretty much
>> the point of schema introspection.
>>=20
>> We could add a comment explaining this command isn't target-specific,
>> but just happens not to be implemented for some targets.  Would that
>> help?
>>=20
>
> Certainly!

Let's do it then.
