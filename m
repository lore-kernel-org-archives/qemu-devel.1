Received: from eggs.gnu.org ([2001:4830:134:3::10]:38628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eydHI-0007uG-Ax
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eydHH-0005i5-JH
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:55:40 -0400
References: <20180321125411.25803-1-pbonzini@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <2f80709e-22b1-ec58-ce28-8165fe578cd2@redhat.com>
Date: Wed, 21 Mar 2018 13:55:30 +0100
MIME-Version: 1.0
In-Reply-To: <20180321125411.25803-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scsi: turn "is this a SCSI device?" into a
 conditional hint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, eblake@redhat.com

On 21/03/2018 13:54, Paolo Bonzini wrote:
> If the user does not have permissions to send ioctls to the device (due to
> SELinux or cgroups, for example), the output can look like
> 
> qemu-kvm: -device scsi-block,drive=disk: cannot get SG_IO version number:
>   Operation not permitted.  Is this a SCSI device?
> 
> but this is confusing because the ioctl was blocked _before_ the device
> even received the SG_GET_VERSION_NUM ioctl.  Therefore, for EPERM errors
> the suggestion should be eliminated.  To make that simpler, change the
> code to use error_append_hint.
> 
> Reported-by: Ala Hino <ahino@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/scsi/scsi-disk.c    | 7 ++++---
>  hw/scsi/scsi-generic.c | 7 ++++---
>  2 files changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
