Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD18CC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:11:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B6520674
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B6520674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYTkj-0006zE-P3
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 08:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Dmitry.Sepp@opensynergy.com>)
 id 1jYTk3-0006FM-VC
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:10:35 -0400
Received: from plasma4.jpberlin.de ([80.241.57.33]:51349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Dmitry.Sepp@opensynergy.com>)
 id 1jYTk2-0001XZ-Nc
 for qemu-devel@nongnu.org; Tue, 12 May 2020 08:10:35 -0400
Received: from spamfilter03.heinlein-hosting.de
 (spamfilter03.heinlein-hosting.de [80.241.56.117])
 by plasma.jpberlin.de (Postfix) with ESMTP id B5C41AAD56;
 Tue, 12 May 2020 14:10:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from plasma.jpberlin.de ([80.241.56.68])
 by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de
 [80.241.56.117]) (amavisd-new, port 10030)
 with ESMTP id eNaeXbqYB0iV; Tue, 12 May 2020 14:10:21 +0200 (CEST)
Received: from webmail.opensynergy.com (unknown [217.66.60.5])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "webmail.opensynergy.com",
 Issuer "GeoTrust EV RSA CA 2018" (not verified))
 (Authenticated sender: opensynergy@jpberlin.de)
 by plasma.jpberlin.de (Postfix) with ESMTPSA id 242FCBC243;
 Tue, 12 May 2020 14:10:21 +0200 (CEST)
Received: from os-lin-dmo.localnet (10.25.255.1) by MXS01.open-synergy.com
 (10.25.10.17) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 12 May
 2020 14:10:20 +0200
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [libcamera-devel] [virtio-dev] Re: Fwd: Qemu Support for Virtio
 Video V4L2 driver
Date: Tue, 12 May 2020 14:10:20 +0200
Message-ID: <64045565.OWohDWQxgf@os-lin-dmo>
Organization: OpenSynergy
In-Reply-To: <20200511143136.GC5830@pendragon.ideasonboard.com>
References: <CAK25hWN3kJcW-dcpryFrvZ50t7Y0Z=MZM66-8NMuhwjRpNo2aQ@mail.gmail.com>
 <CAD90VcYJe7+R256RdOQKxFQciq54+PwbyDRF1cynjOzdQBrq-g@mail.gmail.com>
 <20200511143136.GC5830@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.25.255.1]
X-Rspamd-Queue-Id: B5C41AAD56
X-Rspamd-Score: 1.14 / 15.00 / 200.00
Received-SPF: none client-ip=80.241.57.33;
 envelope-from=Dmitry.Sepp@opensynergy.com; helo=plasma4.jpberlin.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 08:10:29
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_DNSWL_LOW=-0.7 autolearn=_AUTOLEARN
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
Cc: Samiullah Khawaja <samiullah.khawaja@opensynergy.com>,
 Saket Sinha <saket.sinha89@gmail.com>, Alex Lau <alexlau@chromium.org>,
 Kiran Pawar <Kiran.Pawar@opensynergy.com>,
 Alexandre Courbot <acourbot@chromium.org>, virtio-dev@lists.oasis-open.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Keiichi Watanabe <keiichiw@chromium.org>, libcamera-devel@lists.libcamera.org,
 Gerd Hoffmann <kraxel@redhat.com>, Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Laurent,

On Montag, 11. Mai 2020 16:31:36 CEST Laurent Pinchart wrote:
> 
> I don't think this would be the right level of abstraction. The V4L2 API
> is way too low-level when it comes to camera paravirtualization (and may
> not be the only API we'll have in the future). I thus recommend
> virtualizing cameras with a higher-level API, more or less on top of
> libcamera or the Android camera HAL (they both sit at the same level in
> the camera stack). Anything lower than that won't be practical.
> 

I think the the main thing to do first would be to define the logic of such 
virtio-camera device and the set of mandatory features. Host-side API is a bit 
of a side topic. But libcamera fits the best though.

Best regards,
Dmitry.



