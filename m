Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A61C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 21:26:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B0D720842
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 21:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qx9Kmap+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0D720842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k34S0-0004RH-K4
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 17:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k34RB-0003tf-D4
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 17:25:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56205
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k34R7-0003om-Si
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 17:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596576328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PjELvZj9y4r7o3iqmoGzHfXUoUhr5MGeMAAFlsw3ssQ=;
 b=Qx9Kmap+uxY1m1inB3jSY+kK2XBsFpr6ju9tSmtICfB0RzfKt5ynEywzTTlzPIBXfcJmsr
 r4RwOevTdGpfN0qjfL8bK/XPtYFZfvAcuig7qsBXmUpRouDXCIxfmjpfZsfvk9Ewug/F16
 AhymobftzSNh9lRsa5epLSJA9a+gmAc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-xB9k88w6NQO5BRigluO35Q-1; Tue, 04 Aug 2020 17:25:26 -0400
X-MC-Unique: xB9k88w6NQO5BRigluO35Q-1
Received: by mail-qt1-f200.google.com with SMTP id k1so16379612qtp.20
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 14:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PjELvZj9y4r7o3iqmoGzHfXUoUhr5MGeMAAFlsw3ssQ=;
 b=PpVIeOrC5474twXHqFihBCBB9Li/HTjWHZjUHC4ScjHIw5DsBfy+rx2UBQfo05TSnp
 c5N1wpgG/yeH9HpKEmiEudNkQzV89t+9YuBI0rsq1Nor1dkUzpDnf84kQoEjc8Lmi8pB
 EyQPw7hPKNSbBMCTuuGvyYp5xAAKaAgk0b6BuHecF87vFytDaE1SwOuVQ5aB4LaMRsJl
 pP7a9oRJsI3GC5K+2WROoFUuXmCWFYgJ49hPySrH07KYXvT+lbq0DaJUs0B3KitU2SQP
 X1Ltjp1Dvgkfe13iozeXydu6YZATBiDwm3Eof3Ccze+pHmTnz60HbuzLEB1PHaFF4QjA
 NT1g==
X-Gm-Message-State: AOAM531VpopMdxglEysMl2FuFquQ+mA6qxS6oTlalXkd7Cnj+UrplqJM
 wvfQ8Yln2HlUuRaFEtctfS3hHtyDpZVE46Zgw2Se9I93ztanxJlwbS7YmEkybSAVc69CVciN6cF
 tYYZ38QU34aHsVQY=
X-Received: by 2002:a05:620a:7e9:: with SMTP id
 k9mr216277qkk.415.1596576325815; 
 Tue, 04 Aug 2020 14:25:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXCJonDYmB8ie5wdVajx4BN3G50YcofDgzzzQxkUHp2xqKONKexFqIaLg3hFYjl6lLTzsExg==
X-Received: by 2002:a05:620a:7e9:: with SMTP id
 k9mr216260qkk.415.1596576325592; 
 Tue, 04 Aug 2020 14:25:25 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id x29sm168112qtv.80.2020.08.04.14.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 14:25:24 -0700 (PDT)
Date: Tue, 4 Aug 2020 17:25:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/3] virtio,acpi: bugfixes
Message-ID: <20200804172423-mutt-send-email-mst@kernel.org>
References: <20200804141640.591031-1-mst@redhat.com>
 <CAFEAcA_38GRFmdOyxtN+KbO=PtuvRmsgJ2QN0zcpwm4a5Hypmg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_38GRFmdOyxtN+KbO=PtuvRmsgJ2QN0zcpwm4a5Hypmg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 17:25:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 04, 2020 at 06:20:53PM +0100, Peter Maydell wrote:
> On Tue, 4 Aug 2020 at 15:17, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following changes since commit 5c1c3e4f02e458cf280c677c817ae4fd1ed9bf10:
> >
> >   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200803' into staging (2020-08-03 20:34:26 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 5957b49b423fe456896e10f7e4a6c69be07f9407:
> >
> >   virtio-mem: Correct format specifier mismatch for RISC-V (2020-08-04 09:13:34 -0400)
> >
> > ----------------------------------------------------------------
> > virtio,acpi: bugfixes
> >
> > A couple of last minute bugfixes.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ----------------------------------------------------------------
> > Bruce Rogers (1):
> >       virtio-mem: Correct format specifier mismatch for RISC-V
> >
> > Michael S. Tsirkin (2):
> >       i386/acpi: fix inconsistent QEMU/OVMF device paths
> >       arm/acpi: fix an out of spec _UID for PCI root
> 
> 
> I applied your updated pull with just the virtio-mem fix.
> 
> thanks
> -- PMM

Thanks!
OK I think this is a good place to stop. No need to postpone
the rc for the rest of them - not regressions, fixes can wait
until the next release.

-- 
MST


