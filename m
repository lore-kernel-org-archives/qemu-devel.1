Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C156EC282CE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 00:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 673D62089E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 00:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="X5BwGEts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673D62089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54801 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTbRU-0001yh-PU
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 20:18:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTbQY-0001fC-Sw
	for qemu-devel@nongnu.org; Wed, 22 May 2019 20:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTbQX-00006J-19
	for qemu-devel@nongnu.org; Wed, 22 May 2019 20:17:46 -0400
Received: from ozlabs.org ([203.11.71.1]:53125)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hTbLc-0005Wu-P6; Wed, 22 May 2019 20:12:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 458VLm4GLDz9s5c; Thu, 23 May 2019 10:12:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558570352;
	bh=Txq55GIENihYbZ5kE9Rl1OBq3l49PdIZk/ji01L+sKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X5BwGEts9f97yeiW7kj0gO/B2/UCBADVtPr3/S55ieRgsKKh/zrsnCuY8Qv+lOnqD
	rDZ2+be2W4CTxKzHkkJPb9epkTbh2uRyyuBWuhBbzRP0c0tSkNbn6XhL6Klme6Aznt
	TLw6vxICQ7RtYc+zRU6R/vucpDmI0ZLKJUUwj9zA=
Date: Thu, 23 May 2019 09:24:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190522232429.GM30423@umbus.fritz.box>
References: <20190521073348.29657-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JlJsEFsx9RQyiX4C"
Content-Disposition: inline
In-Reply-To: <20190521073348.29657-1-lvivier@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v2] numa: improve cpu hotplug error message
 with a wrong node-id
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--JlJsEFsx9RQyiX4C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2019 at 09:33:48AM +0200, Laurent Vivier wrote:
> On pseries, core-ids are strongly binded to a node-id by the command
> line option. If an user tries to add a CPU to the wrong node, he has
> an error but it is not really helpful:
>=20
>   qemu-system-ppc64 ... -smp 1,maxcpus=3D64,cores=3D1,threads=3D1,sockets=
=3D1 \
>                         -numa node,nodeid=3D0 -numa node,nodeid=3D1 ...
>=20
>   (qemu) device_add power9_v2.0-spapr-cpu-core,core-id=3D30,node-id=3D1
>   Error: node-id=3D1 must match numa node specified with -numa option
>=20
> This patch improves this error message by giving to the user the good
> topology information (node-id, socket-id and thread-id if they are
> available) to use with the core-id he's providing:
>=20
>   Error: core-id 30 can only be plugged into node-id 0
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

LGTM,

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
> Notes:
>     v2: display full topology in the error message
>=20
>  numa.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>=20
> diff --git a/numa.c b/numa.c
> index 3875e1efda3a..7413f821e2bb 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -458,6 +458,27 @@ void qmp_set_numa_node(NumaOptions *cmd, Error **err=
p)
>      set_numa_options(MACHINE(qdev_get_machine()), cmd, errp);
>  }
> =20
> +static char *cpu_topology_to_string(const CPUArchId *cpu)
> +{
> +    GString *s =3D g_string_new(NULL);
> +    if (cpu->props.has_socket_id) {
> +        g_string_append_printf(s, "socket-id %"PRId64, cpu->props.socket=
_id);
> +    }
> +    if (cpu->props.has_node_id) {
> +        if (s->len) {
> +            g_string_append_printf(s, ", ");
> +        }
> +        g_string_append_printf(s, "node-id %"PRId64, cpu->props.node_id);
> +    }
> +    if (cpu->props.has_thread_id) {
> +        if (s->len) {
> +            g_string_append_printf(s, ", ");
> +        }
> +        g_string_append_printf(s, "thread-id %"PRId64, cpu->props.thread=
_id);
> +    }
> +    return g_string_free(s, false);
> +}
> +
>  void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **=
errp)
>  {
>      int node_id =3D object_property_get_int(OBJECT(dev), "node-id", &err=
or_abort);
> @@ -470,8 +491,11 @@ void numa_cpu_pre_plug(const CPUArchId *slot, Device=
State *dev, Error **errp)
>                                      "node-id", errp);
>          }
>      } else if (node_id !=3D slot->props.node_id) {
> -        error_setg(errp, "node-id=3D%d must match numa node specified "
> -                   "with -numa option", node_id);
> +        char *topology =3D cpu_topology_to_string(slot);
> +        error_setg(errp,
> +                   "core-id %"PRId64" can only be plugged into %s",
> +                   slot->props.core_id, topology);
> +        g_free(topology);
>      }
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JlJsEFsx9RQyiX4C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzl2i0ACgkQbDjKyiDZ
s5K/Eg/+Ktn/r8CdwQVKwOJ8/xNwc34839VPxqDE1pdamxDGhQkrxNRngP8LTtQ7
9E8K6iivHTrI/7nEYTHCm7ErVZZlod0Z5o7Lsq0WyZZI3vxxGwbPOpIv+uQb2OXO
vk7fvzwLtDRusJDrJdlEXNbw2/30fWnhkmbshG2yIyD18xcEKZh2CeilntWpfQD5
DZsZ+DiB44OWfoYag2m68HniMOF0K65r6ar2Edj4VsnE8lCq9Xq8NSR0zfndrADw
XE0ZKz82tFzjcK5rPztG+B5tasDWMpeGQaDkZNiaBRNjXT0ZjKsC62W/8cpM2PGO
21EWV2iFDbcwsHBDnxmM1uWut1hTtl/29fzakdNXMvIu0wSVRp9xZFoo5yFlML/d
UOR8nNCI3uV2yhIvxsFLR5nGWlqkicWVMLeYMiDqixw3IHBgYQuFhu4CRgR8HN7C
eY2+pp6f7aNVIFAhtjdwca97L31ig+KvhBfKLw4mqgCPIp5Qytwvqbco6sLulLhw
GpnMD6AWMIZmo/IsJEmMrxq88hrPIAHloHQ/61HFPWAFgS2QLHLPb+wlrCzN267e
a/acMZ0cMud8Z6fAQIBh48tkY/Fk8phobcHJaGxkpsZz5pGCEJyAfFr2WHi8QCVJ
VBSb6vlTGvCVI/9kT+hVpFUdwnxjLDDtCzFWPJeZ56I6s/WACVc=
=Ti2u
-----END PGP SIGNATURE-----

--JlJsEFsx9RQyiX4C--

