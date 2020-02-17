Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27266C34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 14:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7AC3207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 14:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFbOzt+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7AC3207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3haU-0004of-5k
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 09:41:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1j3hZf-0004I9-GS
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 09:40:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1j3hZd-0004eb-PL
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 09:40:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41119
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1j3hZd-0004e4-G7
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 09:40:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581950436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=akBZ9T3Vst2g3JlAb/zL9TSL8mhRZ4hYWwajPlV8i+k=;
 b=iFbOzt+oQgV9HPeGpKciKISpmzZGGGfzwoPm0AYz7d9p/YZiUeglFWppuHQqe+HfbpV5vU
 uw26iL7IRtZy02V6XrYoIhPjns09FeV7Zki6xY9kfAjc7MvPvcqi61RIC7pLzkaovbfDhK
 h/JnbQwdZIV1JAQ+VSwQUR2/UUyvHsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-lIqiz8y9NjSi8jv18da_gg-1; Mon, 17 Feb 2020 09:40:34 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63541107ACC9;
 Mon, 17 Feb 2020 14:40:33 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-116-113.ams2.redhat.com
 [10.36.116.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 533B3194BB;
 Mon, 17 Feb 2020 14:40:31 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 14F683E0489; Mon, 17 Feb 2020 15:40:24 +0100 (CET)
Date: Mon, 17 Feb 2020 15:40:23 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v3] qemu-cpu-models: Document -noTSX, mds-no, taa-no, and
 tsx-ctrl
Message-ID: <20200217144023.GC25927@paraplu>
References: <20200127121625.27078-1-kchamart@redhat.com>
 <20200210140353.GB25927@paraplu>
MIME-Version: 1.0
In-Reply-To: <20200210140353.GB25927@paraplu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: lIqiz8y9NjSi8jv18da_gg-1
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
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, berrange@redhat.com,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 10, 2020 at 03:03:53PM +0100, Kashyap Chamarthy wrote:
> Ping.

I'm going to convert this entire doc (qemu-cpu-models.texi) to rST, and
send it to the list as a separate change.  (Including the content of
this patch.)

[...]

--=20
/kashyap


