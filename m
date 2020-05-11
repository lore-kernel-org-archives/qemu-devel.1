Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121CBC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95AB206D6
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95AB206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY9Yo-0006pK-Tt
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 10:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jY9Xx-0006LK-8H; Mon, 11 May 2020 10:36:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18150
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jY9Xw-0003pU-4w; Mon, 11 May 2020 10:36:44 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04BE38vQ164664; Mon, 11 May 2020 10:36:40 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30wsc3747h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2020 10:36:40 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04BE4Xps170754;
 Mon, 11 May 2020 10:36:40 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30wsc3746s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2020 10:36:40 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04BEZIxE006930;
 Mon, 11 May 2020 14:36:38 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma04fra.de.ibm.com with ESMTP id 30wm55hufs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2020 14:36:38 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04BEaZQ460358700
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2020 14:36:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 578A14C046;
 Mon, 11 May 2020 14:36:35 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B27D34C05A;
 Mon, 11 May 2020 14:36:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.161.199])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 11 May 2020 14:36:34 +0000 (GMT)
Subject: Re: [PATCH v1 2/8] s390/sclp: check sccb len before filling in data
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200508230823.22956-1-walling@linux.ibm.com>
 <20200508230823.22956-3-walling@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <58bc496c-28bb-26f8-ab46-aba6ad141717@linux.ibm.com>
Date: Mon, 11 May 2020 16:36:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200508230823.22956-3-walling@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lY4RFBTQUR3fl6P6rCv5wuhqu1MJr4uuR"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-11_06:2020-05-11,
 2020-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110112
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 10:36:41
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: david@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, mst@redhat.com, svens@linux.ibm.com,
 pbonzini@redhat.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lY4RFBTQUR3fl6P6rCv5wuhqu1MJr4uuR
Content-Type: multipart/mixed; boundary="19f08KTvoKZnBzHvOoPtG1luQLpqjx6yF"

--19f08KTvoKZnBzHvOoPtG1luQLpqjx6yF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/9/20 1:08 AM, Collin Walling wrote:
> The SCCB must be checked for a sufficient length before it is filled
> with any data. If the length is insufficient, then the SCLP command
> is suppressed and the proper response code is set in the SCCB header.
>=20
> Signed-off-by: Collin Walling <walling@linux.ibm.com>

Fixes tag?
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>  hw/s390x/sclp.c | 22 ++++++++++------------
>  smp.max_cpus    |  0
>  2 files changed, 10 insertions(+), 12 deletions(-)
>  create mode 100644 smp.max_cpus
>=20
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 156ffe3223..d08a291e40 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -76,6 +76,11 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sc=
cb)
>      int rnsize, rnmax;
>      IplParameterBlock *ipib =3D s390_ipl_get_iplb();
> =20
> +    if (be16_to_cpu(sccb->h.length) < (sizeof(ReadInfo) + cpu_count * =
sizeof(CPUEntry))) {
> +        sccb->h.response_code =3D cpu_to_be16(SCLP_RC_INSUFFICIENT_SCC=
B_LENGTH);
> +        return;
> +    }
> +
>      /* CPU information */
>      prepare_cpu_entries(read_info->entries, &cpu_count);
>      read_info->entries_cpu =3D cpu_to_be16(cpu_count);
> @@ -84,12 +89,6 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sc=
cb)
> =20
>      read_info->ibc_val =3D cpu_to_be32(s390_get_ibc_val());
> =20
> -    if (be16_to_cpu(sccb->h.length) <
> -            (sizeof(ReadInfo) + cpu_count * sizeof(CPUEntry))) {
> -        sccb->h.response_code =3D cpu_to_be16(SCLP_RC_INSUFFICIENT_SCC=
B_LENGTH);
> -        return;
> -    }
> -
>      /* Configuration Characteristic (Extension) */
>      s390_get_feat_block(S390_FEAT_TYPE_SCLP_CONF_CHAR,
>                           read_info->conf_char);
> @@ -135,17 +134,16 @@ static void sclp_read_cpu_info(SCLPDevice *sclp, =
SCCB *sccb)
>      ReadCpuInfo *cpu_info =3D (ReadCpuInfo *) sccb;
>      int cpu_count;
> =20
> +    if (be16_to_cpu(sccb->h.length) < (sizeof(ReadCpuInfo) + cpu_count=
 * sizeof(CPUEntry))) {
> +        sccb->h.response_code =3D cpu_to_be16(SCLP_RC_INSUFFICIENT_SCC=
B_LENGTH);
> +        return;
> +    }
> +
>      prepare_cpu_entries(cpu_info->entries, &cpu_count);
>      cpu_info->nr_configured =3D cpu_to_be16(cpu_count);
>      cpu_info->offset_configured =3D cpu_to_be16(offsetof(ReadCpuInfo, =
entries));
>      cpu_info->nr_standby =3D cpu_to_be16(0);
> =20
> -    if (be16_to_cpu(sccb->h.length) <
> -            (sizeof(ReadCpuInfo) + cpu_count * sizeof(CPUEntry))) {
> -        sccb->h.response_code =3D cpu_to_be16(SCLP_RC_INSUFFICIENT_SCC=
B_LENGTH);
> -        return;
> -    }
> -
>      /* The standby offset is 16-byte for each CPU */
>      cpu_info->offset_standby =3D cpu_to_be16(cpu_info->offset_configur=
ed
>          + cpu_info->nr_configured*sizeof(CPUEntry));
> diff --git a/smp.max_cpus b/smp.max_cpus
> new file mode 100644
> index 0000000000..e69de29bb2
>=20



--19f08KTvoKZnBzHvOoPtG1luQLpqjx6yF--

--lY4RFBTQUR3fl6P6rCv5wuhqu1MJr4uuR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl65YvIACgkQ41TmuOI4
ufjr6Q/+OIOqv/uXFWJWVwhX/coHra/mZGnVcYchgpj+7m3pFaXeHWNxg3GaOqZg
vit2ktJmYryKD2HJ9pJnM2gP3D5oTdyuLesVBwrnb2J5tb4qejYjd9YeeCeDKKA4
+ubLUqLWIii7e5EdqZb94cj+tS0v08o+tegLNGqpyER+6eqPTrO5kVI5oJNXeOVa
zyiFpBTlfF4CxwWMCl5w/7LLRKCsHiugnQ6e1yMqtJ0ITypDlVy+CgO39tM9VvG5
+x5XaAU88JL+UDwpJZAhXctJwea/RbIUyMhAeETbWiTTwSCclW7TiFfpPW9LW5Dq
plOwhgC/pghP4XcSW2TJuSKg7O/H+WoveTQdBo1flc0kmCoBCkE3Kw5Ga5Jdac+5
eIqRDhXOKtRpnTvtmhQrVlqiOOmqQDZTaCwVEAppW3jfjNYsk6+2VYfhHuATlCR/
dTn0ef3yLrNPGB34CA1ACQZwYvpfGpszoQI/zRGejmoJf+dBLBUJvfwCiAdE2T93
8HH+tS3mI4Ecz3KGlwkX32RJ6sFlKib4Cn+qm+LeY6iW6tf7k4VouczqFaMU3CQ3
EKCFPEAC9PW37qBSl5TAh+/J3vdTf998RBFT49GiwSorhtnp6MkP1X6EEXdPffWG
8TTIxqI4VWplnKH9ovkXQPzZAKtrwYNGdId/DscoDZRTggXV36U=
=JicT
-----END PGP SIGNATURE-----

--lY4RFBTQUR3fl6P6rCv5wuhqu1MJr4uuR--


