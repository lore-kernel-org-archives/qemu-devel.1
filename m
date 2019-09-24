Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBB4C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 11:11:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 064A92146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 11:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ItW2fCv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064A92146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCijY-0001vw-46
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 07:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1iCiia-0001WG-PC
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1iCiiZ-0004Md-Ov
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:10:52 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:29736)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1iCiiZ-0004Ly-Dt
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1569323451;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lEhPz1wHBRrXij4xvkM3tXz/x2Yc8brtutZn/5qk7Qo=;
 b=ItW2fCv9q0MyRUdLdg69qRjeBQb6IYRRmt7groWg2fnbt8rIP+QvJMUr
 ZNiJvGx9GBSrtj/79wd+xifUazYJcDhHOnzeX0LHDZOQ1TNHT8Sk7uuU8
 rLocH5QxiefC0FM0X6jPH3G/K8UO+IHReNFfarhPimhdcI8YeX+AqSZUd U=;
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
IronPort-SDR: 4GQ7jRpk6Ft1B/VadYUNEbJAnuUt4NvQB/7ygI3Pg4L6jxVjdwhvtupuHIsfPMvbeAJfdFS/xn
 /CSNbDZMokQSpvFZDXinmZRB6sawXZcE8PMYILVlagmb4Ihoq7f97btoJZtVXjwcCkMwrED2PY
 ZhoBPBaO4wzftsYxp6cS7Ej7vgIZz76debYfcNsFUupzPMM9WEuXa4ygCtcVZKKwsKopW6ucJu
 OYoPMbcflMEdjlbKSgy1VbFFze7gsHEOeowQyl36f5Bb0sQpmK0rScfUq4VacOHVWNF8kRxsaG
 ywM=
X-SBRS: 2.7
X-MesageID: 6196070
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,543,1559534400"; 
   d="scan'208";a="6196070"
Date: Tue, 24 Sep 2019 12:10:47 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] ui: fix keymap file search in input-barrier object
Message-ID: <20190924111047.GC1163@perard.uk.xensource.com>
References: <20190923220658.27007-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190923220658.27007-1-laurent@vivier.eu>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.168
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 24, 2019 at 12:06:58AM +0200, Laurent Vivier wrote:
> If we try to start QEMU with "-k en-us", qemu prints a message and exits
> with:
> 
>     qemu-system-i386: could not read keymap file: 'en-us'
> 
> It's because this function is called way too early, before
> qemu_add_data_dir() is called, and so qemu_find_file() fails.
> 
> To fix that, move init_keyboard_layout() from the class init function to the
> instance init function.
> 
> Reported-by: Anthony PERARD <anthony.perard@citrix.com>
> Fixes: 6105683da35b ("ui: add an embedded Barrier client")
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Thanks!

With the patch apply, I can start QEMU (with -k).
And the patch looks fine.

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD

