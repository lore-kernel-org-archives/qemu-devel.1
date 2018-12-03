Received: from eggs.gnu.org ([2001:4830:134:3::10]:43534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTvtR-0007pf-Ql
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 16:36:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTvtN-0001ez-L9
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 16:36:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:15846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gTvtJ-0001Pr-LR
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 16:36:36 -0500
References: <20181203092617.24090-1-d.csapak@proxmox.com>
	<20181203092617.24090-3-d.csapak@proxmox.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2a93ca10-e65f-b39a-f82f-f1f43abfdcf4@redhat.com>
Date: Mon, 3 Dec 2018 15:36:25 -0600
MIME-Version: 1.0
In-Reply-To: <20181203092617.24090-3-d.csapak@proxmox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qapi: Add reason to SHUTDOWN and
 RESET events
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
> This makes it possible to determine what the exact reason was for
> a RESET or a SHUTDOWN. A management layer might need the specific reason
> of those events to determine which cleanups or other actions it needs to do.
> 
> This patch also fixes the iotests to include the reason in the output.
> 
> Signed-off-by: Dominik Csapak <d.csapak@proxmox.com>
> ---
>   qapi/run-state.json        |  8 ++++++--

> +++ b/qapi/run-state.json
> @@ -141,6 +141,8 @@
>   # a guest-initiated ACPI shutdown request or other hardware-specific action)
>   # rather than a host request (such as sending qemu a SIGINT). (since 2.10)
>   #
> +# @reason: The @ShutdownCause which resulted in the SHUTDOWN.

Missing a '(since 4.0)' clause.


> @@ -180,6 +182,8 @@
>   # rather than a host request (such as the QMP command system_reset).
>   # (since 2.10)
>   #
> +# @reason: The @ShutdownCause of the RESET.

and again.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
