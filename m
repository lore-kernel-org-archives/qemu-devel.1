Received: from eggs.gnu.org ([2001:4830:134:3::10]:48976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1fq10Z-0006ja-CA
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 14:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1fq10U-0005YH-9N
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 14:59:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.kanda@oracle.com>)
	id 1fq10T-0005Y6-VD
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 14:58:58 -0400
References: <20180815175704.105902-1-prasad.singamsetty@oracle.com>
From: Mark Kanda <mark.kanda@oracle.com>
Message-ID: <f36efa3c-c517-e91f-30b3-60463e25305d@oracle.com>
Date: Wed, 15 Aug 2018 13:58:53 -0500
MIME-Version: 1.0
In-Reply-To: <20180815175704.105902-1-prasad.singamsetty@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] kvm: add call to qemu_add_opts() for
 -overcommit option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: prasad.singamsetty@oracle.com, qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: konrad.wilk@oracle.com



On 8/15/2018 12:57 PM, prasad.singamsetty@oracle.com wrote:
> From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
> 
> qemu command fails to process -overcommit option. Add the missing
> call to qemu_add_opts() in vl.c.
> 
> Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>

Reviewed-by: Mark Kanda <mark.kanda@oracle.com>

> ---
>   vl.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/vl.c b/vl.c
> index 16b913f9d5..12d27fa028 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2987,6 +2987,7 @@ int main(int argc, char **argv, char **envp)
>       qemu_add_opts(&qemu_object_opts);
>       qemu_add_opts(&qemu_tpmdev_opts);
>       qemu_add_opts(&qemu_realtime_opts);
> +    qemu_add_opts(&qemu_overcommit_opts);
>       qemu_add_opts(&qemu_msg_opts);
>       qemu_add_opts(&qemu_name_opts);
>       qemu_add_opts(&qemu_numa_opts);
> 
