Received: from eggs.gnu.org ([2001:4830:134:3::10]:58246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnkvR-0001OW-56
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnkvP-0008L9-FR
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:47:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cnkvP-0008L0-8x
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:47:35 -0400
References: <20170314113209.12025-1-eduardo.otubo@profitbricks.com>
	<20170314113209.12025-3-eduardo.otubo@profitbricks.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8d766251-b085-4d11-783d-c1a69f43c805@redhat.com>
Date: Tue, 14 Mar 2017 12:47:32 +0100
MIME-Version: 1.0
In-Reply-To: <20170314113209.12025-3-eduardo.otubo@profitbricks.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] seccomp: add obsolete argument to
 command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <eduardo.otubo@profitbricks.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com



On 14/03/2017 12:32, Eduardo Otubo wrote:
> +static const struct QemuSeccompSyscall obsolete[] = {
> +    { SCMP_SYS(readdir), 255 },
> +    { SCMP_SYS(_sysctl), 255 },
> +    { SCMP_SYS(afs_syscall), 255 },
> +    { SCMP_SYS(bdflush), 255 },
> +    { SCMP_SYS(break), 255 },
> +    { SCMP_SYS(create_module), 255 },
> +    { SCMP_SYS(ftime), 255 },
> +    { SCMP_SYS(get_kernel_syms), 255 },
> +    { SCMP_SYS(getpmsg), 255 },
> +    { SCMP_SYS(gtty), 255 },
> +    { SCMP_SYS(lock), 255 },
> +    { SCMP_SYS(mpx), 255 },
> +    { SCMP_SYS(prof), 255 },
> +    { SCMP_SYS(profil), 255 },
> +    { SCMP_SYS(putpmsg), 255 },
> +    { SCMP_SYS(query_module), 255 },
> +    { SCMP_SYS(security), 255 },
> +    { SCMP_SYS(sgetmask), 255 },
> +    { SCMP_SYS(ssetmask), 255 },
> +    { SCMP_SYS(stty), 255 },
> +    { SCMP_SYS(sysfs), 255 },
> +    { SCMP_SYS(tuxcall), 255 },
> +    { SCMP_SYS(ulimit), 255 },
> +    { SCMP_SYS(uselib), 255 },
> +    { SCMP_SYS(ustat), 255 },
> +    { SCMP_SYS(vserver), 255 },
> +};

Some of these are already blacklisted in patch 1.

Paolo
