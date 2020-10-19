Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E356C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3497E207DE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="BskcB6OF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3497E207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUSPP-00047l-Pc
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 06:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kUSO2-0002sy-Dz
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:27:30 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:33609)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kUSNx-0007Ao-IZ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=/kEccZ+QUrD85z8nudym2ujzklAeIj3kV4qpxbNxADk=; b=BskcB6OFfOE+5geGuHQ+PE7v+i
 wH7mKhJRjTaDe+riUb7E4bjHEq3lionTuMETxGHIecMgX971zAfWeuQBnr8nKNvcpasjc7ChhzAMT
 YRvw0CmFe/GGVAeV9BkYc5A7CoGN1Envvv2m2m35ptV/ap1BEE1JSnzjkDF822M1WFsf//3WbKBfm
 BKi6B6cXKgbc+cfyIMsHAFIlWPsM49Lmqtx9QezMlpnqu9uGaDxdx2Sc8Yza8jho/+aK7iuhkl16P
 zHNhWLUPt+qjQAyPLYlqfS/U4JL38Y7kpIqBV8+mSlXXKu6jdiOIADkFkiYT4oZAqIwwKViFL+Hv5
 TqUxZABw==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>
Subject: Re: [PULL v2 0/5] 9p queue (previous 2020-10-15)
Date: Mon, 19 Oct 2020 12:27:21 +0200
Message-ID: <3471677.uDMLW391hT@silver>
In-Reply-To: <CAFEAcA_1AcW9n949HXtX6QOmYvTRLcMb_PXLtKSG77s=zdzkwg@mail.gmail.com>
References: <cover.1602943547.git.qemu_oss@crudebyte.com>
 <3061113.rifjho4eKY@silver>
 <CAFEAcA_1AcW9n949HXtX6QOmYvTRLcMb_PXLtKSG77s=zdzkwg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 06:27:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Montag, 19. Oktober 2020 12:22:47 CEST Peter Maydell wrote:
> On Mon, 19 Oct 2020 at 11:19, Christian Schoenebeck
> 
> <qemu_oss@crudebyte.com> wrote:
> > On Montag, 19. Oktober 2020 11:52:38 CEST Peter Maydell wrote:
> > > This emits a lot of new warnings during 'make check':
> > > 
> > > PASS 27 qtest-arm: qos-test
> > > /arm/virt/virtio-mmio/virtio-bus/virtio-9p-device/virtio-9p/virtio-9p-te
> > > sts/ local/config qemu-system-arm: warning: 9p: degraded performance: a
> > > reasonable high msize should be chosen on client/guest side (chosen
> > > msize is <= 8192). See
> > > https://wiki.qemu.org/Documentation/9psetup#msize for details. PASS 28
> > > qtest-arm: qos-test
> > > /arm/virt/virtio-mmio/virtio-bus/virtio-9p-device/virtio-9p/virtio-9p-te
> > > sts/ local/create_dir
> > > 
> > > PASS 54 qtest-i386: qos-test
> > > /i386/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virti
> > > o-9p -tests/local/config qemu-system-i386: warning: 9p: degraded
> > > performance: a reasonable high msize should be chosen on client/guest
> > > side (chosen msize is <= 8192). See
> > > https://wiki.qemu.org/Documentation/9psetup#msize for details. PASS 55
> > > qtest-i386: qos-test
> > > /i386/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virti
> > > o-9p -tests/local/create_dir
> > 
> > One warning per test suite run (i.e. per architecture due to
> > warn_report_once()), yes. That performance warning is meant for end user
> > installations to remind them setting some (reasonable high) value for 9p
> > client parameter 'msize' on guest OS side. The warning triggers here
> > because the 9p test cases intentionally run with a small 'msize' to guard
> > edge cases.
> > 
> > Would it be Ok for you to merge it with this performance warning for now?
> > I
> > can take care of silencing it before 5.2 release. It probably requires to
> > introduce a new CL option to suppress performance warnings like these, or
> > by finding a way to detect that we're currently just running qtests.
> 
> The usual approach is to suppress this kind of warning by guarding
> it with if (qtest_enabled()) { ... }.

Ah, didn't see that one. I do that and resend, thanks!

Best regards,
Christian Schoenebeck



