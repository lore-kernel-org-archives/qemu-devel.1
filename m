Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72003C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 450D0214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxuJeNca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450D0214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94nN-00082b-EU
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j94mU-0006ZM-SJ
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:28:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j94mT-0005rM-UG
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:28:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42608
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j94mT-0005qe-M6
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583231284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qgbf6LEz+dGERiuQP+Ed25W184E5gJySH4/umi6lc2g=;
 b=LxuJeNca3alD/Orku3zWsiVZc0yS4veMy372HmErTdC2FFm1QYWtSuTXeTNA8uW+YpxiHk
 1AmkgcSQPr2Eg4nFpAH7L2llIZ50LzFtxzbX04LnKTbF17sSbPPfy4gjzr6uq8P9I7Sqg5
 k8ff6a7/6UpZLHYhbh8yNHsUH/2k6Bw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-G0ylnslON-q7DBKXSORkmA-1; Tue, 03 Mar 2020 05:28:03 -0500
X-MC-Unique: G0ylnslON-q7DBKXSORkmA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E13B801E6D;
 Tue,  3 Mar 2020 10:28:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-150.ams2.redhat.com
 [10.36.116.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4CD0360C80;
 Tue,  3 Mar 2020 10:28:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 096BC17535; Tue,  3 Mar 2020 11:28:00 +0100 (CET)
Date: Tue, 3 Mar 2020 11:28:00 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Chen Qun <kuhn.chenqun@huawei.com>
Subject: Re: [PATCH v3 11/12] usb/hcd-ehci: Remove redundant statements
Message-ID: <20200303102800.mz3hdpv36cii7t4e@sirius.home.kraxel.org>
References: <20200302130715.29440-1-kuhn.chenqun@huawei.com>
 <20200302130715.29440-13-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200302130715.29440-13-kuhn.chenqun@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Euler Robot <euler.robot@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 02, 2020 at 09:07:14PM +0800, Chen Qun wrote:
> The "again" assignment is meaningless before g_assert_not_reached.
> In addition, the break statements no longer needs to be after
> g_assert_not_reached.
>=20
> Clang static code analyzer show warning:
> hw/usb/hcd-ehci.c:2108:13: warning: Value stored to 'again' is never read
>             again =3D -1;
>             ^       ~~
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Acked-by: Gerd Hoffmann <kraxel@redhat.com>


