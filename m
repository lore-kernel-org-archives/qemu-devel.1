Received: from eggs.gnu.org ([2001:4830:134:3::10]:42955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXYEp-0003f9-LJ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 15:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXYEo-0002mk-Si
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 15:32:55 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-11-git-send-email-armbru@redhat.com>
	<1aa2bff6-8798-cfd4-e969-b98064dd7d4c@redhat.com>
	<87d18xk2si.fsf@dusky.pond.sub.org>
	<d1f4e349-c312-9000-6dc3-d3fa46fce903@redhat.com>
Date: Tue, 18 Jul 2017 21:32:47 +0200
In-Reply-To: <d1f4e349-c312-9000-6dc3-d3fa46fce903@redhat.com> (Eric Blake's
	message of "Tue, 18 Jul 2017 14:09:46 -0500")
Message-ID: <87vampee1s.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.10 10/10] migration: Use JSON null
 instead of "" to reset parameter to default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, mreitz@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 07/18/2017 01:39 PM, Markus Armbruster wrote:
>
>>>> +++ b/qapi-schema.json
>>>> @@ -116,6 +116,13 @@
>>>>  { 'command': 'qmp_capabilities' }
>>>>  
>>>>  ##
>>>> +# @StrOrNull:
>>>
>>> A little light on the documentation.
>> 
>> Care to suggest improvements?  I figure the schema is obvious enough
>> without any, but the generated documentation could perhaps use some.
>
> Perhaps:
>
> Specifies a string value or the explicit lack of a string (often used as
> an optional parameter type, where omitting the parameter has different
> semantics than supplying null).
> @s a JSON string
> @n an explicit NULL
>
>
> and certainly worth having
>
> Since: 2.10

What about:

##
# @StrOrNull:
#
# This is a string value or the explicit lack of a string (null
# pointer in C).  Intended for cases when 'optional absent' already
# has a different meaning.
#
# @s: the string value
# @n: no string value
#
# Since: 2.10
##
