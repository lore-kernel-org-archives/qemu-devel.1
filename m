Received: from eggs.gnu.org ([2001:4830:134:3::10]:44895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clyit-000611-VY
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 09:07:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clyip-00013c-Op
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 09:07:19 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clyip-000137-Kf
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 09:07:15 -0500
Received: by mail-qk0-x244.google.com with SMTP id o135so19735760qke.2
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 06:07:13 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170309132216.23482-1-dgilbert@redhat.com>
	<20170309132216.23482-2-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1e8ca2a3-d2c1-6335-e5c7-edc550ef1bb8@amsat.org>
Date: Thu, 9 Mar 2017 11:07:05 -0300
MIME-Version: 1.0
In-Reply-To: <20170309132216.23482-2-dgilbert@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] RAMBlocks: qemu_ram_is_shared
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com
Cc: lvivier@redhat.com, pbonzini@redhat.com, pasic@linux.vnet.ibm.com

On 03/09/2017 10:22 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Provide a helper to say whether a RAMBlock was created as a
> shared mapping.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  exec.c                    | 5 +++++
>  include/exec/cpu-common.h | 1 +
>  2 files changed, 6 insertions(+)
>
> diff --git a/exec.c b/exec.c
> index aabb035..1f25a12 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2593,6 +2593,11 @@ MemoryRegion *get_system_io(void)
>      return system_io;
>  }
>
> +bool qemu_ram_is_shared(RAMBlock *rb)
> +{
> +    return rb->flags & RAM_SHARED;
> +}
> +
>  #endif /* !defined(CONFIG_USER_ONLY) */
>
>  /* physical memory access (slow version, mainly for debug) */
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index b62f0d8..4d45a72 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -69,6 +69,7 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
>  void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *dev);
>  void qemu_ram_unset_idstr(RAMBlock *block);
>  const char *qemu_ram_get_idstr(RAMBlock *rb);
> +bool qemu_ram_is_shared(RAMBlock *rb);
>  size_t qemu_ram_pagesize(RAMBlock *block);
>  size_t qemu_ram_pagesize_largest(void);
>
>
