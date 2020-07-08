Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83405C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:23:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D35620772
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6sSJNsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D35620772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIT9-0004Uq-Ib
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jtHyY-0002hI-TN
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:51:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32043
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jtHyW-0005AO-TT
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594245091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UN1YaD7Y/2d4ZcceZn9hFPTukBDPtvJVNHYCjTX+qOE=;
 b=X6sSJNsUB75OtCjr6DMMsc9iCB3XycheZV1X1c9jgnG0PRZusTMTejFe7FzUueq9rM3IWA
 Fh6q4sFwSx6Kv1rqQcc7l7dFZtVa+2f66hz91zwqx3DcMMfyIyBmkuUfs2PnVFzuxs5U/o
 /z3PqKY7qVOCs01zMteAvGlTdbGTxGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-mTemUHUOMT-sJfhtHfDC0A-1; Wed, 08 Jul 2020 11:50:17 -0400
X-MC-Unique: mTemUHUOMT-sJfhtHfDC0A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50467107ACF5;
 Wed,  8 Jul 2020 15:50:16 +0000 (UTC)
Received: from starship (unknown [10.35.206.247])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA7C610016E8;
 Wed,  8 Jul 2020 15:50:14 +0000 (UTC)
Message-ID: <1ebf044a89e1d7fcbfb368fd3ce69b51b8ec5784.camel@redhat.com>
Subject: Re: [PULL 00/31] Block patches
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Max Reitz <mreitz@redhat.com>
Date: Wed, 08 Jul 2020 18:50:13 +0300
In-Reply-To: <9d4ae79cb1e1a0102a855500fd062dea1554d045.camel@redhat.com>
References: <20200706100432.2301919-1-mreitz@redhat.com>
 <CAFEAcA-jzUkr9dyKS6_ZFemQ-ojdLjA1zMwXhmWH=PSr7QAR7w@mail.gmail.com>
 <9d4ae79cb1e1a0102a855500fd062dea1554d045.camel@redhat.com>
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-07-08 at 18:11 +0300, Maxim Levitsky wrote:
> On Tue, 2020-07-07 at 21:40 +0100, Peter Maydell wrote:
> > On Mon, 6 Jul 2020 at 11:04, Max Reitz <mreitz@redhat.com> wrote:
> > > The following changes since commit eb6490f544388dd24c0d054a96dd304bc7284450:
> > > 
> > >   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200703' into staging (2020-07-04 16:08:41 +0100)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://github.com/XanClic/qemu.git tags/pull-block-2020-07-06
> > > 
> > > for you to fetch changes up to 365fed5111b06d31c1632af63c7528dfe49d62a2:
> > > 
> > >   qed: Simplify backing reads (2020-07-06 10:34:14 +0200)
> > > 
> > > ----------------------------------------------------------------
> > > Block patches for 5.1:
> > > - LUKS keyslot amendment
> > >   (+ patches to make the iotests pass on non-Linux systems, and to keep
> > >      the tests passing for qcow v1, and to skip LUKS tests (including
> > >      qcow2 LUKS) when the built qemu does not support it)
> > > - Refactoring in the block layer: Drop the basically unnecessary
> > >   unallocated_blocks_are_zero field from BlockDriverInfo
> > > - Fix qcow2 preallocation when the image size is not a multiple of the
> > >   cluster size
> > > - Fix in block-copy code
> > > 
> > 
> > Applied, thanks.
> > 
> > Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
> > for any user-visible changes.
> 
> Since this includes my luks patches, I guess I need to add them to this changelog.
> How do I get an account on the wiki?

Kevin Wolf gave me an account, so I'll write today a short description in the changelog.
Thanks for everyone that helped me get this merged upstream!

Best regards,
	Maxim Levitsky
> 
> Best regards,
> 	Maxim Levitsky
> 
> > -- PMM
> > 



