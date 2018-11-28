Received: from eggs.gnu.org ([2001:4830:134:3::10]:56916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gS4F1-0001iA-3P
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 13:07:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gS4Et-00068f-OF
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 13:07:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gS4Et-00063q-AP
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 13:07:07 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1542290622.git.simon@ruderich.org>
	<0e061333411f8e64a6e53f14c4c067e5e3e1c91e.1542290622.git.simon@ruderich.org>
	<87r2f5fke5.fsf@dusky.pond.sub.org>
	<e343f966-ef6d-73d1-6bc2-f1801df1ba03@redhat.com>
Date: Wed, 28 Nov 2018 19:07:03 +0100
In-Reply-To: <e343f966-ef6d-73d1-6bc2-f1801df1ba03@redhat.com> (Eric Blake's
	message of "Wed, 28 Nov 2018 10:43:56 -0600")
Message-ID: <87efb5dqk8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 6/7] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Simon Ruderich <simon@ruderich.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, David Alan Gilbert <dgilbert@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 11/28/18 6:37 AM, Markus Armbruster wrote:
> ...
>>
>> @offset and @size feel a bit like overengineering to me.  If this work
>> was still at the design stage, I'd advise to start without them, then
>> see whether there's a genuine need.  At v5, I'm li
>>
>>
>
> Was there intended to be more to this message?

Oops!  At v5, it's probably better not to argue about this anymore.
