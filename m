Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C436C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 08:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02003207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 08:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02003207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmCFP-0003xR-BS
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 04:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jmCEe-0003VQ-2D; Fri, 19 Jun 2020 04:18:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4216)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jmCEb-0001v7-P7; Fri, 19 Jun 2020 04:18:51 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05J7Y4Al193268; Fri, 19 Jun 2020 04:18:48 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31rekdgrnc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 04:18:47 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05J82ip7138018;
 Fri, 19 Jun 2020 04:18:47 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31rekdgrmb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 04:18:47 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05J89xWR016082;
 Fri, 19 Jun 2020 08:18:44 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma03ams.nl.ibm.com with ESMTP id 31quaxaf9u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 08:18:44 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 05J8Ifb364291310
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jun 2020 08:18:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B17C9A405F;
 Fri, 19 Jun 2020 08:18:41 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17873A4064;
 Fri, 19 Jun 2020 08:18:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.7.233])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 19 Jun 2020 08:18:41 +0000 (GMT)
Subject: Re: [PATCH v3 4/8] s390/sclp: read sccb from mem based on sccb length
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200618222258.23287-1-walling@linux.ibm.com>
 <20200618222258.23287-5-walling@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f233c178-dfab-5ab5-324c-2f3bd15737f6@linux.ibm.com>
Date: Fri, 19 Jun 2020 10:18:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200618222258.23287-5-walling@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JD0UKqzqtVXutFPExxiCKQjA8vQOkG1lP"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-19_04:2020-06-18,
 2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 cotscore=-2147483648 mlxlogscore=999 impostorscore=0 bulkscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190054
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 04:18:48
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
--JD0UKqzqtVXutFPExxiCKQjA8vQOkG1lP
Content-Type: multipart/mixed; boundary="cZfuE8THn0LqWxjgdp22ls013BzVctpjQ"

--cZfuE8THn0LqWxjgdp22ls013BzVctpjQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/19/20 12:22 AM, Collin Walling wrote:
> The header of the SCCB contains the actual length of the SCCB. Instead
> of using a static 4K size, let's allow for a variable size determined
> by the value set in the header. The proper checks are already in place
> to ensure the SCCB length is sufficent to store a full response, and
> that the length does not cross any explicitly-set boundaries.
>=20
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

I wonder if this brings a measureable performance penalty with it for
protected guests. It's another ioctl to move the remaining bytes from
KVM to QEMU. On the other hand it's only sclp...

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>  hw/s390x/sclp.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 0710138f91..772b7b3b01 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -256,9 +256,8 @@ int sclp_service_call_protected(CPUS390XState *env,=
 uint64_t sccb,
>      SCLPDevice *sclp =3D get_sclp_device();
>      SCLPDeviceClass *sclp_c =3D SCLP_GET_CLASS(sclp);
>      SCCB work_sccb;
> -    hwaddr sccb_len =3D sizeof(SCCB);
> =20
> -    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sccb_len);
> +    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sizeof(SCCBH=
eader));
> =20
>      if (!sclp_command_code_valid(code)) {
>          work_sccb.h.response_code =3D cpu_to_be16(SCLP_RC_INVALID_SCLP=
_COMMAND);
> @@ -269,6 +268,9 @@ int sclp_service_call_protected(CPUS390XState *env,=
 uint64_t sccb,
>          goto out_write;
>      }
> =20
> +    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb,
> +                         be16_to_cpu(work_sccb.h.length));
> +
>      sclp_c->execute(sclp, &work_sccb, code);
>  out_write:
>      s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
> @@ -283,8 +285,6 @@ int sclp_service_call(CPUS390XState *env, uint64_t =
sccb, uint32_t code)
>      SCLPDeviceClass *sclp_c =3D SCLP_GET_CLASS(sclp);
>      SCCB work_sccb;
> =20
> -    hwaddr sccb_len =3D sizeof(SCCB);
> -
>      /* first some basic checks on program checks */
>      if (env->psw.mask & PSW_MASK_PSTATE) {
>          return -PGM_PRIVILEGED;
> @@ -302,7 +302,7 @@ int sclp_service_call(CPUS390XState *env, uint64_t =
sccb, uint32_t code)
>       * from playing dirty tricks by modifying the memory content after=

>       * the host has checked the values
>       */
> -    cpu_physical_memory_read(sccb, &work_sccb, sccb_len);
> +    cpu_physical_memory_read(sccb, &work_sccb, sizeof(SCCBHeader));
> =20
>      /* Valid sccb sizes */
>      if (be16_to_cpu(work_sccb.h.length) < sizeof(SCCBHeader)) {
> @@ -318,6 +318,9 @@ int sclp_service_call(CPUS390XState *env, uint64_t =
sccb, uint32_t code)
>          goto out_write;
>      }
> =20
> +    /* the header contains the actual length of the sccb */
> +    cpu_physical_memory_read(sccb, &work_sccb, be16_to_cpu(work_sccb.h=
=2Elength));
> +
>      sclp_c->execute(sclp, &work_sccb, code);
>  out_write:
>      cpu_physical_memory_write(sccb, &work_sccb,
>=20



--cZfuE8THn0LqWxjgdp22ls013BzVctpjQ--

--JD0UKqzqtVXutFPExxiCKQjA8vQOkG1lP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl7sdOAACgkQ41TmuOI4
ufhfqQ//Y27TKi5JdZZjN31OlXWcPdSafIcf9oAZE7COuDQ2bzWmyt9AINH9/orW
I2G20LVS4wFDzfOVPCZ3e0IqyES4guATXIWegsTuZGGQZM7qtgF3DcJ/F/erX7va
IfabH/6Qh3pu61p+X8j+/y/w8sr+qcYx23ea05blqp3VTiQVk6ctVoj9yyP42qnR
OqdNBlHOvGHQxVBtVRC1rHywjuWENIF9l+Dr5FrCFt6la2Q0MIEwYlyuMlpejlZm
c7EyKSb0yZ0f1XCmESZBXgwk1ipKAj5VC2su+F5g9VaLb7NiuG4ojjvjpJ7r+G2G
hfQvd6vLdk+NU5hz18SxuR6AA9fD/oHqYkk9nTU1dUn1Dw6jTpabwwi7JfttVuu/
VVjT+TDPrqjl9K2X2gQDkZgr/HYYEVvrjMQND+DCiqEZaiWXeAleLdjadAkd6j0N
B/pn7nleqfkVSgKWSkO+GjW4SY18ROHB6CJfEqVX2juWUmGJayMm6wOi+6X6W7h9
QxaeEMRojZCNks7342zrEdwnxE4oLsTcueEP/oY59LH35tHXP/QlGJ3uVo03ecz2
lU8ZydcN75WNv2LJOZqPM/mmkRoNI0mrc/wv0nBYtgyuaTtUj4guD0ruS5hBlmIC
Zw23LqGEYpg5URBVYgTDc5YFpm6Dk6Gw57kPXbSqn5tiF3DOVLM=
=RNxL
-----END PGP SIGNATURE-----

--JD0UKqzqtVXutFPExxiCKQjA8vQOkG1lP--


