Received: from eggs.gnu.org ([2001:4830:134:3::10]:47402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1eFbq1-0000XJ-El
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 03:17:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1eFbpy-0001NP-AN
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 03:17:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:59988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.ning@linux.intel.com>)
	id 1eFbpy-0001IV-2T
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 03:17:22 -0500
References: <e1e3a1d3-da53-e46a-ce9b-7d1707e3a493@linux.intel.com>
	<81495d39-0026-dba2-10b9-86d7df5babd3@tuxfamily.org>
	<4a983bfc-442c-c55f-e3eb-9cb58a0d9ba8@redhat.com>
	<aac92ba4-337c-df4f-c8f5-03b9fef1e2f0@linux.intel.com>
	<cdd6e0a4-93cd-66ca-5e69-7a834f0b10d0@redhat.com>
From: Yu Ning <yu.ning@linux.intel.com>
Message-ID: <a1648b4d-946f-49c4-93c5-5990baa0bce8@linux.intel.com>
Date: Fri, 17 Nov 2017 16:17:13 +0800
MIME-Version: 1.0
In-Reply-To: <cdd6e0a4-93cd-66ca-5e69-7a834f0b10d0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] HAXM is now open source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, Thomas Huth <huth@tuxfamily.org>, qemu-devel <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>
Cc: Vincent Palatin <vpalatin@chromium.org>



On 11/15/2017 22:18, Paolo Bonzini wrote:
> On 15/11/2017 09:25, Yu Ning wrote:
>>
>> On 11/15/2017 3:13, John Snow wrote:
>>> On 11/14/2017 06:09 AM, Thomas Huth wrote:
>>>> That's great news! I hope this all will help to promote QEMU on Windows
>>>> and macOS quite a bit!
>>>>
>>>> However, during the past months, I noticed a couple of times that users
>>>> ask on IRC or the qemu-discuss mailing list how they could accelerate
>>>> their QEMU on Windows - and they are running only in TCG mode when you
>>>> ask how they start QEMU. So it seems like there is not much knowledge
>>>> about "--accel hax" in the public yet. Maybe you could write a nice blog
>>>> post for the QEMU blog or something similar that explains how to use
>>>> HAXM with QEMU on Windows for the normal users? Or maybe make it more
>>>> prominent in the QEMU wiki? (e.g. the main page only mentions KVM and
>>>> Xen, but not HAXM)
>>> A blog post advertising this new development would be an absolute
>>> miracle for linking to people who are just getting started with QEMU on
>>> Windows.
>>>
>>> (It would also be really good for idiots like me, who do not use Windows
>>> for anything other than playing video games and sometimes forget that it
>>> is capable of doing other things.)
>> Thanks for the encouragement.
>>
>> I think I can start by writing a small section that can be added to an
>> existing document, and later expanded to a blog article. But I haven't
>> found a suitable place for it on the QEMU wiki.
>>
>> Does it make sense to add the proposed piece to the QEMU user manual
>> (qemu-doc.texi), under the Quick Start section (2.2)? The user manual is
>> published on Stefan's website and referred to by qemu.org:
>>
>> https://qemu.weilnetz.de/doc/qemu-doc.html
> Unfortunately the "Quick Start" section is quite out of date (it doesn't
> even mention KVM!) and is basically a huge list of options.  We are in
> the process of improving QEMU documentation, so I think a blog post is
> preferrable at this stage.
>
>
I see. I'll take the advice.

Is there a preferred document format for the QEMU blog, e.g. Markdown? 
I'll get the content ready by early next week, and then I'll need 
someone to help me post it.
