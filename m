Received: from eggs.gnu.org ([2001:4830:134:3::10]:53421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eixgD-00069W-Nt
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 02:28:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eixgA-0002QB-83
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 02:28:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eixgA-0002OU-1O
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 02:28:34 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-4-armbru@redhat.com>
	<1cb0a904-25ff-fcac-bfac-7376683ed80d@redhat.com>
	<87vafe4fvv.fsf@dusky.pond.sub.org>
	<ef0c08bb-e277-1e86-cb3c-b4be13c0a0f4@redhat.com>
Date: Tue, 06 Feb 2018 08:28:28 +0100
In-Reply-To: <ef0c08bb-e277-1e86-cb3c-b4be13c0a0f4@redhat.com> (Eric Blake's
	message of "Mon, 5 Feb 2018 09:46:44 -0600")
Message-ID: <87lgg6fug3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 03/21] qapi: New classes QAPIGenC,
 QAPIGenH, QAPIGenDoc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 02/03/2018 02:49 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> On 02/02/2018 07:03 AM, Markus Armbruster wrote:
>>>> These classes encapsulate accumulating and writing output.
>>>>
>>>> Convert C code generation to QAPIGenC and QAPIGenH.  The conversion is
>>>> rather shallow: most of the output accumulation is not converted.
>>>> Left for later.
>>>>
>>>> The indentation machinery uses a single global variable indent_level,
>>>> even though we generally interleave creation of a .c and its .h.  It
>>>> should become instance variable of QAPIGenC.  Also left for later.
>>>>
>>>> Documentation generation isn't converted, and QAPIGenDoc isn't used.
>>>> This will change shortly.
>>>>
>
>>>>  schema = QAPISchema(input_file)
>>>> -gen = QAPISchemaGenEventVisitor()
>>>> -schema.visit(gen)
>>>> -fdef.write(gen.defn)
>>>> -fdecl.write(gen.decl)
>>>> +vis = QAPISchemaGenEventVisitor()
>>>> +schema.visit(vis)
>>>> +genc.body(vis.defn)
>>>> +genh.body(vis.decl)
>>>
>>> I don't know if it is worth a sentence in the commit message that the
>>> visitor variable is renamed from 'gen' to 'vis' for less confusion with
>>> the new class instances 'genc' and 'genh'.
>> 
>> Did the rename give you pause when reviewing?
>
> Enough to question whether it was intentional, since it wasn't mentioned
> in the commit message (I obviously figured out that it was intentional
> and useful, but the fact that I even pointed it out meant that I did
> pause during the review).

Okay, I'll try to make it clearer.
