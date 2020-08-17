Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F50DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 05:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A0B206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 05:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7xnxYcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A0B206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7XsF-0004Ap-Hh
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 01:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k7Xrd-0003lE-65
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 01:39:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58393
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k7Xra-00008b-IZ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 01:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597642756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c5MU3x1ivWmOByHYcMMr1Qy9CcE/da3zFzUZSKqcZ3s=;
 b=H7xnxYcFjo2cxGbCuK47xPqKrzlFOSQ0AP8z5s319x4BcnZxpjX1TbNKYDlil07zBHfOT6
 YiYrPuWBvJd5MLoaHpU8XSId3myQ9OXeIUJ587BsAb9UVfkA9JFktLZ1Dl9430CXX3U9/S
 g9bJyivu262k/2ep7CxYdOq3k1Aahis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396--03YQwVxM2uqU_F3cPLdqg-1; Mon, 17 Aug 2020 01:39:11 -0400
X-MC-Unique: -03YQwVxM2uqU_F3cPLdqg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D1CE1DDE5;
 Mon, 17 Aug 2020 05:39:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com
 [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3851C7A1FA;
 Mon, 17 Aug 2020 05:39:10 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 593D51753B; Mon, 17 Aug 2020 07:39:09 +0200 (CEST)
Date: Mon, 17 Aug 2020 07:39:09 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Cole Robinson <crobinso@redhat.com>
Subject: Re: hw-display-qxl.so: undefined symbol: qemu_qxl_io_log_semaphore
Message-ID: <20200817053909.yivisow25afbrulf@sirius.home.kraxel.org>
References: <3a19e8c0-215a-bc18-9817-450affec7f08@redhat.com>
 <20200729125034.GG37763@stefanha-x1.localdomain>
 <3206f141-be6b-02e1-d1f3-5f56551ef1d5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3206f141-be6b-02e1-d1f3-5f56551ef1d5@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 00:54:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> FWIW I'm still hitting issues with qemu-5.1.0 GA but maybe it's
> unrelated to that specific fix. Issues reproduce on fedora 33+, not
> fedora 32.

> +Failed to open module:
> /builddir/build/BUILD/qemu-5.1.0-rc3/build-dynamic/x86_64-softmmu/../hw-display-qxl.so:
> undefined symbol: qemu_qxl_client_monitors_config_crc_semaphore

> /builddir/build/BUILD/qemu-5.1.0/build-dynamic/s390x-softmmu/../hw-usb-smartcard.so:
> undefined symbol: ccid_card_send_apdu_to_guest

> So maybe there's a more general problem. FWIW Fedora 33 started using
> LTO by default, but it was disabled for the qemu package.

Hmm, the first looks like a problem.  I'm wondering why it happens on
f33 only, not f32.  LTO could explain that (optimizing away symbols used
by modules but not main qemu), but with that already turned off I have
no clue offhand.

The second is sort-of expected, this comes from s390x not supporting
usb.  I have a pending patch to silence those warnings when qemu tries
to load all available modules (for introspection, to make sure the qom
object list is complete).

take care,
  Gerd


