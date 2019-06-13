Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551A6C31E46
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 02:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B12215EA
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 02:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B12215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36566 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbFDM-0003wo-6t
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 22:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41761)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <farosas@linux.ibm.com>) id 1hbFCY-0003Lb-1j
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 22:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farosas@linux.ibm.com>) id 1hbF3T-0007oe-4t
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 22:01:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42030)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
 id 1hbF3H-0007jK-V3
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 22:01:24 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5D1uYBC093436
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 22:01:15 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2t3a7tdw1d-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 22:01:15 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
 Thu, 13 Jun 2019 03:01:13 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
 by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 13 Jun 2019 03:01:09 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5D218ZH39256396
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jun 2019 02:01:08 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF072AE079;
 Thu, 13 Jun 2019 02:01:06 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19159AE071;
 Thu, 13 Jun 2019 02:01:06 +0000 (GMT)
Received: from localhost (unknown [9.80.198.141])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
 Thu, 13 Jun 2019 02:01:04 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
In-Reply-To: <31dba2e5-7e8b-d006-d403-8c58c3c8a464@ozlabs.ru>
References: <20190228225759.21328-1-farosas@linux.ibm.com>
 <20190228225759.21328-6-farosas@linux.ibm.com>
 <b8a30b89-8c19-821e-e3a3-f1b71a088d9d@ozlabs.ru>
 <87ef73rl39.fsf@linux.ibm.com>
 <eadc5e30-5094-9b76-7268-cfb633ac40bd@ozlabs.ru>
 <c5e92072-eb8d-7af5-3eef-fac256f29c98@ozlabs.ru>
 <877e9r3p2e.fsf@linux.ibm.com>
 <31dba2e5-7e8b-d006-d403-8c58c3c8a464@ozlabs.ru>
Date: Wed, 12 Jun 2019 23:01:03 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19061302-0064-0000-0000-000003ED90AC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011252; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01217164; UDB=6.00640031; IPR=6.00998272; 
 MB=3.00027289; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-13 02:01:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061302-0065-0000-0000-00003DDF6711
Message-Id: <874l4u4528.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-13_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=44 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=736 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130014
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [RFC PATCH v4 5/5] target/ppc: support single
 stepping with KVM HV
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> It is TCG, a single CPU with a single thread and no matter where I put

Ok, but then none of this code gets executed because it is kvm-only:

qemu/exec.c
void cpu_single_step(CPUState *cpu, int enabled)
{
    if (cpu->singlestep_enabled != enabled) {
        cpu->singlestep_enabled = enabled;
        if (kvm_enabled()) {
->           kvm_set_singlestep(cpu, enabled);
        } else {
            /* must flush all the translated code to avoid inconsistencies */
            /* XXX: only flush what is necessary */
            tb_flush(cpu);
        }
    }
}

> this "stdu    r1,-368(r1)" - GDB does not stop on the next one and just
> runs.
>
> In the example above:
> 1. "b *0x10f16bc" makes GDB stop there, "ni" continues without stopping
> on at 0x10f16c0.

But this seems wrong anyway. Let me try to reproduce it and see what I
can find.

> 2. "b *0x10f16bc" and "b *0x10f16c0" make GDB stop at 0x10f16bc and "ni"
> steps to 0x10f16c0 but it is rather because it is a breakpoint and not
> the next instruction.
> 3. "b *0x10f16bc" and "b *0x10f16c4" make GDB stop at 0x10f16bc and "ni"
> stops GDB at 0x10f16bc but again it is a breakpoint.
>
> In 2 and 3 it is possible to continue step debugging till the next "stdu".
>


