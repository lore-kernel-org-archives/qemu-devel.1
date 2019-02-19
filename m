Received: from eggs.gnu.org ([209.51.188.92]:41248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw9IM-000852-DF
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:35:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw9IL-00037f-EX
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:35:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gw9IL-00035F-5Z
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:35:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so3725086wmh.4
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 09:35:01 -0800 (PST)
References: <20190219013106.17538-1-richardw.yang@linux.intel.com>
	<20190219013106.17538-2-richardw.yang@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e59b0920-4698-a0d1-7990-77d9e2202f9b@redhat.com>
Date: Tue, 19 Feb 2019 18:34:58 +0100
MIME-Version: 1.0
In-Reply-To: <20190219013106.17538-2-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] CODING_STYLE: specify the indent rule
 for multiline code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: imammedo@redhat.com, mjt@tls.msk.ru

Hi,

On 2/19/19 2:31 AM, Wei Yang wrote:
> We didn't specify the indent rule for multiline code here, which may
> misleading users. And in current code, the code use different rules.
> 
> Add this rule in CODING_STYLE to make sure this is clear to every one.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  CODING_STYLE | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/CODING_STYLE b/CODING_STYLE
> index ec075dedc4..73f66ca185 100644
> --- a/CODING_STYLE
> +++ b/CODING_STYLE
> @@ -29,6 +29,32 @@ Spaces of course are superior to tabs because:
>  
>  Do not leave whitespace dangling off the ends of lines.
>  
> +1.1 Multiline Indent
> +
> +There are several places where indent is necessary:
> +
> + - struct definition
> + - if/else
> + - while/for
> + - function definition & call
> +
> +All the above cases apply the same rule: indent with four spaces.
> +
> +While the last three case may face another situation: code should spread into
> +several lines. In this case the rule is align the new line with first
> +parentheses.
> +
> +For example:
> +
> +    if (a == 1 &&
> +        b == 2)
> +
> +    while (a == 1 &&
> +           b == 2)
> +
> +    do_something(arg1, arg2
> +                 arg3)

Thanks for clearing this.

What is still unclear is what to do when a function name is over 60
characters (you follow a library/API and can not shorten it), for example:

static void ccid_card_vscard_handle_message(PassthruState *card,
    const VSCMsgHeader *scr_msg_header);

What is the project guideline in this case?
(Cc'ed Peter).

> +
>  2. Line width
>  
>  Lines should be 80 characters; try not to make them longer.
> 
