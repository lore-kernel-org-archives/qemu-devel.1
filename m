Received: from eggs.gnu.org ([2001:4830:134:3::10]:46387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gGdrh-0006sK-HD
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 01:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gGdrc-0003eJ-JU
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 01:43:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gGdrc-0003dS-Df
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 01:43:52 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <87mur0ls8o.fsf@dusky.pond.sub.org>
	<20181026142216.GB493@redhat.com>
Date: Sun, 28 Oct 2018 06:43:44 +0100
In-Reply-To: <20181026142216.GB493@redhat.com> ("Daniel P. =?utf-8?Q?Berra?=
	=?utf-8?Q?ng=C3=A9=22's?= message
	of "Fri, 26 Oct 2018 15:22:16 +0100")
Message-ID: <87d0ruiq27.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Minutes of KVM Forum BoF on deprecating stuff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Pino Toscano <ptoscano@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Alberto Garcia <berto@igalia.com>, Eduardo Habkost <ehabkost@redhat.com>, Christophe de Dinechin <cdupontd@redhat.com>, qemu-devel@nongnu.org, Laine Stump <laine@redhat.com>, Thomas Huth <thuth@redhat.com>, Andrea Bolognani <abologna@redhat.com>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Oct 26, 2018 at 04:03:51PM +0200, Markus Armbruster wrote:
>> This is from my (imperfect) notes, corrections welcome.
>>=20
>> Motivation: QEMU contains stuff of dubious value, which gets in the way
>> in various (sometimes painful and expensive) ways.
>>
>> Deprecation is the marking of an external interface as "we intend to
>> remove this, you should stop using it" (preferably with advice on what
>> to use instead).  We have a deprecation policy to guide us through this
>> process.
>
>
> Something I meant to bring up but forgot is about the classification
> of devices, especially with a view towards security. It is not directly
> about deprecation, but it is somewhat related as it is related  to the
> state of maintainence and quality level
>
> We've got alot of devices, but only a subset are written and maintained
> to a level where we'd consider them robust wrt malcious guests. Other
> devices are only suitable for friendly guest environments. We should
> clearly document which are the devices that we consider to provide
> a secure boundary to guests, so users can make suitably informed choices.
> I'd guess this means all virtio devices, and then few of the emulated
> devices that are commonly used & maintained in a KVM environment.

A machine whose mandatory devices don't all provide a security boundary
also doesn't provide one.  Thus, classification of devices leads to a
classification of machines.

> This would be useful for distros/vendors/users who wish to limit their
> potential attack surface once we have a KConfig system for fine grained
> disablement of features.

Yes.
