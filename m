Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA313ECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A8E2089F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Yw6xq+uu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A8E2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7ypb-00070Y-DC
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 05:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1i7yYd-0002Qv-Nb
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 05:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1i7yYc-0002pO-Hv
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 05:04:59 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:44370)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1i7yYc-0002k7-9S
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 05:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1568192698;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5sbN3TEEay/RoYhYb2OignsfGcfyMckBkDNAdIZGzCQ=;
 b=Yw6xq+uudwfsbXJlg5W46Jctt8j+8rCIEaqb0pLas/kBxc01gWemB1sC
 16TAUf26tpbhyG4DHBkNqwFpUrzEsUuq12GuUaTxoQ1mTzfyT1m6eqa0i
 KDnvGu7acLQq3CdUk+Hv1h3KG5lu5szr9QV5f1YCirA8/VN2802/5Sp/p s=;
Authentication-Results: esa5.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: pD/GeX/iOziE3cVDhqMlAKUQ9MN8NEPeibEMXMW2Yu8qLJzYwxPukkFSuf/cP6aXPKKldejt4W
 gWhukrvSw6jo9WEzUeDlxSwbh9S+eVjU9iylC84n2alL9zO/pNZX9PGGCevNANamEMtwriFgeu
 /qYkd5ezRX/Fcvq67frz7swvNYgKFbnKCchrhP6bbjHDv12MxF5dfsUvIGlLpP9Ape0+ESvFpH
 wXBp++FBUWVrqdBm17ugMFZZVACpumWN93tsRJqCVSlhZfHLMXLMQqY+Hnk5id7StQ6Vr7atxB
 rJI=
X-SBRS: 2.7
X-MesageID: 5611795
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,492,1559534400"; 
   d="scan'208";a="5611795"
Date: Wed, 11 Sep 2019 10:04:51 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Paul Durrant <paul.durrant@citrix.com>
Message-ID: <20190911090451.GA1308@perard.uk.xensource.com>
References: <20190910171753.3775-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190910171753.3775-1-paul.durrant@citrix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.168
Subject: Re: [Qemu-devel] [PATCH] xen-bus: check whether the frontend is
 active during device reset...
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 10, 2019 at 06:17:53PM +0100, Paul Durrant wrote:
> ...not the backend
> 
> Commit cb323146 "xen-bus: Fix backend state transition on device reset"
> contained a subtle mistake. The hunk
> 
> @@ -539,11 +556,11 @@ static void xen_device_backend_changed(void *opaque)
> 
>      /*
>       * If the toolstack (or unplug request callback) has set the backend
> -     * state to Closing, but there is no active frontend (i.e. the
> -     * state is not Connected) then set the backend state to Closed.
> +     * state to Closing, but there is no active frontend then set the
> +     * backend state to Closed.
>       */
>      if (xendev->backend_state == XenbusStateClosing &&
> -        xendev->frontend_state != XenbusStateConnected) {
> +        !xen_device_state_is_active(state)) {
>          xen_device_backend_set_state(xendev, XenbusStateClosed);
>      }
> 
> mistakenly replaced the check of 'xendev->frontend_state' with a check
> (now in a helper function) of 'state', which actually equates to
> 'xendev->backend_state'.
> 
> This patch fixes the mistake.
> 
> Fixes: cb3231460747552d70af9d546dc53d8195bcb796
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

