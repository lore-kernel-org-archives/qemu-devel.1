Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C6CC433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 15:40:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45BCD20663
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 15:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="en5jWL8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45BCD20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvjVx-00034R-H6
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 11:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jvjV5-0002dP-Hv
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 11:39:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59185
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jvjV2-00076p-TO
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 11:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594827550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AO3HELiSeq5hjugDpVSW9pgmdZmoWY4N39MiwsHMrNM=;
 b=en5jWL8LdFqNtnHN9PxxhEsHwKeDkpl56nu0h06/kiBIxOYJqAcAu1ONbSValuLAF6M23R
 k4b6rTwc/jVRCqgTvFlvSHDfLRZXYn6mZHPlaANBOMBy+SQHUL6fv5UiJCa4eab4/0fMIf
 BlMIBi1EcpNKoC8oKFwYBOvk8VG6zyc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-hP_TMfRsOQyEv04NHJMHcw-1; Wed, 15 Jul 2020 11:39:04 -0400
X-MC-Unique: hP_TMfRsOQyEv04NHJMHcw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B65E9800EB6;
 Wed, 15 Jul 2020 15:39:02 +0000 (UTC)
Received: from localhost (ovpn-115-22.ams2.redhat.com [10.36.115.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD7005D9CA;
 Wed, 15 Jul 2020 15:38:56 +0000 (UTC)
Date: Wed, 15 Jul 2020 16:38:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Nikos Dragazis <ndragazis@arrikto.com>
Subject: Re: Inter-VM device emulation (call on Mon 20th July 2020)
Message-ID: <20200715153855.GA47883@stefanha-x1.localdomain>
References: <86d42090-f042-06a1-efba-d46d449df280@arrikto.com>
 <20200715112342.GD18817@stefanha-x1.localdomain>
 <deb5788e-c828-6996-025d-333cf2bca7ab@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deb5788e-c828-6996-025d-333cf2bca7ab@siemens.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 05:07:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "John G. Johnson" <john.g.johnson@oracle.com>,
 Andra-Irina Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 qemu-devel@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Alexander Graf <graf@amazon.com>, Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 15, 2020 at 01:28:07PM +0200, Jan Kiszka wrote:
> On 15.07.20 13:23, Stefan Hajnoczi wrote:
> > Let's have a call to figure out:
> > 
> > 1. What is unique about these approaches and how do they overlap?
> > 2. Can we focus development and code review efforts to get something
> >    merged sooner?
> > 
> > Jan and Nikos: do you have time to join on Monday, 20th of July at 15:00
> > UTC?
> > https://www.timeanddate.com/worldclock/fixedtime.html?iso=20200720T1500
> > 
> 
> Not at that slot, but one hour earlier or later would work for me (so far).

Nikos: Please let us know which of Jan's timeslots works best for you.

Thanks,
Stefan


