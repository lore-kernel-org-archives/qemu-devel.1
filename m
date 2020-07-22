Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7336EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 22:09:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4669B20825
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 22:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4669B20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyMvB-0007GF-Fa
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 18:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jyMuG-00067Y-Ml
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 18:08:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13155
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jyMuA-0002LY-Ue
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 18:08:08 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06MM1dmc069100
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 18:08:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32e1vsdb5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 18:08:00 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06MM1cWt068950
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 18:07:59 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0b-001b2d01.pphosted.com with ESMTP id 32e1vsdb5a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2020 18:07:59 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06MM13KH025026;
 Wed, 22 Jul 2020 22:07:59 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma02wdc.us.ibm.com with ESMTP id 32brq9f9fk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Jul 2020 22:07:59 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06MM7wkN52363656
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jul 2020 22:07:59 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF85A2807A;
 Wed, 22 Jul 2020 22:07:58 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0FD128074;
 Wed, 22 Jul 2020 22:07:58 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 22 Jul 2020 22:07:58 +0000 (GMT)
Subject: Re: What is TYPE_TPM_TIS_ISA? (Not an ISA Device)
To: Markus Armbruster <armbru@redhat.com>
References: <8f5a171a-59db-f5d1-477c-1ddf7af45da7@redhat.com>
 <CAFEAcA8b3N+oxAAW3JEKGTtsZezXTOFdnu9Hm1MYK=yURTfVsQ@mail.gmail.com>
 <87pn8o14cj.fsf@dusky.pond.sub.org>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <e4ad751f-8418-bdd4-6c81-600e68f5c92e@linux.ibm.com>
Date: Wed, 22 Jul 2020 18:07:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87pn8o14cj.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-22_16:2020-07-22,
 2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007220135
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 18:08:00
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 1:55 AM, Markus Armbruster wrote:
> pm socket --tpmstate dir=tpm --ctrl type=unixio,path=tpm/swtpm-soc
> running in another terminal.
>
>>> 3/ no machine plug it using isa_register_ioport()
>>>     (it is not registered to the ISA memory space)
>> There's no requirement for an ISA device to have IO ports...
>>
>> thanks
>> -- PMM
> Thread hijack!  Since I didn't have swtpm installed, I tried to take a
> shortcut:
>
>      $ qemu-system-x86_64 -nodefaults -S -display none -monitor stdio -chardev null,id=tpm0 -tpmdev emulator,id=tpm0,chardev=chrtpm -device tpm-tis,tpmdev=tpm0
>      qemu-system-x86_64: -tpmdev emulator,id=tpm0,chardev=chrtpm: tpm-emulator: tpm chardev 'chrtpm' not found.
>      qemu-system-x86_64: -tpmdev emulator,id=tpm0,chardev=chrtpm: tpm-emulator: Could not cleanly shutdown the TPM: No such file or directory
>      QEMU 5.0.90 monitor - type 'help' for more information
>      (qemu) qemu-system-x86_64: -device tpm-tis,tpmdev=tpm0: Property 'tpm-tis.tpmdev' can't find value 'tpm0'
>      $ echo $?
>      1
>
> That a null chardev doesn't work is fine.  But the error handling looks
> broken: QEMU diagnoses and reports the problem, then continues.  The
> final error message indicates that it continued without creating the
> backend "tpm0".  That's wrong.


This issue can be solve via the following change that then displays this 
error:

$ x86_64-softmmu/qemu-system-x86_64 -nodefaults -S -display none 
-monitor stdio -chardev null,id=tpm0 -tpmdev 
emulator,id=tpm0,chardev=chrtpm -device tpm-tis,tpmdev=tpm0
qemu-system-x86_64: -tpmdev emulator,id=tpm0,chardev=chrtpm: 
tpm-emulator: tpm chardev 'chrtpm' not found.
qemu-system-x86_64: -tpmdev emulator,id=tpm0,chardev=chrtpm: 
tpm-emulator: Could not cleanly shutdown the TPM: No such file or directory


diff --git a/tpm.c b/tpm.c
index 358566cb10..857a861e69 100644
--- a/tpm.c
+++ b/tpm.c
@@ -170,8 +170,10 @@ void tpm_cleanup(void)
   */
  void tpm_init(void)
  {
-    qemu_opts_foreach(qemu_find_opts("tpmdev"),
-                      tpm_init_tpmdev, NULL, &error_fatal);
+    if (qemu_opts_foreach(qemu_find_opts("tpmdev"),
+                          tpm_init_tpmdev, NULL, &error_fatal)) {
+        exit(1);
+    }
  }

  /*

We had something like this before this patch here was applied: 
https://github.com/qemu/qemu/commit/d10e05f15d5c3dd5e5cc59c5dfff460d89d48580#diff-0ec5df49c6751cb2dc9fa18ed5cf9f0e


Do we now want to partially revert this patch or call the exit(1) as 
shown here?


    Stefan


