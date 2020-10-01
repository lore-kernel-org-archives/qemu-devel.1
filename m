Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3C1C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 11:36:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC37720B1F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 11:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="JXcWBI7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC37720B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNwtD-00054g-Ml
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 07:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kNwqw-0002vw-6g
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 07:34:26 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:44473)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kNwqt-0000h8-Vf
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 07:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=BGyhHyoCc1oV93JXqnUM17bJ5L+DMHTD5a28udAEA5o=; b=JXcWBI7SonwK4nRaC6LHvTFCCR
 bRuivhIrcJkZ6jLa4yalxwzuzUrIS0j+2nUeShD7qHrywvV2OouiYj48rVuoSAQ/EaQ9hRrSGOKbf
 9m4k0CdW+VdrsoTQtAwME8rc2OdBIzkmPcHVKRFDn5j8HgXEvyG/GEzEzXNl+9lZ27ZHFsFgs8r8E
 xIYbJP7w9ksbdreCSZiY/tQ0duaGN+ceuW5Q8UzLZEQb4BRtto/aw44ciW6UPXcCa5TulDjb6I4wS
 jsjuC0xP2NHvMbrpUcNnQcyqvcE31kuxVPOCrHYRSf9SoHZts6IU4ccb9yFcKJkwN1uKo3xyD+1j3
 QPEXb95g==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 08/12] tests/9pfs: refactor test names and test devices
Date: Thu, 01 Oct 2020 13:34:18 +0200
Message-ID: <2296259.KyODYMqAT8@silver>
In-Reply-To: <0cafb215-e49e-902c-4794-bdb696a892d6@redhat.com>
References: <cover.1601203436.git.qemu_oss@crudebyte.com>
 <9648157.mzsJ5Dm3EP@silver> <0cafb215-e49e-902c-4794-bdb696a892d6@redhat.com>
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

On Montag, 28. September 2020 18:38:00 CEST Paolo Bonzini wrote:
> On 28/09/20 15:35, Christian Schoenebeck wrote:
> >> As I said, the first two patches make total sense.  They would be useful
> >> for testing both packed and split virtqueues, for example.  However, I
> >> think the (useful) feature is being misused here.
> > 
> > I haven't understood why my suggested mult-device use case imposes a
> > misusage, but okay, unless I hear different opinions, I'll prepare a v2
> > with that (IMO hackish) CL fiddling instead in couple days or so.
> 
> Because in my opinion the backend in use is a property of the test
> rather than a property of the device.

Paolo, I'm back at square one after changing to single-device model as you 
suggested:

GTest: run: /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/pci-
device/pci-device-tests/nop
Run QEMU with: '-M pc  -device virtio-9p-pci'
(MSG: starting QEMU: exec x86_64-softmmu/qemu-system-x86_64 -qtest unix:/tmp/
qtest-18032.sock -qtest-log /dev/null -chardev socket,path=/tmp/
qtest-18032.qmp,id=char0 -mon chardev=char0,mode=control -display none -M pc  
-device virtio-9p-pci -accel qtest)
qemu-system-x86_64: -device virtio-9p-pci: 9pfs device couldn't find fsdev 
with the id = NULL
Broken pipe

This fundamental virtio-9p-pci test obviously needs a complete 9p command 
line, that is either a 'synth' driver one, or a 'local' one. But simply either 
picking one or another is inappropriate here. This test should run once for 
'synth' and once for 'local'.

Still not convinced that the multi-device route is the way to go?

Best regards,
Christian Schoenebeck



