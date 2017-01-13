Received: from eggs.gnu.org ([2001:4830:134:3::10]:43525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1cRx6a-00021Z-JF
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:21:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1cRx6V-0002iJ-Uh
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:21:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:50171)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1cRx6V-0002h5-Ly
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 03:20:55 -0500
References: <1484291524-1261-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1484291524-1261-11-git-send-email-caoj.fnst@cn.fujitsu.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <aac5f180-ff00-6aa3-c9ec-1d0fa7dff98a@suse.de>
Date: Fri, 13 Jan 2017 09:20:49 +0100
MIME-Version: 1.0
In-Reply-To: <1484291524-1261-11-git-send-email-caoj.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
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
To: Cao jin <caoj.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 01/13/2017 08:12 AM, Cao jin wrote:
> Also move certain hunk above, to place msix init related code together.
>=20
> CC: Hannes Reinecke <hare@suse.de>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Marcel Apfelbaum <marcel@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
>=20
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  hw/scsi/megasas.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
>=20
> msix_init() doesn't set the MSI-X enable bit, so use msix_enabled()
> is not right here, restore the old check without the
> megasas_use_msix() wrapper.
>=20
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: F. Imend=F6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=FCrnberg)
