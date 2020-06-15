Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ECFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:04:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E21C2068E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0qbd6PU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E21C2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jklyZ-00023A-Ga
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 06:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jklxK-0000X9-CI
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:03:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29417
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jklxH-0001Yl-Pu
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 06:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592215381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rLeDHP8+6xhVwNxOy8bdm9f03R3/6Et50BEQXRu9FXc=;
 b=S0qbd6PUFAGaegeE8D35PCKQSILPRvUahU352VH6uisecvGifn9QWhG2HB1LKZ2RJVanmB
 HmEBtL+HNcRqesX6LN5V+SRdg587De/wf55erAzlONBgeO2cv7I6uzV+FpDd2ayC6PzYMe
 bIo8YHJzMs17l2AJBR0dR0yt3ocyLnU=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-spW-MEETOGqr3ZcQ6aJ-Cg-1; Mon, 15 Jun 2020 06:02:59 -0400
X-MC-Unique: spW-MEETOGqr3ZcQ6aJ-Cg-1
Received: by mail-ot1-f71.google.com with SMTP id c2so6168355otb.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 03:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rLeDHP8+6xhVwNxOy8bdm9f03R3/6Et50BEQXRu9FXc=;
 b=OmZ5ICISn3EyExBwBTsYIbyGeKfuxHr6i2hfNWSAqzPfCwHlnMnxXbwpFyflEsN04c
 Bv8VYx+u6YftjbyF5ECaBwLnPVIKc7oEQBzgwOb+41mHrZQTefyWUDYLMF3y9zPCdFO8
 JAbOnJwNolI4jVBr3zB7QFBO2u8x1TjoIZJPBGDHt6rsdr82ehKVxKVmE/BWEe2igQbo
 5+sRy+b2KDFvwh7b4yVu9yZoeTQpTLMrXsp6xBWPi2JQGNVZYtOYLDAdiBHDUI/7ZQ7p
 Sn/R+hTCJMOPGeK0dhtyIZ507qiWkDg6qayg97Jv87rsQmg/yVXmEhkKAkIiZxuqqEnE
 dbcA==
X-Gm-Message-State: AOAM5307ibPxHm8CTElqMaT1K9KYIjXZOg4ej+HV/VWWuUSMYckHZ2f3
 dkqtrHDqzd/HLcVSlRO0Tg1OcT0ctKzRWdfyQh9fEI7QGvIDJW6Kv++ZVVv68zWbslEAakpQQw/
 qVtq19QM59aa14aBgNA44T6tSvvBLcUM=
X-Received: by 2002:a4a:e658:: with SMTP id q24mr20459598oot.87.1592215378775; 
 Mon, 15 Jun 2020 03:02:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypHq2UlIl1V77qQYJnFtHXa2PQIzOfCXod9KrGyIDmaCbKkTCvQfIQtJRHHVG/5f9Sksgqw/7C1V2aawaixHw=
X-Received: by 2002:a4a:e658:: with SMTP id q24mr20459572oot.87.1592215378500; 
 Mon, 15 Jun 2020 03:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200612141917.9446-1-mst@redhat.com>
 <20200612141917.9446-21-mst@redhat.com>
In-Reply-To: <20200612141917.9446-21-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Mon, 15 Jun 2020 12:02:47 +0200
Message-ID: <CAP+75-V7YX9Kw86konzTv=urYF_hi3ht5eWUtRqALJGZ-WLEDQ@mail.gmail.com>
Subject: Re: [PULL v2 20/58] bios-tables-test: Add Q35/TPM-TIS test
To: "Michael S. Tsirkin" <mst@redhat.com>, Eric Auger <eric.auger@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
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
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 12, 2020 at 5:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Eric Auger <eric.auger@redhat.com>
>
> Test tables specific to the TPM-TIS instantiation.
> The TPM2 is added in the framework. Also the DSDT
> is updated with the TPM. The new function should be
> be usable for CRB as well, later one.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> Message-Id: <20200609125409.24179-5-eric.auger@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  tests/qtest/bios-tables-test.c | 58 ++++++++++++++++++++++++++++++++++
>  tests/qtest/Makefile.include   |  1 +
>  2 files changed, 59 insertions(+)
>
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index c9843829b3..53f104a9c5 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -57,6 +57,9 @@
>  #include "qemu/bitmap.h"
>  #include "acpi-utils.h"
>  #include "boot-sector.h"
> +#include "tpm-emu.h"
> +#include "hw/acpi/tpm.h"
> +
>
>  #define MACHINE_PC "pc"
>  #define MACHINE_Q35 "q35"
> @@ -874,6 +877,60 @@ static void test_acpi_piix4_tcg_numamem(void)
>      free_test_data(&data);
>  }
>
> +uint64_t tpm_tis_base_addr;
> +
> +static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
> +                              uint64_t base)
> +{
> +    gchar *tmp_dir_name = g_strdup_printf("qemu-test_acpi_%s_tcg_%s.XXXXXX",
> +                                          machine, tpm_if);
> +    char *tmp_path = g_dir_make_tmp(tmp_dir_name, NULL);
> +    TestState test;
> +    test_data data;
> +    GThread *thread;
> +    char *args, *variant = g_strdup_printf(".%s", tpm_if);
> +
> +    tpm_tis_base_addr = base;
> +
> +    module_call_init(MODULE_INIT_QOM);
> +
> +    test.addr = g_new0(SocketAddress, 1);
> +    test.addr->type = SOCKET_ADDRESS_TYPE_UNIX;
> +    test.addr->u.q_unix.path = g_build_filename(tmp_path, "sock", NULL);
> +    g_mutex_init(&test.data_mutex);
> +    g_cond_init(&test.data_cond);
> +    test.data_cond_signal = false;
> +
> +    thread = g_thread_new(NULL, tpm_emu_ctrl_thread, &test);
> +    tpm_emu_test_wait_cond(&test);
> +
> +    memset(&data, 0, sizeof(data));
> +    data.machine = machine;
> +    data.variant = variant;
> +
> +    args = g_strdup_printf(
> +        " -chardev socket,id=chr,path=%s"
> +        " -tpmdev emulator,id=dev,chardev=chr"

This test makes our CI fail:
https://gitlab.com/qemu-project/qemu/-/jobs/593586369#L3466

> +        " -device tpm-%s,tpmdev=dev",
> +        test.addr->u.q_unix.path, tpm_if);
> +
> +    test_acpi_one(args, &data);
> +
> +    g_thread_join(thread);
> +    g_unlink(test.addr->u.q_unix.path);
> +    qapi_free_SocketAddress(test.addr);
> +    g_rmdir(tmp_path);
> +    g_free(variant);
> +    g_free(tmp_path);
> +    g_free(tmp_dir_name);
> +    free_test_data(&data);
> +}
> +
> +static void test_acpi_q35_tcg_tpm_tis(void)
> +{
> +    test_acpi_tcg_tpm("q35", "tis", 0xFED40000);
> +}
> +
>  static void test_acpi_tcg_dimm_pxm(const char *machine)
>  {
>      test_data data;
> @@ -1037,6 +1094,7 @@ int main(int argc, char *argv[])
>              return ret;
>          }
>
> +        qtest_add_func("acpi/q35/tpm-tis", test_acpi_q35_tcg_tpm_tis);
>          qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
>          qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
>          qtest_add_func("acpi/q35", test_acpi_q35_tcg);
> diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
> index 9e5a51d033..5023fa413d 100644
> --- a/tests/qtest/Makefile.include
> +++ b/tests/qtest/Makefile.include
> @@ -262,6 +262,7 @@ tests/qtest/hd-geo-test$(EXESUF): tests/qtest/hd-geo-test.o $(libqos-obj-y)
>  tests/qtest/boot-order-test$(EXESUF): tests/qtest/boot-order-test.o $(libqos-obj-y)
>  tests/qtest/boot-serial-test$(EXESUF): tests/qtest/boot-serial-test.o $(libqos-obj-y)
>  tests/qtest/bios-tables-test$(EXESUF): tests/qtest/bios-tables-test.o \
> +        tests/qtest/tpm-emu.o $(test-io-obj-y) \
>         tests/qtest/boot-sector.o tests/qtest/acpi-utils.o $(libqos-obj-y)
>  tests/qtest/pxe-test$(EXESUF): tests/qtest/pxe-test.o tests/qtest/boot-sector.o $(libqos-obj-y)
>  tests/qtest/microbit-test$(EXESUF): tests/qtest/microbit-test.o
> --
> MST
>
>


