Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DD2C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 05:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0656120684
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 05:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0656120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx2Yv-00054Z-1N
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 01:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54373)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bala24@linux.ibm.com>) id 1hx2YS-0004eg-1k
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 01:07:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1hx2YQ-0004m1-WD
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 01:07:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16394
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1hx2YQ-0004lj-M6
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 01:07:34 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7C57Ulv088391
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 01:07:34 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2uavmxfyc2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 01:07:32 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Mon, 12 Aug 2019 06:07:23 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 12 Aug 2019 06:07:20 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7C57J6x54919248
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Aug 2019 05:07:19 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65C7842045;
 Mon, 12 Aug 2019 05:07:19 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A06442041;
 Mon, 12 Aug 2019 05:07:17 +0000 (GMT)
Received: from [9.124.35.43] (unknown [9.124.35.43])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 12 Aug 2019 05:07:16 +0000 (GMT)
To: David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <9cbb8079-d606-ab69-a5b3-93226888108a@kaod.org>
 <20190809044923.GO5465@umbus.fritz.box>
From: Balamuruhan S <bala24@linux.ibm.com>
Date: Mon, 12 Aug 2019 10:37:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190809044923.GO5465@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19081205-0008-0000-0000-00000308091F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081205-0009-0000-0000-00004A2616CD
Message-Id: <3fd0b951-8fe5-20a3-8c79-c63317b77c9e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-12_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120056
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x7C57Ulv088391
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
Cc: Peter Maydell <peter.maydell@linaro.org>, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, qemu-devel@nongnu.org, hari@linux.vnet.ibm.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/9/19 10:19 AM, David Gibson wrote:
> On Wed, Aug 07, 2019 at 10:15:48AM +0200, C=E9dric Le Goater wrote:
>> On 07/08/2019 09:14, Balamuruhan S wrote:
>>> Hi All,
>>>
>>> This is a proposal to extend mmio callbacks in Qemu with scripting in=
terface
>>> that is prototyped with python in this implementation. It gives abili=
ty to
>>> feed runtime data through callbacks without recompiling Qemu in gener=
ic way.
>>> This patchset adds library that provides APIs for Qemu to talk with p=
ython
>>> scripts placed in path -module-path and how existing xscom can be ext=
ended
>>> with python interface infrastructure.
>>>
>>> We have also added an hacky emulation for memory region (OCC common a=
rea and HOMER)
>>> which is shared between core and un-core engine (ideally this should =
be via
>>> sram device) to showcase the effectiveness of having the scripting in=
terface
>>> (uncore engine taken for discussion here is powerpc specificed called=
 OCC).
>> We should try to merge this part first. It is useful as it is after so=
me
>> cleanups.
>>
>>> Having scripting interface helps to emulate/test different uncore-cor=
e
>>> interactions including uncore engine failure or hang. It also helps i=
n feeding
>>> randomized data at byte level access. This patchset is primarily to e=
xtend mmio
>>> callbacks with scripting interface and to demonstrate effectiveness i=
t.
>> It is already possible to feed device models with external data using =
QMP or
>> external agents using a chardev backend transport. What are the benefi=
ts
>> of using the embedded python approach ? =20
> Yeah, I also think this needs better justification.
>
> In particular what's the case that Python makes this significantly
> easier than hacking up experimental interactions with C.  I mean you
> already have to understand POWER9 internals to work with this, right,
> so I wouldn't expect Python's greater accessibility to be a big
> concern here.

right, with python interface what I could think of is,

1. we don't have to patch up every experimental interactions and recompil=
e.
2. we can easily feed in invalid data type to see the behavior for negati=
ve/error
   scenarios.
3. Similar to qtest and acceptance test we can use this to cover many sce=
narios.
4. Ease the CI and maintenance to have test/code separately.

>


