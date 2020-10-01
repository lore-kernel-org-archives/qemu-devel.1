Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B188C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 11:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A259C208B6
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 11:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Yt6c81Lc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A259C208B6
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNwfv-0006iw-La
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 07:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kNwf7-0006FQ-RK
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 07:22:13 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:35993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kNwf5-0007f1-ME
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 07:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1601551331;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qnExyjv72xS4XPByzvVUXHpFl+5PJR+AivecgqaXQ5o=;
 b=Yt6c81Lc79/Tg/CezpdtoQhO8bFSVJQgRz8RkiyuOTuMD394Ws4xpd8v
 M56gqC10evixf9nvv5J+waGJKiP9mSOflkjUk70I+Gi68o0XCHVQL+TiF
 ng4omKjZozSo2Rtenoti07C6Pkb2osD1tmlxXeup4bLaovZnOeiQM6i1H w=;
Authentication-Results: esa3.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: pVs85hELVVepnvZSSMzlegb7wyVcQz9y9CR7mht92eybKcAka+cvI+/dTnHazZuU+Lcmo+QTz+
 ogfjKeXQANkkK3NqDNws5mJBLZXe8qjb7jT4r4gAJaoFJs6zt1JoOR7cbin/SWiI0bm25C5xzL
 Kr7mf+FIs9T2qJjnRUvz200nRwfx9qM0xNrRo+QoDBfJwZ3l3tZ/nEvYvf3CACmHopNedTsQje
 OoPALkS7I4q8xQiQsik1Zs8s/d9Bc6ZS7tlu65NLJLOo/3XqhJMOThrPIwq30g4VmWwLLdxCmK
 Jn0=
X-SBRS: None
X-MesageID: 28038335
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,323,1596513600"; d="scan'208";a="28038335"
Date: Thu, 1 Oct 2020 12:22:03 +0100
To: Paul Durrant <paul@xen.org>
CC: <xen-devel@lists.xenproject.org>, <qemu-devel@nongnu.org>, Paul Durrant
 <pdurrant@amazon.com>, Jerome Leseinne <jerome.leseinne@gmail.com>, "Edwin
 Torok" <edvin.torok@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v2] xen-bus: reduce scope of backend watch
Message-ID: <20201001112203.GM2024@perard.uk.xensource.com>
References: <20201001081500.1026-1-paul@xen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201001081500.1026-1-paul@xen.org>
Received-SPF: pass client-ip=216.71.145.155;
 envelope-from=anthony.perard@citrix.com; helo=esa3.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 07:22:10
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to: Anthony PERARD <anthony.perard@citrix.com>
From: Anthony PERARD via <qemu-devel@nongnu.org>

On Thu, Oct 01, 2020 at 09:15:00AM +0100, Paul Durrant wrote:
> From: Paul Durrant <pdurrant@amazon.com>
> 
> Currently a single watch on /local/domain/X/backend is registered by each
> QEMU process running in service domain X (where X is usually 0). The purpose
> of this watch is to ensure that QEMU is notified when the Xen toolstack
> creates a new device backend area.
> Such a backend area is specific to a single frontend area created for a
> specific guest domain and, since each QEMU process is also created to service
> a specfic guest domain, it is unnecessary and inefficient to notify all QEMU
> processes.
> Only the QEMU process associated with the same guest domain need
> receive the notification. This patch re-factors the watch registration code
> such that notifications are targetted appropriately.
> 
> Reported-by: Jerome Leseinne <jerome.leseinne@gmail.com>
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

