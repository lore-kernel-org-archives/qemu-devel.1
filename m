Received: from eggs.gnu.org ([209.51.188.92]:59836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEfg2-0007fp-JC
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:48:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEfg1-00029D-Lt
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:48:02 -0400
References: <20190304071631.27567-1-richardw.yang@linux.intel.com>
	<20190304071631.27567-3-richardw.yang@linux.intel.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9a8d8585-4113-8ffe-d025-abd49c208428@vivier.eu>
Date: Thu, 11 Apr 2019 21:42:39 +0200
MIME-Version: 1.0
In-Reply-To: <20190304071631.27567-3-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v6 2/2] CODING_STYLE: indent
 example code as all others
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
> All the example code are indented with four spaces except this one.
> 
> Fix this by adding four spaces here.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  CODING_STYLE | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/CODING_STYLE b/CODING_STYLE
> index 90321e9c28..cb8edcbb36 100644
> --- a/CODING_STYLE
> +++ b/CODING_STYLE
> @@ -147,10 +147,10 @@ block to a separate function altogether.
>  When comparing a variable for (in)equality with a constant, list the
>  constant on the right, as in:
>  
> -if (a == 1) {
> -    /* Reads like: "If a equals 1" */
> -    do_something();
> -}
> +    if (a == 1) {
> +        /* Reads like: "If a equals 1" */
> +        do_something();
> +    }
>  
>  Rationale: Yoda conditions (as in 'if (1 == a)') are awkward to read.
>  Besides, good compilers already warn users when '==' is mis-typed as '=',
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
