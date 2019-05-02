Received: from eggs.gnu.org ([209.51.188.92]:51447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hM5XI-0001Nq-Hw
	for qemu-devel@nongnu.org; Thu, 02 May 2019 02:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hM5XG-0008N8-Mp
	for qemu-devel@nongnu.org; Thu, 02 May 2019 02:49:40 -0400
References: <20190501223819.8584-1-richard.henderson@linaro.org>
	<20190501223819.8584-3-richard.henderson@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9e4a2f00-7652-c1dc-e45e-7407810ce4d2@redhat.com>
Date: Thu, 2 May 2019 01:49:19 -0500
MIME-Version: 1.0
In-Reply-To: <20190501223819.8584-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] configure: Use quotes around uses of
 $CPU_CFLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, mark.cave-ayland@ilande.co.uk, alex.bennee@linaro.org, david@gibson.dropbear.id.au

On 5/1/19 5:38 PM, Richard Henderson wrote:
> About half of the values to which CPU_CFLAGS is set
> have multiple space separated arguments.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  configure | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/configure b/configure
> index 234cb929ca..16bd4375d1 100755
> --- a/configure
> +++ b/configure
> @@ -1543,37 +1543,37 @@ case "$cpu" in
>             CPU_CFLAGS="-m64"
>             LDFLAGS="-m64 $LDFLAGS"
>             cross_cc_ppc64=$cc
> -           cross_cc_cflags_ppc64=$CPU_CFLAGS
> +           cross_cc_cflags_ppc64="$CPU_CFLAGS"

Makes no difference semantically (bare variable assignments are not
subject to word splitting or globbing, so the quotes don't change the
result); the only reason to change this is for consistency (using quotes
everywhere is easier to remember, whether or not they are in a context
that matter).

So I'm okay whether this patch goes in or is omitted.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
