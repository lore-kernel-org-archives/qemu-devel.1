Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9B0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A482F206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0e6AUCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A482F206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkmGy-0001oT-T6
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 06:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jkmG9-0001GU-7J
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:22:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29629)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jkmG6-0004tN-TF
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592216549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=kZbD/uoABbIcEKBpTTi29yMB6njKNzQA4Tx+QtinB7A=;
 b=e0e6AUCofouU9J35uv60RZaINkVoQC+rzZsTYgPca0RqaSHqPhTD3pwpOAUMA0Iy8fuT9U
 Fjc1wUfAmVPectXzu4KfUpDaTf+agxqQ1hIx9BJM8pN8RR3e2PwdX/kz0SF3pbxu9zoGcq
 wYJXvYm7TY8L5qeApuIE7x2dKuGfxSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-cCqM_aoSO4OJYUF_z_Snsw-1; Mon, 15 Jun 2020 06:22:27 -0400
X-MC-Unique: cCqM_aoSO4OJYUF_z_Snsw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49A3F7BAC;
 Mon, 15 Jun 2020 10:22:26 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-111.ams2.redhat.com [10.36.112.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 023241A8EC;
 Mon, 15 Jun 2020 10:22:18 +0000 (UTC)
Subject: Re: [PULL v2 20/58] bios-tables-test: Add Q35/TPM-TIS test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Auger <eric.auger@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
 <20200612141917.9446-21-mst@redhat.com>
 <CAP+75-V7YX9Kw86konzTv=urYF_hi3ht5eWUtRqALJGZ-WLEDQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8dbb3662-25b5-ba06-10fe-e3667bb62f6c@redhat.com>
Date: Mon, 15 Jun 2020 12:22:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAP+75-V7YX9Kw86konzTv=urYF_hi3ht5eWUtRqALJGZ-WLEDQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:12:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/06/2020 12.02, Philippe Mathieu-Daudé wrote:
> On Fri, Jun 12, 2020 at 5:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> From: Eric Auger <eric.auger@redhat.com>
>>
>> Test tables specific to the TPM-TIS instantiation.
>> The TPM2 is added in the framework. Also the DSDT
>> is updated with the TPM. The new function should be
>> be usable for CRB as well, later one.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> Message-Id: <20200609125409.24179-5-eric.auger@redhat.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>  tests/qtest/bios-tables-test.c | 58 ++++++++++++++++++++++++++++++++++
>>  tests/qtest/Makefile.include   |  1 +
>>  2 files changed, 59 insertions(+)
>>
>> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
>> index c9843829b3..53f104a9c5 100644
>> --- a/tests/qtest/bios-tables-test.c
>> +++ b/tests/qtest/bios-tables-test.c
>> @@ -57,6 +57,9 @@
>>  #include "qemu/bitmap.h"
>>  #include "acpi-utils.h"
>>  #include "boot-sector.h"
>> +#include "tpm-emu.h"
>> +#include "hw/acpi/tpm.h"
>> +
>>
>>  #define MACHINE_PC "pc"
>>  #define MACHINE_Q35 "q35"
>> @@ -874,6 +877,60 @@ static void test_acpi_piix4_tcg_numamem(void)
>>      free_test_data(&data);
>>  }
>>
>> +uint64_t tpm_tis_base_addr;
>> +
>> +static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
>> +                              uint64_t base)
>> +{
>> +    gchar *tmp_dir_name = g_strdup_printf("qemu-test_acpi_%s_tcg_%s.XXXXXX",
>> +                                          machine, tpm_if);
>> +    char *tmp_path = g_dir_make_tmp(tmp_dir_name, NULL);
>> +    TestState test;
>> +    test_data data;
>> +    GThread *thread;
>> +    char *args, *variant = g_strdup_printf(".%s", tpm_if);
>> +
>> +    tpm_tis_base_addr = base;
>> +
>> +    module_call_init(MODULE_INIT_QOM);
>> +
>> +    test.addr = g_new0(SocketAddress, 1);
>> +    test.addr->type = SOCKET_ADDRESS_TYPE_UNIX;
>> +    test.addr->u.q_unix.path = g_build_filename(tmp_path, "sock", NULL);
>> +    g_mutex_init(&test.data_mutex);
>> +    g_cond_init(&test.data_cond);
>> +    test.data_cond_signal = false;
>> +
>> +    thread = g_thread_new(NULL, tpm_emu_ctrl_thread, &test);
>> +    tpm_emu_test_wait_cond(&test);
>> +
>> +    memset(&data, 0, sizeof(data));
>> +    data.machine = machine;
>> +    data.variant = variant;
>> +
>> +    args = g_strdup_printf(
>> +        " -chardev socket,id=chr,path=%s"
>> +        " -tpmdev emulator,id=dev,chardev=chr"
> 
> This test makes our CI fail:
> https://gitlab.com/qemu-project/qemu/-/jobs/593586369#L3466

Right. The problem seems to occur as soon as you run "configure" with
"--disable-tpm" ... I think you need some "#ifdef CONFIG_TPM" here?

 Thomas


