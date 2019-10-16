Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5CDFA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:06:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C3B20659
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C3B20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKi4v-0003UH-6A
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 08:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKi3Z-0002Sz-Ph
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKi3X-000783-VI
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:05:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54498)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKi3X-00077Y-La
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:05:31 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 623348535C
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 12:05:29 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id z205so1106893wmb.7
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 05:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=509I9WASuzQVkJvj/totZkrhhlBCM8zncHDmxD11nbo=;
 b=gdU3HgqBWl7muXtM0ApNij+uGhh3o15nrQI4zFwHq+oHtoN1NUk/NFyQ2pXl5K2zyD
 tZPy2/ABsRfsElyk6vE3Y6H+e8bNav7qVHIUSPFEcmECobil4HP0e5J9FFjFBKFz2qkV
 yaHbp2RgB8JbUXEwBlMqIFGvBwJ/MV8vtwVw0+UwHCJFourvyncOHst31Ysvs5ZJXhfy
 wUlXykooxVYfCJ4p66MK/s2E621afelb3zrVeMK3z7nLSZf3+dW1bAxcOXsPkULvEASr
 aGVUQRvJBsLRKVamWEpdv05LTsK2fZEScGKermI5rk/gXT9SMy9p8CtSI0EfD8X0Ilk7
 Smfw==
X-Gm-Message-State: APjAAAWzsXqIajlHvK4GpRLmGs2wQgjpKK75oD7zjhAVCfrCo+7J0+Cp
 Q/343rL7H2Whg3XK8GmaGqohVhwitSmQaLo76/bswAQ8bwTO8dnO77lFNzhhvMgd8fYHOB24PcK
 z9k99ClCvMZ4l6O0=
X-Received: by 2002:a05:6000:149:: with SMTP id
 r9mr1599473wrx.90.1571227527934; 
 Wed, 16 Oct 2019 05:05:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxggYhCa6+t4VVExHMMihj22El2B+mUJjRlQrQJdunOWsFWtyQI6XACBRteLBAmzYPKUPU6xA==
X-Received: by 2002:a05:6000:149:: with SMTP id
 r9mr1599444wrx.90.1571227527587; 
 Wed, 16 Oct 2019 05:05:27 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id r27sm67126013wrc.55.2019.10.16.05.05.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2019 05:05:26 -0700 (PDT)
Subject: Re: [PATCH v6 2/9] tests: arm: Introduce cpu feature tests
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20191016085408.24360-1-drjones@redhat.com>
 <20191016085408.24360-3-drjones@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cec54f08-9508-13e5-600f-3442962a1642@redhat.com>
Date: Wed, 16 Oct 2019 14:05:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191016085408.24360-3-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com,
 eric.auger@redhat.com, imammedo@redhat.com, alex.bennee@linaro.org,
 Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Andrew,

On 10/16/19 10:54 AM, Andrew Jones wrote:
> Now that Arm CPUs have advertised features lets add tests to ensure
> we maintain their expected availability with and without KVM.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>   tests/Makefile.include   |   5 +-
>   tests/arm-cpu-features.c | 242 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 246 insertions(+), 1 deletion(-)
>   create mode 100644 tests/arm-cpu-features.c
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 3543451ed309..8fd7c90b625e 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -255,6 +255,7 @@ check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
>   check-qtest-sparc64-y += tests/prom-env-test$(EXESUF)
>   check-qtest-sparc64-y += tests/boot-serial-test$(EXESUF)
>   
> +check-qtest-arm-y += tests/arm-cpu-features$(EXESUF)
>   check-qtest-arm-y += tests/microbit-test$(EXESUF)
>   check-qtest-arm-y += tests/m25p80-test$(EXESUF)
>   check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
> @@ -262,7 +263,8 @@ check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
>   check-qtest-arm-y += tests/hexloader-test$(EXESUF)
>   check-qtest-arm-$(CONFIG_PFLASH_CFI02) += tests/pflash-cfi02-test$(EXESUF)
>   
> -check-qtest-aarch64-y = tests/numa-test$(EXESUF)
> +check-qtest-aarch64-y += tests/arm-cpu-features$(EXESUF)
> +check-qtest-aarch64-y += tests/numa-test$(EXESUF)
>   check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
>   check-qtest-aarch64-y += tests/migration-test$(EXESUF)
>   # TODO: once aarch64 TCG is fixed on ARM 32 bit host, make test unconditional
> @@ -827,6 +829,7 @@ tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
>   tests/numa-test$(EXESUF): tests/numa-test.o
>   tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o tests/acpi-utils.o
>   tests/cdrom-test$(EXESUF): tests/cdrom-test.o tests/boot-sector.o $(libqos-obj-y)
> +tests/arm-cpu-features$(EXESUF): tests/arm-cpu-features.o
>   
>   tests/migration/stress$(EXESUF): tests/migration/stress.o
>   	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
> diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
> new file mode 100644
> index 000000000000..198ff6d6b495
> --- /dev/null
> +++ b/tests/arm-cpu-features.c
> @@ -0,0 +1,242 @@
> +/*
> + * Arm CPU feature test cases
> + *
> + * Copyright (c) 2019 Red Hat Inc.
> + * Authors:
> + *  Andrew Jones <drjones@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "qapi/qmp/qdict.h"
> +#include "qapi/qmp/qjson.h"
> +
> +#define MACHINE    "-machine virt,gic-version=max "
> +#define QUERY_HEAD "{ 'execute': 'query-cpu-model-expansion', " \
> +                     "'arguments': { 'type': 'full', "
> +#define QUERY_TAIL "}}"
> +
> +static QDict *do_query_no_props(QTestState *qts, const char *cpu_type)
> +{
> +    return qtest_qmp(qts, QUERY_HEAD "'model': { 'name': %s }"
> +                          QUERY_TAIL, cpu_type);
> +}
> +
> +static QDict *do_query(QTestState *qts, const char *cpu_type,
> +                       const char *fmt, ...)
> +{
> +    QDict *resp;
> +
> +    if (fmt) {
> +        QDict *args;
> +        va_list ap;
> +
> +        va_start(ap, fmt);
> +        args = qdict_from_vjsonf_nofail(fmt, ap);
> +        va_end(ap);
> +
> +        resp = qtest_qmp(qts, QUERY_HEAD "'model': { 'name': %s, "
> +                                                    "'props': %p }"
> +                              QUERY_TAIL, cpu_type, args);
> +    } else {
> +        resp = do_query_no_props(qts, cpu_type);
> +    }
> +
> +    return resp;
> +}
> +
> +static const char *resp_get_error(QDict *resp)
> +{
> +    QDict *qdict;
> +
> +    g_assert(resp);
> +
> +    qdict = qdict_get_qdict(resp, "error");
> +    if (qdict) {
> +        return qdict_get_str(qdict, "desc");
> +    }
> +    return NULL;
> +}
> +
> +#define assert_error(qts, cpu_type, expected_error, fmt, ...)          \
> +({                                                                     \
> +    QDict *_resp;                                                      \
> +    const char *_error;                                                \
> +                                                                       \
> +    _resp = do_query(qts, cpu_type, fmt, ##__VA_ARGS__);               \
> +    g_assert(_resp);                                                   \
> +    _error = resp_get_error(_resp);                                    \
> +    g_assert(_error);                                                  \
> +    g_assert(g_str_equal(_error, expected_error));                     \
> +    qobject_unref(_resp);                                              \
> +})
> +
> +static bool resp_has_props(QDict *resp)
> +{
> +    QDict *qdict;
> +
> +    g_assert(resp);
> +
> +    if (!qdict_haskey(resp, "return")) {
> +        return false;
> +    }
> +    qdict = qdict_get_qdict(resp, "return");
> +
> +    if (!qdict_haskey(qdict, "model")) {
> +        return false;
> +    }
> +    qdict = qdict_get_qdict(qdict, "model");
> +
> +    return qdict_haskey(qdict, "props");
> +}
> +
> +static QDict *resp_get_props(QDict *resp)
> +{
> +    QDict *qdict;
> +
> +    g_assert(resp);
> +    g_assert(resp_has_props(resp));
> +
> +    qdict = qdict_get_qdict(resp, "return");
> +    qdict = qdict_get_qdict(qdict, "model");
> +    qdict = qdict_get_qdict(qdict, "props");
> +    return qdict;
> +}
> +
> +#define assert_has_feature(qts, cpu_type, feature)                     \
> +({                                                                     \
> +    QDict *_resp = do_query_no_props(qts, cpu_type);                   \
> +    g_assert(_resp);                                                   \
> +    g_assert(resp_has_props(_resp));                                   \
> +    g_assert(qdict_get(resp_get_props(_resp), feature));               \
> +    qobject_unref(_resp);                                              \
> +})
> +
> +#define assert_has_not_feature(qts, cpu_type, feature)                 \
> +({                                                                     \
> +    QDict *_resp = do_query_no_props(qts, cpu_type);                   \
> +    g_assert(_resp);                                                   \
> +    g_assert(resp_has_props(_resp));                                   \
> +    g_assert(!qdict_get(resp_get_props(_resp), feature));              \
> +    qobject_unref(_resp);                                              \
> +})
> +
> +static void assert_type_full(QTestState *qts)
> +{
> +    const char *error;
> +    QDict *resp;
> +
> +    resp = qtest_qmp(qts, "{ 'execute': 'query-cpu-model-expansion', "
> +                            "'arguments': { 'type': 'static', "
> +                                           "'model': { 'name': 'foo' }}}");
> +    g_assert(resp);
> +    error = resp_get_error(resp);
> +    g_assert(error);
> +    g_assert(g_str_equal(error,
> +                         "The requested expansion type is not supported"));
> +    qobject_unref(resp);
> +}
> +
> +static void assert_bad_props(QTestState *qts, const char *cpu_type)
> +{
> +    const char *error;
> +    QDict *resp;
> +
> +    resp = qtest_qmp(qts, "{ 'execute': 'query-cpu-model-expansion', "
> +                            "'arguments': { 'type': 'full', "
> +                                           "'model': { 'name': %s, "
> +                                                      "'props': false }}}",
> +                     cpu_type);
> +    g_assert(resp);
> +    error = resp_get_error(resp);
> +    g_assert(error);
> +    g_assert(g_str_equal(error,
> +                         "Invalid parameter type for 'props', expected: dict"));
> +    qobject_unref(resp);
> +}
> +
> +static void test_query_cpu_model_expansion(const void *data)
> +{
> +    QTestState *qts;
> +
> +    qts = qtest_init(MACHINE "-cpu max");
> +
> +    /* Test common query-cpu-model-expansion input validation */
> +    assert_type_full(qts);
> +    assert_bad_props(qts, "max");
> +    assert_error(qts, "foo", "The CPU type 'foo' is not a recognized "
> +                 "ARM CPU type", NULL);
> +    assert_error(qts, "max", "Parameter 'not-a-prop' is unexpected",
> +                 "{ 'not-a-prop': false }");
> +    assert_error(qts, "host", "The CPU type 'host' requires KVM", NULL);
> +
> +    /* Test expected feature presence/absence for some cpu types */
> +    assert_has_feature(qts, "max", "pmu");
> +    assert_has_feature(qts, "cortex-a15", "pmu");
> +    assert_has_not_feature(qts, "cortex-a15", "aarch64");
> +
> +    if (g_str_equal(qtest_get_arch(), "aarch64")) {
> +        assert_has_feature(qts, "max", "aarch64");
> +        assert_has_feature(qts, "cortex-a57", "pmu");
> +        assert_has_feature(qts, "cortex-a57", "aarch64");
> +
> +        /* Test that features that depend on KVM generate errors without. */
> +        assert_error(qts, "max",
> +                     "'aarch64' feature cannot be disabled "
> +                     "unless KVM is enabled and 32-bit EL1 "
> +                     "is supported",
> +                     "{ 'aarch64': false }");
> +    }
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_query_cpu_model_expansion_kvm(const void *data)
> +{
> +    QTestState *qts;
> +
> +    qts = qtest_init(MACHINE "-accel kvm -cpu host");
> +
> +    assert_has_feature(qts, "host", "pmu");

Have you tried this on a ARM host? I wanted to but don't have access to 
one :(

> +
> +    if (g_str_equal(qtest_get_arch(), "aarch64")) {
> +        assert_has_feature(qts, "host", "aarch64");
> +
> +        assert_error(qts, "cortex-a15",
> +            "We cannot guarantee the CPU type 'cortex-a15' works "
> +            "with KVM on this host", NULL);
> +    } else {
> +        assert_error(qts, "host",
> +                     "'pmu' feature not supported by KVM on this host",
> +                     "{ 'pmu': true }");
> +    }
> +
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    bool kvm_available = false;
> +
> +    if (!access("/dev/kvm",  R_OK | W_OK)) {
> +#if defined(HOST_AARCH64)
> +        kvm_available = g_str_equal(qtest_get_arch(), "aarch64");
> +#elif defined(HOST_ARM)
> +        kvm_available = g_str_equal(qtest_get_arch(), "arm");
> +#endif
> +    }
> +
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_data_func("/arm/query-cpu-model-expansion",
> +                        NULL, test_query_cpu_model_expansion);
> +
> +    if (kvm_available) {
> +        qtest_add_data_func("/arm/kvm/query-cpu-model-expansion",
> +                            NULL, test_query_cpu_model_expansion_kvm);
> +    }
> +
> +    return g_test_run();
> +}
> 

