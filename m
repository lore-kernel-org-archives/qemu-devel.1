Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A368C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 12:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F56A2072F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 12:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F56A2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjME6-00018l-KK
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 08:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jjMD2-0000fv-3U
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 08:21:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jjMD0-0002E1-MK
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 08:21:27 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05BC6ZBX180665; Thu, 11 Jun 2020 08:21:21 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31k5hy7epq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2020 08:21:21 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05BCCoZL026205;
 Thu, 11 Jun 2020 08:21:21 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31k5hy7epc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2020 08:21:21 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05BCFHoA010625;
 Thu, 11 Jun 2020 12:21:20 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma03dal.us.ibm.com with ESMTP id 31hw1c6569-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2020 12:21:20 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05BCLJtV46989708
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jun 2020 12:21:19 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B8B9112064;
 Thu, 11 Jun 2020 12:21:19 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69FF5112061;
 Thu, 11 Jun 2020 12:21:19 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 11 Jun 2020 12:21:19 +0000 (GMT)
Subject: Re: [RFC PATCH 8/8] tpm: Move backend code under the 'backends/'
 directory
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, qemu-devel@nongnu.org
References: <20200610200247.21378-1-philmd@redhat.com>
 <20200610200247.21378-9-philmd@redhat.com>
 <ed92c76e-c20c-1ac1-04c7-66cef6b3eabc@linux.ibm.com>
 <0e1be827-0420-8bcc-c16e-3c2abd0727ba@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <9f30d8ab-abd2-0a32-8524-396962844150@linux.ibm.com>
Date: Thu, 11 Jun 2020 08:21:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0e1be827-0420-8bcc-c16e-3c2abd0727ba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-11_11:2020-06-11,
 2020-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 impostorscore=0
 cotscore=-2147483648 phishscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006110095
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 07:55:30
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 8:05 AM, Thomas Huth wrote:
> On 11/06/2020 14.00, Stefan Berger wrote:
>> On 6/10/20 4:02 PM, Philippe Mathieu-Daudé wrote:
>>> TPM subsytem is split into backends (see commit f4ede81eed2)
>>> and frontends (see i.e. 3676bc69b35). Keep the emulated
>>> hardware 'frontends' under hw/tpm/, but move the backends
>>> in the backends/ directory.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>> RFC due to a FIXME in tpm_tis_common.c, it uses
>>> TRACE_TPM_UTIL_SHOW_BUFFER which is now generated
>>> by backends/trace-events...
>>> ---
>>>    Makefile                               |  2 +-
>>>    {hw/tpm => backends}/tpm_int.h         |  6 ++---
>>>    {hw/tpm => backends}/tpm_ioctl.h       |  0
>>>    {hw/tpm => backends}/tpm_emulator.c    |  0
>>>    {hw/tpm => backends}/tpm_passthrough.c |  0
>>>    {hw/tpm => backends}/tpm_util.c        |  0
>> I don't understand this move. Why not keep everything TPM related in one
>> directory even though there may be a backend directory where 'nothing
>> else fits but the name.' All we need to remember is that 'emulator' and
>> 'passthrough' are the backends.
> We try to have a clean separation between frontends and backends in
> QEMU. The concepts have been mixed in the past (see e.g. the -drive
> parameter) and that led only to confusion and trouble later. The hw/
> directory is clearly for emulated hardware device frontends only, we
> should not include any backend code here.

Then move it into backends/tpm/ as Marc-Andre suggested.

>
>   Thomas
>


