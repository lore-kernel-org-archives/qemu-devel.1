Received: from eggs.gnu.org ([2001:4830:134:3::10]:55274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f8h2l-0002iH-45
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 02:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f8h2g-0000sj-H8
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 02:58:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47582 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f8h2g-0000sc-Cv
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 02:58:10 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180329213857.15499-1-ehabkost@redhat.com>
	<20180329213857.15499-18-ehabkost@redhat.com>
	<87vacqf3da.fsf@dusky.pond.sub.org>
	<20180417144256.GW29865@localhost.localdomain>
Date: Wed, 18 Apr 2018 08:58:00 +0200
In-Reply-To: <20180417144256.GW29865@localhost.localdomain> (Eduardo Habkost's
	message of "Tue, 17 Apr 2018 11:42:56 -0300")
Message-ID: <87lgdl2e87.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC 17/18] validator.py script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Tue, Apr 17, 2018 at 02:01:53PM +0200, Markus Armbruster wrote:
>> Eduardo Habkost <ehabkost@redhat.com> writes:
[...]
>> > +    command-line: '$QEMU -nodefaults -machine none'
>> > +    monitor-commands:
>> > +    - qmp:
>> > +      - execute: qom-list-types
>> > +        arguments:
>> > +          implements: 'device'
>> > +          abstract: true
>> > +    - hmp: 'device_add help'
[...]
>> > +monitor-commands
>> > +~~~~~~~~~~~~~~~~
>> > +
>> > +Mapping or list-of-mappings containing monitor commands to run.

http://yaml.org/spec/1.2/spec.html talks about mappings and sequences.
Recommend to say "sequence" rather than "list".

I can't see how sequences come into play.  Your example's
monitor-command is a mapping, not a sequence of mappings.  Am I
confused?

>> >                                                                   The key on each
>> > +item can be ``hmp`` or ``qmp``.  The value on each entry can be a string,
>> > +mapping, or list.
>> > +
>> > +Default: None.
[...]
>> Can I do
>> 
>>     monitor-commands:
>>     - qmp:
>>       - execute: eins
>>     - hmp: zwei
>>     - qmp:
>>       - execute: drei
>> 
>> to execute eins, zwei, drei in this order?
>
> Yes, it can.  See the test specification examples.

I asked because the YAML spec I quoted above says mappings are unordered
and must be unique.  My example violates "unique", and your "yes, it
can" violates "unordered".

[...]
