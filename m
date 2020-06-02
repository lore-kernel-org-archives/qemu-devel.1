Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A0BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:16:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C751206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WEp3uUve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C751206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgAWS-000342-Bq
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 13:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jgAVq-0002Rd-Vw
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:15:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30755
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jgAVk-0001Qx-LE
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591118135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qdxT1XeBAqOOh1U0HFez6Rt3sDhklWxp8CC2VcQdQH8=;
 b=WEp3uUve0SH66w/9Mo3TvqPalOT4TtE/Lp9/dlIB2RZ28ijSKajCljmeZcM5KXc3eu0t+G
 WuEUqEGwyJOT4Fzy5mSlu9dfILhyJJs/B7QGxEbwGTaUndjKzOKQc3+8is0NN99m4gbhKE
 OjlKziZW/Z0bKlvivMBjypzTp9pUK2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-RU882uhDP52yPvBWUAuBdg-1; Tue, 02 Jun 2020 13:15:30 -0400
X-MC-Unique: RU882uhDP52yPvBWUAuBdg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A9A1800053;
 Tue,  2 Jun 2020 17:15:29 +0000 (UTC)
Received: from [10.36.113.56] (ovpn-113-56.ams2.redhat.com [10.36.113.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E8435117E;
 Tue,  2 Jun 2020 17:15:20 +0000 (UTC)
Subject: Re: [RFC 4/6] tests: tpm-emu: Remove assert on TPM2_ST_NO_SESSIONS
To: Stefan Berger <stefanb@linux.ibm.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, shannon.zhaosl@gmail.com, imammedo@redhat.com
References: <20200601102113.1207-1-eric.auger@redhat.com>
 <20200601102113.1207-5-eric.auger@redhat.com>
 <50a54958-e9e0-c95f-3893-f7f790186e0e@linux.ibm.com>
 <80ce5833-90ee-cbc5-9822-cca1fabc33e6@redhat.com>
 <b310bcc1-02aa-4948-20d0-2e66de68acb3@linux.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <0f27abdd-ee72-22be-4a3f-d2129561d09b@redhat.com>
Date: Tue, 2 Jun 2020 19:15:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <b310bcc1-02aa-4948-20d0-2e66de68acb3@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 22:14:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=_AUTOLEARN
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

Stefan,

On 6/2/20 6:17 PM, Stefan Berger wrote:
> On 6/2/20 12:13 PM, Auger Eric wrote:
>> Hi Stefan,
>>
>> On 6/2/20 3:39 PM, Stefan Berger wrote:
>>> On 6/1/20 6:21 AM, Eric Auger wrote:
>>>> While writing tests for checking the content of TPM2 and DSDT
>>>> along with TPM-TIS instantiation I attempted to reuse the
>>>> framework used for TPM-TIS tests. However While dumping the
>>>> ACPI tables I get an assert on TPM2_ST_NO_SESSIONS. My assumption
>>>> is maybe the other tests did not execute long enough to encounter
>>>> this. So I tentatively propose to remove the assert as it
>>>> does not seem to break other tests and enable the new ones.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>> ---
>>>>    tests/qtest/tpm-emu.c | 1 -
>>>>    1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/tests/qtest/tpm-emu.c b/tests/qtest/tpm-emu.c
>>>> index c43ac4aef8..298d0eec74 100644
>>>> --- a/tests/qtest/tpm-emu.c
>>>> +++ b/tests/qtest/tpm-emu.c
>>>> @@ -49,7 +49,6 @@ static void *tpm_emu_tpm_thread(void *data)
>>>>            s->tpm_msg->tag = be16_to_cpu(s->tpm_msg->tag);
>>>>            s->tpm_msg->len = be32_to_cpu(s->tpm_msg->len);
>>>>            g_assert_cmpint(s->tpm_msg->len, >=, minhlen);
>>>> -        g_assert_cmpint(s->tpm_msg->tag, ==, TPM2_ST_NO_SESSIONS);
>>> You should not have to remove this. The tests are skipped if swtpm does
>>> not support TPM 2 via --tpm2 option. This would be a very old swtpm
>>> version, though. So, all tests are run with --tpm2 option and any
>>> response received from the TPM would be a TPM 2 response that should
>>> have TPM2_ST_NO_SESSIONS as the tag. I'd be curious what other value you
>>> are seeing there.
>> If I revert this patch I am getting TPM2_ST_SESSIONS on my end.
> 
> Is firmware/BIOS active? There's no TPM2_ST_SESSIONS coming out of QEMU.

From what I understand

QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
tests/qtest/bios-tables-test

launches

x86_64-softmmu/qemu-system-x86_64 \
-qtest unix:/tmp/qtest-20181.sock \
-qtest-log /dev/null -chardev socket,path=/tmp/qtest-20181.qmp,id=char0
-mon chardev=char0,mode=control \
-display none -machine q35,kernel-irqchip=off \
-accel kvm -accel tcg \
-net none -display none \
-chardev socket,id=chr,path=/tmp/qemu-test_acpi_q35_tcg_tpm2.RJJCL0/sock
-tpmdev emulator,id=dev,chardev=chr \
-device tpm-tis,tpmdev=dev \
-drive id=hd0,if=none,file=tests/acpi-test-disk-RAnagW,format=raw
-device ide-hd,drive=hd0 -accel qtest

acpi-test-disk-RAnagW consists in an x86 boot sector code, created by
boot_sector_init (x86_boot_sector)

Thanks

Eric




> 
>    Stefan
> 
> 
> 


