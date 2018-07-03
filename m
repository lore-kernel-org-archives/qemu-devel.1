Received: from eggs.gnu.org ([2001:4830:134:3::10]:49192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faKfr-0007Rc-1u
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faKfn-0004Ai-39
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:44:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58394 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faKfm-0004AJ-TD
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:44:47 -0400
References: <20180629195544.34263-1-eblake@redhat.com>
	<20180629195544.34263-3-eblake@redhat.com>
	<87r2kl8oey.fsf@dusky.pond.sub.org>
	<12e2f857-8052-3542-0475-b84f8f02c716@redhat.com>
	<87o9fo7tp4.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7a280a92-06d8-cf3b-3755-97f6c5b9b355@redhat.com>
Date: Tue, 3 Jul 2018 07:44:44 -0500
MIME-Version: 1.0
In-Reply-To: <87o9fo7tp4.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi: Drop qapi-gen --unmask option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

On 07/03/2018 12:51 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> On 07/02/2018 01:48 PM, Markus Armbruster wrote:
>>> Eric Blake <eblake@redhat.com> writes:
>>>
>>>> Now that we have useful access to the type name as a comment
>>>> in the generated qapi-introspect.c, we don't need to regenerate
>>>> code with a temporary -u option just to get at type names.
>>>>

>      # three lines: greeting, output of qmp_capabilities, query-qmp-schema
>      return json.loads(out.split('\n')[2])['return']
> 
> This returns an abstract syntax tree, represented in Python the obvious
> way.  I can then explore it in Python, say search for object types with
> certain properties.  For example, commit 2860b2b2cb8:
> 
>      Thus, the flaw puts an artificial restriction on the QAPI schema: we
>      can't have potentially empty objects and arrays within
>      BlockdevOptions, except when they're optional and "empty" has the same
>      meaning as "absent".
> 
> --> Our QAPI schema satisfies this restriction (I checked), but it's a
>      trap for the unwary, and a temptation to employ awkward workarounds
>      for the wary.  Let's get rid of it.
> 
> I checked with a Python script that read the schema as shown above.
> Without -u, I'd have to revert the identifier hiding.  I could certainly
> write some more Python to read the mapping from the generated C, but
> that feels like busy work.

Good argument. Okay, I'm dropping this patch, and tweaking the other 
patch commit message to explain that -u is still useful, even with the 
addition of comment aids.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
