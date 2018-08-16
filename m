Received: from eggs.gnu.org ([2001:4830:134:3::10]:46259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqB4V-0004LF-8l
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 01:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqB4R-0007Hk-Rd
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 01:43:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33010 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqB4R-0007He-Mw
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 01:43:43 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1526916378.git.simon@ruderich.org>
	<851d095cd457109e4a22a2e5ecd36ccbdacbf48b.1526916378.git.simon@ruderich.org>
	<20180810103650.GA2391@work-vm> <20180814141826.GA26558@ruderich.org>
	<871sb1t0cn.fsf@dusky.pond.sub.org>
	<20180814190329.GA13798@ruderich.org>
	<87pnykqmw4.fsf@dusky.pond.sub.org>
	<20180815124154.GA1116@ruderich.org>
	<87bma3ityy.fsf@dusky.pond.sub.org>
	<20180815154626.GA23638@ruderich.org>
Date: Thu, 16 Aug 2018 07:43:41 +0200
In-Reply-To: <20180815154626.GA23638@ruderich.org> (Simon Ruderich's message
	of "Wed, 15 Aug 2018 17:46:26 +0200")
Message-ID: <87pnyig92q.fsf@dusky.pond.sub.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>

Simon Ruderich <simon@ruderich.org> writes:

> On Wed, Aug 15, 2018 at 04:29:25PM +0200, Markus Armbruster wrote:
>>> For the HMP or the QMP interface?
>>
>> Both.
>
> Ok.
>
>>> If you think 'offset' is not necessary I can also drop it
>>> completely.
>>
>> I think it's a reasonable feature, and since you already coded it up...
>
> In that case, should size also become optional? As already
> suggested in this thread (and similar for QMP):
>
> On Fri, Aug 10, 2018 at 11:36:51AM +0100, Dr. David Alan Gilbert wrote:
>> Also, had you considered rearranging and making them optional,
>> for example if you do:
>>
>> val:l,filename:F,offset:i?,size:i?
>>
>> I think that would mean you can do the fairly obvious:
>>   pmemload addr "myfile"
>>
>> with the assumption that loads the whole file.
>
> This would deviate from pmemsave/memsave, but feels more natural.

The different order or arguments in HMP is somewhat ugly.  Okay if it
makes the command more pleasant to use.  Up to you and Dave to decide.

If you decide to deviate, consider

    filename:F,address:l,size:i?,offset:i?

> How are multiple optional parameters handled? Filled from
> left-to-right?

HMP: yes.

QMP has only named parameters.
