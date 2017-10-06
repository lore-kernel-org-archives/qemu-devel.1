Received: from eggs.gnu.org ([2001:4830:134:3::10]:56977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e0LAP-00031p-KU
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 01:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e0LAM-0002I3-Hl
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 01:27:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1e0LAM-0002HV-C9
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 01:27:18 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-20-armbru@redhat.com>
	<CAJ+F1CJYd4LqyPtkmr40tnCKhDV63urnAhUgkX=M++njtPmgYw@mail.gmail.com>
	<87sheyi4uj.fsf@dusky.pond.sub.org>
	<8ae659b1-dbe5-e446-7fbe-bc044f4f8fa7@redhat.com>
Date: Fri, 06 Oct 2017 07:27:15 +0200
In-Reply-To: <8ae659b1-dbe5-e446-7fbe-bc044f4f8fa7@redhat.com> (Eric Blake's
	message of "Thu, 5 Oct 2017 10:16:43 -0500")
Message-ID: <87fuawalsc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 19/32] qapi: Accept double-quoted
 strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Eric Blake <eblake@redhat.com> writes:

> On 10/04/2017 11:41 PM, Markus Armbruster wrote:
>
>> Sadly, the schema language is neither JSON, nor an established extension
>> of JSON, nor Python.  This commit brings the schema language one step
>> closer to a superset of JSON.  I feel "homegrown superset" is a slightly
>> less bad idea than "homegrown with large overlap".
>> 
>> Naming the schema files .json was in bad taste.
>
> Would it make sense to rename all of our files from .json to .qapi?
> Then it is obvious that we are using a homegrown syntax; and it is also
> easy enough to tweak things like .dir-locals.el to recognize that suffix
> as triggering specific formatting rules.  Git rename detection means it
> is still reasonable to blame across file renames.

I don't know.  I'm always reluctant to rename files.  Probably too
reluctant.  Opinions?
