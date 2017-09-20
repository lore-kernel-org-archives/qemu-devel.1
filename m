Received: from eggs.gnu.org ([2001:4830:134:3::10]:35914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duk6o-000682-By
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 14:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duk6l-0004Pu-A7
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 14:52:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1duk6l-0004MS-3x
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 14:52:27 -0400
References: <20170919213611.8988-1-jsnow@redhat.com>
	<20170919213611.8988-3-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <61dd1fd1-c3e7-2884-22bf-5856803c2a1b@redhat.com>
Date: Wed, 20 Sep 2017 20:52:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170919213611.8988-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] ppc: remove all unused CPU definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, agraf@suse.de, david@gibson.dropbear.id.au

On 19.09.2017 23:36, John Snow wrote:
> Remove *all* unused CPU definitions as indicated by compile-time
> `#if 0` constructs.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  target/ppc/cpu-models.h | 223 ------------------------------------------------
>  1 file changed, 223 deletions(-)
> 
> diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> index b34b512..248f833 100644
> --- a/target/ppc/cpu-models.h
> +++ b/target/ppc/cpu-models.h
[...]
> @@ -234,24 +105,11 @@ enum {
>      CPU_POWERPC_440GXb             = 0x51B21851,
>      CPU_POWERPC_440GXc             = 0x51B21892,
>      CPU_POWERPC_440GXf             = 0x51B21894,
> -#if 0
> -    CPU_POWERPC_440S               = xxx,
> -#endif
>      CPU_POWERPC_440SP              = 0x53221850,
>      CPU_POWERPC_440SP2             = 0x53221891,
>      CPU_POWERPC_440SPE             = 0x53421890,
>      /* PowerPC 460 family */
> -#if 0
> -    /* Generic PowerPC 464 */
> -#define CPU_POWERPC_464              CPU_POWERPC_464H90
> -#endif
>      /* PowerPC 464 microcontrolers */
> -#if 0
> -    CPU_POWERPC_464H90             = xxx,
> -#endif
> -#if 0
> -    CPU_POWERPC_464H90FP           = xxx,
> -#endif

I think you could also remove the "/* PowerPC 460 family */" and "/*
PowerPC 464 microcontrolers */" lines now.

Anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>
