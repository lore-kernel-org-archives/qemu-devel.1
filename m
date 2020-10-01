Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54426C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 12:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90DC2207DE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 12:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="oTIphB0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DC2207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNxWG-0002fS-9Q
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 08:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kNxUN-0001nC-Hm
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 08:15:11 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:51903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kNxUL-0006iR-47
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 08:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=eAKFNG9vbER05dBlsFlHroOwNF5hH3kXXNj939vCsWQ=; b=oTIphB0k+VrRy/CUoph9n/gtg4
 YcvEWp+5+oTmMcyPsaRd3oRzDtQpJIljZs0ueTivnryfDG/Gx/UjlgenjFa2JoyHfxesAVSrmuAc3
 SyAPR6ANtgMQNsYkVjBY4sTM6YTuP4hxTLSZBT77ujNH5NTpivgocSeuSMugpOGhgobnEquc+V17B
 +rbYrBXvH1/P4+mx0nszL0r18tYNg9pJRL7s7DjYtM4aDWIf6FaU24/Y1JoHsSFuMleFVthppmXfh
 4E+AR5IxN7DRkvbPlbUOVfAcqtn+UQdRqchp14P3l7aRIgeqPGTyynQsz8VO35UYt2uYUrAV8C36q
 m4hwDfOg==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 08/12] tests/9pfs: refactor test names and test devices
Date: Thu, 01 Oct 2020 14:15:05 +0200
Message-ID: <12227378.mPQFScNTDJ@silver>
In-Reply-To: <d6f5cc89-bdac-13a9-d7bc-c7b63a10da79@redhat.com>
References: <cover.1601203436.git.qemu_oss@crudebyte.com>
 <2296259.KyODYMqAT8@silver> <d6f5cc89-bdac-13a9-d7bc-c7b63a10da79@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 07:34:20
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

On Donnerstag, 1. Oktober 2020 13:56:42 CEST Paolo Bonzini wrote:
> On 01/10/20 13:34, Christian Schoenebeck wrote:
> > Paolo, I'm back at square one after changing to single-device model as you
> > suggested:
> > 
> > GTest: run:
> > /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/pci-
> > device/pci-device-tests/nop
> > Run QEMU with: '-M pc  -device virtio-9p-pci'
> > (MSG: starting QEMU: exec x86_64-softmmu/qemu-system-x86_64 -qtest
> > unix:/tmp/ qtest-18032.sock -qtest-log /dev/null -chardev
> > socket,path=/tmp/
> > qtest-18032.qmp,id=char0 -mon chardev=char0,mode=control -display none -M
> > pc -device virtio-9p-pci -accel qtest)
> > qemu-system-x86_64: -device virtio-9p-pci: 9pfs device couldn't find fsdev
> > with the id = NULL
> > Broken pipe
> > 
> > This fundamental virtio-9p-pci test obviously needs a complete 9p command
> > line, that is either a 'synth' driver one, or a 'local' one. But simply
> > either picking one or another is inappropriate here. This test should run
> > once for 'synth' and once for 'local'.
> 
> You're right, this is in fact also a problem for virtio-blk and virtio-net:
> 
>     /* FIXME: every test using these two nodes needs to setup a
>      * -drive,id=drive0 otherwise QEMU is not going to start.
>      * Therefore, we do not include "produces" edge for virtio
>      * and pci-device yet.
>     */
> 
>     /* FIXME: every test using these nodes needs to setup a
>      * -netdev socket,id=hs0 otherwise QEMU is not going to start.
>      * Therefore, we do not include "produces" edge for virtio
>      * and pci-device yet.
>      */
> 
> I still think we should do it like this, because it's closer to the way
> that libqos will work long term.

Could you please elaborate why that long term plan bites with the working 
solution I provided? [patches 1 and 2]

I mean, the solution I suggested is simple and working. I don't see a reason 
why that should be incompatible with future plans. IMO it makes sense to use 
the suggested solution instead of dropping tests just because of potential qos 
changes somewhere in far future that might happen or not. It is still a qos 
design limitation after all that must be addressed sooner or later. So also a 
future qos design must deal with this in some way.

Best regards,
Christian Schoenebeck



