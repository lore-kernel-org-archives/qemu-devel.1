Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36F8C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:49:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A76BB206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 08:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZPezKlC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76BB206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCfV1-0001Lc-Sv
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 04:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kCfOJ-0001Ip-LY
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53977)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kCfOH-0007oX-Fl
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 04:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598863332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0rZoT+pRip6bXAghGShLGEtYgGuwoRNhzpWiuPzxy1U=;
 b=EZPezKlCgr9prPOiiZz048LwatIBpZHIx1wCBtqk/hxye3trQNdAwZ5LviJy163Sb9AP5c
 j3Lo6kk2D/JShie7HnIeIzrHl+ohddQ7/omAsoT5XF0Z00fEHHsOgnbaNre04eFFvnqVsq
 fNzfLcARnUOu8DXcrH6fz/+bmcAwQKk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-5glMrNwuMv6_dicG_6hFng-1; Mon, 31 Aug 2020 04:42:10 -0400
X-MC-Unique: 5glMrNwuMv6_dicG_6hFng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19D9A802B6A;
 Mon, 31 Aug 2020 08:42:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D310C5D9D3;
 Mon, 31 Aug 2020 08:42:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0427231FBC; Mon, 31 Aug 2020 10:42:08 +0200 (CEST)
Date: Mon, 31 Aug 2020 10:42:07 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] ui/gtk: Update refresh interval after widget is realized
Message-ID: <20200831084207.jszvvnpgy2lewosx@sirius.home.kraxel.org>
References: <20200817172331.598255-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200817172331.598255-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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
Cc: qemu-devel@nongnu.org, Nikola Pavlica <pavlica.nikola@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 17, 2020 at 07:23:31PM +0200, Philippe Mathieu-Daudé wrote:
> Nikola reported on Windows when gd_vc_gfx_init() is called, the
> window is not yet realized, so we run gd_refresh_rate_millihz(NULL)
> which returns 0 milli-Hertz.
> When a Widget is realized, it fires a 'realized' event. We already
> have the gd_draw_event() handler registered for this even, so simply
> move the gd_refresh_rate_millihz() there. When the event fires, the
> window is known to exist.
> This completes commit c4c00922cc original intention.

Added to UI queue.

thanks,
  Gerd


