Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD85C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:30:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7DAA206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DAA206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnh8M-0000Bm-1Y
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jnh7e-0007qm-6L
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:29:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jnh7c-0006M4-7w
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:29:49 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05NB2c9a093311; Tue, 23 Jun 2020 07:29:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31sk2s80s9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2020 07:29:27 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05NB2n6k093598;
 Tue, 23 Jun 2020 07:29:26 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31sk2s80rf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2020 07:29:26 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05NBPUZE031545;
 Tue, 23 Jun 2020 11:29:24 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma04dal.us.ibm.com with ESMTP id 31sa38vj3j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2020 11:29:23 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05NBTLEV29753698
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2020 11:29:21 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C40B66A04F;
 Tue, 23 Jun 2020 11:29:22 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26E106A047;
 Tue, 23 Jun 2020 11:29:22 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2020 11:29:21 +0000 (GMT)
Subject: Re: [PATCH v3 00/12] tpm: Split hw/ vs backends/
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200612085444.8362-1-philmd@redhat.com>
 <03924193-9774-9f85-2008-05c047fe91cf@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <3dff6351-e20c-e5bd-cb97-8c80793df52c@linux.ibm.com>
Date: Tue, 23 Jun 2020 07:29:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <03924193-9774-9f85-2008-05c047fe91cf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-23_06:2020-06-23,
 2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 cotscore=-2147483648 mlxscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 spamscore=0 phishscore=0 impostorscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006230088
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 07:29:31
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
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
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/23/20 5:39 AM, Paolo Bonzini wrote:
> On 12/06/20 10:54, Philippe Mathieu-Daudé wrote:
>> Missing review: last patch
>> - #12 "tpm: Move backend code under the 'backends/' directory"
>>
>> Hi,
>>
>> Yesterday I started to review some vTPM patches and got very
>> confused by the files under hw/tpm/. In particular after
>> running:
>>
>>    $ git grep TYPE_TPM_BACKEND
>>    backends/tpm.c:188:    .name = TYPE_TPM_BACKEND,
>>    hw/tpm/tpm_emulator.c:985:    .parent = TYPE_TPM_BACKEND,
>>    hw/tpm/tpm_passthrough.c:393:    .parent = TYPE_TPM_BACKEND,
>>    include/sysemu/tpm_backend.h:21:#define TYPE_TPM_BACKEND "tpm-backend"
>>
>> As there is no particular reason to keep this mixed, clean it up.
>>
>> Since v2:
>> - Resolved the FIXME in tpm_tis_common.c by making the
>>    TRACE_TPM_UTIL_SHOW_BUFFER check locally to tpm_util.c
>>
>> Since v1:
>> - Amended docs/ changes
>> - Renamed Kconfig TPM_BACKEND variable
>> - Move backend files under backends/tpm/ (Marc-André & Stefan)
>> - Fix x86-64 build error (patchew)
>>
>> Philippe Mathieu-Daudé (12):
>>    docs/specs/tpm: Correct header path name
>>    backends: Add TPM files into their own directory
>>    hw/tpm: Rename TPMDEV as TPM_BACKEND in Kconfig
>>    hw/tpm: Do not include 'qemu/osdep.h' in header
>>    hw/tpm: Include missing 'qemu/option.h' header
>>    hw/tpm: Move 'hw/acpi/tpm.h' inclusion from header to sources
>>    hw/tpm: Remove unnecessary 'tpm_int.h' header inclusion
>>    hw/tpm: Make TRACE_TPM_UTIL_SHOW_BUFFER check local to tpm_util.c
>>    hw/tpm: Move few declarations from 'tpm_util.h' to 'tpm_int.h'
>>    hw/tpm: Move DEFINE_PROP_TPMBE() macro to 'tmp_prop.h' local header
>>    hw/tpm: Make 'tpm_util.h' publicly accessible as "sysemu/tpm_util.h"
>>    tpm: Move backend code under the 'backends/' directory
>>
>>   docs/specs/tpm.rst                     | 14 +++++------
>>   Makefile                               |  2 +-
>>   Makefile.objs                          |  1 +
>>   {hw => backends}/tpm/tpm_int.h         | 19 +++++++++++---
>>   {hw => backends}/tpm/tpm_ioctl.h       |  0
>>   hw/tpm/tpm_ppi.h                       |  1 -
>>   hw/tpm/tpm_prop.h                      | 31 +++++++++++++++++++++++
>>   hw/tpm/tpm_tis.h                       |  1 -
>>   {hw/tpm => include/sysemu}/tpm_util.h  | 19 +++-----------
>>   backends/{tpm.c => tpm/tpm_backend.c}  |  0
>>   {hw => backends}/tpm/tpm_emulator.c    |  2 +-
>>   {hw => backends}/tpm/tpm_passthrough.c |  2 +-
>>   {hw => backends}/tpm/tpm_util.c        |  5 +++-
>>   hw/tpm/tpm_crb.c                       |  4 +--
>>   hw/tpm/tpm_ppi.c                       |  1 +
>>   hw/tpm/tpm_spapr.c                     |  4 +--
>>   hw/tpm/tpm_tis_common.c                | 11 +++------
>>   hw/tpm/tpm_tis_isa.c                   |  3 ++-
>>   hw/tpm/tpm_tis_sysbus.c                |  3 ++-
>>   tests/qtest/tpm-emu.c                  |  2 +-
>>   MAINTAINERS                            |  2 +-
>>   backends/Kconfig                       |  1 +
>>   backends/Makefile.objs                 |  2 +-
>>   backends/tpm/Kconfig                   | 14 +++++++++++
>>   backends/tpm/Makefile.objs             |  4 +++
>>   backends/tpm/trace-events              | 33 +++++++++++++++++++++++++
>>   hw/tpm/Kconfig                         | 21 +++-------------
>>   hw/tpm/Makefile.objs                   |  3 ---
>>   hw/tpm/trace-events                    | 34 +-------------------------
>>   29 files changed, 136 insertions(+), 103 deletions(-)
>>   rename {hw => backends}/tpm/tpm_int.h (81%)
>>   rename {hw => backends}/tpm/tpm_ioctl.h (100%)
>>   create mode 100644 hw/tpm/tpm_prop.h
>>   rename {hw/tpm => include/sysemu}/tpm_util.h (80%)
>>   rename backends/{tpm.c => tpm/tpm_backend.c} (100%)
>>   rename {hw => backends}/tpm/tpm_emulator.c (99%)
>>   rename {hw => backends}/tpm/tpm_passthrough.c (99%)
>>   rename {hw => backends}/tpm/tpm_util.c (98%)
>>   create mode 100644 backends/Kconfig
>>   create mode 100644 backends/tpm/Kconfig
>>   create mode 100644 backends/tpm/Makefile.objs
>>   create mode 100644 backends/tpm/trace-events
>>
> Queued this one, actually.

I was going to send a PR today.

>
> Paolo
>


