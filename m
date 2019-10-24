Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6869CA9EBB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7454220679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KRjr7LZh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7454220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeIO-0000WH-0l
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNdNv-0002nj-GH
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNdNu-00064c-6z
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:42:39 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNdNu-00064K-2X
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:42:38 -0400
Received: by mail-ot1-x343.google.com with SMTP id d8so9486206otc.7
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 06:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CB+2oiFbxh4lSMQlG0CPRGf4bWxa5qmoD5xmiQFW3NM=;
 b=KRjr7LZhZ3xQVBJmnk74lxWhxgchqIZXDFOBUZ4r+GaYd6gCXgf6nPEkp192Q9Vx1s
 0tzO8pLrrbO9D1ByOyW2OcRY4I2oFjaClTt8yJB0i1DL4v29GVkecDt+xiCVpnoeweLF
 1w7G8JWWPFsyysBhr3QI+IQXXS5Pk44e+SdKvkMxHy7/QGwLRqGFWxAyh+OgU2dzMIfx
 JYe6RJwYXBXZ88ZJGmMq+rib3kb4dXSLLA7qJgVb/cRDEkDrMfC++HSlgYKWnOSe0/7G
 SDDrCnDDWXS2t1zyHgj0MG66YY2YC7QpH9pwFnwqwA6uaS9xR+ez+RcquGcFZHgma5Hc
 wdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CB+2oiFbxh4lSMQlG0CPRGf4bWxa5qmoD5xmiQFW3NM=;
 b=loszibp5hhsI68almBkUO5DOioPttQsHy3qOJbJJTCsjF6+9h3jhdn1SQpaEdcivs9
 IazULet9skmgeXNM1RAwOmHwCgl3r/1WzCMB8EoDmC3x3i4W8EO5Sk4TG0WBJ7INAFVG
 RzbFkvjKv9vhjdfrl3QEFcd3kH0DMmRkvjGIYBvJWBs91pxYLm0y/++aFinS069t2mR2
 BGrZjg4RTBHkFTqq6F2yupNxnrxUlWVmU/QceuQLQIAzfKmoU3coPbtA8IKnWsYiSi/E
 +KUP2JvvUlUyjOjdeZJCdxlyrhmwEyjrz9OR4Vac0aY21Iw7D4ZeSTp4MLs7eMPKTIgm
 ZbCA==
X-Gm-Message-State: APjAAAXVjpXgjyzJRE0tAipcWKxobEq9rPXt8f9sAVTsQgSSdCevJFkI
 bZy0kG1p7rMsswtvdaowsopkCE9x6riQ3KAR5XuUYw==
X-Google-Smtp-Source: APXvYqzVbdw0wum9mFXZ6RXQ2LWQNQ+bvYqE3mpbTXd9JXDR7Y+0mF6EjROoE54s9vTawNilbLB9rxTSkee9pSsiAQ4=
X-Received: by 2002:a9d:398a:: with SMTP id y10mr11136759otb.97.1571924556987; 
 Thu, 24 Oct 2019 06:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191024121808.9612-1-drjones@redhat.com>
In-Reply-To: <20191024121808.9612-1-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Oct 2019 14:42:25 +0100
Message-ID: <CAFEAcA9ehcuktCTGR0xpTvZegUkr99H62F_fiT7RY_L_dqgN4g@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] target/arm/kvm: enable SVE in guests
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: m.mizuma@jp.fujitsu.com, Beata Michalska <beata.michalska@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Dave P Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 24 Oct 2019 at 13:18, Andrew Jones <drjones@redhat.com> wrote:
>
> Since Linux kernel v5.2-rc1 KVM has support for enabling SVE in guests.
> This series provides the QEMU bits for that enablement. First, we
> select existing CPU properties representing features we want to
> advertise in addition to the SVE vector lengths and prepare
> them for a qmp query. Then we introduce the qmp query, applying
> it immediately to those selected features. We also document ARM CPU
> features at this time. We next add a qtest for the selected CPU
> features that uses the qmp query for its tests - and we continue to
> add tests as we add CPU features with the following patches. So then,
> once we have the support we need for CPU feature querying and testing,
> we add our first SVE CPU feature property, 'sve', which just allows
> SVE to be completely enabled/disabled. Following that feature property,
> we add all 16 vector length properties along with the input validation
> they need and tests to prove the validation works. At this point the
> SVE features are still only for TCG, so we provide some patches to
> prepare for KVM and then a patch that allows the 'max' CPU type to
> enable SVE with KVM, but at first without vector length properties.
> After a bit more preparation we add the SVE vector length properties
> to the KVM-enabled 'max' CPU type along with the additional input
> validation and tests that that needs.  Finally we allow the 'host'
> CPU type to also enjoy these properties by simply sharing them with it.
>



Applied to target-arm.next, thanks.

-- PMM

