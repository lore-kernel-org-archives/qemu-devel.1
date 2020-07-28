Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B26C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5378F2074F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CQqRT4Hg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5378F2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0MJ8-0002qI-Kw
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 05:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0MIW-0002P8-9T
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:53:24 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39896)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0MIU-0004e2-Oc
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:53:24 -0400
Received: by mail-ot1-x344.google.com with SMTP id p25so5095855oto.6
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 02:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bIUEUz/EAiYRpt2WF2Gu3Ojb4mqpsyytf7cpodlW4II=;
 b=CQqRT4Hg47XRLF6tzyrfHAQjvIY+LZv/43yt7a/JNKbRATGnHrOMTV3gf3XNXzacat
 j4lsq7sLk9uKTEevI0cAp1OclUpBjMWsvEvMM3f6SIegsYLs/mRnYThdXh9PRMBNYTtC
 Lw+6G+Grdy3uaiMqmudqLMMIBT28tyPKwh3SoWzRgjrwa1YxxMr74aZjM+thdcmWIq2x
 gbN8hJrqU1LLcsS+DB5NRZktQQm6USh1zsHH97h8iyEUvKuWAshY3qiWeQ3ptLyjkLBb
 DHf1eoj3TBVmLnEXe9OW0EMSw5kKemKDAgxtbTGAbTlkKFiNQR2UbicoqFSZ4x1Hw5o9
 AgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bIUEUz/EAiYRpt2WF2Gu3Ojb4mqpsyytf7cpodlW4II=;
 b=S/WaSP9WyS9zs/9GqWHTzK+nZGtIZplHHif5UYEmrKDv4wQUW/4WIPQQvnIYnH+CP/
 Kdl0I59S7Ea9tsTOEX6bLSvpPPVsklOSsMBXdOqiA86LarQ2ER5rDjvoEVw3t/bxee/m
 Wc6DXw/DZLM1H5moCvn2vkbLsXVh3CSzYOeluey8H1agiHe5+DyLLJRQvxrI8RWtTrT/
 mOkLCrNQuRg1U79tlCBNJDT33KL4BSdbu12CXPy02q288NZXlY8zQbLq7cvZHl107+9/
 H8z6BwqHQ238liTPnpbbhLk0f+sfElnMPWqWE8f0PPFMzIpl7JbH7GUmGiK++Gzd7JDK
 uWNQ==
X-Gm-Message-State: AOAM531R/BC68pam2KQnaISwx8P90eCXf+WAaGWhism7wwX0JVQA0pl3
 4pRAQ1aPNTWeHnpMAb3S9GFQtzw1G00jK5rD7/iO5g==
X-Google-Smtp-Source: ABdhPJxvuQZlFISljT+BrSNAaPEtI0usqXjXhKX0zGweSLdhJcx7AtuCM7hYcsi9yHIhzUhOUeI4YgIIiqmVx7n0ny4=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr24370836oto.135.1595930001461; 
 Tue, 28 Jul 2020 02:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200728091828.21702-1-paul@xen.org>
 <CAFEAcA_wKTFWk9Uk5HMabqfa6QkkTAdzBotmnrA_EH1BR4XjYg@mail.gmail.com>
 <32ad0742-bff2-1fbc-2f7a-d078980eb171@redhat.com>
In-Reply-To: <32ad0742-bff2-1fbc-2f7a-d078980eb171@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2020 10:53:10 +0100
Message-ID: <CAFEAcA84fH3aGpbrJoA6S3qJ-FjD3NZMoj0G7jqvRneH_pS6=A@mail.gmail.com>
Subject: Re: [PATCH] configure: define CONFIG_XEN when Xen is enabled
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Paul Durrant <pdurrant@amazon.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 at 10:51, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> I'd rather uninline xen_enabled() but I'm not sure this has perf
> penalties. Paolo is that OK to uninline it?

Can we just follow the same working pattern we already have
for kvm_enabled() etc ?

thanks
-- PMM

