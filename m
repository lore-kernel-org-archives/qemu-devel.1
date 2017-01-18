Received: from eggs.gnu.org ([2001:4830:134:3::10]:48540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1cTm2R-0005lD-Ko
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:56:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1cTm2Q-00029c-QZ
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:56:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:48496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1cTm2Q-00028q-HD
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:56:14 -0500
References: <1484633936-25344-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1484633936-25344-6-git-send-email-caoj.fnst@cn.fujitsu.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <0df606f7-3016-c013-d31f-7ebddc316ec9@suse.de>
Date: Wed, 18 Jan 2017 09:56:12 +0100
MIME-Version: 1.0
In-Reply-To: <1484633936-25344-6-git-send-email-caoj.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 05/11] megasas: change behaviour of msix
 switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On 01/17/2017 07:18 AM, Cao jin wrote:
> Resolve the TODO, msix=3Dauto means msix on; if user specify msix=3Don,
> then device creation fail on msix_init failure.
> Also undo the overwrites of user configuration of msix.
>=20
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Hannes Reinecke <hare@suse.de>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Marcel Apfelbaum <marcel@redhat.com>
>=20
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Acked-by: Marcel Apfelbaum <marcel@redhat.com>
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  hw/scsi/megasas.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
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
