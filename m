Received: from eggs.gnu.org ([2001:4830:134:3::10]:39019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkns9-0000B5-Lq
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkns9-0003q0-0Q
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:52:17 -0400
References: <20170818211542.5380-1-eblake@redhat.com>
	<20170818211542.5380-9-eblake@redhat.com>
	<e44a3300-cbe9-c9d7-ae49-b223f638d7ea@redhat.com>
	<da3712de-986d-8130-7a97-e9f1071d2a03@redhat.com>
	<c665235d-8bec-627a-f750-4dc2798c3d8c@redhat.com>
	<5d84655b-d82a-956a-f434-023961b23552@redhat.com>
	<2ffb6aab-09a0-7136-946f-f68f7478c0f7@redhat.com>
	<bddc04d6-686e-ca5c-ef30-6df7bdb9c3bf@redhat.com>
	<87h8wxqunl.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e1c18d2a-ac5e-2892-3343-80b943345f3e@redhat.com>
Date: Thu, 24 Aug 2017 10:52:06 +0200
MIME-Version: 1.0
In-Reply-To: <87h8wxqunl.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 08/13] tests: Rely more on
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, "open list:Floppy" <qemu-block@nongnu.org>

On 24/08/2017 09:42, Markus Armbruster wrote:
> 
> In a language less primitive than C, I'd write it exactly that way, and
> nobody would complain.  In old, primitive C, I have to write
> 
>     global_qtest = A;
>     do this
>     do that
> 
>     global_qtest = B;
>     do something
> 
>     global_qtest = A;
>     do more
> 
> Why's that so horrible to justify busywork on wrappers?

Because cut-and-paste is a thing. :(

Paolo
