Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149B6C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 17:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800F520706
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 17:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2PmvKpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800F520706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNfus-0002rE-BK
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 13:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kNfsu-0001YS-H8
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 13:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kNfst-0002EY-2f
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 13:27:20 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601486838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yKIRwHPJcifkHSzz+kYYoRa4hC/dEw16YnLV8FX4VfQ=;
 b=F2PmvKpJV06/706xVZedYCgLYWaRgaTIWaHm3GD2wbJZl1A3SirnhgtOnWNnj2+lqhHQrv
 YWEWZ1Am7mHK8S+iLD1q7L8liCh8E43fpHfA0LPgF88wzxoWQZTm3NjYLBqcMRR2nqMJui
 LcMCx2/cMn1ZvW3HtxDaGuUuJi9cdaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-Df79VDGIMee3GsneGtOkbw-1; Wed, 30 Sep 2020 13:27:14 -0400
X-MC-Unique: Df79VDGIMee3GsneGtOkbw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC1411018F83;
 Wed, 30 Sep 2020 17:27:12 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4EA468431;
 Wed, 30 Sep 2020 17:27:12 +0000 (UTC)
Date: Wed, 30 Sep 2020 13:27:11 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 00/11] user-mode: Prune build dependencies (part 3)
Message-ID: <20200930172711.GU3717385@habkost.net>
References: <20200930164949.1425294-1-philmd@redhat.com>
 <20200930171529.GR3717385@habkost.net>
 <0c46bedf-9aa6-4ea9-40e1-b0f85a767bb5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0c46bedf-9aa6-4ea9-40e1-b0f85a767bb5@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-block@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 30, 2020 at 07:24:24PM +0200, Paolo Bonzini wrote:
> On 30/09/20 19:15, Eduardo Habkost wrote:
> > On Wed, Sep 30, 2020 at 06:49:38PM +0200, Philippe Mathieu-Daudé wrote:
> >> This is the third part of a series reducing user-mode
> >> dependencies. By stripping out unused code, the build
> >> and testing time is reduced (as is space used by objects).
> > I'm queueing patches 2-9 on machine-next.  Thanks!
> > 
> > Markus, Eric: I can merge the QAPI patches (1, 11) if I get an
> > Acked-by.
> > 
> > I'll send separate comments on patch 10.
> > 
> 
> 1-8 is fine, but I think 9-11 is too much complication (especially not
> really future-proof) for the benefit.

I'll dequeue patch 9 while this is discussed.

-- 
Eduardo


