Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0E1CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:57:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E322120679
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E322120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMXFF-0007qg-1o
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 08:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMXCm-0004gM-Tx
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMXCl-000682-Ia
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:54:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46992)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMXCl-00067g-9z
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:54:35 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0D05DC04AC69
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 12:54:34 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id l4so4597490wru.10
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 05:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fnNWcF3aH162/o5wr3miNOOP17++hIEoPNCNh7vQ6wc=;
 b=f3U/15kOYxGM4qEdGConR4rv5RMsgpYNbuut+cKRgcEo0xEegAkMqNEyOoSpjjr++/
 5iaucTreHZhO3Amtf/G+G7jQALtkL6aVqq3/4V/q3z7+3IYF1waXvc628bQAu1CDa4ua
 kFB6gzqApEdlCAstzcxXdiKI/xf2NGKddyI5jlLhJWz/6NOI8kQFpdltDeNP04VmdMu6
 gis0tOrNax6HZ8EwQs/jHVKryuPWKFB/OMtpH0Wl4xbz380Z5ZXqFc8UPTeBgApePqSg
 wfvHUkmJ9++DSI7q0ULWRqVI6QK8uc9ZXlQEIeF5SVQPDJDWEa4BN5JjL4OLuSBNwHI1
 n7hg==
X-Gm-Message-State: APjAAAVSrKuKsJ7FyZA2bh/rQQvr9RI3JLMqGQ8ufwghtevL0/MoLHNq
 FeoEIDIe1NKZ1kwOSiyLxT5q2HwemdDcTYuAnkDS9cOrY56l/igL9BWHonpL0swrP/4BsLcJ9S4
 m/BHZQ9RKDWlRWm8=
X-Received: by 2002:a5d:6241:: with SMTP id m1mr20691231wrv.213.1571662472783; 
 Mon, 21 Oct 2019 05:54:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx4heKGyMZ5vc+0RNE05H2szuW3I/S6+GW76cu5P2EjHKHpbxUp6fyYd1k+FnqyD9VneRjX2A==
X-Received: by 2002:a5d:6241:: with SMTP id m1mr20691206wrv.213.1571662472496; 
 Mon, 21 Oct 2019 05:54:32 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id p126sm2005705wme.0.2019.10.21.05.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 05:54:32 -0700 (PDT)
Subject: Re: [PATCH v6 0/9] target/arm/kvm: enable SVE in guests
To: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>
References: <20191016085408.24360-1-drjones@redhat.com>
 <CAFEAcA8pV5batrPk+J6RLU2rv9SNAmL8JS9Kd9tWP3pD-m29eA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3f54f759-9d6d-bf04-85aa-59c1cac31044@redhat.com>
Date: Mon, 21 Oct 2019 14:54:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8pV5batrPk+J6RLU2rv9SNAmL8JS9Kd9tWP3pD-m29eA@mail.gmail.com>
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Dave P Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/19 2:36 PM, Peter Maydell wrote:
> On Wed, 16 Oct 2019 at 09:54, Andrew Jones <drjones@redhat.com> wrote:
>>
>> Since Linux kernel v5.2-rc1 KVM has support for enabling SVE in guests.
>> This series provides the QEMU bits for that enablement. First, we
>> select existing CPU properties representing features we want to
>> advertise in addition to the SVE vector lengths and prepare
>> them for a qmp query. Then we introduce the qmp query, applying
>> it immediately to those selected features. We also document ARM CPU
>> features at this time. We next add a qtest for the selected CPU
>> features that uses the qmp query for its tests - and we continue to
>> add tests as we add CPU features with the following patches. So then,
>> once we have the support we need for CPU feature querying and testing,
>> we add our first SVE CPU feature property, 'sve', which just allows
>> SVE to be completely enabled/disabled. Following that feature property,
>> we add all 16 vector length properties along with the input validation
>> they need and tests to prove the validation works. At this point the
>> SVE features are still only for TCG, so we provide some patches to
>> prepare for KVM and then a patch that allows the 'max' CPU type to
>> enable SVE with KVM, but at first without vector length properties.
>> After a bit more preparation we add the SVE vector length properties
>> to the KVM-enabled 'max' CPU type along with the additional input
>> validation and tests that that needs.  Finally we allow the 'host'
>> CPU type to also enjoy these properties by simply sharing them with it.
> 
> This fails 'make check' on an aarch32 box with KVM support:
> 
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=arm-softmmu/qemu-system-arm QTEST_QEMU_IMG=qemu-img
> tests/arm-cpu-features -m=quick -k --tap < /dev/null |
> ./scripts/tap-driver.pl --test-name="arm-cpu-features"
> PASS 1 arm-cpu-features /arm/arm/query-cpu-model-expansion
> **
> ERROR:/home/pm215/qemu/tests/arm-cpu-features.c:420:test_query_cpu_model_expansion_kvm:
> assertion failed: (resp_has_props(_resp))

Glad you could test it, I was wondering how this test work because it 
first unconditionally assert the host has PMU feature (failing the test) 
then there is a unreachable if(!aarch64) "'pmu' feature not supported" 
warning.

