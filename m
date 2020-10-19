Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B26AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:20:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 654982225A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654982225A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUSHE-000827-6Y
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 06:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kUSGB-0007Z4-BJ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:19:23 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:45031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kUSG9-00066n-52
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=Z763SJkPvSL8IiF0OZtCtvkHrYcMk1vFggig77PRkws=; b=dd5ZnImDGB94esCbwfLDPyBbA8
 UUSPXrZwnu17wMsbcHGX+aSOI1BkPGH/eKJsG6yypqEtT7v4Vij1vhKtdKHdfC5TZ5hhrPsmN2FTV
 J4SpWUv7VFP6orrP96HaTlNoNoNtU7BoVOs5CTn6YLTGg/fdzwcdh87xp1k69QR3+hqM9yI4quLbI
 TUnjD4f5lfTFpwBlkGR9bT+cV4yDmdDDR1qta7o2uBBp7kyAR4J+JDkN7pBrFgu7WhFGwNSBwFAP6
 51c7O0/lF5fUNPr07HtqNPxXZyOdvTu0EUvYK8Qt1nvlShaXj1IFO2g66L8Rzaowt5eWoVMXgzfdy
 0wzHg5LLEbGCE1s1kUQ+m779nwUj/C3zFoteY/wXvw45yhqnk+8t0Oj5/b3lyKzQyqUjQnNw5STo1
 BES14sxA1Ptkjc8DxSPOaY1Fzm9B0aCFMjEtHx/KaBRWCm8BpDDHXPvmj5fm/dSkEwLyo7Ex7UZvr
 D5pYmTt0KRBUXHGHKK22xa59OwFNuWWgXMDnpkpd1oY6ltNTZw4lZZSlm1bIHwtUzr9LnxGRTTSeJ
 pwghkhGOEwyEfWqE5HerSH/Kx+WxhZo5FZzTT8zL8XGAhQEVU9302kmK/WYe27/LDhZ8fBoCQ6Prf
 QIFke5nok4iex/Gp2B2UdbYJUaCL4FkD9hIuHB+CY=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>
Subject: Re: [PULL v2 0/5] 9p queue (previous 2020-10-15)
Date: Mon, 19 Oct 2020 12:19:11 +0200
Message-ID: <3061113.rifjho4eKY@silver>
In-Reply-To: <CAFEAcA8M2n9X0a2bzcc-bZTvh8cMYrQ39mWLUzNAJzkgNe8UFw@mail.gmail.com>
References: <cover.1602943547.git.qemu_oss@crudebyte.com>
 <CAFEAcA8M2n9X0a2bzcc-bZTvh8cMYrQ39mWLUzNAJzkgNe8UFw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 06:19:17
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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

On Montag, 19. Oktober 2020 11:52:38 CEST Peter Maydell wrote:
> On Sat, 17 Oct 2020 at 15:23, Christian Schoenebeck
> 
> <qemu_oss@crudebyte.com> wrote:
> > The following changes since commit 
e12ce85b2c79d83a340953291912875c30b3af06:
> >   Merge remote-tracking branch
> >   'remotes/ehabkost/tags/x86-next-pull-request' into staging (2020-10-16
> >   22:46:28 +0100)> 
> > are available in the Git repository at:
> >   https://github.com/cschoenebeck/qemu.git tags/pull-9p-20201017
> > 
> > for you to fetch changes up to fa4551e3f4416cc8c62086ac430b1ceb4f03eb6b:
> >   tests/9pfs: add local Tmkdir test (2020-10-17 15:58:39 +0200)
> > 
> > ----------------------------------------------------------------
> > 9pfs: add tests using local fs driver
> > 
> > The currently existing 9pfs test cases are all solely using the 9pfs
> > 'synth' fileystem driver, which is a very simple and purely simulated (in
> > RAM only) filesystem. There are issues though where the 'synth' fs driver
> > is not sufficient. For example the following two bugs need test cases
> > running the 9pfs 'local' fs driver:
> > 
> > https://bugs.launchpad.net/qemu/+bug/1336794
> > https://bugs.launchpad.net/qemu/+bug/1877384
> > 
> > This patch set for that reason introduces 9pfs test cases using the 9pfs
> > 'local' filesystem driver along to the already existing tests on 'synth'.
> 
> This emits a lot of new warnings during 'make check':
> 
> PASS 27 qtest-arm: qos-test
> /arm/virt/virtio-mmio/virtio-bus/virtio-9p-device/virtio-9p/virtio-9p-tests/
> local/config qemu-system-arm: warning: 9p: degraded performance: a
> reasonable high msize should be chosen on client/guest side (chosen msize
> is <= 8192). See https://wiki.qemu.org/Documentation/9psetup#msize for
> details. PASS 28 qtest-arm: qos-test
> /arm/virt/virtio-mmio/virtio-bus/virtio-9p-device/virtio-9p/virtio-9p-tests/
> local/create_dir
> 
> PASS 54 qtest-i386: qos-test
> /i386/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p
> -tests/local/config qemu-system-i386: warning: 9p: degraded performance: a
> reasonable high msize should be chosen on client/guest side (chosen msize
> is <= 8192). See https://wiki.qemu.org/Documentation/9psetup#msize for
> details. PASS 55 qtest-i386: qos-test
> /i386/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p
> -tests/local/create_dir
> 
> etc.
> 
> thanks
> -- PMM

One warning per test suite run (i.e. per architecture due to 
warn_report_once()), yes. That performance warning is meant for end user 
installations to remind them setting some (reasonable high) value for 9p 
client parameter 'msize' on guest OS side. The warning triggers here because 
the 9p test cases intentionally run with a small 'msize' to guard edge cases.

Would it be Ok for you to merge it with this performance warning for now? I 
can take care of silencing it before 5.2 release. It probably requires to 
introduce a new CL option to suppress performance warnings like these, or by 
finding a way to detect that we're currently just running qtests.

Best regards,
Christian Schoenebeck



