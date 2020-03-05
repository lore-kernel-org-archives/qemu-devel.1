Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA83C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A16208CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A16208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9mf6-0001DB-2a
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 04:19:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j9mc3-0006Da-U4
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:16:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j9mc2-0005jM-Kq
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:16:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11120)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j9mc2-0005id-Cc
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:16:14 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0259DvMO037431
 for <qemu-devel@nongnu.org>; Thu, 5 Mar 2020 04:16:13 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yhryekr5y-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 04:16:12 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 5 Mar 2020 09:16:10 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 5 Mar 2020 09:16:08 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 0259F9Em48628080
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2020 09:15:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD40E42047;
 Thu,  5 Mar 2020 09:16:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74A784204C;
 Thu,  5 Mar 2020 09:16:07 +0000 (GMT)
Received: from dyn-9-152-224-184.boeblingen.de.ibm.com (unknown
 [9.152.224.184])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu,  5 Mar 2020 09:16:07 +0000 (GMT)
Subject: Re: [PATCH v6 04/18] s390x: protvirt: Add migration blocker
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200304114231.23493-1-frankja@linux.ibm.com>
 <20200304114231.23493-5-frankja@linux.ibm.com>
 <fec085cf-0b64-f6e5-4f7e-9ec20a3909c5@redhat.com>
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
Date: Thu, 5 Mar 2020 10:16:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <fec085cf-0b64-f6e5-4f7e-9ec20a3909c5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kH7u3LHFaZDfPEZicnxVhNsNkdFaHL3Qe"
X-TM-AS-GCONF: 00
x-cbid: 20030509-0020-0000-0000-000003B0AF51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030509-0021-0000-0000-00002208E9E8
Message-Id: <d876014f-262a-483e-aa7b-de32871a00d9@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-05_02:2020-03-04,
 2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=11
 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050059
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kH7u3LHFaZDfPEZicnxVhNsNkdFaHL3Qe
Content-Type: multipart/mixed; boundary="GwAZ4sKURyQ9aOKmbHwSTrfjSqTyy7fJp"

--GwAZ4sKURyQ9aOKmbHwSTrfjSqTyy7fJp
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/4/20 6:13 PM, David Hildenbrand wrote:
> On 04.03.20 12:42, Janosch Frank wrote:
>> Migration is not yet supported.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c | 33 ++++++++++++++++++++++++---------
>>  1 file changed, 24 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index dd39890f89..272531a9ee 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -43,6 +43,9 @@
>>  #include "sysemu/sysemu.h"
>>  #include "hw/s390x/pv.h"
>>  #include <linux/kvm.h>
>> +#include "migration/blocker.h"
>> +
>> +static Error *pv_mig_blocker;
>> =20
>>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>>  {
>> @@ -324,19 +327,30 @@ static void s390_machine_unprotect(S390CcwMachin=
eState *ms)
>>  {
>>      CPUState *t;
>> =20
>> -    if (!ms->pv)
>> -        return;
>> -    s390_pv_vm_disable();
>> -    CPU_FOREACH(t) {
>> -        S390_CPU(t)->env.pv =3D false;
>> +    if (ms->pv) {
>> +        s390_pv_vm_disable();
>> +        CPU_FOREACH(t) {
>> +            S390_CPU(t)->env.pv =3D false;
>> +        }
>> +        ms->pv =3D false;
>>      }
>> -    ms->pv =3D false;
>> +    migrate_del_blocker(pv_mig_blocker);
>=20
> Is it just me or is this unnecessary code churn that wants to challenge=

> my reviewing capabilities? ;) Please perform that rework in the previou=
s
> patch already.

It's rather more of personal style choice to do a "if return" to not
encapsulate everything in ifs.

>=20
> Also, I do wonder why the blocker is always removed (IOW, how we could
> end up unprotecting, although there is nothing to unprotect).
>=20
> This needs a comment in the patch description.

You mean the error check for migrate_add_blocker()?
I'm still metabolizing my coffee...

>=20
>=20
>>  }
>> =20
>>  static int s390_machine_protect(S390CcwMachineState *ms)
>>  {
>> +    static Error *local_err;
>>      CPUState *t;
>> -    int rc;
>> +    int rc =3D -1;
>> +
>> +    if (!pv_mig_blocker) {
>=20
> I think we should instead error_free() when unprotecting ...

Ack

>=20
>> +        error_setg(&pv_mig_blocker,
>> +                   "protected VMs are currently not migrateable.");
>> +    }
>> +    migrate_add_blocker(pv_mig_blocker, &local_err);
>> +    if (local_err) {
>> +        goto out_err;
>=20
> ... and on the error path.

To also return the rc code, I changed it to:

    rc =3D migrate_add_blocker(pv_mig_blocker, &local_err);
    if (local_err) {
        error_free(pv_mig_blocker);
        return rc;
    }


>=20
>> +    }
>> =20
>>      /* Create SE VM */
>>      rc =3D s390_pv_vm_enable();
>> @@ -440,11 +454,12 @@ static void s390_machine_reset(MachineState *mac=
hine)
>> =20
>>          if (s390_machine_protect(ms)) {
>>              s390_machine_inject_pv_error(cs);
>=20
> ew, injecting an exception during a reset. (I know this belongs into th=
e
> previous patch)

Yeah, not too proud about this one, but doing it at diag308 time is not
possible, since we need to reset the devices before attempting to protect=
=2E

>=20
>> -            s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>> -            return;
>> +            goto pv_err;
>=20
> I have no idea why this hunk is in this patch. What am I missing?

The error needs to be communicated to the guest, so we need to resume
CPU operation instead of doing a load which we would do on success.

>=20
>>          }
>> =20
>>          run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
>> +pv_err:
>> +        s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>>          break;
>>      default:
>>          g_assert_not_reached();
>>
>=20
>=20



--GwAZ4sKURyQ9aOKmbHwSTrfjSqTyy7fJp--

--kH7u3LHFaZDfPEZicnxVhNsNkdFaHL3Qe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5gw1cACgkQ41TmuOI4
ufj2QA//UsaqGJFXDiFvVDhRoZaqpq+EZ783FmDDP/4dkGVNgRj/p4ziGhImMYgm
wgOcwIK2W691oExq/WHl3PIerAy80j7G86vCZGWPzqR03zZvgRslK60u5MLr0pIm
6j4x0a97ANl7LTyVi3MzEh+ziQsbBBoaVIiXpvSqDpcqVLI3BIZ0xesoN0QaR9Rt
DcBhXYwRqhvzlHc3yNoNsqkREAVxsp76Sg42PwnbUmSonYdj8X+Gx0BtOR/P5sg+
ORLjPeWhCG6QY0O3LgGnO8pXtiN4DxkYArnIw9T2YPhcJDocUWJoX5ZZ+5DQrgUP
BdXPtPHJq/t8Diqg+nKGqf0ONgF1X69ZvOgNUDBoZNoxs+Gaj3hmjtiQqmga65W+
Br5EoC/+DBmKOGR5O6D9gxazLE5uHpCzQH+Rpfh6uhSF+Zqpus4RRu3bydtKU5I1
9sEwzClxvMonpBxlK8mUbsWZqdFyCtmMyFKLf5TZdhL6tmVKa5OjUfYWjTsYhSb1
d7E2xX30RVSCmC4oxmDCpQeiXj+hGmkrAwADIXjVh9iInZM+rUDjL8oRVg8mOR2A
iDrEmh0I0sAW8iCoGWnZNzwA8vpZ/muQC0Ud2ShQ9oy7KopUD7oKGV1v29hPsL6s
UKVzDV0pd15FeHM36adcE79VGGU+rbPnNG9zptXRRbLoTCKvc10=
=YijK
-----END PGP SIGNATURE-----

--kH7u3LHFaZDfPEZicnxVhNsNkdFaHL3Qe--


