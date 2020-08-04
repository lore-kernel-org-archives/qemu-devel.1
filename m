Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B451C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 13:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 364D32067D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 13:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364D32067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2wys-0006uT-EN
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 09:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1k2wyH-0006R0-Jw; Tue, 04 Aug 2020 09:27:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1k2wxz-0007TG-LB; Tue, 04 Aug 2020 09:27:13 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 074DLk4e073609; Tue, 4 Aug 2020 09:26:52 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32q86qrscs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2020 09:26:51 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 074DLssT075537;
 Tue, 4 Aug 2020 09:26:42 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32q86qrsar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2020 09:26:42 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 074DJml9017394;
 Tue, 4 Aug 2020 13:26:38 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma04ams.nl.ibm.com with ESMTP id 32n0183bv4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2020 13:26:38 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 074DQZEw27591114
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Aug 2020 13:26:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76CD3A4055;
 Tue,  4 Aug 2020 13:26:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0371EA404D;
 Tue,  4 Aug 2020 13:26:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.95.69])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  4 Aug 2020 13:26:34 +0000 (GMT)
Subject: Re: [PATCH for-5.2 3/6] pc-bios/s390-ccw: Move the inner logic of
 find_subch() to a separate function
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20200728183734.7838-1-thuth@redhat.com>
 <20200728183734.7838-4-thuth@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <88dfc306-ac09-c370-73d6-dc9a2e159431@linux.ibm.com>
Date: Tue, 4 Aug 2020 15:26:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200728183734.7838-4-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FrNFRkVyLBOrV8KCy1B4G4leIw75WWU3E"
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-04_04:2020-08-03,
 2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040097
Received-SPF: pass client-ip=148.163.156.1; envelope-from=frankja@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 09:26:52
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FrNFRkVyLBOrV8KCy1B4G4leIw75WWU3E
Content-Type: multipart/mixed; boundary="guKWbYt6PMB54910OrPml7EXE8I3s2QM6"

--guKWbYt6PMB54910OrPml7EXE8I3s2QM6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/28/20 8:37 PM, Thomas Huth wrote:
> Move the code to a separate function to be able to re-use it from a
> different spot later.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/main.c | 99 ++++++++++++++++++++++++-----------------=

>  1 file changed, 57 insertions(+), 42 deletions(-)
>=20
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 9b64eb0c24..9477313188 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -51,6 +51,60 @@ unsigned int get_loadparm_index(void)
>      return atoui(loadparm_str);
>  }
> =20
> +static int check_sch_no(int dev_no, int sch_no)

How about something like is_sch_no_bootable() or check_sch_no_bootable()?=


check_sch_no doesn't tell me what you actually check for.

Otherwise LGTM

> +{
> +    bool is_virtio;
> +    Schib schib;
> +    int r;
> +
> +    blk_schid.sch_no =3D sch_no;
> +    r =3D stsch_err(blk_schid, &schib);
> +    if (r =3D=3D 3 || r =3D=3D -EIO) {
> +        return -EIO;
> +    }
> +    if (!schib.pmcw.dnv) {
> +        return false;
> +    }
> +
> +    enable_subchannel(blk_schid);
> +    cutype =3D cu_type(blk_schid);
> +
> +    /*
> +     * Note: we always have to run virtio_is_supported() here to make
> +     * sure that the vdev.senseid data gets pre-initialized correctly
> +     */
> +    is_virtio =3D virtio_is_supported(blk_schid);
> +
> +    /* No specific devno given, just return 1st possibly bootable devi=
ce */
> +    if (dev_no < 0) {
> +        switch (cutype) {
> +        case CU_TYPE_VIRTIO:
> +            if (is_virtio) {
> +                /*
> +                 * Skip net devices since no IPLB is created and there=
fore
> +                 * no network bootloader has been loaded
> +                 */
> +                if (virtio_get_device_type() !=3D VIRTIO_ID_NET) {
> +                    return true;
> +                }
> +            }
> +            return false;
> +        case CU_TYPE_DASD_3990:
> +        case CU_TYPE_DASD_2107:
> +            return true;
> +        default:
> +            return false;
> +        }
> +    }
> +
> +    /* Caller asked for a specific devno */
> +    if (schib.pmcw.dev =3D=3D dev_no) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
>  /*
>   * Find the subchannel connected to the given device (dev_no) and fill=
 in the
>   * subchannel information block (schib) with the connected subchannel'=
s info.
> @@ -62,53 +116,14 @@ unsigned int get_loadparm_index(void)
>   */
>  static bool find_subch(int dev_no)
>  {
> -    Schib schib;
>      int i, r;
> -    bool is_virtio;
> =20
>      for (i =3D 0; i < 0x10000; i++) {
> -        blk_schid.sch_no =3D i;
> -        r =3D stsch_err(blk_schid, &schib);
> -        if ((r =3D=3D 3) || (r =3D=3D -EIO)) {
> +        r =3D check_sch_no(dev_no, i);
> +        if (r < 0) {
>              break;
>          }
> -        if (!schib.pmcw.dnv) {
> -            continue;
> -        }
> -
> -        enable_subchannel(blk_schid);
> -        cutype =3D cu_type(blk_schid);
> -
> -        /*
> -         * Note: we always have to run virtio_is_supported() here to m=
ake
> -         * sure that the vdev.senseid data gets pre-initialized correc=
tly
> -         */
> -        is_virtio =3D virtio_is_supported(blk_schid);
> -
> -        /* No specific devno given, just return 1st possibly bootable =
device */
> -        if (dev_no < 0) {
> -            switch (cutype) {
> -            case CU_TYPE_VIRTIO:
> -                if (is_virtio) {
> -                    /*
> -                     * Skip net devices since no IPLB is created and t=
herefore
> -                     * no network bootloader has been loaded
> -                     */
> -                    if (virtio_get_device_type() !=3D VIRTIO_ID_NET) {=

> -                        return true;
> -                    }
> -                }
> -                continue;
> -            case CU_TYPE_DASD_3990:
> -            case CU_TYPE_DASD_2107:
> -                return true;
> -            default:
> -                continue;
> -            }
> -        }
> -
> -        /* Caller asked for a specific devno */
> -        if (schib.pmcw.dev =3D=3D dev_no) {
> +        if (r =3D=3D true) {
>              return true;
>          }
>      }
>=20



--guKWbYt6PMB54910OrPml7EXE8I3s2QM6--

--FrNFRkVyLBOrV8KCy1B4G4leIw75WWU3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl8pYgoACgkQ41TmuOI4
ufi/FBAAh9IKniKYBPXuzkByrmPIOuJ9mwrPQpuV2U+vEelq1CHxDdcVWhvzGS7b
0R35m8si75zRpBRpALE9Vk8MnGWD/AB863JRJc4LE7sCMKSYuIooz+vRjIPI68uL
dwrXQie0Q4C7sbsEpyK4MUXRpEAXiuB25it0V14NAhh/cae1EZoJG+Q28bcy62I+
T9cJtzSxjX2gFRb+AwgmOABz6nrUh7ta7tw/wLklJHmV4xJuCMvUwDWQL73UOO/+
Z9ilmV724ZT2mrsAXD5WZi/CEjxSSLeMvwdD2Tbtna/kuAy7ICu3bJ7QETELk9Sz
Ok3H1YqgV7rSNvf6B5jLyitQUaU9s3tCJxTZFiKFifOy3VluGjvQ5PrVQXWM6ug5
fZwZNxC0LdHTs+4JqfRkxsmTjK9acxV9CNzt2lQYpGUlqBMPUZ1Lq9ILIYalN1dC
gBPa5W0/XYyJBqOL2M7HAZcUkUEv/beFspqVrPiOxZskvDo2Ij7wegUVGo9uf0vZ
wa894w1y8H+ZzP+/Tmk2kE35x4783i44WBISjiGYh/MybJ5dT86EUDKvgBHnu+rk
keWBVreVccNJWYmCwIk9wShD3AFuor/65wd9Za/Q9v4yTKWNVFI9vm/VZI54LRGj
NVom435wuyJMgPRtjl7Ys0mmU3j5iaywaJOU+R9yHPZbuG7f+Co=
=J6P3
-----END PGP SIGNATURE-----

--FrNFRkVyLBOrV8KCy1B4G4leIw75WWU3E--


