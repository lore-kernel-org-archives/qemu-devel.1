Received: from eggs.gnu.org ([2001:4830:134:3::10]:56261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fR058-0003ys-MA
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fR057-0005Qg-T1
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:56:22 -0400
References: <1528385894-19434-1-git-send-email-ari@tuxera.com>
	<1528385894-19434-3-git-send-email-ari@tuxera.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f8473628-6510-d4cd-c679-fb8354a8b831@redhat.com>
Date: Thu, 7 Jun 2018 13:56:14 -0500
MIME-Version: 1.0
In-Reply-To: <1528385894-19434-3-git-send-email-ari@tuxera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 02/10] block: Add blklogwrites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ari Sundholm <ari@tuxera.com>, qemu-devel@nongnu.org
Cc: Aapo Vienamo <aapo@tuxera.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

On 06/07/2018 10:38 AM, Ari Sundholm wrote:
> From: Aapo Vienamo <aapo@tuxera.com>
> 
> Implements a block device write logging system, similar to Linux kernel
> device mapper dm-log-writes. The write operations that are performed
> on a block device are logged to a file or another block device. The
> write log format is identical to the dm-log-writes format. Currently,
> log markers are not supported.
> 
> This functionality can be used for crash consistency and fs consistency
> testing. By implementing it in qemu, tests utilizing write logs can be
> be used to test non-Linux drivers and older kernels.
> 
> The implementation is based on the blkverify and blkdebug block drivers.
> 
> Signed-off-by: Aapo Vienamo <aapo@tuxera.com>
> Signed-off-by: Ari Sundholm <ari@tuxera.com>
> ---
>   MAINTAINERS          |   6 +
>   block/Makefile.objs  |   1 +
>   block/blklogwrites.c | 383 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   qapi/block-core.json |  29 +++-

I commented on v2 before seeing v3; but the same issues are still 
present in block-core.json (since our mails crossed).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
