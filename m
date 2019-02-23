Received: from eggs.gnu.org ([209.51.188.92]:54909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1gxKoV-0007Xq-Jr
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 19:05:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1gxKoU-0007tC-Rp
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 19:05:07 -0500
Date: Sat, 23 Feb 2019 00:04:25 +0000
From: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190223000425.hjefbg25qlgdwf7t@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190220031557.26293-1-richardw.yang@linux.intel.com>
	<20190220031557.26293-2-richardw.yang@linux.intel.com>
	<20190221155519.5f199561@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221155519.5f199561@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] CODING_STYLE: specify the indent
 rule for multiline code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, peter.maydell@linaro.org, qemu-trivial@nongnu.org, mjt@tls.msk.ru, qemu-devel@nongnu.org, philmd@redhat.com

On Thu, Feb 21, 2019 at 03:55:19PM +0100, Igor Mammedov wrote:
>On Wed, 20 Feb 2019 11:15:56 +0800
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>
>> We didn't specify the indent rule for multiline code here, which may
>> mislead users. And in current code, the code use different rules.
>> 
>> Add this rule in CODING_STYLE to make sure this is clear to every one.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> 
>> ---
>> v3:
>>    * misleading -> mislead
>>    * add comma after arg2 in example
>> v2:
>>    * rephrase changelog suggested by Eric Blake
>>      - remove one redundant line
>>      - fix some awkward grammar
>>      - add { ; at the end of example
>> 
>> c1
>> ---
>>  CODING_STYLE | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>> 
>> diff --git a/CODING_STYLE b/CODING_STYLE
>> index ec075dedc4..1359f9ab81 100644
>> --- a/CODING_STYLE
>> +++ b/CODING_STYLE
>> @@ -29,6 +29,29 @@ Spaces of course are superior to tabs because:
>>  
>>  Do not leave whitespace dangling off the ends of lines.
>>  
>> +1.1 Multiline Indent
>> +
>> +There are several places where indent is necessary:
>> +
>> + - struct definition
>> + - if/else
>> + - while/for
>> + - function definition & call
>> +
>> +When breaking up a long line to fit within line widths, align the secondary
>s/widths/width/
>
>> +lines just after the opening parenthesis of the first.
>> +
>> +For example:
>> +
>> +    if (a == 1 &&
>> +        b == 2) {
>> +
>> +    while (a == 1 &&
>> +           b == 2) {
>> +
>> +    do_something(arg1, arg2,
>> +                 arg3);
>> +
>
>there is also another widely used acceptable pattern
>  func_name(arg1, arg2,
>      arg3)
>
>where we indent relative to function name start
>(sound weird to me but I'm not sure how to word it properly)
>

Hmm... we may need to add this exception case.

>>  2. Line width
>>  
>>  Lines should be 80 characters; try not to make them longer.
>

-- 
Wei Yang
Help you, Help me
