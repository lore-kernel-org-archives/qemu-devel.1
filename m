Received: from eggs.gnu.org ([2001:4830:134:3::10]:53465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dl6a1-0002ZX-6C
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 00:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dl6Zy-000397-3o
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 00:50:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dl6Zx-00037i-Ti
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 00:50:46 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1503602048-12268-1-git-send-email-armbru@redhat.com>
	<dcdd4567-684a-5ca6-3a34-bbb9ad35bf11@redhat.com>
Date: Fri, 25 Aug 2017 06:50:38 +0200
In-Reply-To: <dcdd4567-684a-5ca6-3a34-bbb9ad35bf11@redhat.com> (Eric Blake's
	message of "Thu, 24 Aug 2017 14:41:01 -0500")
Message-ID: <87y3q85jz5.fsf@dusky.pond.sub.org>
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Alberto Garcia <berto@igalia.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, marcandre.lureau@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 08/24/2017 02:13 PM, Markus Armbruster wrote:
>> Cc: "Daniel P. Berrange" <berrange@redhat.com>
>> Cc: Alberto Garcia <berto@igalia.com>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Juan Quintela <quintela@redhat.com>
>> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>=20
>> Much of the QAPI schema really belongs to a subsystem, but MAINTAINERS
>> can't tell when it's all in a big ball of mud (qapi-schema.json) with
>> a small ball of mud (event.json) on the side.
>>=20
>> Create sub-schemas for the subsystems with the most substantial QAPI
>> footprint in the mud.  The big ball shrinks by half, and the small
>> ball goes away.
>>=20
>> Bonus: the generated documentation's structure makes more sense now.
>> It needs further improvement (see last patch), but it's a start.
>>=20
>> I generally kept the order intact when moving source code.  It may be
>> smarter to reorder it for improved legibility (both source and
>> generated doc).  Subsystem maintainers, please tell me whether you'd
>> like things reordered.
>
> Ideally, moving from one file to another should be kept separate from
> reordering within a file, to make review easier.

I can move in order, then reorder in a separate patch, if that makes
review easier.

Reordering code is always awkward.  It's just less awkward when we
reshuffle things anyway.
