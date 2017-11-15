Received: from eggs.gnu.org ([2001:4830:134:3::10]:32945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEyWp-00005M-5q
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 09:19:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEyWl-00029C-Tx
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 09:18:59 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:45600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eEyWl-00027w-Nb
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 09:18:55 -0500
Received: by mail-wm0-f46.google.com with SMTP id 9so3304689wme.4
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 06:18:55 -0800 (PST)
References: <e1e3a1d3-da53-e46a-ce9b-7d1707e3a493@linux.intel.com>
	<81495d39-0026-dba2-10b9-86d7df5babd3@tuxfamily.org>
	<4a983bfc-442c-c55f-e3eb-9cb58a0d9ba8@redhat.com>
	<aac92ba4-337c-df4f-c8f5-03b9fef1e2f0@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cdd6e0a4-93cd-66ca-5e69-7a834f0b10d0@redhat.com>
Date: Wed, 15 Nov 2017 15:18:51 +0100
MIME-Version: 1.0
In-Reply-To: <aac92ba4-337c-df4f-c8f5-03b9fef1e2f0@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] HAXM is now open source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yu Ning <yu.ning@linux.intel.com>, John Snow <jsnow@redhat.com>, Thomas Huth <huth@tuxfamily.org>, qemu-devel <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>
Cc: Vincent Palatin <vpalatin@chromium.org>

On 15/11/2017 09:25, Yu Ning wrote:
> 
> 
> On 11/15/2017 3:13, John Snow wrote:
>>
>> On 11/14/2017 06:09 AM, Thomas Huth wrote:
>>>
>>> That's great news! I hope this all will help to promote QEMU on Windows
>>> and macOS quite a bit!
>>>
>>> However, during the past months, I noticed a couple of times that users
>>> ask on IRC or the qemu-discuss mailing list how they could accelerate
>>> their QEMU on Windows - and they are running only in TCG mode when you
>>> ask how they start QEMU. So it seems like there is not much knowledge
>>> about "--accel hax" in the public yet. Maybe you could write a nice blog
>>> post for the QEMU blog or something similar that explains how to use
>>> HAXM with QEMU on Windows for the normal users? Or maybe make it more
>>> prominent in the QEMU wiki? (e.g. the main page only mentions KVM and
>>> Xen, but not HAXM)
>> A blog post advertising this new development would be an absolute
>> miracle for linking to people who are just getting started with QEMU on
>> Windows.
>>
>> (It would also be really good for idiots like me, who do not use Windows
>> for anything other than playing video games and sometimes forget that it
>> is capable of doing other things.)
> 
> Thanks for the encouragement.
> 
> I think I can start by writing a small section that can be added to an
> existing document, and later expanded to a blog article. But I haven't
> found a suitable place for it on the QEMU wiki.
> 
> Does it make sense to add the proposed piece to the QEMU user manual
> (qemu-doc.texi), under the Quick Start section (2.2)? The user manual is
> published on Stefan's website and referred to by qemu.org:
> 
> https://qemu.weilnetz.de/doc/qemu-doc.html

Unfortunately the "Quick Start" section is quite out of date (it doesn't
even mention KVM!) and is basically a huge list of options.  We are in
the process of improving QEMU documentation, so I think a blog post is
preferrable at this stage.

Thanks,

Paolo

> so I think it's a popular resource among users.
> 
> BTW, I assume most Windows users begin their QEMU journey from this page
> (also credit to Stefan):
> 
> https://qemu.weilnetz.de/
> 
> and I've verified the hax accelerator module is built into the latest
> binaries there (at least the W64 ones).
> 
> -Yu
> 
