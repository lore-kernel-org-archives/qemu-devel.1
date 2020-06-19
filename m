Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D6BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:51:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2FA32078D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2FA32078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmEbv-0001zq-4n
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 06:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jmEbF-0001RP-SQ; Fri, 19 Jun 2020 06:50:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jmEbD-0002dQ-Tu; Fri, 19 Jun 2020 06:50:21 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05JAXHPR069585; Fri, 19 Jun 2020 06:50:18 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31rq0wfvnt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 06:50:18 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05JAZ2xX074503;
 Fri, 19 Jun 2020 06:50:17 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31rq0wfvn5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 06:50:17 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05JAf78H001596;
 Fri, 19 Jun 2020 10:50:15 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma03fra.de.ibm.com with ESMTP id 31r0u9gyp5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 10:50:15 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05JAoCFH3342624
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jun 2020 10:50:12 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6E87A405F;
 Fri, 19 Jun 2020 10:50:12 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1629EA405B;
 Fri, 19 Jun 2020 10:50:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.7.233])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 19 Jun 2020 10:50:12 +0000 (GMT)
Subject: Re: [PATCH v3 3/8] s390/sclp: rework sclp boundary and length checks
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200618222258.23287-1-walling@linux.ibm.com>
 <20200618222258.23287-4-walling@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 mQINBFubpD4BEADX0uhkRhkj2AVn7kI4IuPY3A8xKat0ihuPDXbynUC77mNox7yvK3X5QBO6
 qLqYr+qrG3buymJJRD9xkp4mqgasHdB5WR9MhXWKH08EvtvAMkEJLnqxgbqf8td3pCQ2cEpv
 15mH49iKSmlTcJ+PvJpGZcq/jE42u9/0YFHhozm8GfQdb9SOI/wBSsOqcXcLTUeAvbdqSBZe
 zuMRBivJQQI1esD9HuADmxdE7c4AeMlap9MvxvUtWk4ZJ/1Z3swMVCGzZb2Xg/9jZpLsyQzb
 lDbbTlEeyBACeED7DYLZI3d0SFKeJZ1SUyMmSOcr9zeSh4S4h4w8xgDDGmeDVygBQZa1HaoL
 Esb8Y4avOYIgYDhgkCh0nol7XQ5i/yKLtnNThubAcxNyryw1xSstnKlxPRoxtqTsxMAiSekk
 0m3WJwvwd1s878HrQNK0orWd8BzzlSswzjNfQYLF466JOjHPWFOok9pzRs+ucrs6MUwDJj0S
 cITWU9Rxb04XyigY4XmZ8dywaxwi2ZVTEg+MD+sPmRrTw+5F+sU83cUstuymF3w1GmyofgsU
 Z+/ldjToHnq21MNa1wx0lCEipCCyE/8K9B9bg9pUwy5lfx7yORP3JuAUfCYb8DVSHWBPHKNj
 HTOLb2g2UT65AjZEQE95U2AY9iYm5usMqaWD39pAHfhC09/7NQARAQABtCVKYW5vc2NoIEZy
 YW5rIDxmcmFua2phQGxpbnV4LmlibS5jb20+iQI3BBMBCAAhBQJbm6Q+AhsjBQsJCAcCBhUI
 CQoLAgQWAgMBAh4BAheAAAoJEONU5rjiOLn4p9gQALjkdj5euJVI2nNT3/IAxAhQSmRhPEt0
 AmnCYnuTcHRWPujNr5kqgtyER9+EMQ0ZkX44JU2q7OWxTdSNSAN/5Z7qmOR9JySvDOf4d3mS
 bMB5zxL9d8SbnSs1uW96H9ZBTlTQnmLfsiM9TetAjSrR8nUmjGhe2YUhJLR1v1LguME+YseT
 eXnLzIzqqpu311/eYiiIGcmaOjPCE+vFjcXL5oLnGUE73qSYiujwhfPCCUK0850o1fUAYq5p
 CNBCoKT4OddZR+0itKc/cT6NwEDwdokeg0+rAhxb4Rv5oFO70lziBplEjOxu3dqgIKbHbjza
 EXTb+mr7VI9O4tTdqrwJo2q9zLqqOfDBi7NDvZFLzaCewhbdEpDYVu6/WxprAY94hY3F4trT
 rQMHJKQENtF6ZTQc9fcT5I3gAmP+OEvDE5hcTALpWm6Z6SzxO7gEYCnF+qGXqp8sJVrweMub
 UscyLqHoqdZC2UG4LQ1OJ97nzDpIRe0g6oJ9ZIYHKmfw5jjwH6rASTld5MFWajWdNsqK15k/
 RZnHAGICKVIBOBsq26m4EsBlfCdt3b/6emuBjUXR1pyjHMz2awWzCq6/6OWs5eANZ0sdosNq
 dq2v0ULYTazJz2rlCXV89qRa7ukkNwdBSZNEwsD4eEMicj1LSrqWDZMAALw50L4jxaMD7lPL
 jJbauQINBFubpD4BEADAcUTRqXF/aY53OSH7IwIK9lFKxIm0IoFkOEh7LMfp7FGzaP7ANrZd
 cIzhZi38xyOkcaFY+npGEWvko7rlIAn0JpBO4x3hfhmhBD/WSY8LQIFQNNjEm3vzrMo7b9Jb
 JAqQxfbURY3Dql3GUzeWTG9uaJ00u+EEPlY8zcVShDltIl5PLih20e8xgTnNzx5c110lQSu0
 iZv2lAE6DM+2bJQTsMSYiwKlwTuv9LI9Chnoo6+tsN55NqyMxYqJgElk3VzlTXSr3+rtSCwf
 tq2cinETbzxc1XuhIX6pu/aCGnNfuEkM34b7G1D6CPzDMqokNFbyoO6DQ1+fW6c5gctXg/lZ
 602iEl4C4rgcr3+EpfoPUWzKeM8JXv5Kpq4YDxhvbitr8Dm8gr38+UKFZKlWLlwhQ56r/zAU
 v6LIsm11GmFs2/cmgD1bqBTNHHcTWwWtRTLgmnqJbVisMJuYJt4KNPqphTWsPY8SEtbufIlY
 HXOJ2lqUzOReTrie2u0qcSvGAbSfec9apTFl2Xko/ddqPcZMpKhBiXmY8tJzSPk3+G4tqur4
 6TYAm5ouitJsgAR61Cu7s+PNuq/pTLDhK+6/Njmc94NGBcRA4qTuysEGE79vYWP2oIAU4Fv6
 gqaWHZ4MEI2XTqH8wiwzPdCQPYsSE0fXWiYu7ObeErT6iLSTZGx4rQARAQABiQIfBBgBCAAJ
 BQJbm6Q+AhsMAAoJEONU5rjiOLn4DDEP/RuyckW65SZcPG4cMfNgWxZF8rVjeVl/9PBfy01K
 8R0hajU40bWtXSMiby7j0/dMjz99jN6L+AJHJvrLz4qYRzn2Ys843W+RfXj62Zde4YNBE5SL
 jJweRCbMWKaJLj6499fctxTyeb9+AMLQS4yRSwHuAZLmAb5AyCW1gBcTWZb8ON5BmWnRqeGm
 IgC1EvCnHy++aBnHTn0m+zV89BhTLTUal35tcjUFwluBY39R2ux/HNlBO1GY3Z+WYXhBvq7q
 katThLjaQSmnOrMhzqYmdShP1leFTVbzXUUIYv/GbynO/YrL2gaQpaP1bEUEi8lUAfXJbEWG
 dnHFkciryi092E8/9j89DJg4mmZqOau7TtUxjRMlBcIliXkzSLUk+QvD4LK1kWievJse4mte
 FBdkWHfP4BH/+8DxapRcG1UAheSnSRQ5LiO50annOB7oXF+vgKIaie2TBfZxQNGAs3RQ+bga
 DchCqFm5adiSP5+OT4NjkKUeGpBe/aRyQSle/RropTgCi85pje/juYEn2P9UAgkfBJrOHvQ9
 Z+2Sva8FRd61NJLkCJ4LFumRn9wQlX2icFbi8UDV3do0hXJRRYTWCxrHscMhkrFWLhYiPF4i
 phX7UNdOWBQ90qpHyAxHmDazdo27gEjfvsgYMdveKknEOTEb5phwxWgg7BcIDoJf9UMC
Message-ID: <afb07359-bfaf-90ee-f68b-9b31e6a7445e@linux.ibm.com>
Date: Fri, 19 Jun 2020 12:50:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200618222258.23287-4-walling@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="84jQrZI84VYaBTLw7F5rZSEHfFMsCsN0n"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-19_05:2020-06-19,
 2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 cotscore=-2147483648 clxscore=1015 malwarescore=0 impostorscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190074
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 06:50:18
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
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
--84jQrZI84VYaBTLw7F5rZSEHfFMsCsN0n
Content-Type: multipart/mixed; boundary="4ROME1fHcUuXiOuF1ppypvsZRiDHfwJ6M"

--4ROME1fHcUuXiOuF1ppypvsZRiDHfwJ6M
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/19/20 12:22 AM, Collin Walling wrote:
> Rework the SCLP boundary check to account for different SCLP commands
> (eventually) allowing different boundary sizes.
>=20
> Move the length check code into a separate function, and introduce a
> new function to determine the length of the read SCP data (i.e. the siz=
e
> from the start of the struct to where the CPU entries should begin).
>=20
> The format of read CPU info is unlikely to change in the future,
> so we do not require a separate function to calculate its length.
>=20
> Signed-off-by: Collin Walling <walling@linux.ibm.com>

Acked-by: Janosch Frank <frankja@linux.ibm.com>

> ---
[...]
> +/*
> + * The data length denotes the start of the struct to where the first
> + * CPU entry is to be allocated. This value also denotes the offset_cp=
u
> + * field.
> + */
> +static inline int get_read_scp_info_data_len(void)
> +{
> +    return offsetof(ReadInfo, entries);
> +}
> +
>  /* Provide information about the configuration, CPUs and storage */
>  static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>  {
> @@ -74,17 +112,16 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *=
sccb)
>      int cpu_count;
>      int rnsize, rnmax;
>      IplParameterBlock *ipib =3D s390_ipl_get_iplb();
> +    int data_len =3D get_read_scp_info_data_len();

Does somebody have a better name than data_len at hand?

> =20
> -    if (be16_to_cpu(sccb->h.length) <
> -          (sizeof(ReadInfo) + machine->possible_cpus->len * sizeof(CPU=
Entry))) {
> -        sccb->h.response_code =3D cpu_to_be16(SCLP_RC_INSUFFICIENT_SCC=
B_LENGTH);
> +    if (!sccb_sufficient_len(sccb, machine->possible_cpus->len, data_l=
en)) {
>          return;
>      }
> =20
>      /* CPU information */
>      prepare_cpu_entries(machine, read_info->entries, &cpu_count);
>      read_info->entries_cpu =3D cpu_to_be16(cpu_count);
> -    read_info->offset_cpu =3D cpu_to_be16(offsetof(ReadInfo, entries))=
;
> +    read_info->offset_cpu =3D cpu_to_be16(data_len);
>      read_info->highest_cpu =3D cpu_to_be16(machine->smp.max_cpus - 1);=

> =20
>      read_info->ibc_val =3D cpu_to_be32(s390_get_ibc_val());
> @@ -133,17 +170,16 @@ static void sclp_read_cpu_info(SCLPDevice *sclp, =
SCCB *sccb)
>  {
>      MachineState *machine =3D MACHINE(qdev_get_machine());
>      ReadCpuInfo *cpu_info =3D (ReadCpuInfo *) sccb;
> +    int data_len =3D offsetof(ReadCpuInfo, entries);
>      int cpu_count;
> =20
> -    if (be16_to_cpu(sccb->h.length) <
> -          (sizeof(ReadInfo) + machine->possible_cpus->len * sizeof(CPU=
Entry))) {
> -        sccb->h.response_code =3D cpu_to_be16(SCLP_RC_INSUFFICIENT_SCC=
B_LENGTH);
> +    if (!sccb_sufficient_len(sccb, machine->possible_cpus->len, data_l=
en)) {
>          return;
>      }
> =20
>      prepare_cpu_entries(machine, cpu_info->entries, &cpu_count);
>      cpu_info->nr_configured =3D cpu_to_be16(cpu_count);
> -    cpu_info->offset_configured =3D cpu_to_be16(offsetof(ReadCpuInfo, =
entries));
> +    cpu_info->offset_configured =3D cpu_to_be16(data_len);
>      cpu_info->nr_standby =3D cpu_to_be16(0);
> =20
>      /* The standby offset is 16-byte for each CPU */
> @@ -229,6 +265,10 @@ int sclp_service_call_protected(CPUS390XState *env=
, uint64_t sccb,
>          goto out_write;
>      }
> =20
> +    if (!sccb_has_valid_boundary(sccb, code, &work_sccb.h)) {
> +        goto out_write;
> +    }
> +
>      sclp_c->execute(sclp, &work_sccb, code);
>  out_write:
>      s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
> @@ -274,8 +314,7 @@ int sclp_service_call(CPUS390XState *env, uint64_t =
sccb, uint32_t code)
>          goto out_write;
>      }
> =20
> -    if ((sccb + be16_to_cpu(work_sccb.h.length)) > ((sccb & PAGE_MASK)=
 + PAGE_SIZE)) {
> -        work_sccb.h.response_code =3D cpu_to_be16(SCLP_RC_SCCB_BOUNDAR=
Y_VIOLATION);
> +    if (!sccb_has_valid_boundary(sccb, code, &work_sccb.h)) {
>          goto out_write;
>      }
> =20
>=20



--4ROME1fHcUuXiOuF1ppypvsZRiDHfwJ6M--

--84jQrZI84VYaBTLw7F5rZSEHfFMsCsN0n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl7smGMACgkQ41TmuOI4
ufgo9g/+MH+YdKKXglF99wUB+I0RaR1DeHBB7cK1Tvh8n51NFlfE14yhOtnnr17n
lsoDdCS7a9MnQSkMfgy8qw+q4OVFORKsZO8My9xkFVyCor0k0hDjt0M0zTp97gDY
NEcsfChl2/pcmdHEtneuGIoWJXRw9Cj2k2L0nPyTxZTQ2iIC4DLIoHjvgxK2oABQ
DyCVt8HwUf35kJrYNgVM6SozuioIqT5ldJumKqKvbUUJOox/q6HswdxvjCPB2EWr
Zwa8jErWsz9fx6j5qOUrzUqDYZLIVtMQLv8LKNUgb8DYctMfy5vh7ZlAvVmx6C9K
GEYg89MOvxN2L42OLtB1UybFrMAh0NI8fAVt7qUT6hT2cvrFFDE3RLThwY5Gg25k
l0vYwTi8KFbh1tpK2vuObfGz2rd6a4uYfn8oWeXndXYkc8N8FvJQFBfeRFVwZ2O4
Vtzk9/Dd16NSTOhY6b7WsOXJbjwq5YzWz/Z5mFoRRoLR5uBVFi7Oezo1hT0WcIVM
sYF6IDOJsNuV3mUXM6PW6QVJUAFMYT8x7g58+ZkJYgeS9MsTuh6n4QWSnjmZhM3G
EGruZgdPGvKm5eC4fIBXLVtrfKFZlz/fMngeYnQKe/xMjEu/r7cL2AyuPH3IBSJO
fVEEMupjAbkolapBH5P9tE++zS0Wu43HwPEbCcbjNcg9eRuCufU=
=asTy
-----END PGP SIGNATURE-----

--84jQrZI84VYaBTLw7F5rZSEHfFMsCsN0n--


