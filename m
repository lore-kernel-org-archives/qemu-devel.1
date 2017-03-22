Received: from eggs.gnu.org ([2001:4830:134:3::10]:38580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqZ2K-0003vK-T5
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 01:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqZ2H-0006P6-QL
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 01:42:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqZ2H-0006P0-KC
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 01:42:17 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1489494746.git.janne.huttunen@nokia.com>
	<1489510640.8844.18.camel@redhat.com>
	<1489561105.24841.25.camel@nokia.com>
	<1489562641.15659.16.camel@redhat.com>
	<1489657576.561.24.camel@nokia.com>
	<33ee8842-e57d-c637-ae26-e4b89a7c1002@redhat.com>
Date: Wed, 22 Mar 2017 06:42:12 +0100
In-Reply-To: <33ee8842-e57d-c637-ae26-e4b89a7c1002@redhat.com> (Eric Blake's
	message of "Tue, 21 Mar 2017 12:48:58 -0500")
Message-ID: <87inn1eukr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC][PATCH 0/6] "bootonceindex" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Janne Huttunen <janne.huttunen@nokia.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 03/16/2017 04:46 AM, Janne Huttunen wrote:
>> On Wed, 2017-03-15 at 08:24 +0100, Gerd Hoffmann wrote:
>>>>
>>>> The short answer: emulating real hardware.
>>>
>>> Ok, that is reason enough.
>>>
>>> Adding bootonceindex everywhere doesn't look like the best plan to me
>>> though.  Possibly we can pimp up bootindex in a backward-compatible
>>> way?
>>> Something like bootindex=<normal>[.<once>] ?
>> 
>> That would (likely) avoid modifying all devices, but wouldn't
>> that make the 'bootindex' property a string (now: 'int32')
>> and thus change the QOM API?
>
> Is there any way to make use of an alternate that supports both int and
> string simultaneously?  But see also Markus' recent addendum on the
> difficulties of supporting multiple types on command-line vs. through QMP:
>
> https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg04125.html

Making it a string that encodes two integers would be inappropriate for
QMP.  If you need two integers, QMP wants you to put two integers in
JSON.  That means either a new member next to bootindex, or turning
bootindex into an alternate of integer and object.

Not passing judgement on whether we actually need "once".
