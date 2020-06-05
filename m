Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4136C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868602077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868602077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEGX-0003Bp-OA
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jhEFI-0002RS-Kw; Fri, 05 Jun 2020 11:27:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9668)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jhEFG-0006rB-Fm; Fri, 05 Jun 2020 11:27:00 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 055F3DR4041928; Fri, 5 Jun 2020 11:26:54 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31fm40qd27-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2020 11:26:53 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 055EXhLu043105;
 Fri, 5 Jun 2020 11:26:51 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31fm40qd1e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2020 11:26:51 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 055FKInX010808;
 Fri, 5 Jun 2020 15:26:49 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma02dal.us.ibm.com with ESMTP id 31bf4axu3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2020 15:26:49 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 055FPmvF1967084
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 5 Jun 2020 15:25:48 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E905B206C;
 Fri,  5 Jun 2020 15:25:48 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A047B2076;
 Fri,  5 Jun 2020 15:25:48 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri,  5 Jun 2020 15:25:48 +0000 (GMT)
Subject: Re: [RFC 4/6] tests: tpm-emu: Remove assert on TPM2_ST_NO_SESSIONS
To: Auger Eric <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, shannon.zhaosl@gmail.com, imammedo@redhat.com
References: <20200601102113.1207-1-eric.auger@redhat.com>
 <20200601102113.1207-5-eric.auger@redhat.com>
 <50a54958-e9e0-c95f-3893-f7f790186e0e@linux.ibm.com>
 <80ce5833-90ee-cbc5-9822-cca1fabc33e6@redhat.com>
 <b310bcc1-02aa-4948-20d0-2e66de68acb3@linux.ibm.com>
 <228f7928-9ffa-498d-0158-aa08e7c3ca55@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <aab64eab-f524-3385-c0c9-c0cd7a41e04e@linux.ibm.com>
Date: Fri, 5 Jun 2020 11:25:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <228f7928-9ffa-498d-0158-aa08e7c3ca55@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-05_04:2020-06-04,
 2020-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 cotscore=-2147483648 phishscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050109
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 11:26:55
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: marcandre.lureau@redhat.com, drjones@redhat.com, lersek@redhat.com,
 ardb@kernel.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/20 5:35 AM, Auger Eric wrote:
> Hi Stefan,
>
> On 6/2/20 6:17 PM, Stefan Berger wrote:
>> On 6/2/20 12:13 PM, Auger Eric wrote:
>>> Hi Stefan,
>>>
>>> On 6/2/20 3:39 PM, Stefan Berger wrote:
>>>> On 6/1/20 6:21 AM, Eric Auger wrote:
>>>>> While writing tests for checking the content of TPM2 and DSDT
>>>>> along with TPM-TIS instantiation I attempted to reuse the
>>>>> framework used for TPM-TIS tests. However While dumping the
>>>>> ACPI tables I get an assert on TPM2_ST_NO_SESSIONS. My assumption
>>>>> is maybe the other tests did not execute long enough to encounter
>>>>> this. So I tentatively propose to remove the assert as it
>>>>> does not seem to break other tests and enable the new ones.
>>>>>
>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>> ---
>>>>>     tests/qtest/tpm-emu.c | 1 -
>>>>>     1 file changed, 1 deletion(-)
>>>>>
>>>>> diff --git a/tests/qtest/tpm-emu.c b/tests/qtest/tpm-emu.c
>>>>> index c43ac4aef8..298d0eec74 100644
>>>>> --- a/tests/qtest/tpm-emu.c
>>>>> +++ b/tests/qtest/tpm-emu.c
>>>>> @@ -49,7 +49,6 @@ static void *tpm_emu_tpm_thread(void *data)
>>>>>             s->tpm_msg->tag = be16_to_cpu(s->tpm_msg->tag);
>>>>>             s->tpm_msg->len = be32_to_cpu(s->tpm_msg->len);
>>>>>             g_assert_cmpint(s->tpm_msg->len, >=, minhlen);
>>>>> -        g_assert_cmpint(s->tpm_msg->tag, ==, TPM2_ST_NO_SESSIONS);
>>>> You should not have to remove this. The tests are skipped if swtpm does
>>>> not support TPM 2 via --tpm2 option. This would be a very old swtpm
>>>> version, though. So, all tests are run with --tpm2 option and any
>>>> response received from the TPM would be a TPM 2 response that should
>>>> have TPM2_ST_NO_SESSIONS as the tag. I'd be curious what other value you
>>>> are seeing there.
>>> If I revert this patch I am getting TPM2_ST_SESSIONS on my end.
>> Is firmware/BIOS active? There's no TPM2_ST_SESSIONS coming out of QEMU.
> So it looks SeaBIOS is in use (bios-256k.bin loaded).
>
> I can see MMIO accesses to the TPM and the following commands are
> observable:
> tpm_emu_tpm_thread code=0x181 tag=0x8001 len=0xa
> tpm_emu_tpm_thread code=0x144 tag=0x8001 len=0xc
> tpm_emu_tpm_thread code=0x121 tag=0x8002 len=0x20
> This last one causes the assert (TPM2_CC_HierarchyControl)
>
> I checked in Seabios and effectively tpm20_hierarchycontrol() tags the
> TPM2_CC_HierarchyControl command with TPM2_ST_SESSIONS
>
> Due to our emulation, maybe tpm_set_failure() gets called, inducing
> tpm20_hierarchycontrol() call.
>
> That being said, what do you recommend? Remove the assert, improve the
> emulation, other?

So this is an ACPI test. What role does the firmware play for success of 
the test? If the test relies on the firmware showing some sort of 
expected result, then I would recommend only running this test with an 
attached swtpm, like we run some other tests. If we don't need the 
firmware to succeed then I would just get rid of the assert. Probably no 
other test we have implemented so far was running the firmware...


    Stefan


>
> Thank you in advance
>
> Best Regards
>
> Eric
>
>>     Stefan
>>
>>
>>


