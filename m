Received: from eggs.gnu.org ([2001:4830:134:3::10]:57278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dv8aF-0005Er-KM
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 17:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dv8aE-0007fF-Hu
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 17:00:31 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:46564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dv8aE-0007d8-B2
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 17:00:30 -0400
Received: by mail-wm0-x231.google.com with SMTP id m72so5178273wmc.1
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 14:00:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f794478b-b73f-60d4-0c0f-0ad1c0e2f20b@redhat.com>
References: <1506014941-31076-1-git-send-email-peter.maydell@linaro.org>
	<f794478b-b73f-60d4-0c0f-0ad1c0e2f20b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 22:00:06 +0100
Message-ID: <CAFEAcA-Ow-e5PHe5HczV2NSLtKnBLsqhZpx5BSjTt-ZQVQyE7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] docs/devel/loads-stores.rst: Document
 our various load and store APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "patches@linaro.org" <patches@linaro.org>

On 21 September 2017 at 20:17, Eric Blake <eblake@redhat.com> wrote:
> On 09/21/2017 12:29 PM, Peter Maydell wrote:
>> QEMU has a wide selection of different functions for doing
>> loads and stores; provide some overview documentation of
>> what they do and how to pick which one to use.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> Changes v1->v2: filled in most of the gaps thanks to the
>> comments on v1.
>>
>> I have left some TODO markers in where they represent
>> fixes we should ideally make to the API. Since this
>> is for-developers internals documentation I think it's
>> OK to leave those in.
>>
>> I found I was referring back to my v1 patch and the replies
>> to it quite a bit recently, so I think it would be nice to
>> get it into the tree.
>>
>> The major question I have left is about the license text
>> to apply to this...
>
>> +   Copyright (c) 2017 Linaro Limited
>> +   Written by Peter Maydell
>> +   TODO: do we have a standard doc license? bitmaps.rst
>> +   uses the FreeBSD documentation license, I notice.
>
> The default GPLv2+ seems okay to me for something for internal use, but
> of course, if you want something looser like FreeBSD docs, I'm also fine
> with that (as it's not the first use in the tree).

I was wondering how GPLv2+ would work with things like the
"readthedocs" website -- if we used that for providing a
nice rendering of the documentation does it get awkward
license-wise?

But yes, just not saying anything and going with our
default is probably simplest.

>> +
>> +===================
>> +Load and Store APIs
>> +===================
>> +
>> +QEMU internally has multiple families of functions for performing
>> +loads and stores. This document attempts to enumerate them all
>> +and indicate when to use them. It does not provide detailed
>> +documentation of each API -- for that you should look at the
>> +documentation comments in the relevant header files.
>> +
>> +
>> +``ld*_p and st_*p``
>
> Difference in placement of * vs. _ - is it intentional?

No, it should be st*_p. (If in doubt, trust the regexs;
I tested them all.)

>> +
>> +``cpu_{ld,st}_*``
>> +~~~~~~~~~~~~~~~~~
>> +
>> +These functions operate on a guest virtual address. Be aware
>> +that these functions may cause a guest CPU exception to be
>> +taken (eg for an alignment fault or MMU fault) which will
>
> Do we care about the formal spelling "e.g." ?

I don't personally, tending to the BBC and Guardian style
guide recommended approach of using no punctuation:
https://www.theguardian.com/guardian-observer-style-guide-e
http://www.bbc.co.uk/academy/journalism/article/art20130716140724183

but grep suggests that 'e.g.' is the much more common
style in docs/ so I guess we should follow that
for consistency.

thanks
-- PMM
