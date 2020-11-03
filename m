Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5CFC5517A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 13:54:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0722822226
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 13:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMBrVf1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0722822226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZwlS-0002qO-Kc
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 08:54:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kZwkm-0002PD-Vx
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 08:53:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kZwkk-0008Vc-SX
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 08:53:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604411618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zs0ZQkGf20CzVCHrN/m9rvU1iNxW9rzLlS6HubMxjhQ=;
 b=eMBrVf1jGmy3nTp+DV3kIEdX0KVM+qt/gViSZdZuPuqoO3W2sjXrb0Vnv4ypoXGRkuAps/
 ojDJbHCPQ7MsIxrulOFqQuyCj0h8ur19m5kSK1hasYRlpe2W/lbgaVQQM40ImSBKF87HZR
 ZzL0LURFYv14z0+fa0FabPFTBn5pO8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-R77pGLPqPeeuR1b3RicMqA-1; Tue, 03 Nov 2020 08:53:34 -0500
X-MC-Unique: R77pGLPqPeeuR1b3RicMqA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8C8C1009E3F;
 Tue,  3 Nov 2020 13:53:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D8411002D4D;
 Tue,  3 Nov 2020 13:53:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1CF1D16E18; Tue,  3 Nov 2020 14:53:28 +0100 (CET)
Date: Tue, 3 Nov 2020 14:53:28 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH v2] ati: check x y display parameter values
Message-ID: <20201103135328.7o4t7ihbz3upbcwn@sirius.home.kraxel.org>
References: <20201021103818.1704030-1-ppandit@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201021103818.1704030-1-ppandit@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Gaoning Pan <pgn@zju.edu.cn>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 21, 2020 at 04:08:18PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> The source and destination x,y display parameters in ati_2d_blt()
> may run off the vga limits if either of s->regs.[src|dst]_[xy] is
> zero. Check the parameter values to avoid potential crash.
> 
> Reported-by: Gaoning Pan <pgn@zju.edu.cn>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/display/ati_2d.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Added to fixes queue.

thanks,
  Gerd


