Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA52CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:32:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15C48205ED
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXkgMF5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C48205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNYXr-0005SD-Rx
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 04:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iNYOS-00057v-U5
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iNYOR-00015t-Lh
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:22:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60160
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iNYOR-000153-Hq
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571905370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BSRKvgC0wSSxXvWmmRsmU7KK90TBQk3JaPsD5L2Leug=;
 b=DXkgMF5Ca7joM5k4HoU6RX+CEcL5d0z6lYW0gBMnRlrthQnXm5ZuOIsc7p36gyQJ6A6fzc
 TGbC3bXgo0yz7ICYUMEJVY1oF+TY6LLbQh1bRNX49xDbZ52uq6CLZc+XBJjfVl0MAGE3id
 N/tEWEF4LLTZmRZ2Osq586IUjYTswRU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-nHVlWF9EMnqFqwcaPtGEIg-1; Thu, 24 Oct 2019 04:22:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3748247B;
 Thu, 24 Oct 2019 08:22:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com
 [10.36.116.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EDA9860852;
 Thu, 24 Oct 2019 08:22:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 330E89DB6; Thu, 24 Oct 2019 10:22:45 +0200 (CEST)
Date: Thu, 24 Oct 2019 10:22:45 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Huth <huth@tuxfamily.org>
Subject: Re: [PATCH] ui: Print available display backends with '-display help'
Message-ID: <20191024082245.m4zaa4nhxmcsp2l5@sirius.home.kraxel.org>
References: <20191023134151.32011-1-huth@tuxfamily.org>
MIME-Version: 1.0
In-Reply-To: <20191023134151.32011-1-huth@tuxfamily.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: nHVlWF9EMnqFqwcaPtGEIg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

On Wed, Oct 23, 2019 at 03:41:51PM +0200, Thomas Huth wrote:
> We already print availabled devices with "-device help", or available
> backends with "-netdev help" or "-chardev help". Let's provide a way
> for the users to query the available display backends, too.

It isn't that simple, this fails to list backends built as module.

cheers,
  Gerd


