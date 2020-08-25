Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FF7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 09:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3264E2068F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 09:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="uPNG5yev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3264E2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAVEX-0005Lv-H7
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 05:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1kAVCz-0004JL-LV
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 05:25:37 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:46150 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1kAVCx-0006b6-Dt
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 05:25:37 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 1F805574EA;
 Tue, 25 Aug 2020 09:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-transfer-encoding:content-disposition
 :content-type:content-type:mime-version:references:message-id
 :subject:subject:from:from:date:date:received:received:received;
 s=mta-01; t=1598347531; x=1600161932; bh=eXlx3JY6i2SJ7rh8P6mxI3
 Y3DTrmTm2AhUOki7kXt18=; b=uPNG5yev+9CezCYxzm09yjjkl9XCRutmdr1zSG
 jeHqx/hNOcI+LTvnJOVvtWsip9/QreRwJ65WK0DHgyXTcqxKDV4nDX6C1FGWz2oo
 URTxlMA3mjQttnrXkOGe8GjTC0iIOnDCRobNJCzI/nkcH2FO80dHCTXBbFaZvYgx
 vzsuQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sh3gEUS8ySvb; Tue, 25 Aug 2020 12:25:31 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 7B97654C2A;
 Tue, 25 Aug 2020 12:25:31 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 25
 Aug 2020 12:25:31 +0300
Date: Tue, 25 Aug 2020 12:25:30 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 3/4] configure: Prefer gmake on darwin
Message-ID: <20200825092530.GB38400@SPB-NB-133.local>
References: <20200822212129.97758-1-r.bolshakov@yadro.com>
 <20200822212129.97758-4-r.bolshakov@yadro.com>
 <051b2296-f656-9488-f66a-1e74fdd53dc7@redhat.com>
 <CAFEAcA_zB0quJkmgT_rEPzZ7knVB4WGkxzUSM7w0WSGqiHF1og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_zB0quJkmgT_rEPzZ7knVB4WGkxzUSM7w0WSGqiHF1og@mail.gmail.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 05:04:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 24, 2020 at 04:57:31PM +0100, Peter Maydell wrote:
> On Mon, 24 Aug 2020 at 15:51, Eric Blake <eblake@redhat.com> wrote:
> >
> > On 8/22/20 4:21 PM, Roman Bolshakov wrote:
> > > New meson/make build requires GNU make 3.82+ but macOS ships 3.81 even
> > > on Big Sur while homebrew provides GNU make 4.3 as 'gmake' in $PATH.
> >
> > Does this line up with our development policies on supported platforms?
> > Should we be fixing the creation of Makefile.ninja to avoid constructs
> > not understood by older GNU make, if that is what is shipped out of the
> > box on MacOS as one of our supported platforms?  Or is MacOS on the
> > fringe for what counts as supported, where we are okay mandating that
> > users must install a separate newer GNU make than what comes by default?
> 
> If it's easy to add back support for make 3.81 that would be the
> nicest thing, I think. But we already require the user to install
> a non-system python, for instance, so asking them to also install
> make from homebrew isn't a completely new thing. (The only awkward
> thing is that homebrew doesn't actually put the new make on the
> path as 'make', only as 'gmake', so you have to then manually
> fiddle the PATH.) At some point requiring some tools from homebrew
> or similar for QEMU compilation is just inevitable given
> Apple's apparent policy of never moving the system versions of
> tools beyond the last GPLv2 version.
> 

Never thought of that, but perhaps it's similar to what happened with
bash. Apple shipped an old GPLv2 version of bash (3.2) for quite a while
even after 4.x release. Then they suddenly switched default shell to
zsh. Following the approach, we're more likely to see meson and ninja in
Apple Command Line Tools than GNU Make 3.82+ 🙂

As for alias, Homebrew also provides GNU coreutils and sed with g
prefix and a special gnubin prefix is provided to simplify bulk addition
of GNU tools to PATH, so it's consistent in some sense :)

Here's a related homebrew discussion about system binary shadowing:
https://discourse.brew.sh/t/why-was-with-default-names-removed/4405/14

-Roman

