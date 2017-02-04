Received: from eggs.gnu.org ([2001:4830:134:3::10]:56988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cZzgW-0007UT-Tu
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 07:43:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cZzgW-00054A-0k
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 07:43:20 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<20170202202739.GA15804@work-vm> <87shnvhfwc.fsf@dusky.pond.sub.org>
	<6e65ad3c-db00-0ce5-a9c6-0e8ba84ad3c6@redhat.com>
	<87zii270hm.fsf@dusky.pond.sub.org>
	<da71759e-5bce-2089-3be7-f0d256468ee8@redhat.com>
	<87poiy2mwv.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fc4c70f1-e111-8cca-fcc5-4f38b906880a@redhat.com>
Date: Sat, 4 Feb 2017 04:43:11 -0800
MIME-Version: 1.0
In-Reply-To: <87poiy2mwv.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Non-flat command line option argument syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 04/02/2017 03:52, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 04/02/2017 01:45, Markus Armbruster wrote:
>>>>>      -drive driver=qcow2,
>>>>>             file.driver=gluster,
>>>>>                 .volume=testvol,
>>>>>                 .path=/path/a.qcow2,
>>>>>                 .debug=9,
>>>>>             file.server.0.type=tcp,
>>>>>                          .host=1.2.3.4,
>>>>>                          .port=24007,
>>>>>             file.server.1.type=unix,
>>>>>                          .socket=/var/run/glusterd.socket
>>>>>
>>>>> Mind, I'm not at all sure this is a *good* idea.  I suspect it's more
>>>>> magic than it's worth.
>>>> As someone who likes dot syntax very much, I don't like it. If you
>>>> structure it like this, it's OK, but then you can just write the full
>>>> prefix (which gets the point across just as well because I can quickly
>>>> tell from a glance that it's the same prefix).
>>>>
>>>> OTOH, when joined into a single line it doesn't change much in terms of
>>>> legibility, in my opinion.
>>>
>>> Thanks!
>>
>> Actually I think it does improve legibility.
>>
>> It doesn't improve writability though, as anecdotally proved by Markus's
>> own mistake.
>>
>> I am a fan of the dot syntax too.  It seems to be the most incremental
>> solution, and it's still as expressive as JSON.
> 
> Noted.
> 
>> _However_ we could also extend -readconfig to support JSON, i.e. instead of
>>
>> 	[drive "abc"]
>> 		file = "foo"
>>
>> it could support
>>
>> 	{ 'drive': { 'file: 'foo' }, 'id': 'abc' }
>>
>> In other words [ would introduce key-value QemuOpts with dot syntax,
>> while { would introduce JSON.
> 
> Yes, we should support config files in JSON syntax.  Not sure mixing INI
> and JSON syntax in the same file is a good idea, though.

It's probably not, so we could have "-readconfig foo,syntax=json"
instead (yes, that's QemuOpts syntax---so meta).

Paolo
