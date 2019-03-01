Received: from eggs.gnu.org ([209.51.188.92]:52870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gzX4z-0004Yq-PN
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 20:35:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gzWxo-0008Cr-5B
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 20:27:49 -0500
Date: Fri, 1 Mar 2019 09:27:15 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190301012715.GB17080@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190225012530.28225-1-richardw.yang@linux.intel.com>
	<20190225012530.28225-2-richardw.yang@linux.intel.com>
	<20190228153614.2d6a2a43@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228153614.2d6a2a43@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] CODING_STYLE: specify the indent
 rule for multiline code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, g@richard
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, mjt@tls.msk.ru, philmd@redhat.com, eblake@redhat.com, peter.maydell@linaro.org

On Thu, Feb 28, 2019 at 03:36:14PM +0100, Igor Mammedov wrote:
>On Mon, 25 Feb 2019 09:25:29 +0800
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>
>> We didn't specify the indent rule for multiline code here, which may
>> mislead users. And in current code, the code use different rules.
>diffrent from what? I'd use "various styles"
>
>> 
>> Add this rule in CODING_STYLE to make sure this is clear to every one.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> 
>> ---
>> v4:
>>    * widths -> width
>>    * add an exception example for function
>> v3:
>>    * misleading -> mislead
>>    * add comma after arg2 in example
>> v2:
>>    * rephrase changelog suggested by Eric Blake
>>      - remove one redundant line
>>      - fix some awkward grammar
>>      - add { ; at the end of example
>> ---
>>  CODING_STYLE | 29 +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>> 
>> diff --git a/CODING_STYLE b/CODING_STYLE
>> index ec075dedc4..1bccf4f865 100644
>> --- a/CODING_STYLE
>> +++ b/CODING_STYLE
>> @@ -29,6 +29,35 @@ Spaces of course are superior to tabs because:
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
>> +When breaking up a long line to fit within line width, align the secondary
>> +lines just after the opening parenthesis of the first.
> Probably it's not true for struct/function, they could use 4 spaces indent
> relative to previous line. I'd drop struct as it just follow generic block
> 4 spaces rule. And describe possible function variants separately
>

That sounds reasonable. Let me adjust this.

>
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
>> +One exception for function is indenting following lines relative to function
>> +name start:
>it's not really exception and used not only with functions, it's basically
>generic 4 spaces indent. Another variant I've seen used is
>    foo(x, y(z,
>             h);
>and variations of that
>
>
>> +
>> +    do_something(arg1, arg2,
>> +        arg3);
>> +
>>  2. Line width
>>  
>>  Lines should be 80 characters; try not to make them longer.

-- 
Wei Yang
Help you, Help me
