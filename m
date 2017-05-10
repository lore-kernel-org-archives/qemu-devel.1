Received: from eggs.gnu.org ([2001:4830:134:3::10]:43359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8Rvl-0004d8-VW
	for qemu-devel@nongnu.org; Wed, 10 May 2017 09:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8Rvi-0003UV-T7
	for qemu-devel@nongnu.org; Wed, 10 May 2017 09:45:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d8Rvi-0003UP-Mt
	for qemu-devel@nongnu.org; Wed, 10 May 2017 09:45:26 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170505201128.12099-1-ehabkost@redhat.com>
	<20170505201128.12099-4-ehabkost@redhat.com>
	<a30986e0-6a07-509d-a2c0-969847bc4906@redhat.com>
	<20170505210923.GP3482@thinpad.lan.raisama.net>
Date: Wed, 10 May 2017 15:45:23 +0200
In-Reply-To: <20170505210923.GP3482@thinpad.lan.raisama.net> (Eduardo
	Habkost's message of "Fri, 5 May 2017 18:09:23 -0300")
Message-ID: <87ziekzuz0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/3] string-input-visitor: Support
 alternate types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Fri, May 05, 2017 at 03:53:40PM -0500, Eric Blake wrote:
[...]
>> Slightly simpler for ignoring int for now, while still something we
>> could add in later.  I've been wanting to have an alternate for
>> 'int'/'str' for InetAddress port, since we want to support named ports
>> but most often use just integers.  On the command line, port=1 is fine,
>> but in QMP, we currently have to spell it port="1".  That's a case where
>> we'd allow a pairing of any string with an integer, rather than just an
>> enum.
>
> Does that mean we already have an use case where we will have to
> relax the restrictions on ambiguous enums? :)

A rather weak one.  Certainly too weak by itself to make me open another
can of string-input-visitor worms.

> I won't mind at all if we remove the runtime detection of
> ambiguous enums. It will make the code much simpler.

That's the idea :)
