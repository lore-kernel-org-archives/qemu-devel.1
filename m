Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373C0C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F09172067D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09172067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxYSy-0002qh-Ab
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 11:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46781)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hxYSZ-0002Ow-02
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:11:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hxYSX-00034L-Hz
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:11:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48477)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hxYSX-00033u-9Q
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:11:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 74A6630EBE7B;
 Tue, 13 Aug 2019 15:11:36 +0000 (UTC)
Received: from [10.3.117.22] (ovpn-117-22.phx2.redhat.com [10.3.117.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 24B2E10013A1;
 Tue, 13 Aug 2019 15:11:35 +0000 (UTC)
To: Tao <tao3.xu@intel.com>, imammedo@redhat.com, ehabkost@redhat.com
References: <20190809065731.9097-1-tao3.xu@intel.com>
 <20190809065731.9097-10-tao3.xu@intel.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
 xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
 xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
 TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
 GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
 sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
 AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
 CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
 RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
 wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
 Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
 gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
 pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
 zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
 pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
 3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
 NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
 cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
 SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
 I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
 mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
 Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
 2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <be305a8a-f1f4-7084-4bb7-4174d530483d@redhat.com>
Date: Tue, 13 Aug 2019 10:11:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190809065731.9097-10-tao3.xu@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Qg8aNq8QcDZ1H9if7a8Whcr9WOrgJHI5R"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 13 Aug 2019 15:11:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v9 09/11] numa: Extend the CLI to provide
 memory latency and bandwidth information
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: jingqi.liu@intel.com, fan.du@intel.com, qemu-devel@nongnu.org,
 daniel@linux.ibm.com, Markus Armbruster <armbru@redhat.com>,
 jonathan.cameron@huawei.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qg8aNq8QcDZ1H9if7a8Whcr9WOrgJHI5R
Content-Type: multipart/mixed; boundary="U048lAAeGXzlrI5vdCoJ7DClS1dpiyx0S";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Tao <tao3.xu@intel.com>, imammedo@redhat.com, ehabkost@redhat.com
Cc: jingqi.liu@intel.com, dan.j.williams@intel.com,
 jonathan.cameron@huawei.com, daniel@linux.ibm.com, fan.du@intel.com,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Message-ID: <be305a8a-f1f4-7084-4bb7-4174d530483d@redhat.com>
Subject: Re: [PATCH v9 09/11] numa: Extend the CLI to provide memory latency
 and bandwidth information
References: <20190809065731.9097-1-tao3.xu@intel.com>
 <20190809065731.9097-10-tao3.xu@intel.com>
In-Reply-To: <20190809065731.9097-10-tao3.xu@intel.com>

--U048lAAeGXzlrI5vdCoJ7DClS1dpiyx0S
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/9/19 1:57 AM, Tao wrote:
> From: Liu Jingqi <jingqi.liu@intel.com>
>=20
> Add -numa hmat-lb option to provide System Locality Latency and
> Bandwidth Information. These memory attributes help to build
> System Locality Latency and Bandwidth Information Structure(s)
> in ACPI Heterogeneous Memory Attribute Table (HMAT).
>=20
> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>=20
> Changes in v9:
>     - change the CLI input way, make it more user firendly (Daniel Blac=
k)
>     use latency=3DNUM[p|n|u]s and bandwidth=3DNUM[M|G|P](B/s) as input =
and drop
>     the base-lat and base-bw input.

Why are you hand-rolling yet another scaling parser instead of reusing
one that's already in-tree?

> +++ b/hw/core/numa.c

> +void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
> +                        Error **errp)
> +{

> +    if (node->has_latency) {
> +        hmat_lb =3D ms->numa_state->hmat_lb[node->hierarchy][node->dat=
a_type];
> +
> +        if (!hmat_lb) {
> +            hmat_lb =3D g_malloc0(sizeof(*hmat_lb));
> +            ms->numa_state->hmat_lb[node->hierarchy][node->data_type] =
=3D hmat_lb;
> +        } else if (hmat_lb->latency[node->initiator][node->target]) {
> +            error_setg(errp, "Duplicate configuration of the latency f=
or "
> +                       "initiator=3D%" PRIu16 " and target=3D%" PRIu16=
 ".",
> +                       node->initiator, node->target);
> +            return;
> +        }
> +
> +        ret =3D qemu_strtoui(node->latency, &endptr, 10, &latency);
> +        if (ret < 0) {
> +            error_setg(errp, "Invalid latency %s", node->latency);
> +            return;
> +        }
> +
> +        if (*endptr =3D=3D '\0') {
> +            base_lat =3D 1;
> +        } else if (*(endptr + 1) =3D=3D 's') {
> +            switch (*endptr) {
> +            case 'p':
> +                base_lat =3D 1;
> +                break;
> +            case 'n':
> +                base_lat =3D PICO_PER_NSEC;
> +                break;
> +            case 'u':
> +                base_lat =3D PICO_PER_USEC;
> +                break;

Hmm - this is a different scaling than any of our existing parsers
(which assume multiples k/M/G..., not subdivisions u/n/s)


> +    if (node->has_bandwidth) {
> +        hmat_lb =3D ms->numa_state->hmat_lb[node->hierarchy][node->dat=
a_type];
> +
> +        if (!hmat_lb) {
> +            hmat_lb =3D g_malloc0(sizeof(*hmat_lb));
> +            ms->numa_state->hmat_lb[node->hierarchy][node->data_type] =
=3D hmat_lb;
> +        } else if (hmat_lb->bandwidth[node->initiator][node->target]) =
{
> +            error_setg(errp, "Duplicate configuration of the bandwidth=
 for "
> +                       "initiator=3D%" PRIu16 " and target=3D%" PRIu16=
 ".",
> +                       node->initiator, node->target);
> +            return;
> +        }
> +
> +        ret =3D qemu_strtoui(node->bandwidth, &endptr, 10, &bandwidth)=
;
> +        if (ret < 0) {
> +            error_setg(errp, "Invalid bandwidth %s", node->bandwidth);=

> +            return;
> +        }
> +
> +        switch (toupper(*endptr)) {
> +        case '\0':
> +        case 'M':
> +            base_bw =3D 1;
> +            break;
> +        case 'G':
> +            base_bw =3D UINT64_C(1) << 10;
> +            break;
> +        case 'P':
> +            base_bw =3D UINT64_C(1) << 20;
> +            break;

But this one, in addition to being wrong (P is 1<<30, not 1<<20), should
definitely be reusing qemu_strtosz_metric() or similar (look in
util/cutils.c).


> +++ b/qapi/machine.json
> @@ -377,10 +377,12 @@
>  #
>  # @cpu: property based CPU(s) to node mapping (Since: 2.10)
>  #
> +# @hmat-lb: memory latency and bandwidth information (Since: 4.2)
> +#
>  # Since: 2.1
>  ##
>  { 'enum': 'NumaOptionsType',
> -  'data': [ 'node', 'dist', 'cpu' ] }
> +  'data': [ 'node', 'dist', 'cpu', 'hmat-lb' ] }
> =20

> +##
> +# @HmatLBDataType:
> +#
> +# Data type in the System Locality Latency
> +# and Bandwidth Information Structure of HMAT (Heterogeneous
> +# Memory Attribute Table)
> +#
> +# For more information of @HmatLBDataType see
> +# the chapter 5.2.27.4: Table 5-142:  Field "Data Type" of ACPI 6.3 sp=
ec.
> +#
> +# @access-latency: access latency (picoseconds)
> +#
> +# @read-latency: read latency (picoseconds)
> +#
> +# @write-latency: write latency (picoseconds)
> +#
> +# @access-bandwidth: access bandwidth (MB/s)
> +#
> +# @read-bandwidth: read bandwidth (MB/s)
> +#
> +# @write-bandwidth: write bandwidth (MB/s)

Are these really the best scales?


> +
> +##
> +# @NumaHmatLBOptions:
> +#
> +# Set the system locality latency and bandwidth information
> +# between Initiator and Target proximity Domains.
> +#
> +# For more information of @NumaHmatLBOptions see
> +# the chapter 5.2.27.4: Table 5-142 of ACPI 6.3 spec.
> +#
> +# @initiator: the Initiator Proximity Domain.
> +#
> +# @target: the Target Proximity Domain.
> +#
> +# @hierarchy: the Memory Hierarchy. Indicates the performance
> +#             of memory or side cache.
> +#
> +# @data-type: presents the type of data, access/read/write
> +#             latency or hit latency.
> +#
> +# @latency: the value of latency from @initiator to @target proximity =
domain,
> +#           the latency units are "ps(picosecond)", "ns(nanosecond)" o=
r
> +#           "us(microsecond)".
> +#
> +# @bandwidth: the value of bandwidth between @initiator and @target pr=
oximity
> +#             domain, the bandwidth units are "MB(/s)","GB(/s)" or "PB=
(/s)".
> +#
> +# Since: 4.2
> +##
> +{ 'struct': 'NumaHmatLBOptions',
> +    'data': {
> +    'initiator': 'uint16',
> +    'target': 'uint16',
> +    'hierarchy': 'HmatLBMemoryHierarchy',
> +    'data-type': 'HmatLBDataType',
> +    '*latency': 'str',
> +    '*bandwidth': 'str' }}

=2E..and then parsing strings instead of taking raw integers?  Parsing
strings is okay for HMP, but for QMP, our goal should be a single
representation with no additional sugar on top.  Latency and bandwidth
should be int in a single scale.


> +++ b/qemu-options.hx
> @@ -164,16 +164,19 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
>      "-numa node[,mem=3Dsize][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnod=
e][,initiator=3Dnode]\n"
>      "-numa node[,memdev=3Did][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dno=
de][,initiator=3Dnode]\n"
>      "-numa dist,src=3Dsource,dst=3Ddestination,val=3Ddistance\n"
> -    "-numa cpu,node-id=3Dnode[,socket-id=3Dx][,core-id=3Dy][,thread-id=
=3Dz]\n",
> +    "-numa cpu,node-id=3Dnode[,socket-id=3Dx][,core-id=3Dy][,thread-id=
=3Dz]\n"
> +    "-numa hmat-lb,initiator=3Dnode,target=3Dnode,hierarchy=3Dmemory|f=
irst-level|second-level|third-level,data-type=3Daccess-latency|read-laten=
cy|write-latency[,latency=3Dlat][,bandwidth=3Dbw]\n",

Command-line parsing can then take human-written scaled numbers, and
pre-convert them into the single scale accepted by the QMP interface.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--U048lAAeGXzlrI5vdCoJ7DClS1dpiyx0S--

--Qg8aNq8QcDZ1H9if7a8Whcr9WOrgJHI5R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1S0yQACgkQp6FrSiUn
Q2riXQf+KBwZj0aAoYAvX1Cz6r2s8cVmUtkHYI4zmnlFxcZ6tJKCR52PN1ujAMM+
5PdeMw1si7TnglNbiE3qpBcUHJ4g+FN7urETwPOascCRHSZjHJC5TaHXvn1+GfqU
LYhfKDaL9JXPUJz+lqo+ZBYrrnhL4ps0iqZVDjxPhh5oV7OuSnnM5YJ/WtSxTFJ1
eM2vtv/ZG2AMZwGYRaGQCpnSqk5tbFsN57D8I/OnL7SXbk6Iv3EzrGfZt6CgSmqd
7+VS0Z0dhJ0vhZtxzFSS+8sJOBHEDrxulkrHnZcQsIdTJCqgF9kBJIX+uL5q/J/d
xU5QfPepgjcF0P4aSaIBpDcPl1D4gQ==
=jsol
-----END PGP SIGNATURE-----

--Qg8aNq8QcDZ1H9if7a8Whcr9WOrgJHI5R--

