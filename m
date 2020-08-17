Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E3AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 07:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C67C2078A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 07:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCf8efzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C67C2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7Za8-0002pp-DS
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 03:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k7ZZX-0002Q3-GF
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 03:28:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36017
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k7ZZW-0003Z5-24
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 03:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597649325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nlUtJ5tTLiocHATnHprsqcNiR1K0H+8orMchSbKAXRs=;
 b=GCf8efzlt2yqY9W52v+vHs27uU8kULqddXfSRbK2Dem0Ivkm7R40m9fCD6eTPRz57z5qFx
 i7IheByUsa4DspkObH+IxWFji3bkUiRL/ZsopYhrcPbSVOxwFHNCtS1KKsRpTBiqFV2Kf6
 MVntYb6Al+Wg5x9gn4NUyHWSL6ZxW08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-XufnMTJzNjuARj6vyOxjAQ-1; Mon, 17 Aug 2020 03:28:43 -0400
X-MC-Unique: XufnMTJzNjuARj6vyOxjAQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3A6D100A608;
 Mon, 17 Aug 2020 07:28:42 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com
 [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A82D07010B;
 Mon, 17 Aug 2020 07:28:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 515DE1753B; Mon, 17 Aug 2020 09:28:41 +0200 (CEST)
Date: Mon, 17 Aug 2020 09:28:41 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH] hw: dev-wacom: Support wacom tablet emulation in linux
 qemu
Message-ID: <20200817072841.lvbco4k7hzzimxsb@sirius.home.kraxel.org>
References: <20200812152149.260163-1-michael@amarulasolutions.com>
 <20200817064701.o3q3plnjhzyz3s42@sirius.home.kraxel.org>
 <CAOf5uwn94gZPZXChFDXWZ-1w0jOY_SxRqzF4Mk8hrtLq-r3yCg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOf5uwn94gZPZXChFDXWZ-1w0jOY_SxRqzF4Mk8hrtLq-r3yCg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 00:24:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > > +static const uint8_t qemu_wacom_hid_report_descriptor[] = {
> > > +     0x05, 0x01,
> > > +     0x09, 0x02,
> >
> > Where does this come from?  Created from scratch?  Copied from real
> 
> No, there are dump of several descriptor on github. I will put in the
> commit message

A comment with a link would be good too.

> > wacom tablet?  Any chance this can get descriptive comments like the
> > other report descriptors (see dev-hid.c)?
> 
> Yes, no problem. I will study a bit more. How was working before?

I suspect in the past the linux driver simply checked the device id and
went with that without fetching the report descriptor.

Also note qemu has a generic tablet (-device usb-tablet), so there are
probably very few users using the wacom emulation.  Possibly it is
broken for quite a while already but nobody noticed ...

take care,
  Gerd


