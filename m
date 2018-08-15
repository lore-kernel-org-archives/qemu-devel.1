Received: from eggs.gnu.org ([2001:4830:134:3::10]:36659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpnQs-0006x0-IR
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 00:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpnQp-0001Ux-6A
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 00:29:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39238 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fpnQo-0001Q5-1e
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 00:29:14 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180813171132.21939-1-cota@braap.org>
	<20180813171132.21939-2-cota@braap.org>
	<d9bb9cc8-f9ab-83e9-106e-7f405c6793af@redhat.com>
	<20180815004420.GB17669@flamenco>
Date: Wed, 15 Aug 2018 06:29:11 +0200
In-Reply-To: <20180815004420.GB17669@flamenco> (Emilio G. Cota's message of
	"Tue, 14 Aug 2018 20:44:20 -0400")
Message-ID: <87ftzgqmlk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/3] qsp: QEMU's Synchronization Profiler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>

"Emilio G. Cota" <cota@braap.org> writes:

> On Tue, Aug 14, 2018 at 10:13:12 +0200, Paolo Bonzini wrote:
>> On 13/08/2018 19:11, Emilio G. Cota wrote:
>> > +    struct qsp_report rep;
>> 
>> Don't like camelcase?  But that's really all that I have to remark on
>> this lovely series.
>
> I have a strong aversion to it :-)

I despise it as much as anyone, but CODING_STYLE demands CamelCase for
"type names" (which I interpret as typedef names), and convention (not
codified in CODING_STYLE) demands typedef for struct types.

> But if that's a deal breaker, let me know.

Hold your nose and go with the flow.
