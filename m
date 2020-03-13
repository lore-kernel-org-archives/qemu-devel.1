Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EDEC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:17:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FC96206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC96206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCkBe-0003Id-EH
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 09:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jCkAW-0001rZ-1G
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jCkAT-0006aU-Vx
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:16:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39286)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jCkAT-0006Xz-ML
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:16:01 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02DD518K049878
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:16:00 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yr0ch71fk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:16:00 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 13 Mar 2020 13:15:57 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Mar 2020 13:15:55 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 02DDEr1v44499220
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 13:14:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9B2642041;
 Fri, 13 Mar 2020 13:15:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F14142042;
 Fri, 13 Mar 2020 13:15:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.48.117])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Mar 2020 13:15:53 +0000 (GMT)
Subject: Re: [PATCH v9 12/15] s390x: protvirt: Move IO control structures over
 SIDA
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
 <20200311132151.172389-13-frankja@linux.ibm.com>
 <20200313135742.37a78d26@p-imbrenda>
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
Date: Fri, 13 Mar 2020 14:15:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200313135742.37a78d26@p-imbrenda>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aED9GAgzptD7p6pQZSzqLWqMF9p0keLY4"
X-TM-AS-GCONF: 00
x-cbid: 20031313-0028-0000-0000-000003E42F1D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031313-0029-0000-0000-000024A97A6B
Message-Id: <5e7b08eb-0540-106a-a635-eaca5de595a0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-13_04:2020-03-12,
 2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003130067
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aED9GAgzptD7p6pQZSzqLWqMF9p0keLY4
Content-Type: multipart/mixed; boundary="RrQeJadYLNqaxijT9hKc2TikXkTCRRCrV"

--RrQeJadYLNqaxijT9hKc2TikXkTCRRCrV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/13/20 1:57 PM, Claudio Imbrenda wrote:
> On Wed, 11 Mar 2020 09:21:48 -0400
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> For protected guests, we need to put the IO emulation results into the=

>> SIDA, so SIE will write them into the guest at the next entry.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  target/s390x/ioinst.c | 87
>> ++++++++++++++++++++++++++++++------------- 1 file changed, 61
>> insertions(+), 26 deletions(-)
>>
>> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
>> index 481d789de9e09a04..61095bdc9ffef436 100644
>> --- a/target/s390x/ioinst.c
>> +++ b/target/s390x/ioinst.c
>> @@ -136,9 +136,13 @@ void ioinst_handle_msch(S390CPU *cpu, uint64_t
>> reg1, uint32_t ipb, uintptr_t ra) s390_program_interrupt(env,
>> PGM_SPECIFICATION, ra); return;
>>      }
>> -    if (s390_cpu_virt_mem_read(cpu, addr, ar, &schib,
>> sizeof(schib))) {
>> -        s390_cpu_virt_mem_handle_exc(cpu, ra);
>> -        return;
>> +    if (s390_is_pv()) {
>> +        s390_cpu_pv_mem_read(cpu, addr, &schib, sizeof(schib));
>> +    } else {
>> +        if (s390_cpu_virt_mem_read(cpu, addr, ar, &schib,
>> sizeof(schib))) {
>> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
>> +            return;
>> +        }
>>      }
>>      if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid,
>> &schid) || !ioinst_schib_valid(&schib)) {
>> @@ -193,9 +197,13 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t
>> reg1, uint32_t ipb, uintptr_t ra) s390_program_interrupt(env,
>> PGM_SPECIFICATION, ra); return;
>>      }
>> -    if (s390_cpu_virt_mem_read(cpu, addr, ar, &orig_orb,
>> sizeof(orb))) {
>> -        s390_cpu_virt_mem_handle_exc(cpu, ra);
>> -        return;
>> +    if (s390_is_pv()) {
>> +        s390_cpu_pv_mem_read(cpu, addr, &orig_orb, sizeof(orb));
>> +    } else {
>> +        if (s390_cpu_virt_mem_read(cpu, addr, ar, &orig_orb,
>> sizeof(orb))) {
>> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
>> +            return;
>> +        }
>>      }
>>      copy_orb_from_guest(&orb, &orig_orb);
>>      if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid,
>> &schid) || @@ -229,14 +237,19 @@ void ioinst_handle_stcrw(S390CPU
>> *cpu, uint32_t ipb, uintptr_t ra) cc =3D css_do_stcrw(&crw);
>>      /* 0 - crw stored, 1 - zeroes stored */
>> =20
>> -    if (s390_cpu_virt_mem_write(cpu, addr, ar, &crw, sizeof(crw)) =3D=
=3D
>> 0) {
>> +    if (s390_is_pv()) {
>> +        s390_cpu_pv_mem_write(cpu, addr, &crw, sizeof(crw));
>>          setcc(cpu, cc);
>>      } else {
>> -        if (cc =3D=3D 0) {
>> -            /* Write failed: requeue CRW since STCRW is suppressing
>> */
>> -            css_undo_stcrw(&crw);
>> +        if (s390_cpu_virt_mem_write(cpu, addr, ar, &crw,
>> sizeof(crw)) =3D=3D 0) {
>> +            setcc(cpu, cc);
>> +        } else {
>> +            if (cc =3D=3D 0) {
>> +                /* Write failed: requeue CRW since STCRW is
>> suppressing */
>> +                css_undo_stcrw(&crw);
>> +            }
>> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
>>          }
>> -        s390_cpu_virt_mem_handle_exc(cpu, ra);
>>      }
>>  }
>> =20
>> @@ -258,6 +271,9 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t
>> reg1, uint32_t ipb, }
>> =20
>>      if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid,
>> &schid)) {
>> +        if (s390_is_pv()) {
>> +            return;
>> +        }
>=20
> If the operand is invalid, should we not inject an operand exception?
>=20
> If instead the Ultravisor or KVM make sure that we don't end up here,
> then, why handle this at all?

Currently the specs specify that we may inject an operand exception but
I'm not able to find any exception that would still apply after all of
the ones that SIE already handles.

I've already asked for clarification and I'm considering to make this a
g_assert(!s390_is_pv())

So I hope we can clear this up in the next architecture call.

>=20
>>          /*
>>           * As operand exceptions have a lower priority than access
>> exceptions,
>>           * we check whether the memory area is writeable (injecting
>> the @@ -290,14 +306,19 @@ void ioinst_handle_stsch(S390CPU *cpu,
>> uint64_t reg1, uint32_t ipb, }
>>      }
>>      if (cc !=3D 3) {
>> -        if (s390_cpu_virt_mem_write(cpu, addr, ar, &schib,
>> -                                    sizeof(schib)) !=3D 0) {
>> -            s390_cpu_virt_mem_handle_exc(cpu, ra);
>> -            return;
>> +        if (s390_is_pv()) {
>> +            s390_cpu_pv_mem_write(cpu, addr, &schib, sizeof(schib));
>> +        } else {
>> +            if (s390_cpu_virt_mem_write(cpu, addr, ar, &schib,
>> +                                        sizeof(schib)) !=3D 0) {
>> +                s390_cpu_virt_mem_handle_exc(cpu, ra);
>> +                return;
>> +            }
>>          }
>>      } else {
>>          /* Access exceptions have a higher priority than cc3 */
>> -        if (s390_cpu_virt_mem_check_write(cpu, addr, ar,
>> sizeof(schib)) !=3D 0) {
>> +        if (!s390_is_pv() &&
>> +            s390_cpu_virt_mem_check_write(cpu, addr, ar,
>> sizeof(schib)) !=3D 0) { s390_cpu_virt_mem_handle_exc(cpu, ra);
>>              return;
>>          }
>> @@ -334,15 +355,20 @@ int ioinst_handle_tsch(S390CPU *cpu, uint64_t
>> reg1, uint32_t ipb, uintptr_t ra) }
>>      /* 0 - status pending, 1 - not status pending, 3 - not
>> operational */ if (cc !=3D 3) {
>> -        if (s390_cpu_virt_mem_write(cpu, addr, ar, &irb, irb_len) !=3D=

>> 0) {
>> -            s390_cpu_virt_mem_handle_exc(cpu, ra);
>> -            return -EFAULT;
>> +        if (s390_is_pv()) {
>> +            s390_cpu_pv_mem_write(cpu, addr, &irb, irb_len);
>> +        } else {
>> +            if (s390_cpu_virt_mem_write(cpu, addr, ar, &irb,
>> irb_len) !=3D 0) {
>> +                s390_cpu_virt_mem_handle_exc(cpu, ra);
>> +                return -EFAULT;
>> +            }
>>          }
>>          css_do_tsch_update_subch(sch);
>>      } else {
>>          irb_len =3D sizeof(irb) - sizeof(irb.emw);
>>          /* Access exceptions have a higher priority than cc3 */
>> -        if (s390_cpu_virt_mem_check_write(cpu, addr, ar, irb_len) !=3D=

>> 0) {
>> +        if (!s390_is_pv() &&
>> +            s390_cpu_virt_mem_check_write(cpu, addr, ar, irb_len) !=3D=

>> 0) { s390_cpu_virt_mem_handle_exc(cpu, ra);
>>              return -EFAULT;
>>          }
>> @@ -640,9 +666,13 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t
>> ipb, uintptr_t ra)
>>       * present CHSC sub-handlers ... if we ever need more, we should
>> take
>>       * care of req->len here first.
>>       */
>> -    if (s390_cpu_virt_mem_read(cpu, addr, reg, buf,
>> sizeof(ChscReq))) {
>> -        s390_cpu_virt_mem_handle_exc(cpu, ra);
>> -        return;
>> +    if (s390_is_pv()) {
>> +        s390_cpu_pv_mem_read(cpu, addr, buf, sizeof(ChscReq));
>> +    } else {
>> +        if (s390_cpu_virt_mem_read(cpu, addr, reg, buf,
>> sizeof(ChscReq))) {
>> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
>> +            return;
>> +        }
>>      }
>>      req =3D (ChscReq *)buf;
>>      len =3D be16_to_cpu(req->len);
>> @@ -673,11 +703,16 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t
>> ipb, uintptr_t ra) break;
>>      }
>> =20
>> -    if (!s390_cpu_virt_mem_write(cpu, addr + len, reg, res,
>> -                                 be16_to_cpu(res->len))) {
>> +    if (s390_is_pv()) {
>> +        s390_cpu_pv_mem_write(cpu, addr + len, res,
>> be16_to_cpu(res->len)); setcc(cpu, 0);    /* Command execution
>> complete */ } else {
>> -        s390_cpu_virt_mem_handle_exc(cpu, ra);
>> +        if (!s390_cpu_virt_mem_write(cpu, addr + len, reg, res,
>> +                                     be16_to_cpu(res->len))) {
>> +            setcc(cpu, 0);    /* Command execution complete */
>> +        } else {
>> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
>> +        }
>>      }
>>  }
>> =20
>=20
>=20



--RrQeJadYLNqaxijT9hKc2TikXkTCRRCrV--

--aED9GAgzptD7p6pQZSzqLWqMF9p0keLY4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5rh4gACgkQ41TmuOI4
ufgkOA/+Lb1exfBdw/IZ/RV59VqcoJOxab/pswDiE3r4dG3u4LVTltcmPZ+cB1CS
nUtwjCEfWIYLwEI0jh9KVANUelWGcfcCuOPDatk9y+6DPSCXeerEToDssrPJcJuD
68OkuhzHTMtruUlBisZkZAMWvUNLt9l4iARmWg53k5Y8b2qOA9DN4qM1ZPuXsCPl
m5kltvBRV6pwjQni/qZMpc09hX3MV6Jqn477WMgt2CgZ1x6pJEDYaRsah506maRL
kGEjBCC4I468cQIvcNE0iV6PwBRoAMKPbnUML2EGDMjK3x0jsbY6Rq0m+OPx8sB6
61yD2UNuReiZeeO7wy5YnKONxIOLMRW8FO3hLug9RLDeH7Cx2ArjyBBr0VhqEAJc
KnnMv1z4BKRkTKIZnIUaXuoRNfQleantwUqruPYntoPA2q0HK8MYnaOuls+XmJxQ
9dCnjUlhJYFEszwfttiAxvfbSZ1OpiXcysyyNVFynNAOndA+fDMGtFrEsrLchfWv
YNmq2V8s/bMWFDQy08hIthOJnbkxiIgg5hF+gg5SkM8tn92yJSrdBPon0aOjmk1U
Ip1hoA32AyczSSXgSzUylKdkEe3ZR1LFjxmcyXk87xB75lardz0FGzy7GJt+tQhC
EOF0aKesjY7FSv96P9z2OVqFVicHnoaGq9tKjYWGRz75BcCb44E=
=3UCu
-----END PGP SIGNATURE-----

--aED9GAgzptD7p6pQZSzqLWqMF9p0keLY4--


