Received: from eggs.gnu.org ([2001:4830:134:3::10]:48807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDby-00026F-4f
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDbu-0000Vd-4e
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:26:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57358 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqDbr-0000UR-On
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:26:24 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <851d095cd457109e4a22a2e5ecd36ccbdacbf48b.1526916378.git.simon@ruderich.org>
	<20180810103650.GA2391@work-vm> <20180814141826.GA26558@ruderich.org>
	<871sb1t0cn.fsf@dusky.pond.sub.org>
	<20180814190329.GA13798@ruderich.org>
	<87pnykqmw4.fsf@dusky.pond.sub.org>
	<20180815124154.GA1116@ruderich.org>
	<87bma3ityy.fsf@dusky.pond.sub.org>
	<20180815154626.GA23638@ruderich.org>
	<87pnyig92q.fsf@dusky.pond.sub.org>
	<20180816081320.GA16148@ruderich.org>
Date: Thu, 16 Aug 2018 10:26:18 +0200
In-Reply-To: <20180816081320.GA16148@ruderich.org> (Simon Ruderich's message
	of "Thu, 16 Aug 2018 10:13:20 +0200")
Message-ID: <87h8jud8et.fsf@dusky.pond.sub.org>
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

> On Thu, Aug 16, 2018 at 07:43:41AM +0200, Markus Armbruster wrote:
>>> On Fri, Aug 10, 2018 at 11:36:51AM +0100, Dr. David Alan Gilbert wrote:
>>>> Also, had you considered rearranging and making them optional,
>>>> for example if you do:
>>>>
>>>> val:l,filename:F,offset:i?,size:i?
>>>>
>>>> I think that would mean you can do the fairly obvious:
>>>>   pmemload addr "myfile"
>>>>
>>>> with the assumption that loads the whole file.
>>>
>>> This would deviate from pmemsave/memsave, but feels more natural.
>>
>> The different order or arguments in HMP is somewhat ugly.  Okay if it
>> makes the command more pleasant to use.  Up to you and Dave to decide.
>>
>> If you decide to deviate, consider
>>
>>     filename:F,address:l,size:i?,offset:i?
>
> From what I understand we can't have optional arguments in the
> middle. Would you prefer mandatory size/offset parameters in HMP
> or optional parameters but inconsistent with pmemsave/memsave?

If you guys decide you want consistency with memsave, that's fine with
me.  If you decide you want to rearrange arguments for better usability,
that's also fine.  I just wanted to throw in another rearrangement for
you to consider.
