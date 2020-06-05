Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1B5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:50:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74367206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RaYGkgrC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74367206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEc7-00052w-LC
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jhEZ5-0001Cs-0c
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:47:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57048
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jhEZ4-000482-0u
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591372041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lBGUigN66of/D5bqVsdbwfZQ9rBKxrHjQbLptJuj28s=;
 b=RaYGkgrCCc8Q+naoiyhtxHFAEmphQvrIzME6gjUhxuR5fM45LLKvl9Tkhwhb30C+IA1lMY
 0aXu82nS3eJpssTE8B/x293NiCvL7DmNyDhHHrUrJu6AtTkM8/nSG9aVoH+f7bYuW6IwuM
 UWNmQb8r/B0hp4c+Mx9vjPYJszlBuEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-NbPViOGXN_2vRybDaDkpbA-1; Fri, 05 Jun 2020 11:47:20 -0400
X-MC-Unique: NbPViOGXN_2vRybDaDkpbA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBC3E835B47;
 Fri,  5 Jun 2020 15:47:18 +0000 (UTC)
Received: from [10.36.112.85] (ovpn-112-85.ams2.redhat.com [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 70DC77B60F;
 Fri,  5 Jun 2020 15:47:10 +0000 (UTC)
Subject: Re: [RFC 4/6] tests: tpm-emu: Remove assert on TPM2_ST_NO_SESSIONS
To: Stefan Berger <stefanb@linux.ibm.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, shannon.zhaosl@gmail.com, imammedo@redhat.com
References: <20200601102113.1207-1-eric.auger@redhat.com>
 <20200601102113.1207-5-eric.auger@redhat.com>
 <50a54958-e9e0-c95f-3893-f7f790186e0e@linux.ibm.com>
 <80ce5833-90ee-cbc5-9822-cca1fabc33e6@redhat.com>
 <b310bcc1-02aa-4948-20d0-2e66de68acb3@linux.ibm.com>
 <228f7928-9ffa-498d-0158-aa08e7c3ca55@redhat.com>
 <aab64eab-f524-3385-c0c9-c0cd7a41e04e@linux.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <fe6c6130-e027-af88-e005-d850a8ce0c89@redhat.com>
Date: Fri, 5 Jun 2020 17:47:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <aab64eab-f524-3385-c0c9-c0cd7a41e04e@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:40:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Stefan,

On 6/5/20 5:25 PM, Stefan Berger wrote:
> On 6/5/20 5:35 AM, Auger Eric wrote:
>> Hi Stefan,
>>
>> On 6/2/20 6:17 PM, Stefan Berger wrote:
>>> On 6/2/20 12:13 PM, Auger Eric wrote:
>>>> Hi Stefan,
>>>>
>>>> On 6/2/20 3:39 PM, Stefan Berger wrote:
>>>>> On 6/1/20 6:21 AM, Eric Auger wrote:
>>>>>> While writing tests for checking the content of TPM2 and DSDT
>>>>>> along with TPM-TIS instantiation I attempted to reuse the
>>>>>> framework used for TPM-TIS tests. However While dumping the
>>>>>> ACPI tables I get an assert on TPM2_ST_NO_SESSIONS. My assumption
>>>>>> is maybe the other tests did not execute long enough to encounter
>>>>>> this. So I tentatively propose to remove the assert as it
>>>>>> does not seem to break other tests and enable the new ones.
>>>>>>
>>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>>> ---
>>>>>>     tests/qtest/tpm-emu.c | 1 -
>>>>>>     1 file changed, 1 deletion(-)
>>>>>>
>>>>>> diff --git a/tests/qtest/tpm-emu.c b/tests/qtest/tpm-emu.c
>>>>>> index c43ac4aef8..298d0eec74 100644
>>>>>> --- a/tests/qtest/tpm-emu.c
>>>>>> +++ b/tests/qtest/tpm-emu.c
>>>>>> @@ -49,7 +49,6 @@ static void *tpm_emu_tpm_thread(void *data)
>>>>>>             s->tpm_msg->tag = be16_to_cpu(s->tpm_msg->tag);
>>>>>>             s->tpm_msg->len = be32_to_cpu(s->tpm_msg->len);
>>>>>>             g_assert_cmpint(s->tpm_msg->len, >=, minhlen);
>>>>>> -        g_assert_cmpint(s->tpm_msg->tag, ==, TPM2_ST_NO_SESSIONS);
>>>>> You should not have to remove this. The tests are skipped if swtpm
>>>>> does
>>>>> not support TPM 2 via --tpm2 option. This would be a very old swtpm
>>>>> version, though. So, all tests are run with --tpm2 option and any
>>>>> response received from the TPM would be a TPM 2 response that should
>>>>> have TPM2_ST_NO_SESSIONS as the tag. I'd be curious what other
>>>>> value you
>>>>> are seeing there.
>>>> If I revert this patch I am getting TPM2_ST_SESSIONS on my end.
>>> Is firmware/BIOS active? There's no TPM2_ST_SESSIONS coming out of QEMU.
>> So it looks SeaBIOS is in use (bios-256k.bin loaded).
>>
>> I can see MMIO accesses to the TPM and the following commands are
>> observable:
>> tpm_emu_tpm_thread code=0x181 tag=0x8001 len=0xa
>> tpm_emu_tpm_thread code=0x144 tag=0x8001 len=0xc
>> tpm_emu_tpm_thread code=0x121 tag=0x8002 len=0x20
>> This last one causes the assert (TPM2_CC_HierarchyControl)
>>
>> I checked in Seabios and effectively tpm20_hierarchycontrol() tags the
>> TPM2_CC_HierarchyControl command with TPM2_ST_SESSIONS
>>
>> Due to our emulation, maybe tpm_set_failure() gets called, inducing
>> tpm20_hierarchycontrol() call.
>>
>> That being said, what do you recommend? Remove the assert, improve the
>> emulation, other?
> 
> So this is an ACPI test. What role does the firmware play for success of
> the test? If the test relies on the firmware showing some sort of
> expected result, then I would recommend only running this test with an
> attached swtpm, like we run some other tests. If we don't need the
> firmware to succeed then I would just get rid of the assert. Probably no
> other test we have implemented so far was running the firmware...
FWIU The goal of this test is to compare the acpi tables generated by
qemu against reference ones. I dont think we expect from the FW any
specific result but I would prefer Igor or Michael to confirm.

In that case, removing the assert() allows to compare the specific DSDT
and TPM2 tables and that's our expectation here I think.

Thanks

Eric
> 
> 
>    Stefan
> 
> 
>>
>> Thank you in advance
>>
>> Best Regards
>>
>> Eric
>>
>>>     Stefan
>>>
>>>
>>>
> 
> 


