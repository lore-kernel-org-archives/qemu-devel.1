Received: from eggs.gnu.org ([2001:4830:134:3::10]:56116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gJwJe-0000zr-56
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 03:02:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gJwJX-0004a5-MC
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 03:02:26 -0500
References: <20181105135400.18366-1-marcandre.lureau@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <2f1e312b-2ece-8039-1e7b-b6b67749760a@vivier.eu>
Date: Tue, 6 Nov 2018 09:02:14 +0100
MIME-Version: 1.0
In-Reply-To: <20181105135400.18366-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] misc: fix spelling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 05/11/2018 14:54, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index af7e9f09cc..4d2e2d9902 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4065,7 +4065,7 @@ arch_query_cpu_model_expansion(CpuModelExpansionType type,
>          x86_cpu_to_dict_full(xc, props);
>      break;
>      default:
> -        error_setg(&err, "Unsupportted expansion type");
> +        error_setg(&err, "Unsupported expansion type");
>          goto out;
>      }
>  
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
