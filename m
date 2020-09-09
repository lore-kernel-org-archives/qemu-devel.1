Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91982C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B4F20757
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtKGcBP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B4F20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFzZG-0004vW-2X
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 08:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kFzY4-0004Nq-OB
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 08:50:04 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:46158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kFzY2-0000Ep-VU
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 08:50:04 -0400
Received: by mail-oi1-x234.google.com with SMTP id u126so2172849oif.13
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 05:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=LMhfptro8pecsthlx3C45tcBkcjSZHqChmJAbPhxxn8=;
 b=WtKGcBP4uYXqZXXNwx7iOjLR+v9hp2amFQ3YXYetSYfWEwbJA6B7Y2N5LzaMGk5tkm
 F0T6jpedRQlM62+4A96GiDRnpi0KiQ7u3RIc8teM5yGhy/JPFhQOQ4fs+pjoN9+d1R82
 cTsuH/wnH3scLOWCZsJxZWoFW0UxLKB71yYslKe1mMQiu7gDsIGuVCB4FpY5utDRTfH1
 ZJ4Nqdmum0JAwumVoAIjfxN90DBM6OUvqzQ/k0RJu5KdiaMdMizdcFOxDflCSwjsAyYA
 CbjQE8epoMbFYIQyFQqJJdxANNZQgLZyMZWxLp/5BouN3w/UzlOK7qlubyMt7wtCfiep
 muFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=LMhfptro8pecsthlx3C45tcBkcjSZHqChmJAbPhxxn8=;
 b=q4pmXWlbj8IpXRl1rgil4cUnSchDVdieJPE7iaHsBnfMZl83F2M2EHhKXTBwdJCcRa
 7+DHZQXeSykQCEIeP8tC6nowGzew8wYodbB4o1moA7WaeoY1CYRNQyyhMaRGnftjf+gA
 Y9kG20IEHEiQIZsfvy36KSz29WMq8jtVgkj/DRZ6Kvm/VmbO4bmgEWVpRDavK4JQj10P
 4cAumhjOuKHEy5bRL8CVyYCjstYVE2dNKOUAy7Gu+faLA29DAzwk5U7NDgOyHynQx4tJ
 3Y0FxZnXmgNg/2M+DigBvOizvlrRAG4Bz7S6gJZ5ku4neJDl+Ikxx+jserSuqyy/Orrd
 48tw==
X-Gm-Message-State: AOAM532XhWT8FSZD0FB16k/KIU+9C0BMvSj+20Vwa9zLunzHxVghySlD
 l3MAYzFJx3U5wEsT8flTy7jcJr1clRVQzyaqdXU=
X-Google-Smtp-Source: ABdhPJxrxLT/oNWTjovSu4/T90kA1O1hNQpJB4wlNctOrJDpZiwIP7YHKa1QLR+bkvN8mGo4+8EFseRF4c90p6JVBRY=
X-Received: by 2002:aca:904:: with SMTP id 4mr518098oij.97.1599655801120; Wed,
 09 Sep 2020 05:50:01 -0700 (PDT)
MIME-Version: 1.0
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 9 Sep 2020 20:49:25 +0800
Message-ID: <CAKXe6SJWAt8U-UmCqgtMwt-moL6MAtV5BpBiaM=BN92mQN0Z2g@mail.gmail.com>
Subject: Does. there exists race condition in virtio-gpu device
To: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x234.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Gerd and Paolo,

I think there is a race condition in virtio-gpu device.
In 'virtio_gpu_reset' and 'virtio_gpu_process_cmdq' they both operate
on 'g->cmdq'.

However the 'virtio_gpu_reset' is in vcpu thread and the
'virtio_gpu_process_cmdq' is
in main thread through BH.

So I think there is a race condition. But I don't find a pattern for
this kind of bug(BH and vcpu thread). I missed anything?

Thanks,
Li Qiang

