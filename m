Received: from eggs.gnu.org ([209.51.188.92]:44788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nshah@disroot.org>) id 1gou9X-0003ow-DE
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 13:00:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nshah@disroot.org>) id 1gou9W-0004tV-Id
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:59:59 -0500
References: <20190116183358.30287-1-nshah@disroot.org>
	<20190123185043.GV4136@habkost.net>
From: Nisarg Shah <nshah@disroot.org>
Message-ID: <0f2e88e8-7a69-f5aa-e1df-70cdff2b371e@disroot.org>
Date: Wed, 30 Jan 2019 23:30:10 +0530
Mime-Version: 1.0
In-Reply-To: <20190123185043.GV4136@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] device-crash-test: Convert to Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

Thanks for the review.

On 1/24/19 12:20 AM, Eduardo Habkost wrote:
> 
> This breaks Python 2 support:
> 
> $ python2 scripts/device-crash-test
>    File "scripts/device-crash-test", line 534
>      print("No QEMU binary found", file=sys.stderr)
>                                        ^
> SyntaxError: invalid syntax
> 
> 
Apologies. This is my first patch to qemu and I did not consider 
backward compatibility with Python 2. I'll see if I can fix this.
>>   
>>   import sys
>>   import os
>> @@ -272,7 +272,7 @@ def qemuOptsEscape(s):
>>   
>>   def formatTestCase(t):
>>       """Format test case info as "key=value key=value" for prettier logging output"""
>> -    return ' '.join('%s=%s' % (k, v) for k, v in t.items())
>> +    return ' '.join('%s=%s' % (k, v) for k, v in list(t.items()))
> 
> Why is this necessary?
> 
> 
This was automatically modified by the 2to3 tool. I see that it is not 
really required.

Regards,
Nisarg
