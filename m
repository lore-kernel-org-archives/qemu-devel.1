Received: from eggs.gnu.org ([2001:4830:134:3::10]:46457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePRfr-0002E2-Oy
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePRfp-0002Il-4Y
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:27:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ePRfo-0002HJ-Vd
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:27:33 -0500
References: <1513187549-2435-1-git-send-email-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d6ca149d-0c1d-cb5b-9691-d9a8d84d4093@redhat.com>
Date: Thu, 14 Dec 2017 12:27:28 +0100
MIME-Version: 1.0
In-Reply-To: <1513187549-2435-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] Don't abort on writes to ROMs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, Paul Burton <paul.burton@mips.com>

On 13/12/2017 18:52, Peter Maydell wrote:
> Currently we set up the io_mem_rom special memory region using the
> unassigned_mem_ops structure; this is then used when a guest tries to
> write to ROM.  This is incorrect, because the behaviour of unassigned
> memory may be different from that of ROM for writes.  In particular,
> on some architectures writing to unassigned memory generates a guest
> exception, whereas writing to ROM is generally ignored.
> 
> This patchset creates a separate readonly_mem_ops for handling the
> writes to readonly memory, which just ignores them.
> 
> Patch 2 removes a workaround in the MIPS boston board which
> is no longer needed once the core memory system is fixed.
> 
> Disclaimer: I haven't tested the mips change beyond 'make check'
> (I tested the exec patch with a temporary hack to the Arm
> virt board), but I believe it to be correct...
> 
> thanks
> -- PMM
> 
> 
> Peter Maydell (2):
>   exec: Don't reuse unassigned_mem_ops for io_mem_rom
>   hw/mips/boston: Remove workaround for writes to ROM aborting
> 
>  exec.c           | 34 +++++++++++++++++++++++++++++++++-
>  hw/mips/boston.c | 14 ++------------
>  2 files changed, 35 insertions(+), 13 deletions(-)
> 

Queued for 2.12, thanks.

Paolo
