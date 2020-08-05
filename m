Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086C0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 17:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D212722D2B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 17:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D212722D2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Mop-0006HF-32
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 13:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1k3Mnh-0005E3-UV; Wed, 05 Aug 2020 13:02:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17878)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1k3Mnf-0005u0-VP; Wed, 05 Aug 2020 13:02:01 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 075GXD6c119174; Wed, 5 Aug 2020 13:01:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32qye7tm4a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2020 13:01:25 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 075GXG3c119761;
 Wed, 5 Aug 2020 13:01:25 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32qye7tm34-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2020 13:01:25 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 075Gu4NV028717;
 Wed, 5 Aug 2020 17:01:23 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma04wdc.us.ibm.com with ESMTP id 32n019abup-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2020 17:01:23 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 075H1Mda57672136
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Aug 2020 17:01:22 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A5230C6055;
 Wed,  5 Aug 2020 17:01:22 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38E9DC605F;
 Wed,  5 Aug 2020 17:01:18 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.53.138])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Wed,  5 Aug 2020 17:01:17 +0000 (GMT)
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
 <878sf3uojf.fsf@morokweng.localdomain>
 <20200730005947.GO84173@umbus.fritz.box>
 <CAAdtpL5Mtaf7Xwu74U33eGTCAiFZNNXeCST8COwQeW8S9j8ZVQ@mail.gmail.com>
 <87a6zh3uyv.fsf@morokweng.localdomain>
User-agent: mu4e 1.2.0; emacs 26.3
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v3 0/8] Generalize start-powered-off property from ARM
In-reply-to: <87a6zh3uyv.fsf@morokweng.localdomain>
Date: Wed, 05 Aug 2020 14:01:14 -0300
Message-ID: <874kph58o5.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-05_13:2020-08-03,
 2020-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 mlxlogscore=808 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008050132
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=bauerman@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 13:01:53
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo
 Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Greg Kurz <groug@kaod.org>, Richard Henderson <rth@twiddle.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:

> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>
>> Le jeu. 30 juil. 2020 03:00, David Gibson <david@gibson.dropbear.id.au> a
>> =C3=A9crit :
>>
>>> On Tue, Jul 28, 2020 at 09:56:36PM -0300, Thiago Jung Bauermann wrote:
>>> >
>>> > Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
>>> >
>>> > > The ARM code has a start-powered-off property in ARMCPU, which is a
>>> > > subclass of CPUState. This property causes arm_cpu_reset() to set
>>> > > CPUState::halted to 1, signalling that the CPU should start in a ha=
lted
>>> > > state. Other architectures also have code which aim to achieve the =
same
>>> > > effect, but without using a property.
>>> > >
>>> > > The ppc/spapr version has a bug where QEMU does a KVM_RUN on the vc=
pu
>>> > > before cs->halted is set to 1, causing the vcpu to run while it's
>>> still in
>>> > > an unitialized state (more details in patch 3).
>>> >
>>> > Since this series fixes a bug is it eligible for 5.1, at least the
>>> > patches that were already approved by the appropriate maintainers?
>>>
>>> Ok by me.
>>>
>>
>> Maybe just the arm generalization and ppc fix for 5.1, delaying all not
>> bugfix to 5.2?
>
> That would be great.

Any news on this? Is there something I should be doing? I saw -rc3 today
but not these patches.

--=20
Thiago Jung Bauermann
IBM Linux Technology Center

