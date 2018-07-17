Received: from eggs.gnu.org ([2001:4830:134:3::10]:38863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ffSQx-0003sr-3Z
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ffSQu-00066t-0H
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:02:39 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ffSQt-00066U-O5
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:02:35 -0400
Received: by mail-pg1-x544.google.com with SMTP id y5-v6so642441pgv.1
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 09:02:35 -0700 (PDT)
References: <1531809130-31088-1-git-send-email-junyan.he@gmx.com>
	<1531809130-31088-3-git-send-email-junyan.he@gmx.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5a3a6160-e7ed-0bfb-7f52-a067a9a0762f@linaro.org>
Date: Tue, 17 Jul 2018 09:02:31 -0700
MIME-Version: 1.0
In-Reply-To: <1531809130-31088-3-git-send-email-junyan.he@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7 V10] memory,
 exec: switch file ram allocation functions to 'flags' parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: junyan.he@gmx.com, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, xiaoguangrong.eric@gmail.com, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, yi.z.zhang@intel.com, Junyan He <junyan.he@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

On 07/16/2018 11:32 PM, junyan.he@gmx.com wrote:
>  RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
> -                                 bool share, int fd,
> +                                 uint64_t ram_flags, int fd,
>                                   Error **errp)
>  {
>      RAMBlock *new_block;
> @@ -2280,14 +2280,14 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>      new_block->mr = mr;
>      new_block->used_length = size;
>      new_block->max_length = size;
> -    new_block->flags = share ? RAM_SHARED : 0;
> +    new_block->flags = ram_flags;

The type of "flags" within RAMBlock is uint32_t.

You should either change the member type in the struct,
or change the argument type in all of these functions.

More likely the latter, since you seem to have just
five used bits at the moment.


r~
