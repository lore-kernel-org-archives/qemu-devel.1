Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472C3C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 04:46:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 165042085A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 04:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165042085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx2E4-0000wU-0f
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 00:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49302)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bala24@linux.ibm.com>) id 1hx2De-0000WZ-1t
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 00:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1hx2Dc-0005Pi-TV
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 00:46:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34600
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1hx2Dc-0005Pa-PS
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 00:46:04 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7C4g6j7101326
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 00:46:03 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2uax9dcsqp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 00:46:03 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Mon, 12 Aug 2019 05:46:01 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 12 Aug 2019 05:45:57 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7C4ju9G51839038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Aug 2019 04:45:57 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D20A842041;
 Mon, 12 Aug 2019 04:45:56 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB7784203F;
 Mon, 12 Aug 2019 04:45:53 +0000 (GMT)
Received: from [9.124.35.43] (unknown [9.124.35.43])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 12 Aug 2019 04:45:53 +0000 (GMT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <20190807071445.4109-2-bala24@linux.ibm.com>
 <20190808104904.GD2534@redhat.com>
 <5b5eb81f-86c7-30c3-16e3-7be969e45fde@redhat.com>
From: Balamuruhan S <bala24@linux.ibm.com>
Date: Mon, 12 Aug 2019 10:15:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5b5eb81f-86c7-30c3-16e3-7be969e45fde@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19081204-0012-0000-0000-0000033DABE7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081204-0013-0000-0000-00002177B69D
Message-Id: <85c9748f-10cc-a313-51db-35b27f7e8769@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-12_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120051
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x7C4g6j7101326
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [RFC PATCH 1/6] utils/python_api: add scripting
 interface for Qemu with python lib
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, maddy@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, qemu-devel@nongnu.org, hari@linux.vnet.ibm.com,
 clg@kaod.org, pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/8/19 6:15 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 8/8/19 12:49 PM, Daniel P. Berrang=C3=A9 wrote:
>> On Wed, Aug 07, 2019 at 12:44:40PM +0530, Balamuruhan S wrote:
>>> Adds scripting interface with python library to call functions in
>>> python modules from Qemu that can be used to feed input externally
>>> and without recompiling Qemu that can be used for early development,
>>> testing and can be extended to abstract some of Qemu code out to a
>>> python script to ease maintenance.
>> I admit the use case is interesting, but this is opening a can of
>> worms...
>>
>> Historically the project has held the view that we do not wish
>> to have an mechanism to support loading out of tree code into the
>> QEMU process. Much previously talk was around dlopen'd C plugins,
>> but dynanically loaded Python plugins are doing the same thing
>> at a conceptual level.
>>
>> We didn't wish to expose internals of QEMU in a plugin API to
>> avoid having any kind of API promise across releases.
>>
>> There was also the question of licensing with plugins opening
>> the door for people to extend QEMU with non-free/closed source
>> functionality.
>>
>> While this series only uses the plugin for one fairly obscure
>> device, once a python plugin feature is intergrated in QEMU
>> there will inevitably be requests to use it in further areas
>> of QEMU.
>>
>> IOW, acceptance of this patch is a significant question for
>> the project, and a broader discussion point, than just this
>> PPC feature patch series.
> Since performance is not an issue, we can use a QMP-PyMMIO bridge.
> Most of the functions required are already exposed, Damien completed th=
e
> missing ones in his 'FAULT INJECTION FRAMEWORK' series:
> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06230.html

will look at this approach and try using QMP-PyMMIO bridge.

Thank you all for review and suggestions.

>
> Maybe we simply need a clearer (better documented) QMP 'MMIO' API?
>


