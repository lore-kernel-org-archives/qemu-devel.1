Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEC7C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0367F23CEC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0367F23CEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55390 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYCdP-0007up-66
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 12:50:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYCce-0007cF-Cf
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYCcd-0007YN-0A
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:49:16 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hYCcc-0007Ov-SR
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:49:14 -0400
Received: by mail-qt1-f193.google.com with SMTP id y57so14583588qtk.4
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 09:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=LgdxTYgP2nRKjfbPjtCA+hB51r4kmvgOS8L6jNjr2l0=;
	b=VUIqX57SsCn0tmW2cWjEUhTEml+162ToaWOBGUQhQu6/509kfD4NpH/kwYAb7XyVtP
	PhGlOjTgN0tgu1dmgIKV2UCP2brFDrlu1RnA67sLELYhw8MAPDSrsAT3/kCYlqdS2KOZ
	09pjnkdzsIELPdF+tmUXeD1I57rEY+5artusNjHpgYNAImAkFvKKw+90mRPq/2E0qwcl
	cqi0n/T73vNs2+rA+uaOAz4fiosOuhd70p59KzRF1808VPyaag36a9XNYInieW2dBKhJ
	H23LAxqkyczlV+Lcluq3N/4V1NBtEVLiQoX0mswy4zoI2x1xWuSclgGNnOST+D9nxtui
	mtNQ==
X-Gm-Message-State: APjAAAVXgkZykpfLvAkzz/eZJVFsyG8L9+bu6r2rk5xc6jxjl8nLogL7
	9XqqoEZXZ0Oben/eqVDTE+eARA==
X-Google-Smtp-Source: APXvYqyWNfH1rlwS1Ur2vywYWjX/MOHIjKh/j1OeF9eZCSe5zT9zUq7HyRLQZ189FkkyTsyEWUGrvg==
X-Received: by 2002:a0c:9499:: with SMTP id j25mr28284056qvj.155.1559666938723;
	Tue, 04 Jun 2019 09:48:58 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103])
	by smtp.gmail.com with ESMTPSA id s8sm9497043qkm.45.2019.06.04.09.48.56
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 04 Jun 2019 09:48:57 -0700 (PDT)
Date: Tue, 4 Jun 2019 12:48:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190604122506-mutt-send-email-mst@kernel.org>
References: <20190603180807.16140-1-mst@redhat.com>
	<CAFEAcA8zMLAs6-ssLhsKBfhRECzADUzpKWw+_jgJhQz0BnxciQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8zMLAs6-ssLhsKBfhRECzADUzpKWw+_jgJhQz0BnxciQ@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.193
Subject: Re: [Qemu-devel] [PULL v2 00/14] virtio, pci, pc: cleanups, features
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 04, 2019 at 04:57:00PM +0100, Peter Maydell wrote:
> On Mon, 3 Jun 2019 at 19:08, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following changes since commit 8c1ecb590497b0349c550607db923972b37f6963:
> >
> >   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-280519-2' into staging (2019-05-28 17:38:32 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to df7cafdeb68b6572fa81d2be9a1910547c4dfafc:
> >
> >   bios-tables-test: list all tables that differ (2019-06-03 08:05:43 -0400)
> >
> > ----------------------------------------------------------------
> > virtio, pci, pc: cleanups, features
> >
> > stricter rules for acpi tables: we now fail
> > on any difference that isn't whitelisted.
> >
> > vhost-scsi migration.
> >
> > some cleanups all over the place
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ----------------------------------------------------------------
> 
> 
> Hi; I'm afraid this fails 'make check' on my aarch32 build:
> 
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=i386-softmmu/qemu-system-i386
> QTEST_QEMU_IMG=qemu-img tests/bios-tables-test -m=quick -k --tap <
> /dev/null | ./scripts/tap-driver.pl --test-name="bios-tables-test"
> 
> Looking for expected file 'tests/data/acpi/pc/FACP'
> Using expected file 'tests/data/acpi/pc/FACP'
> Looking for expected file 'tests/data/acpi/pc/APIC'
> Using expected file 'tests/data/acpi/pc/APIC'
> Looking for expected file 'tests/data/acpi/pc/HPET'
> Using expected file 'tests/data/acpi/pc/HPET'
> Looking for expected file 'tests/data/acpi/pc/FACS'
> Using expected file 'tests/data/acpi/pc/FACS'
> Looking for expected file 'tests/data/acpi/pc/DSDT'
> Using expected file 'tests/data/acpi/pc/DSDT'
> PASS 1 bios-tables-test /i386/acpi/piix4
> 
> Looking for expected file 'tests/data/acpi/q35/FACP'
> Using expected file 'tests/data/acpi/q35/FACP'
> Looking for expected file 'tests/data/acpi/q35/APIC'
> Using expected file 'tests/data/acpi/q35/APIC'
> Looking for expected file 'tests/data/acpi/q35/HPET'
> Using expected file 'tests/data/acpi/q35/HPET'
> Looking for expected file 'tests/data/acpi/q35/MCFG'
> Using expected file 'tests/data/acpi/q35/MCFG'
> Looking for expected file 'tests/data/acpi/q35/FACS'
> Using expected file 'tests/data/acpi/q35/FACS'
> Looking for expected file 'tests/data/acpi/q35/DSDT'
> Using expected file 'tests/data/acpi/q35/DSDT'
> acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-NKUU2Z.dsl,
> aml:/tmp/aml-UERV2Z], Expected [asl:/tmp/asl-3ITW2Z.dsl,
> aml:tests/data/acpi/q35/DSDT].
> acpi-test: Warning. not showing difference since no diff utility is
> specified. Set 'DIFF' environment variable to a preferred diff utility
> and run 'make V=1 check' again to see ASL difference.**
> ERROR:/home/peter.maydell/qemu/tests/bios-tables-test.c:422:test_acpi_asl:
> assertion failed: (all_tables_match)
> Aborted
> ERROR - too few tests run (expected 15, got 1)
> /home/peter.maydell/qemu/tests/Makefile.include:884: recipe for target
> 'check-qtest-i386' failed
> 
> 
> This is the only 32-bit host I test on, so it may be a generic
> 32-bit host problem rather than arm-specific.
> 
> thanks
> -- PMM

I see. I can drop this patch for now, but I suspect this
means this host always produced warning and possibly
that the tables are all wrong.
Could you send me the actual and expected files please?
Preferably both dsl and binary.

-- 
MST

