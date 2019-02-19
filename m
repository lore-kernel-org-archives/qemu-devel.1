Received: from eggs.gnu.org ([209.51.188.92]:42150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw9MG-0002SM-FH
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:39:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw9ME-0005N6-Fk
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:39:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gw9MC-0005K3-D9
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:39:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id l5so21835922wrw.6
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 09:38:57 -0800 (PST)
References: <20190219013106.17538-1-richardw.yang@linux.intel.com>
	<20190219013106.17538-3-richardw.yang@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ba83c335-c0f1-5190-33a9-f2f7f44c55f0@redhat.com>
Date: Tue, 19 Feb 2019 18:38:54 +0100
MIME-Version: 1.0
In-Reply-To: <20190219013106.17538-3-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: imammedo@redhat.com, mjt@tls.msk.ru

On 2/19/19 2:31 AM, Wei Yang wrote:
> All the example code are indented with four spaces except this one.
> 
> Fix this by adding four spaces here.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  CODING_STYLE | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/CODING_STYLE b/CODING_STYLE
> index 73f66ca185..27581d80c1 100644
> --- a/CODING_STYLE
> +++ b/CODING_STYLE
> @@ -134,10 +134,10 @@ block to a separate function altogether.
>  When comparing a variable for (in)equality with a constant, list the
>  constant on the right, as in:
>  
> -if (a == 1) {
> -    /* Reads like: "If a equals 1" */
> -    do_something();
> -}
> +    if (a == 1) {
> +        /* Reads like: "If a equals 1" */

I guess you found a bug in the documentation :)

Since 8c06fbdf36bf4d the style asked is:

    We now require Linux-kernel-style multiline comments:
        /*
         * line one
         * line two
         */

> +        do_something();
> +    }
>  
>  Rationale: Yoda conditions (as in 'if (1 == a)') are awkward to read.
>  Besides, good compilers already warn users when '==' is mis-typed as '=',
> 
