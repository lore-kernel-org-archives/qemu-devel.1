Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259A5C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 08:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E30342065E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 08:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRdyH5vy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30342065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2VTH-000308-Pz
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 04:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k2VSi-0002bJ-Ko
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 04:04:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27843
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k2VSf-0001Yl-SK
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 04:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596441884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7owg6uhmRsmYtGtR7slLFk3UXl0QYT0r5QN7NXL9m1o=;
 b=LRdyH5vyk1FIB9q9WzAbYG78t8DPH86EVWt6pSk5+1WBzd4Ka/SCQiWBbnkp0q47yf2qSL
 jY3YrQpbiLKr7hk170r2iIvd9XJmbZGTSTf3fWoB8v9tLURKIcFSTsfgih4hNQ11aKd9WD
 yiSXF+CJRL0FiihDpWAh0GEG0E30HiY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-BMqJmu5qP8GwKlW1IHY60Q-1; Mon, 03 Aug 2020 04:04:40 -0400
X-MC-Unique: BMqJmu5qP8GwKlW1IHY60Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9B5F106B243;
 Mon,  3 Aug 2020 08:04:39 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0017C1002393;
 Mon,  3 Aug 2020 08:04:38 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D62A217447; Mon,  3 Aug 2020 10:04:37 +0200 (CEST)
Date: Mon, 3 Aug 2020 10:04:37 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Michael Brown <mcb30@ipxe.org>
Subject: Re: [ipxe-devel] https booting
Message-ID: <20200803080437.wlyslxdhuzlfacgn@sirius.home.kraxel.org>
References: <20200722120827.dq72uabrk26nllra@sirius.home.kraxel.org>
 <73923bb0-0a75-d8f1-fa49-87994e5354db@ipxe.org>
MIME-Version: 1.0
In-Reply-To: <73923bb0-0a75-d8f1-fa49-87994e5354db@ipxe.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 01:24:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: ipxe-devel@lists.ipxe.org,
 =?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > After looking at https://ipxe.org/cfg/crosscert I'm not convinced this
> > is a good idea though.  This would likely put quite some load to
> > ca.ipxe.org.  Also that machine becomes a single point of failure for
> > worldwide ipxe https boot, and looking through the mailing list I've
> > seen we already had (at least) two outages this year.
> 
> The crosscert fetches are static files (with iPXE including a query string
> only for debugging purposes), and it should be fairly straightforward for me
> to switch to hosting them in AWS S3 or equivalent.  The ca.ipxe.org domain
> is not used for anything else so could be pointed at a new hosting
> infrastructure with no disruption or code changes.

It's also simple to create a mirror, for example to serve machines
without direct internet connection.

> I would worry more about the OCSP service for the cross-signed certificates,
> since OCSP does not just serve static responses.  This service is currently
> implemented using openca-ocspd running on a VM in AWS.  I'm very open to
> suggestions on more scalable ways to host this.

How much of the crosscert creation process is (or can can be) automated?

Is it an option to update the certificates much more frequently?  Say
generate them every three days, be valid for 7 days (instead of 90)?
Then just don't run a OCSP service?

take care,
  Gerd


