Received: from eggs.gnu.org ([2001:4830:134:3::10]:47897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnl1w-0005EC-T3
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnl1s-00046F-56
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:26:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnl1r-000468-Ve
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:26:32 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1503602048-12268-1-git-send-email-armbru@redhat.com>
Date: Fri, 01 Sep 2017 14:26:23 +0200
In-Reply-To: <1503602048-12268-1-git-send-email-armbru@redhat.com> (Markus
	Armbruster's message of "Thu, 24 Aug 2017 21:13:52 +0200")
Message-ID: <87inh261w0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/16] qapi-schema: Reorganize along
 maintenance boundaries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Alberto Garcia <berto@igalia.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Markus Armbruster <armbru@redhat.com> writes:

> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Cc: Alberto Garcia <berto@igalia.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
>
> Much of the QAPI schema really belongs to a subsystem, but MAINTAINERS
> can't tell when it's all in a big ball of mud (qapi-schema.json) with
> a small ball of mud (event.json) on the side.
>
> Create sub-schemas for the subsystems with the most substantial QAPI
> footprint in the mud.  The big ball shrinks by half, and the small
> ball goes away.
>
> Bonus: the generated documentation's structure makes more sense now.
> It needs further improvement (see last patch), but it's a start.
>
> I generally kept the order intact when moving source code.  It may be
> smarter to reorder it for improved legibility (both source and
> generated doc).  Subsystem maintainers, please tell me whether you'd
> like things reordered.

Applied to qapi-next.  Prone to stupid conflicts, better move fast...

We may still want to reorder stuff for legibility.
