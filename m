Received: from eggs.gnu.org ([2001:4830:134:3::10]:42280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIHCK-0002wh-7F
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:19:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dIHCG-0006UD-58
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:19:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dIHCF-0006U9-VM
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 12:19:08 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170605085254.16485-1-sf@sfritsch.de>
	<e27e8fb4-64fa-9ba9-26a2-aa2af758462b@redhat.com>
	<39506179-0abd-5bba-89a2-fe89e6f3a167@redhat.com>
Date: Tue, 06 Jun 2017 18:19:00 +0200
In-Reply-To: <39506179-0abd-5bba-89a2-fe89e6f3a167@redhat.com> (Paolo
	Bonzini's message of "Tue, 6 Jun 2017 16:17:42 +0200")
Message-ID: <87a85ljdhn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] Add chardev-send-break monitor command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Stefan Fritsch <sf@sfritsch.de>, qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 05/06/2017 14:24, Eric Blake wrote:
>> On 06/05/2017 03:52 AM, Stefan Fritsch wrote:
>>> Sending a break on a serial console can be useful for debugging the
>>> guest. But not all chardev backends support sending breaks (only telnet
>>> and mux do). The chardev-send-break command allows to send a break even
>>> if using other backends.
>>>
>>> Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
>>> ---
>>>  chardev/char.c   | 12 ++++++++++++
>>>  hmp-commands.hx  | 16 ++++++++++++++++
>>>  hmp.c            |  8 ++++++++
>>>  hmp.h            |  1 +
>>>  qapi-schema.json | 20 ++++++++++++++++++++
>>>  5 files changed, 57 insertions(+)
>> 
>> Is there an obvious test that we can enhance to add coverage of the new
>> QMP command?
>
> You could have a new test covering hw/char/serial.c, but I wouldn't let
> that hold the patch.

Holding patches is pretty much the only leverage I have to get tests for
new stuff :)

Asking for tests that cover all of serial.c wouldn't be fair.  But I am
asking for basic test coverage of new QMP commands.


Message-ID: <871sugkrw5.fsf@dusky.pond.sub.org>
https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg00296.html
