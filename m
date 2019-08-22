Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DF6C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC4CD2339F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="cuAJrhDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4CD2339F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0l7t-0006Sp-R7
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 07:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1i0l66-0005GB-Fw
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1i0l65-00062o-6t
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:17:42 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:44362)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1i0l64-000617-Fp
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1566472661;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=cdC/+XCF8A4lCfmd72kiRwi9Nh8c5EpDpeHakVk7NDc=;
 b=cuAJrhDAp0jDoytSloO0hc6UHk2xsD/21IlVk7AGRbWnkH4r0X3Ebwe/
 0YORgZlPsjJFjnUlJqKsc1vT6fBy8AVzLpgdGNYBo7EU4jo+IzCySpR9w
 pyViE0JNgeV567rTZfCFAHH0Zcu9W1acnF2rDVZXJ/KtzJn1+m+5/n8Tw 8=;
Authentication-Results: esa3.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: ahKcjPonF7nN3SGQWWXY8ZrFBzs8BrcW5o0qDNPXsGQWdKWxesJGJkVhIyaAjhiO9zqmHY6Jrr
 ySdPW0fAKug7ljQLWKcoUL96DZI92V1jQktjtSGyNpP5IKsO2lVjMtDdtGwoCQMTZCZT9eVQZd
 VdooDKlIP4KW/FcrO+zofrPkUXDY7nI4yzen8KuUrUfQut83PXC/IxdpPT6W2xAMhe1PqKXHBX
 61R8FHTxbVfDXI08lpyfLQB2fE8cPW1a/T6tNtxocCeyhLjKcJWT/zyeR/DrRaMEPOo0c3hzp5
 J+o=
X-SBRS: 2.7
X-MesageID: 4591279
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,416,1559534400"; 
   d="scan'208";a="4591279"
Date: Thu, 22 Aug 2019 12:17:30 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Paul Durrant <Paul.Durrant@citrix.com>
Message-ID: <20190822111730.GK1289@perard.uk.xensource.com>
References: <20190821092020.17952-1-anthony.perard@citrix.com>
 <20190821092020.17952-3-anthony.perard@citrix.com>
 <703d5a46d4c74eb4afd93d76b7341efc@AMSPEX02CL03.citrite.net>
 <20190822102132.GJ1289@perard.uk.xensource.com>
 <b63f378211d8451d8267f83f0922138e@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b63f378211d8451d8267f83f0922138e@AMSPEX02CL03.citrite.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.155
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

On Thu, Aug 22, 2019 at 11:36:32AM +0100, Paul Durrant wrote:
> But, now I look at the code again without your patch applied I don't actually see the problem it is trying to fix. The functions xen_device_[back|front]end_set_state return early if the state being set matches the existing state and hence never get to the line where the state is written to xenstore.

Let's see:
    * step 1 (initial states in xenstore and QEMU)
        xenstore/frontend/state = 4
        xendev->frontend_state = 4
    * step 2 (frontend changes state in xenstore)
        xenstore/frontend/state = 5
    * step 3 (watch event received by QEMU)
        xen_device_frontend_changed()
            state = read(xenstore/frontend/state) (state=5)
            xen_device_frontend_set_state(state)
                xendev->frontend_state != state  (4!=5)
                    xendev->frontend_state = state
                    xenstore/frontend/state = state
    * step 4
        # watch event triggers xen_device_frontend_changed() again but
        # this time xendev->frontend_state == xenstore/frontend_state

This is how QEMU writes to xenstore an identical value.

That behavior might be an issue if the frontend changes the value after
QEMU have read it but before QEMU writes it again.

Also, it's nice to avoid extra work.

-- 
Anthony PERARD

