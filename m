Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A976FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 23:05:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D312075D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 23:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D312075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Yeg-0005oI-P3
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 19:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1k0Yds-0005Bh-Dq; Tue, 28 Jul 2020 19:04:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1k0Ydq-0003Ta-2I; Tue, 28 Jul 2020 19:04:16 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06SN2wfO055069; Tue, 28 Jul 2020 19:03:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32hs1dfnam-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2020 19:03:38 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06SN2whd055056;
 Tue, 28 Jul 2020 19:03:38 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32hs1dfna5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2020 19:03:38 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06SMsU3V015338;
 Tue, 28 Jul 2020 23:03:36 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma03dal.us.ibm.com with ESMTP id 32gcy74e4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2020 23:03:36 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06SN3abQ30474616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jul 2020 23:03:36 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B533AC062;
 Tue, 28 Jul 2020 23:03:36 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 403C3AC060;
 Tue, 28 Jul 2020 23:03:29 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.54.39])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
 Tue, 28 Jul 2020 23:03:28 +0000 (GMT)
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
 <20200723025657.644724-4-bauerman@linux.ibm.com>
 <20200727152828.133ee76a@bahia.lan>
User-agent: mu4e 1.2.0; emacs 26.3
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3 3/8] ppc/spapr: Use start-powered-off CPUState property
In-reply-to: <20200727152828.133ee76a@bahia.lan>
Date: Tue, 28 Jul 2020 20:03:24 -0300
Message-ID: <87bljzuts3.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-28_17:2020-07-28,
 2020-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007280164
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=bauerman@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 19:04:11
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, David
 Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Greg Kurz <groug@kaod.org> writes:

> On Wed, 22 Jul 2020 23:56:52 -0300
> Thiago Jung Bauermann <bauerman@linux.ibm.com> wrote:
>
>> PowerPC sPAPR CPUs start in the halted state, and spapr_reset_vcpu()
>> attempts to implement this by setting CPUState::halted to 1. But that's too
>> late for the case of hotplugged CPUs in a machine configure with 2 or more
>> threads per core.
>> 
>> By then, other parts of QEMU have already caused the vCPU to run in an
>> unitialized state a couple of times. For example, ppc_cpu_reset() calls
>> ppc_tlb_invalidate_all(), which ends up calling async_run_on_cpu(). This
>> kicks the new vCPU while it has CPUState::halted = 0, causing QEMU to issue
>> a KVM_RUN ioctl on the new vCPU before the guest is able to make the
>> start-cpu RTAS call to initialize its register state.
>> 
>> This problem doesn't seem to cause visible issues for regular guests, but
>> on a secure guest running under the Ultravisor it does. The Ultravisor
>> relies on being able to snoop on the start-cpu RTAS call to map vCPUs to
>> guests, and this issue causes it to see a stray vCPU that doesn't belong to
>> any guest.
>> 
>> Fix by setting the start-powered-off CPUState property in
>> spapr_create_vcpu(), which makes cpu_common_reset() initialize
>> CPUState::halted to 1 at an earlier moment.
>> 
>> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> ---
>
> Thanks for doing this ! I remember seeing partly initialized CPUs being
> kicked in the past, which is clearly wrong but I never got time to find
> a proper fix (especially since it didn't seem to break anything).
>
> Reviewed-by: Greg Kurz <groug@kaod.org>

Thanks for confirming the issue, and for reviewing the code.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

