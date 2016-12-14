Received: from eggs.gnu.org ([2001:4830:134:3::10]:44375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cHDeF-0005aH-LM
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:47:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cHDeD-0003TH-1r
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:47:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cHDeC-0003St-Ru
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:47:20 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1481567461-2341-1-git-send-email-ehabkost@redhat.com>
	<87zijyfyq5.fsf@dusky.pond.sub.org>
	<20161214134841.GG3808@thinpad.lan.raisama.net>
	<b5cf13d0-d03f-d477-20ce-211948b315ee@redhat.com>
Date: Wed, 14 Dec 2016 18:47:18 +0100
In-Reply-To: <b5cf13d0-d03f-d477-20ce-211948b315ee@redhat.com> (Paolo
	Bonzini's message of "Wed, 14 Dec 2016 18:07:48 +0100")
Message-ID: <87oa0e8kt5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] qom: Make all interface types
 abstract
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Lin Ma <lma@suse.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 14/12/2016 14:48, Eduardo Habkost wrote:
>>> How do you find all abstract TypeInfo in the source?  The uninitiated
>>> might grep for .abstract = true, and be misled.  The initiated will be
>>> annoyed instead, because grepping for *absence* of .instance_size = is
>>> bothersome.
>>>
>>> I suspect life could be easier going forward if we instead required
>>> .abstract = true for interfaces, and enforced it with
>>> assert(ti->instance_size || ti->abstract) here.
>> I was doing that before deciding to change type_initialize(). I
>> think I still have the commit in my git reflog, I will recover it
>> and submit it as v3.
>
> I think it's worse.
>
> Interfaces are abstract by definition.  Requiring ".abstract = true"
> makes things less intuitive.  v2 seems good.

What makes a TypeInfo declaration an interface?  Whatever it is, it
better be *locally* obvious.
