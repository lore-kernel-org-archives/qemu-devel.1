Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD44FC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 09:42:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 581B72078B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 09:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAJH+0Eu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581B72078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDPI9-0005at-I4
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 05:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kDPHU-00058t-35
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 05:42:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kDPHS-00062b-EH
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 05:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599039733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OyOjltA50Waxq+dHVfu2lZff5euOQPxwZc+6hx8qCHY=;
 b=fAJH+0EuVNj70jjRGW20tjjSdkHOftOeNPC1sgd03u7XGE6pDpG7mCAgx1+ChRR9tGU4iq
 51B8UmkSzMHwQiDuiGP4FR+0GvApUhh+fNkpDPOiILwHXa8Ljc/zOX82Vbr3CS76cqKMLg
 SWAJZ9CP2q51H9joKSJFO5yq0QuhwYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-Mo2-gfINPg2T0we8iavQCw-1; Wed, 02 Sep 2020 05:42:10 -0400
X-MC-Unique: Mo2-gfINPg2T0we8iavQCw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B55621DE00;
 Wed,  2 Sep 2020 09:42:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B2B561983;
 Wed,  2 Sep 2020 09:42:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F3E7531E23; Wed,  2 Sep 2020 11:42:07 +0200 (CEST)
Date: Wed, 2 Sep 2020 11:42:07 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/5] Ui 20200831 patches
Message-ID: <20200902094207.plxixzyy5jhyrbld@sirius.home.kraxel.org>
References: <20200831110416.15176-1-kraxel@redhat.com>
 <CAFEAcA99xWV2=12YeZL2Aq+U5kDGLx9eC2vfEVtbqs=Avz78Pw@mail.gmail.com>
 <20200901141628.nfvsojjje2d7vgfa@sirius.home.kraxel.org>
 <CAFEAcA90KpnJF2kF7QmVE3DJCSk7W_RriM6TbT3oweRjNUJSvA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA90KpnJF2kF7QmVE3DJCSk7W_RriM6TbT3oweRjNUJSvA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 01:13:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 01, 2020 at 03:54:29PM +0100, Peter Maydell wrote:
> On Tue, 1 Sep 2020 at 15:16, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> >   Hi,
> >
> > > Generating ar with a custom command
> > > cp: '../../pc-bios/keymaps/ar' and 'pc-bios/keymaps/ar' are the same file
> >
> > Hmm, strange.  No failures in gitlab ci:
> >         https://gitlab.com/kraxel/qemu/-/pipelines/183769485
> >
> > Any chance this is an old build tree?  Specifically created before
> > commit ddcf607fa3d6 ("meson: drop keymaps symlink") was merged, and the
> > symlink is present still?
> 
> Yeah, mostly my build trees don't get regenerated. We like
> incremental builds to continue to work.

So just not creating the symlink isn't enough, i.e. configure must
remove it if present?

Or is requiring fresh build trees ok if announced in the
cover letter / pull request?

thanks,
  Gerd


