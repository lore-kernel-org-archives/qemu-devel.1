Received: from eggs.gnu.org ([2001:4830:134:3::10]:57265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1g0T5P-0006p8-Fc
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1g0T5L-0003AQ-16
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:59:15 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1g0T5I-00039Q-5S
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:59:08 -0400
Received: by mail-pg1-x544.google.com with SMTP id r1-v6so2862960pgp.11
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 07:59:07 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1536833233-14121-1-git-send-email-lizhijian@cn.fujitsu.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <07bccb6f-0921-90ee-e43b-b7ea6dfd4d99@twiddle.net>
Date: Thu, 13 Sep 2018 07:59:03 -0700
MIME-Version: 1.0
In-Reply-To: <1536833233-14121-1-git-send-email-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] change get_image_size return type to
 int64_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>, mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, ehabkost@redhat.com, amarkovic@wavecomp.com, aurelien@aurel32.net, green@moxielogic.com, qemu-devel@nongnu.org
Cc: philip.li@intel.com

On 09/13/2018 03:07 AM, Li Zhijian wrote:
> Previously, if the size of initrd >=2G, qemu exits with error:
> root@haswell-OptiPlex-9020:/home/lizj# /home/lizhijian/lkp/qemu-colo/x86_64-softmmu/qemu-system-x86_64 -kernel ./vmlinuz-4.16.0-rc4 -initrd large.cgz -nographic
> qemu: error reading initrd large.cgz: No such file or directory
> root@haswell-OptiPlex-9020:/home/lizj# du -sh large.cgz
> 2.5G	large.cgz
> 
> this patch changes the caller side that use this function to calculate
> size of initrd file as well.
> 
> v2: update error message and int64_t printing format
> 
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
