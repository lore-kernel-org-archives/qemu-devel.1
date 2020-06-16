Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE520C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:29:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E1F20707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E1F20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlFOp-0004iy-Sx
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guilherme.piccoli@canonical.com>)
 id 1jlFAm-0008QV-KS
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:14:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49233)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from <guilherme.piccoli@canonical.com>)
 id 1jlFAk-00004q-Vk
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:14:56 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <guilherme.piccoli@canonical.com>) id 1jlFAi-0000H4-4P
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 17:14:52 +0000
Received: by mail-ed1-f72.google.com with SMTP id dn27so6370940edb.15
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PDViOL291DGwbnt+0FCFMMRB59e44btmcQ5NQEcXP4w=;
 b=nG+qQbwf1j6w/AUlU0Go8OP7x9PHyJMAijR4LRO7ifFyiVfNCvDPv5QMMJtFLwhUIl
 UCFKU3ZvFi9ktG7AfX/4uFucvjtiMaQCt/WapipCdn/s0n0I3/+KVonZ10sYdbakTf4a
 abe46JyLT8Gk3bhBod3Kd2ddMKRqk80j6YNgJfVIDl/4pzRoBE5mUrNOKWlYDb0pwEzm
 KBC3S7jDX8yPrceokVfxM34C/C6CzA1+Jfr//vvVO1W/e+fqDmjj1Dt0KEEIUpmofMRv
 kjGki16xphh+VCqX/CzQxyXlavgEq/h5E1fJyCc+o/c3m2Rr97hvFiFkOatcC/bhP+NC
 OTHg==
X-Gm-Message-State: AOAM530J0HtxJre0gZP3SWqXy2wSyCTD0XkGkTJVz7oEdYh7hchpreUk
 s2y1LLh7l7brklu0DRGYtElvuq6yb5kRLMnSP1ogGLJTjmu2mWkyaQWMGmeddzo5pA2sOOzDJKo
 ieOqZWQLtE5SBSnTYXH3E2ycCTBIvjATULmIcNv6FvmwpXqB/
X-Received: by 2002:a05:6402:b13:: with SMTP id
 bm19mr3613993edb.82.1592327691789; 
 Tue, 16 Jun 2020 10:14:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOdRW7u3iepFLKAs3HwF1AOaLn5KMxEAVNFBac1UHIChvFbU2hYes9oYIzQaHYiHgN8iqG4JoGDcj32ES2BM4=
X-Received: by 2002:a05:6402:b13:: with SMTP id
 bm19mr3613974edb.82.1592327691593; 
 Tue, 16 Jun 2020 10:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <99779e9c-f05f-501b-b4be-ff719f140a88@canonical.com>
 <20200616165043.24y2cp53axk7uggy@sirius.home.kraxel.org>
 <20200616165746.GH2788@work-vm>
In-Reply-To: <20200616165746.GH2788@work-vm>
From: Guilherme Piccoli <gpiccoli@canonical.com>
Date: Tue, 16 Jun 2020 14:14:15 -0300
Message-ID: <CAHD1Q_zGu4Q63HjHx3aZKu3wh8NppuP6T4kgnUN3j=-ZDufVZA@mail.gmail.com>
Subject: Re: ovmf / PCI passthrough impaired due to very limiting PCI64
 aperture
To: Gerd Hoffmann <kraxel@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=91.189.89.112;
 envelope-from=guilherme.piccoli@canonical.com; helo=youngberry.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 11:16:23
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Pedro Principeza <pedro.principeza@canonical.com>, ehabkost@redhat.com,
 Dann Frazier <dann.frazier@canonical.com>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>, lersek@redhat.com,
 fw@gpiccoli.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks Gerd, Dave and Eduardo for the prompt responses!

So, I understand that when we use "-host-physical-bits", we are
passing the *real* number for the guest, correct? So, in this case we
can trust that the guest physbits matches the true host physbits.

What if then we have OVMF relying in the physbits *iff*
"-host-phys-bits" is used (which is the default in RH and a possible
machine configuration on libvirt XML in Ubuntu), and we have OVMF
fallbacks to 36-bit otherwise?

Now, regarding the problem "to trust or not" in the guests' physbits,
I think it's an orthogonal discussion to some extent. It'd be nice to
have that check, and as Eduardo said, prevent migration in such cases.
But it's not really preventing OVMF big PCI64 aperture if we only
increase the aperture _when  "-host-physical-bits" is used_.

Thanks,


Guilherme

