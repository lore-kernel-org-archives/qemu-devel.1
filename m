Received: from eggs.gnu.org ([2001:4830:134:3::10]:52071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fFdQQ-00037V-Eo
	for qemu-devel@nongnu.org; Mon, 07 May 2018 06:31:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fFdQN-0008GS-AC
	for qemu-devel@nongnu.org; Mon, 07 May 2018 06:31:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48830 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1fFdQN-0008F9-5F
	for qemu-devel@nongnu.org; Mon, 07 May 2018 06:31:19 -0400
Date: Mon, 7 May 2018 12:31:08 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20180507103108.GD17261@vader>
References: <20180507033214.19219-1-zyimin@linux.ibm.com>
	<20180507033214.19219-2-zyimin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180507033214.19219-2-zyimin@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] sandbox: avoid to compile options if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.ibm.com>
Cc: qemu-devel@nongnu.org, jtomko@redhat.com, jferlan@redhat.com, berrange@redhat.com, borntraeger@de.ibm.com, fiuczy@linux.ibm.com

On 07/05/2018 - 11:32:14, Yi Min Zhao wrote:
> If CONFIG_SECCOMP is undefined, the option 'elevatorprivileges' remains
> complied. This would make libvirt set the corresponding capability and
> then trigger the guest startup fails. So let's wrap the options with
> CONFIG_SECCOMP.
> 
> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
> ---
>  vl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/vl.c b/vl.c
> index fce1fd12d8..cb07b19c02 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -268,6 +268,7 @@ static QemuOptsList qemu_sandbox_opts = {
>              .name = "enable",
>              .type = QEMU_OPT_BOOL,
>          },
> +#ifdef CONFIG_SECCOMP
>          {
>              .name = "obsolete",
>              .type = QEMU_OPT_STRING,
> @@ -284,6 +285,7 @@ static QemuOptsList qemu_sandbox_opts = {
>              .name = "resourcecontrol",
>              .type = QEMU_OPT_STRING,
>          },
> +#endif
>          { /* end of list */ }
>      },
>  };
> -- 
> 2.15.1 (Apple Git-101)
> 
Acked-by: Eduardo Otubo <otubo@redhat.com>
