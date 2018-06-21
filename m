Received: from eggs.gnu.org ([2001:4830:134:3::10]:42849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fW2ZO-00015I-Jq
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fW2ZL-0005jg-F4
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:36:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49086 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fW2ZL-0005jN-AO
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:36:23 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180615154203.11347-1-berrange@redhat.com>
	<20180615154203.11347-9-berrange@redhat.com>
	<48a79954-a9a7-cd76-40f2-c99e69ffb087@redhat.com>
	<20180621153941.GO3615@redhat.com>
Date: Thu, 21 Jun 2018 18:36:19 +0200
In-Reply-To: <20180621153941.GO3615@redhat.com> ("Daniel P. =?utf-8?Q?Berr?=
	=?utf-8?Q?ang=C3=A9=22's?=
	message of "Thu, 21 Jun 2018 16:39:41 +0100")
Message-ID: <8736xgjdvg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/11] authz: add QAuthZList object type
 for an access control list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, "Dr. David
	Alan Gilbert" <dgilbert@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Jun 21, 2018 at 10:28:23AM -0500, Eric Blake wrote:
>> On 06/15/2018 10:42 AM, Daniel P. Berrang=C3=A9 wrote:
>> > From: "Daniel P. Berrange" <berrange@redhat.com>
>> >=20
>> > Add a QAuthZList object type that implements the QAuthZ interface. This
>> > built-in implementation maintains a trivial access control list with a
>> > sequence of match rules and a final default policy. This replicates the
>> > functionality currently provided by the qemu_acl module.
>> >=20
>>=20
>> >=20
>> > It is not currently possible to create this via -object, since there is
>> > no syntax supported to specify non-scalar properties for objects. This
>> > is likely to be addressed by later support for using JSON with -object,
>> > or an equivalent approach.
>>=20
>> Is this statement slightly stale, since we have JSON support with --obje=
ct
>> already?
>
> That's news to me if we do. Markus did a PoC but AFAIK it was never
> proposed for merge so far.

Correct.  Can finish the job if there's a need.

[...]
