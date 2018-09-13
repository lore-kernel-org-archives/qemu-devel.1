Received: from eggs.gnu.org ([2001:4830:134:3::10]:39351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0VAz-0006C0-2F
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 13:13:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0VAv-0008Lc-So
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 13:13:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g0VAv-0008I8-Kv
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 13:13:05 -0400
References: <1536833233-14121-1-git-send-email-lizhijian@cn.fujitsu.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <932b5618-9dad-64bc-23d6-6a2fbf026c0a@redhat.com>
Date: Thu, 13 Sep 2018 12:12:58 -0500
MIME-Version: 1.0
In-Reply-To: <1536833233-14121-1-git-send-email-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Li Zhijian <lizhijian@cn.fujitsu.com>, rth@twiddle.net, mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, ehabkost@redhat.com, amarkovic@wavecomp.com, aurelien@aurel32.net, green@moxielogic.com, qemu-devel@nongnu.org
Cc: philip.li@intel.com

On 9/13/18 5:07 AM, Li Zhijian wrote:
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

This v2 line is useful to reviewers, but makes no sense in long term git 
(a year from now, we won't care about how many versions it took or what 
had to be tweaked, only what got committed).  Thus, it belongs...

> 
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---

...here, after the --- separator, so that it is automatically stripped 
by 'git am' rather than requiring a maintainer to touch up your commit 
message.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
