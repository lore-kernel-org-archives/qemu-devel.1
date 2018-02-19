Received: from eggs.gnu.org ([2001:4830:134:3::10]:34452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrHb-0002OG-M0
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrHY-0003Vc-8r
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42056
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1enrHY-0003Ug-3l
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:39:24 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1JJcZxK115765
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:39:23 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g82dpx85s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:39:23 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 12:39:22 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180211093607.27351-29-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-29-armbru@redhat.com>
Date: Mon, 19 Feb 2018 13:38:21 -0600
Message-Id: <151906910102.12376.11792130292491177643@sif>
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
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

Quoting Markus Armbruster (2018-02-11 03:36:06)
> Fix up the reference to qmp-commands.hx in qmp.c.  Missed in commit
> 5032a16d1d.
> =

> Fix up the reference to qmp-commands.txt in
> docs/xen-save-devices-state.txt.  Missed in commit 4d8bb958fa.
> =

> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  docs/xen-save-devices-state.txt |  3 +--
>  qmp.c                           | 14 +++++++-------
>  2 files changed, 8 insertions(+), 9 deletions(-)
> =

> diff --git a/docs/xen-save-devices-state.txt b/docs/xen-save-devices-stat=
e.txt
> index a72ecc8081..1912ecad25 100644
> --- a/docs/xen-save-devices-state.txt
> +++ b/docs/xen-save-devices-state.txt
> @@ -8,8 +8,7 @@ These operations are normally used with migration (see mi=
gration.txt),
>  however it is also possible to save the state of all devices to file,
>  without saving the RAM or the block devices of the VM.
> =

> -This operation is called "xen-save-devices-state" (see
> -qmp-commands.txt)
> +The save operation is available as QMP command xen-save-devices-state.
> =

> =

>  The binary format used in the file is the following:
> diff --git a/qmp.c b/qmp.c
> index a8d4eba973..ba82e1df9f 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -147,13 +147,13 @@ VncInfo2List *qmp_query_vnc_servers(Error **errp)
> =

>  #ifndef CONFIG_SPICE
>  /*
> - * qmp-commands.hx ensures that QMP command query-spice exists only
> - * #ifdef CONFIG_SPICE.  Necessary for an accurate query-commands
> - * result.  However, the QAPI schema is blissfully unaware of that,
> - * and the QAPI code generator happily generates a dead
> - * qmp_marshal_query_spice() that calls qmp_query_spice().  Provide it
> - * one, or else linking fails.  FIXME Educate the QAPI schema on
> - * CONFIG_SPICE.
> + * qmp_unregister_commands_hack() ensures that QMP command query-spice
> + * exists only #ifdef CONFIG_SPICE.  Necessary for an accurate
> + * query-commands result.  However, the QAPI schema is blissfully
> + * unaware of that, and the QAPI code generator happily generates a
> + * dead qmp_marshal_query_spice() that calls qmp_query_spice().
> + * Provide it one, or else linking fails.  FIXME Educate the QAPI
> + * schema on CONFIG_SPICE.
>   */
>  SpiceInfo *qmp_query_spice(Error **errp)
>  {
> -- =

> 2.13.6
>=20
