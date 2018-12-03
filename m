Received: from eggs.gnu.org ([2001:4830:134:3::10]:42159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTvrN-0006mE-85
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 16:34:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTvrH-0006yX-Cb
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 16:34:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gTvrH-0006nJ-0w
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 16:34:27 -0500
References: <20181203092617.24090-1-d.csapak@proxmox.com>
	<20181203092617.24090-2-d.csapak@proxmox.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5091fc5e-51f0-d470-de1c-c75ad0314d42@redhat.com>
Date: Mon, 3 Dec 2018 15:34:23 -0600
MIME-Version: 1.0
In-Reply-To: <20181203092617.24090-2-d.csapak@proxmox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qapi: Turn ShutdownCause into QAPI
 enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dominik Csapak <d.csapak@proxmox.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, armbru@redhat.com, mreitz@redhat.com

On 12/3/18 3:26 AM, Dominik Csapak wrote:
> Needed so the patch after next can add ShutdownCause to QMP events
> SHUTDOWN and RESET.
> 
> Signed-off-by: Dominik Csapak <d.csapak@proxmox.com>
> ---
>   include/sysemu/sysemu.h | 20 --------------------
>   qapi/run-state.json     | 34 ++++++++++++++++++++++++++++++++++
>   2 files changed, 34 insertions(+), 20 deletions(-)

> +++ b/qapi/run-state.json

> +# @subsystem-reset: Partial guest reset that does not trigger QMP events and
> +#                  ignores --no-reboot. This is useful for sanitizing
> +#                  hypercalls on s390 that are used during kexec/kdump/boot

Is it ever possible for a user to see this state, or is the intent that 
it is internal-only?  But it's not the first time we've leaked internal 
states into enums (see, for example, 'null' within JobStatus in 
job.json), so it's not a showstopper.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
