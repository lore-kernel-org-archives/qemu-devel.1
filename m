Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2A6C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F7A2465D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F7A2465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4jg5-0000Fx-Eu
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 06:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j4jfV-0008IN-IG
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:06:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j4jfU-0004nr-9x
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:06:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1136)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j4jfT-0004mo-Qn
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:06:56 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01KB0Ix7136333
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 06:06:53 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubg4ndd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 06:06:52 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 20 Feb 2020 11:06:50 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 20 Feb 2020 11:06:48 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 01KB6lY830998932
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Feb 2020 11:06:47 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3880DA405F;
 Thu, 20 Feb 2020 11:06:47 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7C1CA4054;
 Thu, 20 Feb 2020 11:06:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.185.143])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 20 Feb 2020 11:06:46 +0000 (GMT)
Subject: Re: [PATCH v3 04/17] s390x: protvirt: Add diag308 subcodes 8 - 10
To: Cornelia Huck <cohuck@redhat.com>
References: <20200214151636.8764-1-frankja@linux.ibm.com>
 <20200214151636.8764-5-frankja@linux.ibm.com>
 <20200220110720.6142d055.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Thu, 20 Feb 2020 12:06:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200220110720.6142d055.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GrxYRzehIxpRiauutT8ih17h8KFJbgWUq"
X-TM-AS-GCONF: 00
x-cbid: 20022011-0016-0000-0000-000002E88FCD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022011-0017-0000-0000-0000334BABC5
Message-Id: <b4daeb33-089b-ce55-4f91-78a770ac5352@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-20_03:2020-02-19,
 2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 suspectscore=2 mlxscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200082
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: qemu-s390x@nongnu.org, mihajlov@linux.ibm.com, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GrxYRzehIxpRiauutT8ih17h8KFJbgWUq
Content-Type: multipart/mixed; boundary="V5mxSoLC5e7UwJzJpzhp5yvTrySUxcONO"

--V5mxSoLC5e7UwJzJpzhp5yvTrySUxcONO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/20/20 11:07 AM, Cornelia Huck wrote:
> On Fri, 14 Feb 2020 10:16:23 -0500
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> For diag308 subcodes 8 - 10 we have a new ipib of type 5. The ipib
>> holds the address and length of the secure execution header, as well
>> as a list of guest components.
>>
>> Each component is a block of memory, for example kernel or initrd,
>> which needs to be decrypted by the Ultravisor in order to run a
>> protected VM. The secure execution header instructs the Ultravisor on
>> how to handle the protected VM and its components.
>>
>> Subcodes 8 and 9 are similiar to 5 and 6 and subcode 10 will finally
>> start the protected guest.
>>
>> Subcodes 8-10 are not valid in protected mode, we have to do a subcode=

>> 3 and then the 8 and 10 combination for a protected reboot.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  hw/s390x/ipl.c      | 48 ++++++++++++++++++++++++++++++++++++++++++--=
-
>>  hw/s390x/ipl.h      | 31 +++++++++++++++++++++++++++++
>>  target/s390x/diag.c | 27 ++++++++++++++++++++++---
>>  3 files changed, 100 insertions(+), 6 deletions(-)
>=20
> (...)
>=20
>>  void s390_ipl_update_diag308(IplParameterBlock *iplb)
>>  {
>>      S390IPLState *ipl =3D get_ipl_device();
>> =20
>> -    ipl->iplb =3D *iplb;
>> -    ipl->iplb_valid =3D true;
>> +    if (iplb->pbt =3D=3D 5) {
>=20
> Magic value; maybe introduce a #define or at least a comment?

Well, there is already one defined, but it seems I never came around to
use it -_-

>=20
>> +        ipl->iplb_pbt5 =3D *iplb;
>> +        ipl->iplb_valid_pbt5 =3D true;
>> +    } else {
>> +        ipl->iplb =3D *iplb;
>> +        ipl->iplb_valid =3D true;
>> +    }
>>      ipl->netboot =3D is_virtio_net_device(iplb);
>>  }
>=20
>> @@ -133,6 +154,7 @@ struct S390IPLState {
>>      /*< private >*/
>>      DeviceState parent_obj;
>>      IplParameterBlock iplb;
>> +    IplParameterBlock iplb_pbt5;
>=20
> Add /* for protected virtualization */ ?
>=20
> Or, if this is not used for anything else, call it iplb_pv?

ack.

>=20
>>      QemuIplParameters qipl;
>>      uint64_t start_addr;
>>      uint64_t compat_start_addr;
>=20
> (...)
>=20
>> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
>> index b5aec06d6b..4ba6033609 100644
>> --- a/target/s390x/diag.c
>> +++ b/target/s390x/diag.c
>> @@ -52,6 +52,8 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1,=
 uint64_t r3)
>>  #define DIAG_308_RC_OK              0x0001
>>  #define DIAG_308_RC_NO_CONF         0x0102
>>  #define DIAG_308_RC_INVALID         0x0402
>> +#define DIAG_308_RC_NO_PV_CONF      0x0a02
>> +#define DIAG_308_RC_INV_FOR_PV      0x0b02
>=20
> DIAG_308_RC_INVAL_FOR_PV ?

ack

>=20
>> =20
>>  #define DIAG308_RESET_MOD_CLR       0
>>  #define DIAG308_RESET_LOAD_NORM     1
>=20
> (...)
>=20
>> @@ -128,17 +135,31 @@ out:
>>          g_free(iplb);
>>          return;
>>      case DIAG308_STORE:
>> +    case DIAG308_PV_STORE:
>>          if (diag308_parm_check(env, r1, addr, ra, true)) {
>>              return;
>>          }
>> -        iplb =3D s390_ipl_get_iplb();
>> +        if (subcode =3D=3D DIAG308_PV_STORE) {
>> +            iplb =3D s390_ipl_get_iplb_secure();
>> +        } else {
>> +            iplb =3D s390_ipl_get_iplb();
>> +        }
>=20
> iplb =3D (subcode =3D=3D DIAG308_PV_STORE) ?
>        s390_ipl_get_iplb_secure() : s390_ipl_get_iplb();
>=20
> Matter of taste, I guess.

I'll have a look what I find nicer to read

>=20
>>          if (iplb) {
>>              cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->l=
en));
>>              env->regs[r1 + 1] =3D DIAG_308_RC_OK;
>>          } else {
>>              env->regs[r1 + 1] =3D DIAG_308_RC_NO_CONF;
>>          }
>> -        return;
>> +        break;
>> +    case DIAG308_PV_START:
>> +        iplb =3D s390_ipl_get_iplb_secure();
>> +        if (!iplb || !iplb_valid_pv(iplb)) {
>> +            env->regs[r1 + 1] =3D DIAG_308_RC_NO_PV_CONF;
>> +            return;
>> +        }
>> +
>> +        s390_ipl_reset_request(cs, S390_RESET_PV);
>> +        break;
>>      default:
>>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>>          break;
>=20



--V5mxSoLC5e7UwJzJpzhp5yvTrySUxcONO--

--GrxYRzehIxpRiauutT8ih17h8KFJbgWUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5OaEYACgkQ41TmuOI4
ufg+LA//ZeDBowu5WaH9Cn6h9fuKeSwYVX6uEvHdNFs2YlkFd0g5GL5n/BOf5YJF
0gq6/bDknnGxoUVJSLDaU2R70WSh1T8I6n6TolKX7oGJLP3WpLrgiUQNKMrQvvzI
nnb47k2Y9OJa1qPUPadH+SLgoOYauGAxYokEJd5dwc3Bg95RIrnEF+7TD9oApYFH
UqMsB7nmexWTsIjLyqQKXZcSu1lI8CUQJdM71Ws6OiBzfgPt7mO9k/z7+yiXys9S
ynIKpMnM3OMSIssf1w8nfYDPCIdEYXCqHQ4O5NIn1LDeSPDGC5ibkN9ANMgiAVQm
AkOzzG8YY0toZH277SaUo6H3ffgUmWcftYezX3Y7yo9inGs7viptjgpzPQyToSaS
6Z/++BxeY+qABu+tPDBF9xxocTd8AsNtIycNs5ZbkbZpTuovcbgbAD8UM5jebmuK
TWEVIXqPmmJXhyw8dj06Ykl55jj9yR9+jFWNz7cl067drPO5ABz7NXggDWcbTnfe
8mvQDXcIoZiyoQ2PCfXiiOJS1iGSfE6aKkRXKysu5rqDykyKPKZZVlF6mPgMgiri
6DUBqPKjhw/JzruwKKO88kXCYUhqjAaBxp/oxLY/7jU5EeB22PNmMcIFJXMooxk5
eGjMtnfq70SG57jVW0f8mACD4tQ6mnlsh2E5n6syQ42Z7DU8D8o=
=aqCV
-----END PGP SIGNATURE-----

--GrxYRzehIxpRiauutT8ih17h8KFJbgWUq--


