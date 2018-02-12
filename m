Received: from eggs.gnu.org ([2001:4830:134:3::10]:38909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elMsr-0007kd-Ot
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 17:47:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elMsn-0000fX-T6
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 17:47:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elMsn-0000fC-Mg
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 17:47:33 -0500
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-29-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5ab531d1-347d-a04d-377e-1008bb597934@redhat.com>
Date: Mon, 12 Feb 2018 16:47:23 -0600
MIME-Version: 1.0
In-Reply-To: <20180211093607.27351-29-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 28/29] Fix up dangling references to
 qmp-commands.* in comment and doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com

On 02/11/2018 03:36 AM, Markus Armbruster wrote:
> Fix up the reference to qmp-commands.hx in qmp.c.  Missed in commit
> 5032a16d1d.
> 
> Fix up the reference to qmp-commands.txt in
> docs/xen-save-devices-state.txt.  Missed in commit 4d8bb958fa.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   docs/xen-save-devices-state.txt |  3 +--
>   qmp.c                           | 14 +++++++-------
>   2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/docs/xen-save-devices-state.txt b/docs/xen-save-devices-state.txt
> index a72ecc8081..1912ecad25 100644
> --- a/docs/xen-save-devices-state.txt
> +++ b/docs/xen-save-devices-state.txt
> @@ -8,8 +8,7 @@ These operations are normally used with migration (see migration.txt),
>   however it is also possible to save the state of all devices to file,
>   without saving the RAM or the block devices of the VM.
>   
> -This operation is called "xen-save-devices-state" (see
> -qmp-commands.txt)
> +The save operation is available as QMP command xen-save-devices-state.

I like the fact that you made the reword more generic (in case we rename 
things again, one less place to edit).

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
