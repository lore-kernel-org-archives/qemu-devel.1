Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F30CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:14:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3275220657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3275220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvhEf-0007Hb-GA
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 09:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jvhDs-0006Ym-Pj
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:13:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28384)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1jvhDq-0005o7-LW
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:13:20 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06FCX6UV196599
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 09:13:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 329x5xr8yv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 09:13:16 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06FCXDtc001403
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 09:13:15 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com with ESMTP id 329x5xr8xg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2020 09:13:15 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06FD9dMn027271;
 Wed, 15 Jul 2020 13:13:12 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma02fra.de.ibm.com with ESMTP id 327527vjje-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2020 13:13:12 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 06FDDAuh49938898
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jul 2020 13:13:10 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D79F4203F;
 Wed, 15 Jul 2020 13:13:10 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7C644204D;
 Wed, 15 Jul 2020 13:13:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.18.50])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 15 Jul 2020 13:13:09 +0000 (GMT)
Subject: Re: [PATCH 7/7] pc-bios: s390x: Setup io and ext new psws only once
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
References: <20200715094045.381984-1-frankja@linux.ibm.com>
 <20200715094045.381984-8-frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <33fd76e8-ec0f-4cbe-9e84-6197696f70a3@linux.ibm.com>
Date: Wed, 15 Jul 2020 15:13:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200715094045.381984-8-frankja@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XO60WIqmuOXnK7buSnCwVZvcL2L0LwxtB"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-15_11:2020-07-15,
 2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 suspectscore=1 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150105
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 05:41:23
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: borntraeger@de.ibm.com, thuth@redhat.com, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XO60WIqmuOXnK7buSnCwVZvcL2L0LwxtB
Content-Type: multipart/mixed; boundary="sogjNAUuvu4Cbw6XGmjMflT7DhvHT4aoM"

--sogjNAUuvu4Cbw6XGmjMflT7DhvHT4aoM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/15/20 11:40 AM, Janosch Frank wrote:
> Absolutely no need to set them up every time before we enable our
> interrupt masks.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

So, this one doesn't seem to be a great idea as a kernel loaded to 0x0
will overwrite the ext/io new PSWs and we'll then try to load a zero PSW
when an IRQ hits.

We have two options:
* Add a piece of code that fixes the low core after a kernel has been loa=
ded
* Leave the code as is and add a comment, so other people don't fall
into this trap.

I'd be fine with both and for now I'd settle for the second option.

> ---
>  pc-bios/s390-ccw/start.S | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
>=20
> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
> index 01c4c21b26..0059a15d21 100644
> --- a/pc-bios/s390-ccw/start.S
> +++ b/pc-bios/s390-ccw/start.S
> @@ -34,6 +34,12 @@ loop:
>  remainder:
>  	larl	%r2,memsetxc
>  	ex	%r3,0(%r2)
> +        /* Store io new PSW */
> +        larl	%r1,io_new_psw
> +        mvc	0x1f0(16),0(%r1)
> +	/* Store ext new PSW */
> +        larl	%r1,external_new_psw
> +        mvc	0x1b0(16),0(%r1)
>  done:
>  	j      main		/* And call C */
> =20
> @@ -64,11 +70,6 @@ consume_sclp_int:
>          stctg   %c0,%c0,0(%r15)
>          oi      6(%r15),0x2
>          lctlg   %c0,%c0,0(%r15)
> -        /* prepare external call handler */
> -        larl %r1, external_new_code
> -        stg %r1, 0x1b8
> -        larl %r1, external_new_mask
> -        mvc 0x1b0(8),0(%r1)
>          /* load enabled wait PSW */
>          larl %r1, enabled_wait_psw
>          lpswe 0(%r1)
> @@ -81,14 +82,9 @@ consume_sclp_int:
>          .globl consume_io_int
>  consume_io_int:
>          /* enable I/O interrupts in cr6 */
> -        stctg %c6,%c6,0(%r15)
> -        oi    4(%r15), 0xff
> -        lctlg %c6,%c6,0(%r15)
> -        /* prepare i/o call handler */
> -        larl  %r1, io_new_code
> -        stg   %r1, 0x1f8
> -        larl  %r1, io_new_mask
> -        mvc   0x1f0(8),0(%r1)
> +        stctg	%c6, %c6, 0(%r15)
> +        oi	4(%r15), 0xff
> +        lctlg	%c6, %c6, 0(%r15)
>          /* load enabled wait PSW */
>          larl  %r1, enabled_wait_psw
>          lpswe 0(%r1)
> @@ -112,7 +108,7 @@ disabled_wait_psw:
>          .quad   PSW_MASK_DWAIT, 0x0000000000000000
>  enabled_wait_psw:
>          .quad   PSW_MASK_EWAIT, 0x0000000000000000
> -external_new_mask:
> -        .quad   PSW_MASK_64
> -io_new_mask:
> -        .quad   PSW_MASK_64
> +external_new_psw:
> +        .quad   PSW_MASK_64, external_new_code
> +io_new_psw:
> +        .quad   PSW_MASK_64, io_new_code
>=20



--sogjNAUuvu4Cbw6XGmjMflT7DhvHT4aoM--

--XO60WIqmuOXnK7buSnCwVZvcL2L0LwxtB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl8PAOUACgkQ41TmuOI4
ufgGCRAAvCcGqshX0Uhhu1ooQ9HbkSqyLcQ/qdTRo1VjPyJojUgrkSTUeGgPUP47
tSKbzO6H91ShjboTrfpfsPUV0Sqt5ubvcTOwhOuVsKIE6mgALnlYbC51OzvwAMbW
WCv5/VdVmQZ5xj8CJaKT35BF1e0/i9CsYkRst/AJoeg8KnO6i4uwb40rQYqlDvsH
VpXQJQ9830cksX0VbRwyhlLpSk1CBHPPpSM5duTDhzVu/GVlfnhs0bMR9CNLD3pa
O6IyMsVxSib6c+70Zl6wbXM98fgvpcTaUo8BEr5Jz9hYxVOCWGQEnE+V2UfHEonG
AxabAmn8q/YmgGO+wMGuRWJWAkH+oGEH5RZUd4qK6/TqSkgcPNPKqhSTm8VvPKhH
LN2GYTBDi3jl9Rls7SfRYvG+N95XOfLwf/UoWVXygAXcXeQUUnHRvLYwGXUT0GdG
+gikYjDduQZ3Vec8IjeKqKsernsnFdF/cNNhnnLdFbqh7mB6YsDFnyU+8GAfyA8F
vI9WLSyAv4q++lhCXKdx2K554vhWZZC+FWa84eXwejPkHh0XWHo6EbSnQdY+lae0
Bw7blamkkdXfPfyblvCpgL+t9M3QOVeCQF2SI8m1ZG9Q5sT4K1faa7hCa/C2xf6d
lLFjVZ1jrAEEvHhNa6odN36M2H55MvxCevs2kAD9cLjAOCUKZCA=
=8DIm
-----END PGP SIGNATURE-----

--XO60WIqmuOXnK7buSnCwVZvcL2L0LwxtB--


