Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E937EC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:27:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5B620675
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ah/LHjZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5B620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1r7J-0002sJ-SW
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 07:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j1r6c-0002Qy-Sy
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:27:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j1r6b-0005mT-VL
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:27:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58287
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j1r6b-0005lZ-RK
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581510421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GOlJJCy4VtCbFnO1lr/f+i4Cn1S1mhP5LQm/SNStKLk=;
 b=ah/LHjZQ6HkPu7LijFNpVuMaDSoTWYIbio3ahCllMJ41u7KsVgzULx+TT9qY3mlM+b9xrE
 Qf/IwpBS0VwCzWS9EqmvNdSQBVIxWcaPaGwFvg5WP8+nvl1FfefYQ2T09aT1R2G+fx8K7t
 8cEudL4qqQyrjNwe0DRogQ+KLGzsG7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-kUychp67N0q7MRyAHz5xkg-1; Wed, 12 Feb 2020 07:26:57 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7922C1800D6B;
 Wed, 12 Feb 2020 12:26:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com
 [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E4B71001B05;
 Wed, 12 Feb 2020 12:26:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 760919D6B; Wed, 12 Feb 2020 13:26:55 +0100 (CET)
Date: Wed, 12 Feb 2020 13:26:55 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] ui/cocoa: Drop workarounds for pre-10.12 OSX
Message-ID: <20200212122655.4fquc5fpttosfmln@sirius.home.kraxel.org>
References: <20200201170534.22123-1-peter.maydell@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200201170534.22123-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: kUychp67N0q7MRyAHz5xkg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Feb 01, 2020 at 05:05:34PM +0000, Peter Maydell wrote:
> Our official OSX support policy covers the last two released versions.
> Currently that is 10.14 and 10.15.  We also may work on older versions, b=
ut
> don't guarantee it.
>=20
> In commit 50290c002c045280f8d in mid-2019 we introduced some uses of
> CLOCK_MONOTONIC which incidentally broke compilation for pre-10.12 OSX
> versions (see LP:1861551). We don't intend to fix that, so we might
> as well drop the code in ui/cocoa.m which caters for pre-10.12
> versions as well. (For reference, 10.11 fell out of Apple extended
> security support in September 2018.)

Added to UI patch queue.

thanks,
  Gerd


