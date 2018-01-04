Received: from eggs.gnu.org ([2001:4830:134:3::10]:54804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eXDbX-0004sD-E8
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 17:03:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eXDbU-0005B5-0P
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 17:03:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54632
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eXDbT-00059u-RV
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 17:03:11 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w04LwnEF026260
	for <qemu-devel@nongnu.org>; Thu, 4 Jan 2018 17:03:11 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2f9rs7hjbt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 17:03:10 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 4 Jan 2018 17:03:10 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180103115455.25843-3-danielhb@linux.vnet.ibm.com>
References: <20180103115455.25843-1-danielhb@linux.vnet.ibm.com>
	<20180103115455.25843-3-danielhb@linux.vnet.ibm.com>
Date: Thu, 04 Jan 2018 16:02:28 -0600
Message-Id: <151510334864.2579.17551290704822094291@sif>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] qga: update guest-suspend-ram and
 guest-suspend-hybrid descriptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, eblake@redhat.com

Quoting Daniel Henrique Barboza (2018-01-03 05:54:55)
> This patch updates the descriptions of 'guest-suspend-ram' and
> 'guest-suspend-hybrid' to mention that both commands relies now
> on the existence of 'system_wakeup' and also on the proper support
> for wake up from suspend, retrieved by the 'wakeup-suspend-support'
> attribute of the 'query-target' QMP command.
> =

> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  qga/qapi-schema.json | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> =

> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 17884c7c70..e3fb8adfce 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -566,8 +566,11 @@
>  # package installed in the guest.
>  #
>  # IMPORTANT: guest-suspend-ram requires QEMU to support the 'system_wake=
up'
> -# command.  Thus, it's *required* to query QEMU for the presence of the
> -# 'system_wakeup' command before issuing guest-suspend-ram.
> +# command and the guest to support wake up from suspend. Thus, it's
> +# *required* to query QEMU for the presence of the 'system_wakeup' comma=
nd
> +# and to verify that wake up from suspend is enabled by checking the
> +# 'wakeup-suspend-support' flag of 'query-target' QMP command, before is=
suing
> +# guest-suspend-ram.
>  #
>  # This command does NOT return a response on success. There are two opti=
ons
>  # to check for success:
> @@ -593,8 +596,11 @@
>  # This command requires the pm-utils package to be installed in the gues=
t.
>  #
>  # IMPORTANT: guest-suspend-hybrid requires QEMU to support the 'system_w=
akeup'
> -# command.  Thus, it's *required* to query QEMU for the presence of the
> -# 'system_wakeup' command before issuing guest-suspend-hybrid.
> +# command and the guest to support wake up from suspend. Thus, it's
> +# *required* to query QEMU for the presence of the 'system_wakeup' comma=
nd
> +# and to verify that wake up from suspend is enabled by checking the
> +# 'wakeup-suspend-support' flag of 'query-target' QMP command, before is=
suing
> +# guest-suspend-hybrid.
>  #
>  # This command does NOT return a response on success. There are two opti=
ons
>  # to check for success:
> -- =

> 2.13.6
>=20
