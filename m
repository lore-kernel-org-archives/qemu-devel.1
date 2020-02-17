Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7339C7619B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0CC420725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hj7KJhyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0CC420725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3bgk-0006wi-T4
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 03:23:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j3bf9-0005VN-3m
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:21:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j3bf7-0000h4-9N
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:21:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42565
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j3bf6-0000fT-G9
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581927711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lLC6hvry3al3USDaACNa83FXWkKprfzMAPP542CsDZU=;
 b=hj7KJhyV0+2bUhaC2EUXj34Dx9sCmFDueaoZULHECkTz6WgkTvK0eLP5w2Xwue3+zXPVhF
 2Bh2hefxmqjF6MaoaTQbALe1Q3sXRZsSPSsRgXjsVI+JKAIiGgiIe2zYstzBucTvO5xtX4
 0KASr7I1eZpg8ucIn1v07MTHhtYGWlE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-_pe6ig_nMZCeEP5kgy3YPA-1; Mon, 17 Feb 2020 03:21:49 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 218388017CC;
 Mon, 17 Feb 2020 08:21:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com
 [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA2B690531;
 Mon, 17 Feb 2020 08:21:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 02C9A16E1A; Mon, 17 Feb 2020 09:21:47 +0100 (CET)
Date: Mon, 17 Feb 2020 09:21:46 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 0/2] hw/arm/xilinx_zynq: Fix USB port instantiation
Message-ID: <20200217082146.7zzrcdv6drtnxblu@sirius.home.kraxel.org>
References: <20200215122354.13706-1-linux@roeck-us.net>
MIME-Version: 1.0
In-Reply-To: <20200215122354.13706-1-linux@roeck-us.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: _pe6ig_nMZCeEP5kgy3YPA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Feb 15, 2020 at 04:23:52AM -0800, Guenter Roeck wrote:
> USB ports on Xilinx Zync must be instantiated as TYPE_CHIPIDEA to work.
> Linux expects and checks various chipidea registers, which do not exist
> with the basic ehci emulation. This patch series fixes the problem.
>=20
> The first patch in the series fixes the actual problem.
>=20
> The second patch removes the now obsolete explicit Xilinx
> support from the EHCI code.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>


