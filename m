Received: from eggs.gnu.org ([209.51.188.92]:43095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gvngA-00056Q-Df
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:30:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gvng8-0006tz-O4
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:30:09 -0500
Date: Mon, 18 Feb 2019 18:29:56 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190218182956.GL32287@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190218181349.23885-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190218181349.23885-1-ppandit@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] ppc: add host-serial and host-model
 machine attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, Prasad J Pandit <pjp@fedoraproject.org>

On Mon, Feb 18, 2019 at 11:43:49PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>=20
> On ppc hosts, hypervisor shares following system attributes
>=20
>   - /proc/device-tree/system-id
>   - /proc/device-tree/model
>=20
> with a guest. This could lead to information leakage and misuse.[*]
> Add machine attributes to control such system information exposure
> to a guest.
>=20
> [*] https://wiki.openstack.org/wiki/OSSN/OSSN-0028
>=20
> Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Fix-suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/ppc/spapr.c         | 76 ++++++++++++++++++++++++++++++++++++++----
>  include/hw/ppc/spapr.h |  2 ++
>  2 files changed, 72 insertions(+), 6 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
