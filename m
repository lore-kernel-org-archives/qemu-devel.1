Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B970C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 19:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95DB2076E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 19:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tBEOMWj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95DB2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnSah-0002JF-1Z
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 15:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnSZx-0001i2-Mo
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 15:58:05 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38730)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnSZv-0004fm-IY
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 15:58:05 -0400
Received: by mail-ot1-x343.google.com with SMTP id 64so3252465oti.5
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 12:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZHtfmO0X2IMDRr3k87n3VRnRH4Q5pS9Wc8iN4phHSsQ=;
 b=tBEOMWj2zXQPq8sw3gMHdaWJy4rCMk8n3EonoWheEVvyce8pfup0DVXxYJwXBChQry
 IHwztsKrWh/ANF/YtfBYGCP4MRiU8M6wwwjFMlNTyZLOlxrb5PINk5O/RL6JHrOhVQsu
 iVn7J44n6pXcUzWyTMWk4RiEagNht1Xf/haBMdg5CLXeSHfcDPp1YlMClSbiSbiHA35M
 X2KwLho9XmrquLRvwSz+WNAASfQLKUbVH5OJB5w/ISqTuX2GzwB+4p4O4Y6iD38vq8Uh
 lFQkHhAOwgoNmWEWQnof3ey5Hrg7R5gQDZlNCzmvm6LeNZai9NM7ejD21WZngX6tH7ys
 4hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZHtfmO0X2IMDRr3k87n3VRnRH4Q5pS9Wc8iN4phHSsQ=;
 b=gaRirLscJ9tOUoF6fi3aNSKtGq99fr3/EcSHdpygK5YFahq2Pyi0/MaunDEdSvBJZy
 LDK35dZHD9dYUcd6fNOMuzy367H6v3rzd5Pt/KnKrRRZFkvp7NMhYWWOkMzWQjh+YNZH
 n3YFHr/3ZWnDDuc4E7vcENFr6d4iTteerDsw+rt4f+cN3jEimIfkxPoIc6ZoOkZaRe/t
 ZZJ2M+m4LH9YpeSlkEbVNt4Zu5lTwOgaSUThAnWu8qsdYB/Zz5xx5S/NIgZqVUvj70dM
 2qiQpA2mUXIJciWHl63/a+3GEcmd2LHR5caSKwJrPPfAHYoki7QvON8S1ZelJ3gAuJvi
 niyw==
X-Gm-Message-State: AOAM531tD4s3gIo/zYAyMwvyxPpDKChzR9hrJ8sCkYFR4CajfO7WbD6x
 L9Zh3Qi4HLtITRkQXQfhC0aZZb7EUJrldPvoxtzzxA==
X-Google-Smtp-Source: ABdhPJx42aJYb+oUAl8Is5zLirmDqBzR+yjUwWTv1Se8OZG27JpQx/I//UVoSo2EhsVTgv+i+icW7+hS8sMJ5n3f/eA=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr14710011otn.221.1592855882151; 
 Mon, 22 Jun 2020 12:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200619095542.2095-1-philmd@redhat.com>
 <20200619114123.7nhuehm76iwhsw5i@kamzik.brq.redhat.com>
In-Reply-To: <20200619114123.7nhuehm76iwhsw5i@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jun 2020 20:57:51 +0100
Message-ID: <CAFEAcA-3keThbaWccv+Rzh4dmnLquSwXMyEOmbMMHgQHM=c-8Q@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Check supported KVM features globally (not
 per vCPU)
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: kvm-devel <kvm@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Haibo Xu <haibo.xu@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jun 2020 at 12:41, Andrew Jones <drjones@redhat.com> wrote:
> Can you also post the attached patch with this one (a two patch series)?

This would be easier to review if you'd just posted it as
a patch with a Based-on: and a note that it needed to be
applied after the bugfix patch. Anyway:

+    /* Enabling and disabling kvm-no-adjvtime should always work. */
     assert_has_feature_disabled(qts, "host", "kvm-no-adjvtime");
+    assert_set_feature(qts, "host", "kvm-no-adjvtime", true);
+    assert_set_feature(qts, "host", "kvm-no-adjvtime", false);

     if (g_str_equal(qtest_get_arch(), "aarch64")) {
         bool kvm_supports_sve;
@@ -475,7 +497,11 @@ static void
test_query_cpu_model_expansion_kvm(const void *data)
         char *error;

         assert_has_feature_enabled(qts, "host", "aarch64");
+
+        /* Enabling and disabling pmu should always work. */
         assert_has_feature_enabled(qts, "host", "pmu");
+        assert_set_feature(qts, "host", "pmu", true);
+        assert_set_feature(qts, "host", "pmu", false);

It seems a bit odd that we do the same "set true, then
set false" sequence whether the feature is enabled or not.
Shouldn't the second one be "set false, then set true" ?

thanks
-- PMM

