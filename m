Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7B4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 852DB20771
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cam.ac.uk header.i=@cam.ac.uk header.b="k4r3m+iz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 852DB20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cl.cam.ac.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKVk-0002gy-LA
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alr48@hermes.cam.ac.uk>)
 id 1jmJwR-00054J-NQ; Fri, 19 Jun 2020 12:32:35 -0400
Received: from ppsw-43.csi.cam.ac.uk ([131.111.8.143]:43630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alr48@hermes.cam.ac.uk>)
 id 1jmJwP-0006FD-7z; Fri, 19 Jun 2020 12:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cam.ac.uk; 
 s=20180806.ppsw;
 h=Sender:Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NAb26gyr/K5h/Ph6R4AoRAP5xysoGB7s9rr1Hlxe1Hw=; b=k4r3m+iz1ycurBv/Sx0Dss425O
 19J4+2C2kHbAuOJ1Q/S30Ni//458ND/FX0Eq8WE+ssUURmOlp7a3OWa1U0MuLFfA/WjkdyYoNmJ5N
 GTEITB2HnjP6Yql/7g1fv68PDW0KLiI6e/prBAYF2wghZqlMEKM4V5qm0T6i1kMiHIlA=;
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Received: from mail-il1-f170.google.com ([209.85.166.170]:37782)
 by ppsw-43.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:587)
 with esmtpsa (PLAIN:alr48) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 id 1jmJwK-000QFA-pW (Exim 4.92.3)
 (return-path <alr48@hermes.cam.ac.uk>); Fri, 19 Jun 2020 17:32:29 +0100
Received: by mail-il1-f170.google.com with SMTP id e11so9786766ilr.4;
 Fri, 19 Jun 2020 09:32:28 -0700 (PDT)
X-Gm-Message-State: AOAM531WCFBHGlhJdizzYmXV2T27aQJ4KmmAOjVfjKFHmwjDTN7uEtpK
 MJVgo+m59AMb8RE7phCMMr+DKnFRpoqK37mVaIA=
X-Google-Smtp-Source: ABdhPJx9Zk66FxsJ0ZauBl0VQTJaeC/B/5T6o1tlXoEkCIFyaKfSxjW2Q0RyO9qqqMF6wj+is4A/YqQwO+G4RVs+MNY=
X-Received: by 2002:a05:6e02:13f4:: with SMTP id
 w20mr4501867ilj.294.1592584347920; 
 Fri, 19 Jun 2020 09:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200616192700.1900260-1-atish.patra@wdc.com>
 <CAEUhbmVRN2Ze=jNqFSJbZgO0_ggyX6B-1UydPJB1sZVdAokrxQ@mail.gmail.com>
 <CAOnJCUKN=L+eqMsp5X_6HG3j85Gzf6jtZMdNhCZ+cwROpJOTCQ@mail.gmail.com>
In-Reply-To: <CAOnJCUKN=L+eqMsp5X_6HG3j85Gzf6jtZMdNhCZ+cwROpJOTCQ@mail.gmail.com>
From: Alexander Richardson <Alexander.Richardson@cl.cam.ac.uk>
Date: Fri, 19 Jun 2020 17:32:11 +0100
X-Gmail-Original-Message-ID: <CAEeofcg7Rvu-=AxZJKwQxHJX1pq_P6sfZJ3Vn_JGcSw5C2aF4A@mail.gmail.com>
Message-ID: <CAEeofcg7Rvu-=AxZJKwQxHJX1pq_P6sfZJ3Vn_JGcSw5C2aF4A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add OpenSBI dynamic firmware support
To: Atish Patra <atishp@atishpatra.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=131.111.8.143;
 envelope-from=alr48@hermes.cam.ac.uk; helo=ppsw-43.csi.cam.ac.uk
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 12:32:29
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Jun 2020 13:07:04 -0400
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 18 Jun 2020 at 19:22, Atish Patra <atishp@atishpatra.org> wrote:
>
> On Thu, Jun 18, 2020 at 1:56 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > On Wed, Jun 17, 2020 at 3:29 AM Atish Patra <atish.patra@wdc.com> wrote:
> > >
> > > This series adds support OpenSBI dynamic firmware support to Qemu.
> > > Qemu loader passes the information about the DT and next stage (i.e. kernel
> > > or U-boot) via "a2" register. It allows the user to build bigger OS images
> > > without worrying about overwriting DT. It also unifies the reset vector code
> >
> > I am not sure in what situation overwriting DT could happen. Could you
> > please elaborate?
> >
>
> Currently, the DT is loaded 0x82200000 (34MB offset) for fw_jump.
> Thus, a bigger kernel image
> would overwrite the DT. In fact, it was reported by FreeBSD folks.
> https://github.com/riscv/opensbi/issues/169
>
The problem is that the DT overwrites the kernel image. Usually this
is not noticeable since it's so small and rarely overwrites something
useful, but in my case it was overwriting program memory which
resulted in invalid instruction crashes.
Since this is quite awkward to debug, I added a kernel assertion to
FreeBSD to abort boot in that case.

> There are temporary solutions that can put DT a little bit further or
> put it within 2MB offset. But that's
> just delaying the inevitable.
>
I've changed OpenSBI locally to use a 1MB offset (i.e. place the DT
between OpenSBI and the kernel), but I think the fw_dynamic approach
is much nicer.

Thanks,
Alex

