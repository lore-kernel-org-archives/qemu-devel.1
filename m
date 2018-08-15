Received: from eggs.gnu.org ([2001:4830:134:3::10]:41328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpwnl-0001dL-44
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 10:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpwng-0005m4-14
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 10:29:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54058 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fpwnf-0005k1-Nm
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 10:29:27 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1526916378.git.simon@ruderich.org>
	<851d095cd457109e4a22a2e5ecd36ccbdacbf48b.1526916378.git.simon@ruderich.org>
	<20180810103650.GA2391@work-vm> <20180814141826.GA26558@ruderich.org>
	<871sb1t0cn.fsf@dusky.pond.sub.org>
	<20180814190329.GA13798@ruderich.org>
	<87pnykqmw4.fsf@dusky.pond.sub.org>
	<20180815124154.GA1116@ruderich.org>
Date: Wed, 15 Aug 2018 16:29:25 +0200
In-Reply-To: <20180815124154.GA1116@ruderich.org> (Simon Ruderich's message of
	"Wed, 15 Aug 2018 14:41:54 +0200")
Message-ID: <87bma3ityy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 5/5] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Simon Ruderich <simon@ruderich.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Simon Ruderich <simon@ruderich.org> writes:

> On Wed, Aug 15, 2018 at 06:22:51AM +0200, Markus Armbruster wrote:
>>> My initial patch didn't have the offset. It was suggested by Eric
>>> Blake in <0a960aa8-2a3f-8667-3d46-cecf8e65e482@redhat.com>:
>>>
>>> On Tue, Apr 10, 2018 at 04:33:03PM -0500, Eric Blake wrote:
>>>> Do you additionally need an offset where to start reading from within
>>>> the file (that is, since you already have the 'size' parameter to avoid
>>>> reading the entire file, and the 'val' parameter to target anywhere in
>>>> physical memory, how do I start reading anywhere from the file)?
>>>
>>> It sounded useful to me so I added it.
>>
>> Feels like an optional parameter to me.
>
> For the HMP or the QMP interface?

Both.

> If you think 'offset' is not necessary I can also drop it
> completely.

I think it's a reasonable feature, and since you already coded it up...
