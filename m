Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4248FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 08:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14777207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 08:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14777207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmC9k-00085H-A2
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 04:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jmC98-0007f4-7B; Fri, 19 Jun 2020 04:13:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12204
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jmC96-0001Cy-6W; Fri, 19 Jun 2020 04:13:09 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05J83M0o185246; Fri, 19 Jun 2020 04:13:05 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31rr2k2uu7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 04:13:04 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05J83W6j185879;
 Fri, 19 Jun 2020 04:13:04 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31rr2k2utr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 04:13:04 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05J8B0KJ029255;
 Fri, 19 Jun 2020 08:13:02 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma03fra.de.ibm.com with ESMTP id 31r0u9gt87-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 08:13:02 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 05J8BfAr12517802
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jun 2020 08:11:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B035BA4068;
 Fri, 19 Jun 2020 08:12:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1504CA405F;
 Fri, 19 Jun 2020 08:12:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.7.233])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 19 Jun 2020 08:12:59 +0000 (GMT)
Subject: Re: [PATCH v3 1/8] s390/sclp: get machine once during read scp/cpu
 info
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200618222258.23287-1-walling@linux.ibm.com>
 <20200618222258.23287-2-walling@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <31efc0f1-c8dd-028f-237b-1fb09f3f6ab5@linux.ibm.com>
Date: Fri, 19 Jun 2020 10:12:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200618222258.23287-2-walling@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6m9XUncMH09oHAAurL72h4B5WvLOuPFIG"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-19_04:2020-06-18,
 2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 cotscore=-2147483648
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190054
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 04:13:05
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: thuth@redhat.com, mst@redhat.com, cohuck@redhat.com, david@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, svens@linux.ibm.com,
 pbonzini@redhat.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6m9XUncMH09oHAAurL72h4B5WvLOuPFIG
Content-Type: multipart/mixed; boundary="Cdx3O2s6tvgna9ljjDO1d39GfgXyGvLRp"

--Cdx3O2s6tvgna9ljjDO1d39GfgXyGvLRp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/19/20 12:22 AM, Collin Walling wrote:
> Functions within read scp/cpu info will need access to the machine
> state. Let's make a call to retrieve the machine state once and
> pass the appropriate data to the respective functions.
>=20
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>  hw/s390x/sclp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 20aca30ac4..7875334037 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -49,9 +49,8 @@ static inline bool sclp_command_code_valid(uint32_t c=
ode)
>      return false;
>  }
> =20
> -static void prepare_cpu_entries(SCLPDevice *sclp, CPUEntry *entry, int=
 *count)
> +static void prepare_cpu_entries(MachineState *ms, CPUEntry *entry, int=
 *count)
>  {
> -    MachineState *ms =3D MACHINE(qdev_get_machine());
>      uint8_t features[SCCB_CPU_FEATURE_LEN] =3D { 0 };
>      int i;
> =20
> @@ -77,7 +76,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *scc=
b)
>      IplParameterBlock *ipib =3D s390_ipl_get_iplb();
> =20
>      /* CPU information */
> -    prepare_cpu_entries(sclp, read_info->entries, &cpu_count);
> +    prepare_cpu_entries(machine, read_info->entries, &cpu_count);
>      read_info->entries_cpu =3D cpu_to_be16(cpu_count);
>      read_info->offset_cpu =3D cpu_to_be16(offsetof(ReadInfo, entries))=
;
>      read_info->highest_cpu =3D cpu_to_be16(machine->smp.max_cpus - 1);=

> @@ -132,10 +131,11 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB =
*sccb)
>  /* Provide information about the CPU */
>  static void sclp_read_cpu_info(SCLPDevice *sclp, SCCB *sccb)
>  {
> +    MachineState *machine =3D MACHINE(qdev_get_machine());
>      ReadCpuInfo *cpu_info =3D (ReadCpuInfo *) sccb;
>      int cpu_count;
> =20
> -    prepare_cpu_entries(sclp, cpu_info->entries, &cpu_count);
> +    prepare_cpu_entries(machine, cpu_info->entries, &cpu_count);
>      cpu_info->nr_configured =3D cpu_to_be16(cpu_count);
>      cpu_info->offset_configured =3D cpu_to_be16(offsetof(ReadCpuInfo, =
entries));
>      cpu_info->nr_standby =3D cpu_to_be16(0);
>=20



--Cdx3O2s6tvgna9ljjDO1d39GfgXyGvLRp--

--6m9XUncMH09oHAAurL72h4B5WvLOuPFIG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl7sc4oACgkQ41TmuOI4
ufi6aBAAy7w57/dRc0XYM2HjOnc+Xqtc1NsDVYhRufLR/VyBISAvPbNf7aN7uWak
dcP9eUu+Q37uIlN2spSrcXIZcWSem3Q71cSEWCn1Y6t/bZf/slZioQDNKIQSCY5L
EvRQpVGbUDlE5bVDYpbEeRbzOdV5MCUnpZEnHtnF5JDP2FzQrSHR9k9NZRaOa4PA
EzP9YIW+7lZR1dRtr4grPWqe2op5Xv0tNiNJnXSZOYmJrEQEHkI3WIeOxbgGiA1h
ZB0vTuG6nknAT2d/Pz3Cc7jxFuC1JI6pq43wnINmmh3oFaGo/CvDV4eaHX7POoyM
lcWcEqV49/FqpoF75npsbms7HOqSJuTE1GAR/hYOQX0duUXU9eCyMQQGFn01C5K/
/EqK26WjjxmzciIcINgfSnyXML9xrX+mQ68Q0HKVwtIn3edUSmh1KgVlSZx0FSYB
30tQdqCj+yOTwEBsb7o2ujAPxriUKMuz0L6LMETiInlDa6ScEBRugl98zH2VYo7q
88PexIL9YK2HdHGN6TRu7s58jrOSdd7I2rsf2spq+IyN688bKiG1ynBkhw85Gh2K
zdOkENifhUfZ3tbHZHq5P09Gs0yPZhhlwZalNNv27gbqAjGC45ebrAV+O1O+dfh7
ySw3nLqr8PAuExyS7P1sC0F+59pmohzBgZ6l/XjjY47OEWp68L4=
=XDMJ
-----END PGP SIGNATURE-----

--6m9XUncMH09oHAAurL72h4B5WvLOuPFIG--


