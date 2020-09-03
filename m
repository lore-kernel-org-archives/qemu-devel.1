Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE37C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 14:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549FE208CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 14:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="dwSRDJsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549FE208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDqbX-0002gs-DL
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 10:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1kDqZX-0001ta-J9
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 10:50:43 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:38182 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1kDqZV-0002W4-Ab
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 10:50:43 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 7B8D1527D2;
 Thu,  3 Sep 2020 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1599144636;
 x=1600959037; bh=whXgQncPmySMi5ux2XudGNFJeGLOM22REE0zFwp6smA=; b=
 dwSRDJsySIPQ52JZY0PI9i5EFGEB/tg6/BHKK6dNR+E0PdrN0v8AgM+tyJjECf4C
 NOO9yg149MOZC0a3a06pZLz6U7MMjP24XiXbP+z72ERPHA6ME2cqfSk2+zpmyv9i
 uOh77W+1hn9jsIWrIXu+uwmnzJJhrSl+feJC7zjftAc=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p34s6LUMWkly; Thu,  3 Sep 2020 17:50:36 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 6CF66574EE;
 Thu,  3 Sep 2020 17:50:35 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 3 Sep
 2020 17:50:35 +0300
Date: Thu, 3 Sep 2020 17:50:34 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: qemu panic on OSX 10.15.6
Message-ID: <20200903145034.GA52559@SPB-NB-133.local>
References: <a1f5ea65-073c-6130-1151-722d66d1564e@zohomail.com>
 <1645171.kiFi0bBsqf@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1645171.kiFi0bBsqf@silver>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 10:50:37
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
Cc: David Cohen <dacohen@zohomail.com>, qemu-devel@nongnu.org,
 Cameron Esfahani <dirty@apple.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 02, 2020 at 10:17:01AM +0200, Christian Schoenebeck wrote:
> On Dienstag, 1. September 2020 14:45:55 CEST David Cohen wrote:
> > Hi,
> > 
> > I'm trying to use qemu on OSX Catalina using HVF hypervisor, but it's
> > currently panic'ing upon booting Linux guest.
> > 
> > These are the args I'm using:
> > build % ./qemu-system-x86_64 -cdrom
> > ~/Downloads/archlinux-2020.08.01-x86_64.iso -smp 4 -m 4G -vga virtio
> > -accel hvf -cpu host
> > 
> > I could trace the failure to test_pt_entry(), in this exact position:
> > 
> > build % git diff
> > diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
> > index 65d4603dbf..8f04a94cc6 100644
> > --- a/target/i386/hvf/x86_mmu.c
> > +++ b/target/i386/hvf/x86_mmu.c
> > @@ -113,6 +113,7 @@ static bool test_pt_entry(struct CPUState *cpu,
> > struct gpt_translation *pt,
> >       }
> > 
> >       if (!pte_present(pte)) {
> > +        printf("Code is failing here");
> >           return false;
> >       }
> > 
> > 
> > Is anyone aware of this issue?
> > 
> > Br, David Cohen
> 
> CCing Cameron and Roman, just in case.
> 

Hi Christian, David,

Are we talking about the issue?

$ $QEMU -cdrom ~/Downloads/archlinux-2020.08.01-x86_64.iso -smp 4 -m 4G -vga virtio -accel hvf -cpu host
vmx_write_mem: mmu_gva_to_gpa ffff8ecf3b150000 failed
[1]    24888 abort      $QEMU -cdrom ~/Downloads/archlinux-2020.08.01-x86_64.iso -smp 4 -m 4G -vga

It might be a dup of:
https://bugs.launchpad.net/qemu/+bug/1838390

The likely cause of the issue is HVF doesn't generate #PF to the guest
when it emulates an instruction and finds a page that's not in memory,
instead it just aborts. setjmp()/longjmp() in hvf_vcpu_exec() might be
used to raise the CPU exception similar to TCG, that would fix the
ticket.

But I'm also seeing a kernel panic in the guest on TSC read in the
guest. It doesn't happen if -cpu host is not used.

Thanks,
Roman

