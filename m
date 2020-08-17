Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0197CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 11:50:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA8E220674
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 11:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="U2UtxOd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA8E220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7deh-00035A-VC
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 07:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1k7de3-0002fx-Rl
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 07:49:43 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:40506 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1k7de1-00027A-VU
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 07:49:43 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id D291E52894;
 Mon, 17 Aug 2020 11:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-transfer-encoding:content-disposition
 :content-type:content-type:mime-version:references:message-id
 :subject:subject:from:from:date:date:received:received:received;
 s=mta-01; t=1597664978; x=1599479379; bh=kFUNgJMf6lpUZ1DfgyGuDB
 tc8+syh71p2UHl3ZtN4L8=; b=U2UtxOd805a0bAIQttlIW3mtC04o/zVUw6sYBd
 Xxbvm4l6dbmPLWJcBZ38SGkVxX3BHp2GenpSlpaM4RSK1sMZdkbu5avfJHXixWN8
 e3+bshjQiOjZPLfWrqNoaSc9ldE4GUN5pQoo47OLRmDcy+P1P1iHfce3JGKgSvIr
 I8VH8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lTyFwkQ9tD47; Mon, 17 Aug 2020 14:49:38 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 2E219527DA;
 Mon, 17 Aug 2020 14:49:37 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 17
 Aug 2020 14:49:37 +0300
Date: Mon, 17 Aug 2020 14:49:37 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 000/150] Meson integration for 5.2
Message-ID: <20200817114937.GC98227@SPB-NB-133.local>
References: <20200814091326.16173-1-pbonzini@redhat.com>
 <20200817110254.GA98227@SPB-NB-133.local>
 <f8a9f236-7017-01a7-0a6d-06a2e18f95f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8a9f236-7017-01a7-0a6d-06a2e18f95f1@redhat.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 07:02:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 17, 2020 at 01:24:50PM +0200, Paolo Bonzini wrote:
> On 17/08/20 13:02, Roman Bolshakov wrote:
> > 
> > Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>
> > 
> > On the next step, it might be good to drop configure in favor of meson
> > configuration, so configure, build and test commands would be similar to
> > libvirt:
> > 
> > meson build
> > ninja -C build
> > meson test -C build
> 
> Well, there are quite a few steps needed to get there:
> 
> 1) moving feature tests from configure to Meson is a no-brainer.
> However it's better to first convert the unit tests to Meson and get rid
> of the rest of rules.mak.  This is because it's simpler to do this if
> there are no uses left of CONFIG_* symbols in the Makefiles.
> 

Agreed

> 2) moving the rest of "make install" to Meson is even more of a
> no-brainer.  Marc-André has patches there.  They also include a
> conversion of the ROM build.
> 
> 3) moving the bulk of the build from meson to ninja is possible and I
> already have patches for it.  It requires adding ninja as a build
> dependency however.  The main advantage here is getting rid of
> Ninjatool.  I'm not sure how moving the handling of submodules to Meson
> would work, and that's needed in order to be able to build with "ninja
> -C build".
> 

I'm more familiar with CMake rather than meson but they seem to be
similar. CMake has a way to wrap build of submodules:
https://cmake.org/cmake/help/latest/module/ExternalProject.html

I haven't found if meson has the feature. Perhaps, like 4) it's
something to be enhanced in meson.

An alternative is to change the submodules to Meson (if their
maintainers don't mind the change) and use meson subproject:

https://mesonbuild.com/Subprojects.html

Regards,
Roman

> 4) I find "meson test" to be inferior in some respects to the QEMU's TAP
> test harness.  In particular, one feature of QEMU's Makefiles is that
> you can cut-and-paste from "make V=1 output" into the shell.  So that
> part may take some time.  I'd rather extend Meson so that it's possible
> to write arbitrary test runners.
> 

