Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C1FC3A5A3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 13:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E93A822CE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 13:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ZScSRKzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93A822CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0n1P-000053-Tn
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 09:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1i0myh-0006l3-M4
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1i0myf-0000ub-LD
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:18:11 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:60318)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1i0myd-0000s8-QG
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 09:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1566479887;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=n1YD+OOFNmPvGD6PZfLyWOtHg05FIvLB0Iy7GPtxjcU=;
 b=ZScSRKzHaHGAesW9lRDc/0Njkx1UZbHfcmhqIM8t79TmOyI/6ZI7uxGY
 d2Z5kOvT9DPviMDnbKew0u3FF7JYV3CKXHjiIFSg0AOsOaA7JzsElR5Lh
 5Sc1Y/Xvq+lVQQClABirWH/XCDYleqUu5YvWBFwJ4MbadayJIQA2oBshc s=;
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: GcIuFt9r5ZLRP2r6HYqKEGc2cHHVz/XraIynBlMaIJXnDzLH8s5VvwxFNqUSw6azEqiPDeVADf
 n5aowvHQfwAlFX+7LuPl6v96zu6YS8bvlFXrj/ueysl3nmtGmVA5Q2B/uIRXkGRX3Eck/fONWW
 ucHFW8HonKNF+TBlQVos18NtwZI4+Qy8Y9gwpGkHCiXi/5FU6sbM1exa6a5SU4YYjz60jdVh+v
 CQ1/rafLZEWCVx0Kzk1MdjF05aGaabDvZNJ0ej5roOZzExuVkOvZIqEGwMFTkyx18dae7d9Ekn
 MDY=
X-SBRS: 2.7
X-MesageID: 4836255
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,416,1559534400"; 
   d="scan'208";a="4836255"
Date: Thu, 22 Aug 2019 14:18:02 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Paul Durrant <Paul.Durrant@citrix.com>
Message-ID: <20190822124427.GL1289@perard.uk.xensource.com>
References: <20190821092020.17952-1-anthony.perard@citrix.com>
 <20190821092020.17952-3-anthony.perard@citrix.com>
 <703d5a46d4c74eb4afd93d76b7341efc@AMSPEX02CL03.citrite.net>
 <20190822102132.GJ1289@perard.uk.xensource.com>
 <b63f378211d8451d8267f83f0922138e@AMSPEX02CL03.citrite.net>
 <20190822111730.GK1289@perard.uk.xensource.com>
 <40872481b00f4dbeb82ab540e99121a6@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <40872481b00f4dbeb82ab540e99121a6@AMSPEX02CL03.citrite.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.144
Subject: Re: [Qemu-devel] [PATCH 2/2] xen-bus: Avoid rewriting identical
 values to xenstore
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
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 22, 2019 at 12:25:44PM +0100, Paul Durrant wrote:
> > From: Anthony PERARD <anthony.perard@citrix.com>
> > Sent: 22 August 2019 12:18
> > 
> > On Thu, Aug 22, 2019 at 11:36:32AM +0100, Paul Durrant wrote:
> > > But, now I look at the code again without your patch applied I don't actually see the problem it is
> > trying to fix. The functions xen_device_[back|front]end_set_state return early if the state being set
> > matches the existing state and hence never get to the line where the state is written to xenstore.
> > 
> > Let's see:
> >     * step 1 (initial states in xenstore and QEMU)
> >         xenstore/frontend/state = 4
> >         xendev->frontend_state = 4
> >     * step 2 (frontend changes state in xenstore)
> >         xenstore/frontend/state = 5
> >     * step 3 (watch event received by QEMU)
> >         xen_device_frontend_changed()
> >             state = read(xenstore/frontend/state) (state=5)
> >             xen_device_frontend_set_state(state)
> >                 xendev->frontend_state != state  (4!=5)
> >                     xendev->frontend_state = state
> >                     xenstore/frontend/state = state
> >     * step 4
> >         # watch event triggers xen_device_frontend_changed() again but
> >         # this time xendev->frontend_state == xenstore/frontend_state
> > 
> > This is how QEMU writes to xenstore an identical value.
> > 
> > That behavior might be an issue if the frontend changes the value after
> > QEMU have read it but before QEMU writes it again.
> 
> Ah, ok, so the problem is actually limited to frontend state because that is written by both frontend and backend, so whether QEMU writes an updated frontend state to xenstore needs to be controlled. It's only called in two places xen_device_frontend_changed() and xen_device_realize(). The write to xenstore should be avoided in the former case, but not the latter. So adding a 'publish' boolean and using that to determine whether the write to xenstore is done seems like the right approach. But I don't think any change is needed to xen_device_backend_set_online() or xen_device_backend_set_state(), is it?

I guess it's not that much of a issue for backend_set_*(), the double
write would only happen when the toolstack try to tear down the backend,
so it would happen only once.

Alright, I'll only change frontend_set_state() and use 'publish'.

-- 
Anthony PERARD

