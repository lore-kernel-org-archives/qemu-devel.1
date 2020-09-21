Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A5BC43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D6F20874
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VALVZZ88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D6F20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKGqq-00069t-7r
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 04:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kKGmX-0001c7-MY
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:02:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kKGmT-0006gM-D7
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600675355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+nqB8JTec2Z+6O0M77TSnv/ZRS1vasxp47+y5LccB0Y=;
 b=VALVZZ88TZTgoWWvlpOZ5v559EbmUsMs0EUhwAyBtUdrYewr2KTvj+rJJMR85ySQogJudw
 1OjHSVdpeP1pRpe4HLTH8gTUZ2Iijx/7sguYVcZuTdjbXJJ+v/BkWr7gBwXkP9m8te6Zhe
 x3l0wNDgdx0xwAAFPx7iGpPqWL/EaLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-9kuO0iWTOJyRAQNW4CoQGg-1; Mon, 21 Sep 2020 04:02:33 -0400
X-MC-Unique: 9kuO0iWTOJyRAQNW4CoQGg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4F971005E5B
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 08:02:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 500D060C13;
 Mon, 21 Sep 2020 08:02:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AB49316E0A; Mon, 21 Sep 2020 10:02:27 +0200 (CEST)
Date: Mon, 21 Sep 2020 10:02:27 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: marcandre.lureau@redhat.com
Subject: Re: [PATCH] spice: remove obsolete callback
Message-ID: <20200921080227.nx73aafh5myr3n7f@sirius.home.kraxel.org>
References: <20200918100737.91646-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918100737.91646-1-marcandre.lureau@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
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
Cc: qemu-devel@nongnu.org, fziglio@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> Fix compiler deprecation warnings with Spice > 0.14.3 (not released
> yet). We may want to wait until newer version is actually released to
> apply the patch.

Probably makes sense, just in case.  It's not like this is an urgent
fix.

> +#if SPICE_SERVER_VERSION < 0x000e04 /* release 0.14.4 */
>  static void interface_attach_worker(QXLInstance *sin, QXLWorker *qxl_worker)
>  {
>      PCIQXLDevice *qxl = container_of(sin, PCIQXLDevice, ssd.qxl);
>  
>      trace_qxl_interface_attach_worker(qxl->id);
>  }
> +#endif

> +#if SPICE_SERVER_VERSION < 0x000e04 /* release 0.14.4 */
>  static void interface_attach_worker(QXLInstance *sin, QXLWorker *qxl_worker)
>  {
>      /* nothing to do */
>  }
> +#endif

While being at it, can we also drop one of the dummy callbacks?

The tracepoint can go away too I think, given qemu doesn't do anything
in the callback anyway.

> +#if SPICE_SERVER_VERSION < 0x000e04 /* release 0.14.4 */
>      .attache_worker          = interface_attach_worker,
> +#endif
>      .set_compression_level   = interface_set_compression_level,
>  #if SPICE_NEEDS_SET_MM_TIME
>      .set_mm_time             = interface_set_mm_time,

Add a SPICE_NEEDS_ATTACH_WORKER #define for consistency?

take care,
  Gerd


