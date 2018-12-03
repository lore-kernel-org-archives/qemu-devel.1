Received: from eggs.gnu.org ([2001:4830:134:3::10]:45240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gTnWx-0007R1-VV
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 07:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gTnL0-0001Vb-GA
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 07:28:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gTnKz-0001V0-Px
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 07:28:34 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181203092617.24090-1-d.csapak@proxmox.com>
	<20181203092617.24090-4-d.csapak@proxmox.com>
Date: Mon, 03 Dec 2018 13:28:31 +0100
In-Reply-To: <20181203092617.24090-4-d.csapak@proxmox.com> (Dominik Csapak's
	message of "Mon, 3 Dec 2018 10:26:17 +0100")
Message-ID: <875zwa4wwg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Dominik Csapak <d.csapak@proxmox.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com

Dominik Csapak <d.csapak@proxmox.com> writes:

> It is interesting to know whether the shutdown cause was 'quit' or
> 'reset', especially when using "--no-reboot". In that case, a management
> layer can now determine if the guest wanted a reboot or shutdown, and
> can act accordingly.
>
> Changes the ouput of the reason in the iotests from 'host-qmp' to
> 'host-qmp-quit'.
>
> Signed-off-by: Dominik Csapak <d.csapak@proxmox.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
