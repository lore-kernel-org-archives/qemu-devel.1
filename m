Received: from eggs.gnu.org ([209.51.188.92]:60846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwFED-0003zy-2z
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 18:55:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwFEB-00046d-7S
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 18:55:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwFEA-00046H-5W
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 18:55:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id t15so4516892wmi.5
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 15:55:05 -0800 (PST)
References: <20190219013106.17538-1-richardw.yang@linux.intel.com>
	<20190219013106.17538-3-richardw.yang@linux.intel.com>
	<ba83c335-c0f1-5190-33a9-f2f7f44c55f0@redhat.com>
	<77cf32b1-6a4a-33c5-4b3c-8ba3245a4b23@redhat.com>
	<2e584c55-5b40-4a29-b0ae-e53039e38a7d@redhat.com>
	<20190219222028.y3wt6bgihmx73ptw@master>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <58531fe2-edd9-0be9-6136-074a7226e8b5@redhat.com>
Date: Wed, 20 Feb 2019 00:55:02 +0100
MIME-Version: 1.0
In-Reply-To: <20190219222028.y3wt6bgihmx73ptw@master>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] CODING_STYLE: indent example code as
 all others
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, imammedo@redhat.com, mjt@tls.msk.ru

On 2/19/19 11:20 PM, Wei Yang wrote:
> On Tue, Feb 19, 2019 at 07:55:31PM +0100, Philippe Mathieu-Daudé wrote:
>> On 2/19/19 6:56 PM, Eric Blake wrote:
>>> On 2/19/19 11:38 AM, Philippe Mathieu-Daudé wrote:
>>>
>>>>> +    if (a == 1) {
>>>>> +        /* Reads like: "If a equals 1" */
>>>>
>>>> I guess you found a bug in the documentation :)
>>>>
>>>> Since 8c06fbdf36bf4d the style asked is:
>>>>
>>>>     We now require Linux-kernel-style multiline comments:
>>>>         /*
>>>>          * line one
>>>>          * line two
>>>>          */
>>>>
>>>>> +        do_something();
>>>
>>> We only require winged multiline comments when the comment is actually
>>> multiline.  In this case, the comment is a one-liner, and is just fine
>>> as written.
>>
>> Hmm I have a series where I moved code and changed from /* one line */
>> to the multi-line style, I wonder why and remember checkpatch errors.
>> Maybe a side-effect from what b94e809d3e fixed.
>>
>> Anyway, Wei do you mind adding a multi-line example here too?
>>
> 
> A multi-line example for multiline comments?
> 
> This looks not relavant to this sectioin. I am afraid I will not add
> this example here. Sorry for that.

No worries, R-b stands.

>> With/without multi-line example:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>> Thanks!
>>
>> Phil.
> 
