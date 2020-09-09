Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3DDC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 03:20:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 562F220708
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 03:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lvASdAnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562F220708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFqfE-0003cz-Gx
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 23:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFqeW-0002p6-5G
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 23:20:08 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:44764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFqeU-0007RR-9J
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 23:20:07 -0400
Received: by mail-io1-xd41.google.com with SMTP id g128so1620400iof.11
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 20:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2zPQO5AQ4HhpoQb9HMnUh3AE8e9auFs4KQT3/apDvk8=;
 b=lvASdAnwR2B5iT72Rf7oF6AnFcPOB4qjnQurOEZoDYv3p6HnDwGnqkgLvRnMKOhP/N
 DtokjzoIWqVXNCbuN9GQafobifMNwSFUrranFobEDMeMVxTXIdG1iudePTI4h3W8ZA8J
 rDXzB3fDvdjbP4ekuVS/QEg8c39hmVTzplaDT4qDO6L1mzuJ/rM1zEPd/4fFAf8DlLma
 2t8k/NZlnvY7BAs5bYgGo0GcSRVJN+PtANcb9POeum7NrCPlXf1+qxv2bENHPoLVJe9Q
 ovhtMMnljYyZnE4L9f8Hd/XnuLSpMfGXeTrqvmqdvVtiHb4t9wURfShvaC2o4Bvght2V
 nCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2zPQO5AQ4HhpoQb9HMnUh3AE8e9auFs4KQT3/apDvk8=;
 b=f28nLMvsTXB3SUmlLw8WoRviOy6PjPU3pIhud552754hPS+/Gu6nT+zrnp9GYfBxqA
 B8QGTHStj6F4Oh7Dn5O1pBwlMpYoJxfC/bc/bRmknPeZwkq2RaGCIPZ41VhME5Uja+jJ
 lItpE5RKGgWlIhA6w79tpJsgvWEcvHf+L2uWlqLlWBiR+ylF6ITkObu7F7b/mMkyCFgI
 Fai5l/ah7AVaQxgcfZTMVatCODMaXsf1cpsn61vhKTQFlTTzJfSc6X4JhXmhNHySM2bz
 HwxWKnFCbGOgQWszSVgD3UjJ7/FLMV4vkz54gZ/Ku8WlKnGXdqolbgPCQGZAYaA1oHj2
 UrLQ==
X-Gm-Message-State: AOAM531sv9TxLFskBsKOCIyhK8g3tD9Me7E+LSbR7GA+sOnKCncjFCX+
 7UtdcWJY4kW/Q/81yrTQlK40ozli1WuY7v/0AwHK
X-Google-Smtp-Source: ABdhPJxuVNIAzW1uE13hSYOU4e9jFoLOAxs29DYTYFofAt4XjldeXFFsMMa5vKFMxD5c6AxKNgBxwWKL5EMOl8SkTis=
X-Received: by 2002:a02:4b07:: with SMTP id q7mr2263949jaa.84.1599621604974;
 Tue, 08 Sep 2020 20:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599549462.git.haibo.xu@linaro.org>
 <f85b67a841ad86f461c7dc0c8f5f8b1e5d490da5.1599549462.git.haibo.xu@linaro.org>
 <20200908114149.tdkns7qwwchsmnbi@kamzik.brq.redhat.com>
In-Reply-To: <20200908114149.tdkns7qwwchsmnbi@kamzik.brq.redhat.com>
From: Haibo Xu <haibo.xu@linaro.org>
Date: Wed, 9 Sep 2020 11:19:54 +0800
Message-ID: <CAJc+Z1Fqc4wTXE56naZ0s7eQGjV1_23C6Qa=n9_8euyZgUioUA@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] target/arm: spe: Add corresponding doc and test.
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=haibo.xu@linaro.org; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: philmd@redhat.com, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 8 Sep 2020 at 19:41, Andrew Jones <drjones@redhat.com> wrote:
>
> On Tue, Sep 08, 2020 at 08:13:30AM +0000, Haibo Xu wrote:
> > Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> > ---
> >  docs/system/arm/cpu-features.rst | 20 ++++++++++++++++++++
> >  target/arm/monitor.c             |  2 +-
> >  tests/qtest/arm-cpu-features.c   |  9 +++++++++
> >  3 files changed, 30 insertions(+), 1 deletion(-)
> >
> > diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
> > index 2d5c06cd01..5b81b9a560 100644
> > --- a/docs/system/arm/cpu-features.rst
> > +++ b/docs/system/arm/cpu-features.rst
> > @@ -344,3 +344,23 @@ verbose command lines.  However, the recommended way to select vector
> >  lengths is to explicitly enable each desired length.  Therefore only
> >  example's (1), (4), and (6) exhibit recommended uses of the properties.
> >
> > +SPE CPU Property
> > +==================
>
> Too many '='
>
> > +
> > +The SPE CPU property `spe` is used to enable or disable the SPE feature,
> > +just as the `pmu` CPU property completely enables or disables the PMU.
> > +
> > +Currently, this property is only available with KVM mode, and is enabled
> > +by default if KVM support it. When KVM is enabled, if the host does not
> > +support SPE, then an error is generated when attempting to enable it.
> > +
> > +Following are 2 examples to use this property:
> > +
> > +  1) Disable SPE::
> > +
> > +     $ qemu-system-aarch64 -M virt,accel=kvm -cpu max,spe=off
> > +
> > +  2) Implicitly enable it with the `host` CPU type if host cpu
> > +     support it::
>
> if the host CPU supports it
>
>
> Actually, I'm not sure we need to document this feature. We didn't bother
> documenting pauth, since there wasn't anything special about it and
> there's nothing special about this feature either.
>

Yes, there is no special treatment for this feature, and it just
follows the syntax
of other vCPU features. Will remove this doc in v3.
Anyway, thanks so much for the review!

Regards,
Haibo

> > +
> > +     $ qemu-system-aarch64 -M virt,accel=kvm -cpu host
> > diff --git a/target/arm/monitor.c b/target/arm/monitor.c
> > index ba6e01abd0..1b8f08988a 100644
> > --- a/target/arm/monitor.c
> > +++ b/target/arm/monitor.c
> > @@ -99,7 +99,7 @@ QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
> >   * then the order that considers those dependencies must be used.
> >   */
> >  static const char *cpu_model_advertised_features[] = {
> > -    "aarch64", "pmu", "sve",
> > +    "aarch64", "pmu", "spe", "sve",
> >      "sve128", "sve256", "sve384", "sve512",
> >      "sve640", "sve768", "sve896", "sve1024", "sve1152", "sve1280",
> >      "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
> > diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
> > index 77b5e30a9c..4d393fb2e2 100644
> > --- a/tests/qtest/arm-cpu-features.c
> > +++ b/tests/qtest/arm-cpu-features.c
> > @@ -494,6 +494,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
> >
> >      if (g_str_equal(qtest_get_arch(), "aarch64")) {
> >          bool kvm_supports_sve;
> > +        bool kvm_supports_spe;
> >          char max_name[8], name[8];
> >          uint32_t max_vq, vq;
> >          uint64_t vls;
> > @@ -512,8 +513,10 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
> >              "with KVM on this host", NULL);
> >
> >          assert_has_feature(qts, "host", "sve");
> > +        assert_has_feature(qts, "host", "spe");
> >          resp = do_query_no_props(qts, "host");
> >          kvm_supports_sve = resp_get_feature(resp, "sve");
> > +        kvm_supports_spe = resp_get_feature(resp, "spe");
> >          vls = resp_get_sve_vls(resp);
> >          qobject_unref(resp);
> >
> > @@ -573,10 +576,16 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
> >          } else {
> >              g_assert(vls == 0);
> >          }
> > +
> > +        if (kvm_supports_spe) {
> > +                assert_set_feature(qts, "host", "spe", false);
> > +                assert_set_feature(qts, "host", "spe", true);
> > +        }
> >      } else {
> >          assert_has_not_feature(qts, "host", "aarch64");
> >          assert_has_not_feature(qts, "host", "pmu");
> >          assert_has_not_feature(qts, "host", "sve");
> > +        assert_has_not_feature(qts, "host", "spe");
> >      }
> >
> >      qtest_quit(qts);
> > --
> > 2.17.1
> >
>
> Otherwise
>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
>

