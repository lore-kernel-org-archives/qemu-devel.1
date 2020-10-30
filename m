Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F53C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 13:07:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C52C4206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 13:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="iNuSGqM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52C4206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYU7t-00045I-6q
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 09:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kYU5I-0002T0-NR
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 09:04:49 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:44293)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kYU5G-0006u5-Hk
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 09:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=gBC5k0AYuTsf00tXi6aGmJPGzahDfRFuexugyr1+Dn4=; b=iNuSGqM6+5NkN85We4MTgLFp+8
 raAZ3+8UafYhEEksTG+aJubfZgImig+P7fgrx0NvFkWSRY06K0GLAz4eJk+NbQNfJeE3QmJ3O97Tw
 1U5Ck+OYKOoCFvGZJH9da6buVD4xWvx14y5QFaySJyeX/YnxlDPxMOhOhpC2yq2jQvZjyWF+ssAut
 xz8mADJYDNZfnpUT15TwoNuIVg1u7k/TOKQkSZQVu/mZyw+97/klzpMy7gwyj7Vyr9+lipVO6s/Xb
 ujShzB3U8muvMS6hn7GU1lsgsykEQpKJxubHapeJqMvUEBLSYDCPO7JehJgK3sq+Xy0oNDrN97JP6
 JqZBcgUA==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 2/2] tests/9pfs: fix coverity error in
 create_local_test_dir()
Date: Fri, 30 Oct 2020 14:04:19 +0100
Message-ID: <4348432.rlt2hFKyKB@silver>
In-Reply-To: <CAFEAcA8QW0T3e4gUAOWh0Jnfov09=rPnqXGQDvHs3sYAYn7O3g@mail.gmail.com>
References: <cover.1604046404.git.qemu_oss@crudebyte.com>
 <3565953.R2qxJ1zP7r@silver>
 <CAFEAcA8QW0T3e4gUAOWh0Jnfov09=rPnqXGQDvHs3sYAYn7O3g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 07:59:50
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

On Freitag, 30. Oktober 2020 13:09:26 CET Peter Maydell wrote:
> On Fri, 30 Oct 2020 at 12:02, Christian Schoenebeck
> 
> <qemu_oss@crudebyte.com> wrote:
> > On Freitag, 30. Oktober 2020 12:44:18 CET Greg Kurz wrote:
> > It's not clear to me where this coverity report is accessible online. A
> > quick search only brought me to statistics about its latest check, but
> > not the details of the report you quoted.
> 
> https://scan.coverity.com/projects/qemu . To see the actual
> defect reports you need to create an account and request
> access to the QEMU project (we happily give access to developers,
> but it is a manual-approval process).
> 
> > And more importantly: is there coverity CI support that one could enable
> > on
> > github, so that pending patches were checked before upstream merge?
> 
> No, unfortunately not. The Coverity free-for-open-source-projects
> system has a very limited number of scans it allows (for a project
> the size of ours just one a day) so we can't open it up to
> submaintainer branches or even use it on pull requests pre merge;
> the best we can do is running it on master daily.
> 
> thanks
> -- PMM

Thanks for the clarification Peter!

I try to sign up for Coverity next week.

Best regards,
Christian Schoenebeck



