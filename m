Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33849C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 08:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08AD720787
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 08:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08AD720787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jabHr-00012e-7N
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 04:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jabGv-0008P2-Rj; Mon, 18 May 2020 04:37:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23270
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jabGu-0006W4-PV; Mon, 18 May 2020 04:37:17 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04I8Wmaq036976; Mon, 18 May 2020 04:37:12 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 313pm80nhg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2020 04:37:12 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04I8aHOa049863;
 Mon, 18 May 2020 04:37:12 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 313pm80ngn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2020 04:37:12 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04I8ZuVq004520;
 Mon, 18 May 2020 08:37:10 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma04ams.nl.ibm.com with ESMTP id 3127t5kre4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2020 08:37:10 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04I8b7YD50856120
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 May 2020 08:37:07 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54D36A4054;
 Mon, 18 May 2020 08:37:07 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C46EA405C;
 Mon, 18 May 2020 08:37:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.44.214])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 18 May 2020 08:37:06 +0000 (GMT)
Subject: Re: [PATCH v2 2/8] s390/sclp: check sccb len before filling in data
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200515222032.18838-1-walling@linux.ibm.com>
 <20200515222032.18838-3-walling@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <68164af4-d7ab-2bc4-0947-5a199da93ca8@linux.ibm.com>
Date: Mon, 18 May 2020 10:37:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200515222032.18838-3-walling@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IhUfapCqEI9Gsr4vtPcwDOm98xYuk9IED"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-18_02:2020-05-15,
 2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 priorityscore=1501 cotscore=-2147483648 clxscore=1015 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005180074
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 04:37:13
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, mst@redhat.com, svens@linux.ibm.com,
 pbonzini@redhat.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IhUfapCqEI9Gsr4vtPcwDOm98xYuk9IED
Content-Type: multipart/mixed; boundary="8ZUdvX8LiiU961PMAX6057J7cjcVpftCt"

--8ZUdvX8LiiU961PMAX6057J7cjcVpftCt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/16/20 12:20 AM, Collin Walling wrote:
> The SCCB must be checked for a sufficient length before it is filled
> with any data. If the length is insufficient, then the SCLP command
> is suppressed and the proper response code is set in the SCCB header.
>=20
> Fixes: 832be0d8a3bb ("s390x: sclp: Report insufficient SCCB length")
> Signed-off-by: Collin Walling <walling@linux.ibm.com>

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>  hw/s390x/sclp.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 61e2e2839c..2bd618515e 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -75,6 +75,11 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sc=
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
>      prepare_cpu_entries(machine, read_info->entries, &cpu_count);
>      read_info->entries_cpu =3D cpu_to_be16(cpu_count);
> @@ -83,12 +88,6 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sc=
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
>      prepare_cpu_entries(machine, cpu_info->entries, &cpu_count);
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
>=20



--8ZUdvX8LiiU961PMAX6057J7cjcVpftCt--

--IhUfapCqEI9Gsr4vtPcwDOm98xYuk9IED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl7CSTIACgkQ41TmuOI4
ufg3pg//dUP+IMchFUVUXIQj+Jrwr90KKmU2HlXUvtFtxL4pWy1DLYuQsxY99vLV
Wxfim/oadfoF5C4LlmmRsa9H+WE1f70WuiSvwV6R+hpGAhBAwlcOTHT9HaxHHymK
Gl53e4bwSgwXzuy+oixOL7AFgRpLFImGwuQZ2QTbdCSZERXOrdgnTa1bQ5AQVqmL
RKNE1mTePYocg6I9KKPNxW+eDmDL7qboqGTI2V5gbnSGMJThGH32IzQ08V5IJpVa
EvvT6f6WH+1iql7DH0Y8JlOLcOsXH9r5d7WdJYrFkCFdlFsdV98pE/1ljOaHXfFD
LrEA+tb3Ea8KHFpK60txkFCciAsqeQI7IBBxDduYqKUytgTl8jqK0n9CSiyhrM4I
QOM99pLfKWC1NQJSqMAFkWZ6OZC752GcXFbyQaOyZUl12PfHoxzV4tHmuJkNC7Nb
srRZgk2/gS50Z0GUM7w3ET7Ez1fQeE87H3GKIXYL/TjIJVLGDQQJ9Nn1kmkj0zUv
kxmwXqly30VVa3/1GvQpk/4J6yspXPapx7cs91knBku8cdLwUWpV3TnBtYs6GkPA
JzXxxLjt6lJ9KVmfgSZGEqZpCn2iA75BZBgd5O5kkPsEvp+sS3RoQJ6pSOZY1mIl
5DEJQkKLf/ZsphHCklCZMlH3SnL8urrM4N0bYLAdqKBgMuSxCmc=
=Ve+w
-----END PGP SIGNATURE-----

--IhUfapCqEI9Gsr4vtPcwDOm98xYuk9IED--


