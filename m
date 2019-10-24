Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CD0CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC31E205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC31E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeSF-00061U-Os
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNd4m-0004qi-16
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNd4k-0005l3-5Z
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:22:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40804)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNd4j-0005kT-R5
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:22:50 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3168A796E0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 13:22:48 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id o128so837031wmo.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 06:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=orDeG2HpFEm4uQ8OkwdIq1VcQnCs3GmS/UVoomI07oM=;
 b=G3hVRmLM62JLh4e/JWRGfKOAAXdUg6Hpae2ks3FTExRJe4It0j5ixCtquePgpBfyIR
 Mk6i4WECG+Ac9EwclNGTnLjWLZzBvJDUkG3X5NYoaORWgmc9eSeEmMWHY4dk9opPWGv6
 reCXFZvjyCZCb6CQ3DQYWy2qQdUJbjOTBjOwPyhidW3eA/kvKjX/W17kK07MqjdVfBRQ
 VVDFFDKG15zQQ8hIcD8q9WXxtN5qdOB6UkseZuZapWRNCxMoIGUsgWpnq9ZVYj+Z1Q+o
 jauq4/a0jGhu/mwyvrNCk7gB3a1L/48tszkNgWkVTznUOwNqmQXus/j+KO2kCNKr3Z3G
 RpXA==
X-Gm-Message-State: APjAAAXUfvVyzU2JIFgv+c9XfoseFLJ52kqGmduqORH5cejWKMLiIoQq
 rW9gpjON/wFbpAvFqRjz2i2DYsSAOuYHeaYsEPmUeGU8yBHpGBE7TGUqP9BdBRO57qP6IHq4NEB
 sAhSl4MVgc2tAa3M=
X-Received: by 2002:a1c:2c4:: with SMTP id 187mr5274333wmc.78.1571923366846;
 Thu, 24 Oct 2019 06:22:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx5bQ/DwFXNxrM1Vl8PMjpc8sem7i+tTIve8MLw4MkyJNKKy82f3kzCl1JGl+GRtLprvvhqew==
X-Received: by 2002:a1c:2c4:: with SMTP id 187mr5274307wmc.78.1571923366536;
 Thu, 24 Oct 2019 06:22:46 -0700 (PDT)
Received: from [192.168.1.115] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id b7sm10511469wrn.53.2019.10.24.06.22.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 06:22:45 -0700 (PDT)
Subject: Re: [PATCH v7 2/9] tests: arm: Introduce cpu feature tests
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20191024121808.9612-1-drjones@redhat.com>
 <20191024121808.9612-3-drjones@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4717bef4-5952-7df0-7e9a-951ea140a42a@redhat.com>
Date: Thu, 24 Oct 2019 15:22:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191024121808.9612-3-drjones@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: m.mizuma@jp.fujitsu.com, beata.michalska@linaro.org,
 richard.henderson@linaro.org, armbru@redhat.com, eric.auger@redhat.com,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/19 2:18 PM, Andrew Jones wrote:
> Now that Arm CPUs have advertised features lets add tests to ensure
> we maintain their expected availability with and without KVM.
>=20
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>   tests/Makefile.include   |   5 +-
>   tests/arm-cpu-features.c | 240 ++++++++++++++++++++++++++++++++++++++=
+
>   2 files changed, 244 insertions(+), 1 deletion(-)
>   create mode 100644 tests/arm-cpu-features.c
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 3543451ed309..8fd7c90b625e 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -255,6 +255,7 @@ check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) =3D tests=
/endianness-test$(EXESUF)
>   check-qtest-sparc64-y +=3D tests/prom-env-test$(EXESUF)
>   check-qtest-sparc64-y +=3D tests/boot-serial-test$(EXESUF)
>  =20
> +check-qtest-arm-y +=3D tests/arm-cpu-features$(EXESUF)
>   check-qtest-arm-y +=3D tests/microbit-test$(EXESUF)
>   check-qtest-arm-y +=3D tests/m25p80-test$(EXESUF)
>   check-qtest-arm-y +=3D tests/test-arm-mptimer$(EXESUF)
> @@ -262,7 +263,8 @@ check-qtest-arm-y +=3D tests/boot-serial-test$(EXES=
UF)
>   check-qtest-arm-y +=3D tests/hexloader-test$(EXESUF)
>   check-qtest-arm-$(CONFIG_PFLASH_CFI02) +=3D tests/pflash-cfi02-test$(=
EXESUF)
>  =20
> -check-qtest-aarch64-y =3D tests/numa-test$(EXESUF)
> +check-qtest-aarch64-y +=3D tests/arm-cpu-features$(EXESUF)
> +check-qtest-aarch64-y +=3D tests/numa-test$(EXESUF)
>   check-qtest-aarch64-y +=3D tests/boot-serial-test$(EXESUF)
>   check-qtest-aarch64-y +=3D tests/migration-test$(EXESUF)
>   # TODO: once aarch64 TCG is fixed on ARM 32 bit host, make test uncon=
ditional
> @@ -827,6 +829,7 @@ tests/test-qapi-util$(EXESUF): tests/test-qapi-util=
.o $(test-util-obj-y)
>   tests/numa-test$(EXESUF): tests/numa-test.o
>   tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o=
 tests/acpi-utils.o
>   tests/cdrom-test$(EXESUF): tests/cdrom-test.o tests/boot-sector.o $(l=
ibqos-obj-y)
> +tests/arm-cpu-features$(EXESUF): tests/arm-cpu-features.o
>  =20
>   tests/migration/stress$(EXESUF): tests/migration/stress.o
>   	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $=
< ,"LINK","$(TARGET_DIR)$@")
> diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
> new file mode 100644
> index 000000000000..c59fcf409c89
> --- /dev/null
> +++ b/tests/arm-cpu-features.c
> @@ -0,0 +1,240 @@
> +/*
> + * Arm CPU feature test cases
> + *
> + * Copyright (c) 2019 Red Hat Inc.
> + * Authors:
> + *  Andrew Jones <drjones@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + */
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "qapi/qmp/qdict.h"
> +#include "qapi/qmp/qjson.h"
> +
> +#define MACHINE    "-machine virt,gic-version=3Dmax "
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
> +        args =3D qdict_from_vjsonf_nofail(fmt, ap);
> +        va_end(ap);
> +
> +        resp =3D qtest_qmp(qts, QUERY_HEAD "'model': { 'name': %s, "
> +                                                    "'props': %p }"
> +                              QUERY_TAIL, cpu_type, args);
> +    } else {
> +        resp =3D do_query_no_props(qts, cpu_type);
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
> +    qdict =3D qdict_get_qdict(resp, "error");
> +    if (qdict) {
> +        return qdict_get_str(qdict, "desc");
> +    }
> +    return NULL;
> +}
> +
> +#define assert_error(qts, cpu_type, expected_error, fmt, ...)         =
 \
> +({                                                                    =
 \
> +    QDict *_resp;                                                     =
 \
> +    const char *_error;                                               =
 \
> +                                                                      =
 \
> +    _resp =3D do_query(qts, cpu_type, fmt, ##__VA_ARGS__);            =
   \
> +    g_assert(_resp);                                                  =
 \
> +    _error =3D resp_get_error(_resp);                                 =
   \
> +    g_assert(_error);                                                 =
 \
> +    g_assert(g_str_equal(_error, expected_error));                    =
 \
> +    qobject_unref(_resp);                                             =
 \
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
> +    qdict =3D qdict_get_qdict(resp, "return");
> +
> +    if (!qdict_haskey(qdict, "model")) {
> +        return false;
> +    }
> +    qdict =3D qdict_get_qdict(qdict, "model");
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
> +    qdict =3D qdict_get_qdict(resp, "return");
> +    qdict =3D qdict_get_qdict(qdict, "model");
> +    qdict =3D qdict_get_qdict(qdict, "props");
> +    return qdict;
> +}
> +
> +#define assert_has_feature(qts, cpu_type, feature)                    =
 \
> +({                                                                    =
 \
> +    QDict *_resp =3D do_query_no_props(qts, cpu_type);                =
   \
> +    g_assert(_resp);                                                  =
 \
> +    g_assert(resp_has_props(_resp));                                  =
 \
> +    g_assert(qdict_get(resp_get_props(_resp), feature));              =
 \
> +    qobject_unref(_resp);                                             =
 \
> +})
> +
> +#define assert_has_not_feature(qts, cpu_type, feature)                =
 \
> +({                                                                    =
 \
> +    QDict *_resp =3D do_query_no_props(qts, cpu_type);                =
   \
> +    g_assert(_resp);                                                  =
 \
> +    g_assert(!resp_has_props(_resp) ||                                =
 \
> +             !qdict_get(resp_get_props(_resp), feature));             =
 \
> +    qobject_unref(_resp);                                             =
 \
> +})
> +
> +static void assert_type_full(QTestState *qts)
> +{
> +    const char *error;
> +    QDict *resp;
> +
> +    resp =3D qtest_qmp(qts, "{ 'execute': 'query-cpu-model-expansion',=
 "
> +                            "'arguments': { 'type': 'static', "
> +                                           "'model': { 'name': 'foo' }=
}}");
> +    g_assert(resp);
> +    error =3D resp_get_error(resp);
> +    g_assert(error);
> +    g_assert(g_str_equal(error,
> +                         "The requested expansion type is not supporte=
d"));
> +    qobject_unref(resp);
> +}
> +
> +static void assert_bad_props(QTestState *qts, const char *cpu_type)
> +{
> +    const char *error;
> +    QDict *resp;
> +
> +    resp =3D qtest_qmp(qts, "{ 'execute': 'query-cpu-model-expansion',=
 "
> +                            "'arguments': { 'type': 'full', "
> +                                           "'model': { 'name': %s, "
> +                                                      "'props': false =
}}}",
> +                     cpu_type);
> +    g_assert(resp);
> +    error =3D resp_get_error(resp);
> +    g_assert(error);
> +    g_assert(g_str_equal(error,
> +                         "Invalid parameter type for 'props', expected=
: dict"));
> +    qobject_unref(resp);
> +}
> +
> +static void test_query_cpu_model_expansion(const void *data)
> +{
> +    QTestState *qts;
> +
> +    qts =3D qtest_init(MACHINE "-cpu max");
> +
> +    /* Test common query-cpu-model-expansion input validation */
> +    assert_type_full(qts);
> +    assert_bad_props(qts, "max");
> +    assert_error(qts, "foo", "The CPU type 'foo' is not a recognized "
> +                 "ARM CPU type", NULL);
> +    assert_error(qts, "max", "Parameter 'not-a-prop' is unexpected",
> +                 "{ 'not-a-prop': false }");
> +    assert_error(qts, "host", "The CPU type 'host' requires KVM", NULL=
);
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
> +        /* Test that features that depend on KVM generate errors witho=
ut. */
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
> +    qts =3D qtest_init(MACHINE "-accel kvm -cpu host");
> +
> +    if (g_str_equal(qtest_get_arch(), "aarch64")) {
> +        assert_has_feature(qts, "host", "aarch64");
> +        assert_has_feature(qts, "host", "pmu");
> +
> +        assert_error(qts, "cortex-a15",
> +            "We cannot guarantee the CPU type 'cortex-a15' works "
> +            "with KVM on this host", NULL);
> +    } else {
> +        assert_has_not_feature(qts, "host", "aarch64");
> +        assert_has_not_feature(qts, "host", "pmu");

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> +    }
> +
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    bool kvm_available =3D false;
> +
> +    if (!access("/dev/kvm",  R_OK | W_OK)) {
> +#if defined(HOST_AARCH64)
> +        kvm_available =3D g_str_equal(qtest_get_arch(), "aarch64");
> +#elif defined(HOST_ARM)
> +        kvm_available =3D g_str_equal(qtest_get_arch(), "arm");
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
>=20

