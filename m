Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F50C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:41:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDAAA21527
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAAA21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlb87-0006ft-4f
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 12:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guilherme.piccoli@canonical.com>)
 id 1jlb7O-0005jG-7O
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:40:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60783)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from <guilherme.piccoli@canonical.com>)
 id 1jlb7M-00054U-EP
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:40:53 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <guilherme.piccoli@canonical.com>) id 1jlb7K-0007h1-EP
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 16:40:50 +0000
Received: by mail-ed1-f70.google.com with SMTP id y5so1177022edw.19
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 09:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KCM+DMwzX69mYMF1ekYUpzRR5/NdlG4jHAJPY5TCtcg=;
 b=jd0b+5cCaGrTXTZxFQV18t9GYrRGERzbeleUuKYkxAlKW3Vw6hVXrrsuSp69pzs44W
 m6r30GkxgiizAfsaORwhOz01q28R0GlvNaKJ6cxbY3LAhq5wL2G8CoJCgovPMPAk31jB
 aOOraIQKv0DTe10Av7bKJlP5yKWxuZP3yT1smZAYxo7UYrXbhh35XPOdTELH+7FsqmWS
 +v34f9ZPQ9bBobOHerm8+LzkXLx9H1PI5bngBRYBQ6SoV8vbO+fHUFp6jfMbCMEa4uwh
 ioPYr56AooI3xDt8aRPjrdouS91nv7yL8aOU6+HTYMoZhBshKWRQ9yiPFE1bBN+joiW6
 L5xw==
X-Gm-Message-State: AOAM533xjJIDldubUFoWyk48LlOOL3B1hvQCbF3tnAXC7q8sgDPT029o
 ItZN2oC8YHHLzgOY8i8SOj2wGQ8G7f8i0IHthIn6IqgExhvgKvL8Ee76wKebgXG4NDblQ74sagF
 F5lncaNmzgk43NLBtocP+8i0BWb6kuLjttIrfkQnnf7NJCXy7
X-Received: by 2002:a17:906:5602:: with SMTP id
 f2mr8101171ejq.381.1592412050135; 
 Wed, 17 Jun 2020 09:40:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkky3qvr8qiiPIfrrL2NIm490Gfmod0WExOhAZwMSCyf26UoJ3lFF20mrB7ztdyOdVnv0CSQoC1nt/w7TGdkY=
X-Received: by 2002:a17:906:5602:: with SMTP id
 f2mr8101145ejq.381.1592412049955; 
 Wed, 17 Jun 2020 09:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <99779e9c-f05f-501b-b4be-ff719f140a88@canonical.com>
 <20200616165043.24y2cp53axk7uggy@sirius.home.kraxel.org>
 <20200616165746.GH2788@work-vm>
 <CAHD1Q_zGu4Q63HjHx3aZKu3wh8NppuP6T4kgnUN3j=-ZDufVZA@mail.gmail.com>
 <b423f4a4-2552-bdc8-7c9f-41f200aef672@redhat.com>
 <20200617134652.GE2776@work-vm>
 <20200617154959.GZ2366737@habkost.net>
 <CAHD1Q_z7E79HwCeFEg8yQOUGsOZRQuhL-zc4RXJdubT3eYp+NA@mail.gmail.com>
 <20200617163308.GE2366737@habkost.net>
In-Reply-To: <20200617163308.GE2366737@habkost.net>
From: Guilherme Piccoli <gpiccoli@canonical.com>
Date: Wed, 17 Jun 2020 13:40:14 -0300
Message-ID: <CAHD1Q_xJD5X4Qmbu=CLRTzmdFHnhe57g8EA=vKs7th62LYtHKg@mail.gmail.com>
Subject: Re: ovmf / PCI passthrough impaired due to very limiting PCI64
 aperture
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=91.189.89.112;
 envelope-from=guilherme.piccoli@canonical.com; helo=youngberry.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 11:58:29
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
Cc: Pedro Principeza <pedro.principeza@canonical.com>,
 Dann Frazier <dann.frazier@canonical.com>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 fw@gpiccoli.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Awesome, thanks a bunch Eduardo!

On Wed, Jun 17, 2020 at 1:33 PM Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Wed, Jun 17, 2020 at 12:57:52PM -0300, Guilherme Piccoli wrote:
> > Can't qemu reads the host physical bits and pass that as fw_cfg as
> > "real_host_physbits" or something like that?
> > OVMF could rely on that - if such property is available, we use it to
> > extend the PCI64 aperture.
>
> Giving a exact "real host physbits" value would be too limiting
> if we still want to allow migration to smaller hosts.  But we can
> provide extra information on CPUID or fw_cfg, yes.
>
> I will try to write down a proposal to extend the KVM CPUID leaf
> to provide extra information about MAXPHYADDR guarantees.
>
> --
> Eduardo
>

