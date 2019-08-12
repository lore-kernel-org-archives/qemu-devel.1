Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38C4C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 06:04:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13BD2070C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 06:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13BD2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx3RQ-0007oq-TI
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 02:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36452)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bala24@linux.ibm.com>) id 1hx3R1-0007MG-1j
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 02:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1hx3Qz-0005Ay-Sd
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 02:03:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65496
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1hx3Qz-0005Ag-NH
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 02:03:57 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7C61f9A196028
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 02:03:56 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ub25pgmy8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 02:03:56 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Mon, 12 Aug 2019 07:03:54 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 12 Aug 2019 07:03:52 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7C63pXV51642522
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Aug 2019 06:03:51 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9E7442045;
 Mon, 12 Aug 2019 06:03:51 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50FA74204F;
 Mon, 12 Aug 2019 06:03:49 +0000 (GMT)
Received: from [9.124.35.43] (unknown [9.124.35.43])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 12 Aug 2019 06:03:49 +0000 (GMT)
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <20190808102547.GE1999@stefanha-x1.localdomain>
From: Balamuruhan S <bala24@linux.ibm.com>
Date: Mon, 12 Aug 2019 11:33:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190808102547.GE1999@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19081206-0016-0000-0000-0000029DB2B2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081206-0017-0000-0000-000032FDC0EE
Message-Id: <0d8ca403-c640-1f38-e943-b314f623cb79@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-12_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120067
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] Enhancing Qemu MMIO emulation with
 scripting interface
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
Cc: maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com, qemu-devel@nongnu.org,
 hari@linux.vnet.ibm.com, clg@kaod.org, pbonzini@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/8/19 3:55 PM, Stefan Hajnoczi wrote:
> On Wed, Aug 07, 2019 at 12:44:39PM +0530, Balamuruhan S wrote:
>> This is a proposal to extend mmio callbacks in Qemu with scripting interface
>> that is prototyped with python in this implementation. It gives ability to
>> feed runtime data through callbacks without recompiling Qemu in generic way.
>> This patchset adds library that provides APIs for Qemu to talk with python
>> scripts placed in path -module-path and how existing xscom can be extended
>> with python interface infrastructure.
>>
>> We have also added an hacky emulation for memory region (OCC common area and HOMER)
>> which is shared between core and un-core engine (ideally this should be via
>> sram device) to showcase the effectiveness of having the scripting interface
>> (uncore engine taken for discussion here is powerpc specificed called OCC).
>> Having scripting interface helps to emulate/test different uncore-core
>> interactions including uncore engine failure or hang. It also helps in feeding
>> randomized data at byte level access. This patchset is primarily to extend mmio
>> callbacks with scripting interface and to demonstrate effectiveness it.
>>
>> Some changes are required in PowerPC skiboot tree to test these changes since
>> the memory region is disabled currently for Qemu emulated PowerNV host,
>> https://github.com/balamuruhans/skiboot/commit/a655514d2a730e0372a2faee277d1cf01f71a524
> Although writing Python is quick and easy, carefully wiring up the
> Python C API for it is not.  In practice you lose much of the benefit of
> Python if you need to study the Python C API every time you wish to do
> some quick scripting :(.

Initially as you said to wire Python C API it needs study and care, but
once the framework reach to a stability we can use it for easy scripting
using it seamlessly.

>
> It must be possible to compile out the Python integration code.  If the
> Python integration code remains in the device model then the QEMU binary
> has a dependency on libpython, which is undesirable when this feature is
> not in use.

if we can keep it conditional during configure, so that by default qemu
binary will not depend on libpython. If user needs to use this feature
then python 3 based libpython and python-config are necessary.

>
> Assuming this feature can be compiled out, I think it should have a
> chance to prove its usefulness and gain users.  Documentation and an
> active maintainer are essential.

yes, hope that community will find its usefulness as it helped us to
test, study behavior of firmware/kernel and find bugs that is hard
to find otherwise.

Agreed that it would need proper documentation and active maintainer.

>
> Stefan


