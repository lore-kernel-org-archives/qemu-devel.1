Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5165C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:43:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D6552067C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOVyd7Um"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6552067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFc1c-0000HZ-E0
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 07:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kFc0g-00084O-2N
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:42:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kFc0d-0001mx-GQ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599565318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Z2mpZ4De4ZPR19fEUl7/NoUb0ZHeWI84J/EbXO4rIA=;
 b=JOVyd7Umo+3qhg1g0Es69el3WLMpw5c4D/Qj/klvm6A1NESR21F/T3WtksR1oN+go71Jpw
 9A5v68nO3ehvYMVxy7kGFBRHlNz/u8w8st7gl8ho5Si3hGLoBCqnfQfQ5VG0PEJ9E6dLaX
 yN46rdthdSO0zx+J8cxRHKfrbjsYpfQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-siLF8DSHNEunU1Hx3zSRbQ-1; Tue, 08 Sep 2020 07:41:55 -0400
X-MC-Unique: siLF8DSHNEunU1Hx3zSRbQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9083801AAB;
 Tue,  8 Sep 2020 11:41:53 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB49A380;
 Tue,  8 Sep 2020 11:41:51 +0000 (UTC)
Date: Tue, 8 Sep 2020 13:41:49 +0200
From: Andrew Jones <drjones@redhat.com>
To: Haibo Xu <haibo.xu@linaro.org>
Subject: Re: [PATCH v2 12/12] target/arm: spe: Add corresponding doc and test.
Message-ID: <20200908114149.tdkns7qwwchsmnbi@kamzik.brq.redhat.com>
References: <cover.1599549462.git.haibo.xu@linaro.org>
 <f85b67a841ad86f461c7dc0c8f5f8b1e5d490da5.1599549462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
In-Reply-To: <f85b67a841ad86f461c7dc0c8f5f8b1e5d490da5.1599549462.git.haibo.xu@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: philmd@redhat.com, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 08, 2020 at 08:13:30AM +0000, Haibo Xu wrote:
> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> ---
>  docs/system/arm/cpu-features.rst | 20 ++++++++++++++++++++
>  target/arm/monitor.c             |  2 +-
>  tests/qtest/arm-cpu-features.c   |  9 +++++++++
>  3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
> index 2d5c06cd01..5b81b9a560 100644
> --- a/docs/system/arm/cpu-features.rst
> +++ b/docs/system/arm/cpu-features.rst
> @@ -344,3 +344,23 @@ verbose command lines.  However, the recommended way to select vector
>  lengths is to explicitly enable each desired length.  Therefore only
>  example's (1), (4), and (6) exhibit recommended uses of the properties.
>  
> +SPE CPU Property
> +==================

Too many '='

> +
> +The SPE CPU property `spe` is used to enable or disable the SPE feature,
> +just as the `pmu` CPU property completely enables or disables the PMU.
> +
> +Currently, this property is only available with KVM mode, and is enabled
> +by default if KVM support it. When KVM is enabled, if the host does not
> +support SPE, then an error is generated when attempting to enable it.
> +
> +Following are 2 examples to use this property:
> +
> +  1) Disable SPE::
> +
> +     $ qemu-system-aarch64 -M virt,accel=kvm -cpu max,spe=off
> +
> +  2) Implicitly enable it with the `host` CPU type if host cpu
> +     support it::

if the host CPU supports it


Actually, I'm not sure we need to document this feature. We didn't bother
documenting pauth, since there wasn't anything special about it and
there's nothing special about this feature either.

> +
> +     $ qemu-system-aarch64 -M virt,accel=kvm -cpu host
> diff --git a/target/arm/monitor.c b/target/arm/monitor.c
> index ba6e01abd0..1b8f08988a 100644
> --- a/target/arm/monitor.c
> +++ b/target/arm/monitor.c
> @@ -99,7 +99,7 @@ QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
>   * then the order that considers those dependencies must be used.
>   */
>  static const char *cpu_model_advertised_features[] = {
> -    "aarch64", "pmu", "sve",
> +    "aarch64", "pmu", "spe", "sve",
>      "sve128", "sve256", "sve384", "sve512",
>      "sve640", "sve768", "sve896", "sve1024", "sve1152", "sve1280",
>      "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
> diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
> index 77b5e30a9c..4d393fb2e2 100644
> --- a/tests/qtest/arm-cpu-features.c
> +++ b/tests/qtest/arm-cpu-features.c
> @@ -494,6 +494,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>  
>      if (g_str_equal(qtest_get_arch(), "aarch64")) {
>          bool kvm_supports_sve;
> +        bool kvm_supports_spe;
>          char max_name[8], name[8];
>          uint32_t max_vq, vq;
>          uint64_t vls;
> @@ -512,8 +513,10 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>              "with KVM on this host", NULL);
>  
>          assert_has_feature(qts, "host", "sve");
> +        assert_has_feature(qts, "host", "spe");
>          resp = do_query_no_props(qts, "host");
>          kvm_supports_sve = resp_get_feature(resp, "sve");
> +        kvm_supports_spe = resp_get_feature(resp, "spe");
>          vls = resp_get_sve_vls(resp);
>          qobject_unref(resp);
>  
> @@ -573,10 +576,16 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>          } else {
>              g_assert(vls == 0);
>          }
> +
> +        if (kvm_supports_spe) {
> +                assert_set_feature(qts, "host", "spe", false);
> +                assert_set_feature(qts, "host", "spe", true);
> +        }
>      } else {
>          assert_has_not_feature(qts, "host", "aarch64");
>          assert_has_not_feature(qts, "host", "pmu");
>          assert_has_not_feature(qts, "host", "sve");
> +        assert_has_not_feature(qts, "host", "spe");
>      }
>  
>      qtest_quit(qts);
> -- 
> 2.17.1
>

Otherwise

Reviewed-by: Andrew Jones <drjones@redhat.com> 


