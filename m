Received: from eggs.gnu.org ([2001:4830:134:3::10]:44619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cRxC4-0006ET-Tr
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:26:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cRxC1-0006OA-0p
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:26:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cRxC0-0006Ms-Qs
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:26:36 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1484291524-1261-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1484291524-1261-11-git-send-email-caoj.fnst@cn.fujitsu.com>
Date: Fri, 13 Jan 2017 09:26:33 +0100
In-Reply-To: <1484291524-1261-11-git-send-email-caoj.fnst@cn.fujitsu.com> (Cao
	jin's message of "Fri, 13 Jan 2017 15:12:04 +0800")
Message-ID: <8760lj2wna.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 10/10] megasas: remove unnecessary
 megasas_use_msix()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Hannes Reinecke <hare@suse.de>

Cao jin <caoj.fnst@cn.fujitsu.com> writes:

> Also move certain hunk above, to place msix init related code together.
>
> CC: Hannes Reinecke <hare@suse.de>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Marcel Apfelbaum <marcel@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
>
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  hw/scsi/megasas.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
>
> msix_init() doesn't set the MSI-X enable bit, so use msix_enabled()
> is not right here, restore the old check without the
> megasas_use_msix() wrapper.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
