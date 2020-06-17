Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75535C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:07:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EDB220FC3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y46WyVMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EDB220FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlXmS-0000ng-FG
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 09:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jlXlt-0000MU-Ut
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:06:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51872
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jlXlr-0000GS-Mf
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592399185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2zy1H0UrXbG3wWrhUjFtxzG/Gppf7p/8RfiZdiOnJPc=;
 b=Y46WyVMoqtYIpcYisv25/3eCuM60TcvX2KOiq3dF1MqzcV3+fwsROMH2WEPuA90VzwF2vG
 zcOCzhKvXT7JyYx2ulWnxGlImMFTPI7OVhH4ptO/wAPf/qjfMHjCaeAZ258P89Jk9uPV+l
 uUrjg5G5hhV3qRE/3gV+r7yI74RCLJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-aJP3_NuYOg6FCxPpT7cVQQ-1; Wed, 17 Jun 2020 09:06:24 -0400
X-MC-Unique: aJP3_NuYOg6FCxPpT7cVQQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1A1E1018481;
 Wed, 17 Jun 2020 13:06:22 +0000 (UTC)
Received: from x1.home (ovpn-112-195.phx2.redhat.com [10.3.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0FA07BA1D;
 Wed, 17 Jun 2020 13:06:21 +0000 (UTC)
Date: Wed, 17 Jun 2020 07:06:21 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 0/6] Add various undefined MMIO r/w functions
Message-ID: <20200617070621.29051d4b@x1.home>
In-Reply-To: <20200617063956.GA12597@umbus.fritz.box>
References: <20200617053934.122642-1-ppandit@redhat.com>
 <20200617063956.GA12597@umbus.fritz.box>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Lei Sun <slei.casper@gmail.com>,
 =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 17 Jun 2020 16:39:56 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Jun 17, 2020 at 11:09:27AM +0530, P J P wrote:
> > From: Prasad J Pandit <pjp@fedoraproject.org>
> > 
> > Hello,
> > 
> > This series adds various undefined MMIO read/write functions
> > to avoid potential guest crash via a NULL pointer dereference.  
> 
> Hrm.  If this is such a common problem, maybe we should just add a
> NULL check in the common paths.

+1, clearly the behavior is already expected.  Thanks,

Alex


