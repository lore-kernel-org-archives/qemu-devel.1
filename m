Received: from eggs.gnu.org ([2001:4830:134:3::10]:41187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fqiic-0008Qg-Pf
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:39:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fqiic-0006IA-00
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:39:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51086 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fqiib-0006HL-QJ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:39:25 -0400
References: <20180815175704.105902-1-prasad.singamsetty@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9a045ecf-5bcf-c0ca-a694-13a383ae8470@redhat.com>
Date: Fri, 17 Aug 2018 19:39:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180815175704.105902-1-prasad.singamsetty@oracle.com>
Content-Type: text/plain; charset=utf-8
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
To: prasad.singamsetty@oracle.com, qemu-devel@nongnu.org
Cc: konrad.wilk@oracle.com, mark.kanda@oracle.com

On 15/08/2018 19:57, prasad.singamsetty@oracle.com wrote:
> From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
> 
> qemu command fails to process -overcommit option. Add the missing
> call to qemu_add_opts() in vl.c.
> 
> Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
> ---
>  vl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/vl.c b/vl.c
> index 16b913f9d5..12d27fa028 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2987,6 +2987,7 @@ int main(int argc, char **argv, char **envp)
>      qemu_add_opts(&qemu_object_opts);
>      qemu_add_opts(&qemu_tpmdev_opts);
>      qemu_add_opts(&qemu_realtime_opts);
> +    qemu_add_opts(&qemu_overcommit_opts);
>      qemu_add_opts(&qemu_msg_opts);
>      qemu_add_opts(&qemu_name_opts);
>      qemu_add_opts(&qemu_numa_opts);
> 

Queued, thanks.

Paolo
