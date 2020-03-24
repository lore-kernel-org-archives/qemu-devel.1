Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152C1C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEAD220774
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WcPE+ej3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAD220774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGl0X-0000o2-0q
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 10:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGkzm-0000H9-8h
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:57:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGkzl-0007Tl-7J
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:57:34 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:43744)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGkzk-0007S8-S3
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:57:33 -0400
Received: by mail-oi1-x22f.google.com with SMTP id p125so18697266oif.10
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 07:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MbaoIojSv+EmvlRaf9LUk3NxpcMgrQ1cKI+IKrF2Mz4=;
 b=WcPE+ej3G+CbEtDzkdKX/jiPkn6JEW+PULphRstystqsBiQQa/93ya0pOrefA1wV0J
 wn9UF+u3auGwGlPlLYhzAvgdiWwy7aD5LG3gaTueHpqeBYCaJAg3lSJlvaEhlo3EaK93
 /UhR8T92krNy58ye70AfZjna0utibUQ+PzMEn5emtKvT9w+CZmxbVp+3sQPe0ARK6JSQ
 01Muhsq4RSlcO75ilq/6TUxy9CTggIKK41+YJXKb176r7OaSoDZB3Ri4dxKoCRY3X7IT
 gm8zybAjcSsKhdDi1QeDNATNgVQHzdLNQ2M5gfm3QUeohiMMH1CSl7tUdghixJ/q7+ZT
 tSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MbaoIojSv+EmvlRaf9LUk3NxpcMgrQ1cKI+IKrF2Mz4=;
 b=ZoVqK313Vg4l+DyOo4eiYNKRaPISEYUVH6wGxgdTgALCcgG7Is9m/Kio3yoci/wBib
 F98PxfQ1VFLAKwLXbOVNpl5kN8jIaezVHSr6YkegPQiwhWObPNZ9s3nZGngBNIiG/dLC
 n6ZYafuj0n2EDFByHf5jDk5LXsdzcpihy3HSL8UNZpkZnS+Jy/1GTRVaJDyroqxjlCCj
 PgKYaIAHJyDejKDVOIWrRNRnCH2SvsXee0k6k6cydkxj/hbyx8+IyCk7rumIcBntFYSQ
 iOqjWPSr3Sf8PDCOjGvDXdhilUoAcvmyERATQySAC/auINY3hn1k9KVZ3X7+tPzaeAWm
 f/UA==
X-Gm-Message-State: ANhLgQ2faZLjZsXriWWlGFzOVM2TIz5UaHlSEbXWZ/e7Ew+O494Kwe0M
 nYAWgs2tsTC14nEuR3t7A/t+gR+hylnWCgEiSGF9d7vqtVkUHA==
X-Google-Smtp-Source: ADFU+vvoGFMdXQoFyYRvAcpn8TV6D/jz+CNF6QRzay6MHhGcyeK92bebuSJE2sbUq/FEvSwpyLULbFmwU+ihev4sGe0=
X-Received: by 2002:a05:6808:64c:: with SMTP id
 z12mr3541724oih.146.1585061852090; 
 Tue, 24 Mar 2020 07:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200318001932.180617-1-crosa@redhat.com>
 <20200318001932.180617-4-crosa@redhat.com>
In-Reply-To: <20200318001932.180617-4-crosa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2020 14:57:20 +0000
Message-ID: <CAFEAcA9JQbMsQpm30nVb2XQWqV=TYE5nqEEzH4uznG_Rnarorw@mail.gmail.com>
Subject: Re: [PULL 3/6] Acceptance test: add "boot_linux" tests
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
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
Cc: Fam Zheng <fam@euphon.net>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>, Willian Rampazzo <willianr@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 at 00:19, Cleber Rosa <crosa@redhat.com> wrote:
>
> This acceptance test, validates that a full blown Linux guest can
> successfully boot in QEMU.  In this specific case, the guest chosen is
> Fedora version 31.
>
>  * x86_64, pc-i440fx and pc-q35 machine types, with TCG and KVM as
>    accelerators
>
>  * aarch64 and virt machine type, with TCG and KVM as accelerators
>
>  * ppc64 and pseries machine type with TCG as accelerator
>
>  * s390x and s390-ccw-virtio machine type with TCG as accelerator

I have noticed that these seem to slow down 'make check-acceptance'
a lot. At least for arm, the other tests run in check-acceptance take
perhaps 10 or 20 seconds a test. The
"tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg"
test takes about 240 seconds. Is it possible to make it faster ?

thanks
-- PMM

