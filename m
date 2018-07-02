Received: from eggs.gnu.org ([2001:4830:134:3::10]:45168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa4vG-0006R4-OF
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 15:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa4vD-0004no-KE
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 15:55:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55448 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fa4vD-0004nc-FA
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 15:55:39 -0400
References: <20180629195544.34263-1-eblake@redhat.com>
	<20180629195544.34263-3-eblake@redhat.com>
	<87r2kl8oey.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <12e2f857-8052-3542-0475-b84f8f02c716@redhat.com>
Date: Mon, 2 Jul 2018 14:55:37 -0500
MIME-Version: 1.0
In-Reply-To: <87r2kl8oey.fsf@dusky.pond.sub.org>
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
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 07/02/2018 01:48 PM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> Now that we have useful access to the type name as a comment
>> in the generated qapi-introspect.c, we don't need to regenerate
>> code with a temporary -u option just to get at type names.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> I occasionally feed output of query-qmp-schema to ad hoc Python scripts.
> My last one searched for object types containing non-string members
> (directly or indirectly).  -u remains useful there, and having to
> recompile is not a problem.  I'd prefer to keep it.

Would it be any easier to argue for the removal of -u if the generated 
output resembled:

{ "ret-type", QLIT_QSTR("1") /* Foo */ },

that is, sticking in the comment everywhere the type name is mangled to 
an integer, rather than just once per type?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
