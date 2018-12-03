Received: from eggs.gnu.org ([2001:4830:134:3::10]:44719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTvvS-0002zo-Dn
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 16:38:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTvvO-0004TR-Ow
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 16:38:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gTvvO-0004S0-Gi
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 16:38:42 -0500
References: <20181203092617.24090-1-d.csapak@proxmox.com>
	<20181203092617.24090-4-d.csapak@proxmox.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <20470290-837c-e137-ec6b-4a0179195597@redhat.com>
Date: Mon, 3 Dec 2018 15:38:40 -0600
MIME-Version: 1.0
In-Reply-To: <20181203092617.24090-4-d.csapak@proxmox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qapi: Split host-qmp into quit and
 system-reset
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
> It is interesting to know whether the shutdown cause was 'quit' or
> 'reset', especially when using "--no-reboot". In that case, a management
> layer can now determine if the guest wanted a reboot or shutdown, and
> can act accordingly.
> 
> Changes the ouput of the reason in the iotests from 'host-qmp' to

s/ouput/output/

> 'host-qmp-quit'.

May be worth adding that this change is not a compatibility break, 
because the field itself was also added in 4.0.

> 
> Signed-off-by: Dominik Csapak <d.csapak@proxmox.com>
> ---
>   qapi/run-state.json        | 10 ++++++----

Otherwise, series is looking good to me.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
