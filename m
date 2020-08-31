Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC84C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:38:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60DC62073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJ24eEcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60DC62073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCfKz-0001eP-FV
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 04:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kCfDa-0006JP-Lq
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:31:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kCfDY-0006Oz-Sl
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598862668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OTq9z7q+Fq1kqDy4vC8ryspcUmtNcOgnJbkgiLwnDhw=;
 b=GJ24eEcXYVQcffA6o0PGuRsxMWqmcUgfPVt2qZdixD4D83dlh5CmDPf5jely+Fw6soMao3
 at5x20vHPCS1pV5Ee43zWjXn1sBUGJSIDzQe16HkLsO2kuegJBepBzLy88EdQjagezuPyQ
 MOHpDM8bhXIH9gXIurgcFohqtL4m6/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-sHhKcD_EP2qhgo61P_9rrQ-1; Mon, 31 Aug 2020 04:31:05 -0400
X-MC-Unique: sHhKcD_EP2qhgo61P_9rrQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20B85801AC3;
 Mon, 31 Aug 2020 08:31:04 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF4C1100EBB8;
 Mon, 31 Aug 2020 08:31:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DC65917447; Mon, 31 Aug 2020 10:31:02 +0200 (CEST)
Date: Mon, 31 Aug 2020 10:31:02 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 00/18] Usb 20200828 patches
Message-ID: <20200831083102.hghf3vi2xb7e32zl@sirius.home.kraxel.org>
References: <20200828080845.28287-1-kraxel@redhat.com>
 <CAFEAcA8rSCDnSvymWigeU4VPjyrEB-WMws57q0-Q3cNijQjEBw@mail.gmail.com>
 <CABgObfbufQJza=XykCSp2V5xdTwzycx-GsWTD6jKEV3PnomRXQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABgObfbufQJza=XykCSp2V5xdTwzycx-GsWTD6jKEV3PnomRXQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 03:43:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 28, 2020 at 04:33:04PM +0200, Paolo Bonzini wrote:
> Il ven 28 ago 2020, 16:14 Peter Maydell <peter.maydell@linaro.org> ha
> scritto:
> 
> > Why is Meson trying to use CMake here? I don't think we want
> > to bring in another build tool dependency...
> >
> 
> It's asking cmake if it knows about the package, if pkg-config fails. This
> is because cmake has its own incompatible mechanism to tell users about
> compilation and linking flags, and the "dependency" line doesn't tell Meson
> if u2f-emu has a pkg-config or a cmake description.

It uses pkg-config, so we can explicitly say so.

> We can ask to use pkg-config only since none of our dependencies are
> cmake-only; see https://mesonbuild.com/Dependencies.html#dependency-method.

I'll send a new pull with that addressed (also the other 11/18 comments).

thanks,
  Gerd


