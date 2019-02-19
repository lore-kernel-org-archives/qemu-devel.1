Received: from eggs.gnu.org ([209.51.188.92]:41787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1gwDao-0000TE-6x
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1gwDWf-0004Og-6h
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:06:05 -0500
Date: Tue, 19 Feb 2019 22:05:44 +0000
From: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190219220544.g5uyxxxedmjuzfm3@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190219013106.17538-1-richardw.yang@linux.intel.com>
	<20190219013106.17538-3-richardw.yang@linux.intel.com>
	<ba83c335-c0f1-5190-33a9-f2f7f44c55f0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba83c335-c0f1-5190-33a9-f2f7f44c55f0@redhat.com>
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
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, imammedo@redhat.com, mjt@tls.msk.ru

On Tue, Feb 19, 2019 at 06:38:54PM +0100, Philippe Mathieu-Daudé wrote:
>On 2/19/19 2:31 AM, Wei Yang wrote:
>> All the example code are indented with four spaces except this one.
>> 
>> Fix this by adding four spaces here.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  CODING_STYLE | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>> 
>> diff --git a/CODING_STYLE b/CODING_STYLE
>> index 73f66ca185..27581d80c1 100644
>> --- a/CODING_STYLE
>> +++ b/CODING_STYLE
>> @@ -134,10 +134,10 @@ block to a separate function altogether.
>>  When comparing a variable for (in)equality with a constant, list the
>>  constant on the right, as in:
>>  
>> -if (a == 1) {
>> -    /* Reads like: "If a equals 1" */
>> -    do_something();
>> -}
>> +    if (a == 1) {
>> +        /* Reads like: "If a equals 1" */

I don't get your point.

You mean to put it into multiline comments?

>
>I guess you found a bug in the documentation :)
>
>Since 8c06fbdf36bf4d the style asked is:
>
>    We now require Linux-kernel-style multiline comments:
>        /*
>         * line one
>         * line two
>         */
>
>> +        do_something();
>> +    }
>>  
>>  Rationale: Yoda conditions (as in 'if (1 == a)') are awkward to read.
>>  Besides, good compilers already warn users when '==' is mis-typed as '=',
>> 

-- 
Wei Yang
Help you, Help me
