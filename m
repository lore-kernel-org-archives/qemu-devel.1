Received: from eggs.gnu.org ([209.51.188.92]:58549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEfb3-0004lm-16
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEfb2-00081H-3e
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:42:52 -0400
References: <20190304071631.27567-1-richardw.yang@linux.intel.com>
	<20190304071631.27567-2-richardw.yang@linux.intel.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <4cd402a1-4da3-dc2e-82ad-64249c5fddc0@vivier.eu>
Date: Thu, 11 Apr 2019 21:42:26 +0200
MIME-Version: 1.0
In-Reply-To: <20190304071631.27567-2-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v6 1/2] CODING_STYLE:
 specify the indent rule for multiline code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: peter.maydell@linaro.org, philmd@redhat.com, mjt@tls.msk.ru, imammedo@redhat.com, eblake@redhat.com, sgarzare@redhat.com

On 04/03/2019 08:16, Wei Yang wrote:
> We didn't specify the indent rule for multiline code here, which may
> mislead users. And in current code, the code use various styles.
> 
> Add this rule in CODING_STYLE to make sure this is clear to every one.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> 
> ---
> v6:
>    * add ) for last example of function
> v5:
>    * different rules -> various styles
>    * describe function variants separately
>    * take struct out
> v4:
>    * widths -> width
>    * add an exception example for function
> v3:
>    * misleading -> mislead
>    * add comma after arg2 in example
> v2:
>    * rephrase changelog suggested by Eric Blake
>      - remove one redundant line
>      - fix some awkward grammar
>      - add { ; at the end of example
> ---
>  CODING_STYLE | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/CODING_STYLE b/CODING_STYLE
> index ec075dedc4..90321e9c28 100644
> --- a/CODING_STYLE
> +++ b/CODING_STYLE
> @@ -29,6 +29,45 @@ Spaces of course are superior to tabs because:
>  
>  Do not leave whitespace dangling off the ends of lines.
>  
> +1.1 Multiline Indent
> +
> +There are several places where indent is necessary:
> +
> + - if/else
> + - while/for
> + - function definition & call
> +
> +When breaking up a long line to fit within line width, we need a proper indent
> +for the following lines.
> +
> +In case of if/else, while/for, align the secondary lines just after the
> +opening parenthesis of the first.
> +
> +For example:
> +
> +    if (a == 1 &&
> +        b == 2) {
> +
> +    while (a == 1 &&
> +           b == 2) {
> +
> +In case of function, there are several variants:
> +
> +    * 4 spaces indent from the beginning
> +    * align the secondary lines just after the opening parenthesis of the
> +      first
> +
> +For example:
> +
> +    do_something(x, y,
> +        z);
> +
> +    do_something(x, y,
> +                 z);
> +
> +    do_something(x, do_another(y,
> +                               z));
> +
>  2. Line width
>  
>  Lines should be 80 characters; try not to make them longer.
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
