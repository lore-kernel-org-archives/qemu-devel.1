Received: from eggs.gnu.org ([2001:4830:134:3::10]:56065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eCRrc-0001M9-Jk
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:02:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eCRrZ-000429-FP
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:02:00 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:48359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eCRrZ-00041b-9N
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:01:57 -0500
Received: by mail-wr0-f177.google.com with SMTP id 15so2693156wrb.5
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 07:01:57 -0800 (PST)
References: <cover.1510093478.git.jcody@redhat.com>
	<41ed8543e005205118438328c7e162532729d9c7.1510093478.git.jcody@redhat.com>
	<20171108104737.xtxfex7leabfbqyc@starbug-vm.ie.oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1465eafb-d4c4-4628-cffd-1b4ea47f2e8a@redhat.com>
Date: Wed, 8 Nov 2017 16:01:51 +0100
MIME-Version: 1.0
In-Reply-To: <20171108104737.xtxfex7leabfbqyc@starbug-vm.ie.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 7/7] block/curl: code
 cleanup to comply with coding style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, rjones@redhat.com, namei.unix@gmail.com

On 08/11/2017 11:47, Darren Kenny wrote:
>>
>>
>> -// #define DEBUG_CURL
>> -// #define DEBUG_VERBOSE
>> +/*
>> + #define DEBUG_CURL
>> + #define DEBUG_VERBOSE
>> +*/
> 
> Is it not more common to use the style:
> 
>    /*
>     * text
>     */
> 
> This is visible in almost every file at the top, where the Copyright
> and License is.

The most common style in QEMU is probably

   /* text
    * more text
    */

But for DEBUG_* macros I think // are appropriate.  checkpatch should
still warn about them because DEBUG_* macros should be replaced by
tracepoints; but unless we do that we should keep line comments.

>>
>> -    CURLState *s = ((CURLState*)opaque);
>> +    CURLState *s = opaque;
> 
> Not sure about this one - while it may not be strictly necessary to
> do the casting, from a readability point of view it is helpful to
> see the cast - possibly with the outer brackets removed:
> 
>      CURLState *s = (CURLState*)opaque;

I think the most common idiom here is to omit the cast.

>> -    // In case we have the requested data already (e.g. read-ahead),
>> -    // we can just call the callback and be done.
>> +    /* In case we have the requested data already (e.g. read-ahead),
>> +       we can just call the callback and be done. */
> 
> Please don't do a multi-line comment like this, it is much more
> obvious that the second line is a comment if you use the more normal
> format of as outlined earlier by me. 

Agreed.

Paolo
