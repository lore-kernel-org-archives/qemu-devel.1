Received: from eggs.gnu.org ([2001:4830:134:3::10]:45309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ePmWI-0005H7-RI
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:43:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ePmWF-0004yj-OG
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:43:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ePmWF-0004xw-HG
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 04:43:03 -0500
Date: Fri, 15 Dec 2017 17:42:55 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171215094255.GC15187@lemon>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-14-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-14-peterx@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v5 13/26] qmp: introduce some capability
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, 12/05 13:51, Peter Xu wrote:
> Introduce qmp_cap_enabled() and qmp_oob_enabled() helpers.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/monitor.c b/monitor.c
> index 097312e65f..9666115259 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1038,6 +1038,16 @@ static void monitor_init_qmp_commands(void)
>                           qmp_marshal_qmp_capabilities, QCO_NO_OPTIONS)=
;
>  }
> =20
> +static bool qmp_cap_enabled(Monitor *mon, QMPCapability cap)
> +{
> +    return mon->qmp.qmp_caps[cap];
> +}
> +
> +static bool qmp_oob_enabled(Monitor *mon)
> +{
> +    return qmp_cap_enabled(mon, QMP_CAPABILITY_OOB);
> +}
> +
>  static void qmp_caps_check(Monitor *mon, QMPCapabilityList *list,
>                             Error **errp)
>  {
> --=20
> 2.14.3
>=20

NACK, this commit doesn't commit for me:

/home/fam/work/qemu/monitor.c:1046:13: error: =E2=80=98qmp_oob_enabled=E2=
=80=99 defined but not used [-Werror=3Dunused-function]
 static bool qmp_oob_enabled(Monitor *mon)
             ^~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
  CC      x86_64-softmmu/accel/stubs/hax-stub.o
