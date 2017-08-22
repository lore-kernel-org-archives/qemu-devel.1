Received: from eggs.gnu.org ([2001:4830:134:3::10]:41971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dkBd3-0003qJ-Cj
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 12:02:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dkBd0-0008Fd-CS
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 12:02:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dkBd0-0008FT-69
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 12:02:06 -0400
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-52-marcandre.lureau@redhat.com>
	<20170822162400.51f07d89.cohuck@redhat.com>
	<d1574f35-ebe5-8ede-180a-e584834e9d9a@redhat.com>
	<87d17n61cr.fsf@dusky.pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1dfa5fc1-5981-4283-eb36-eb29194bdb8a@redhat.com>
Date: Tue, 22 Aug 2017 18:01:59 +0200
MIME-Version: 1.0
In-Reply-To: <87d17n61cr.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>


> Yes, but Marc-Andr=C3=A9's patch makes the "not supported yet" informat=
ion
> available in query-qmp-schema.  Carrying such information is pretty muc=
h
> the point of schema introspection.
>=20
> We could add a comment explaining this command isn't target-specific,
> but just happens not to be implemented for some targets.  Would that
> help?
>=20

Certainly!

--=20

Thanks,

David
