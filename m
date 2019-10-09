Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB49C4360C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 01:30:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11CF320859
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 01:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CF320859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iI0nh-0001Qa-4i
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 21:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iI0mx-0000id-EA
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iI0mw-0000GR-Fd
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:29:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46028)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>)
 id 1iI0ms-0000FB-Gp; Tue, 08 Oct 2019 21:29:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 830CB83F4C;
 Wed,  9 Oct 2019 01:29:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-151.rdu2.redhat.com
 [10.10.122.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBF6260167;
 Wed,  9 Oct 2019 01:28:59 +0000 (UTC)
Date: Tue, 8 Oct 2019 21:28:57 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 02/19] hw/arm/bcm2835_peripherals: Improve logging
Message-ID: <20191009012857.GA22824@localhost.localdomain>
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-3-f4bug@amsat.org>
 <874l0jk3w6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <874l0jk3w6.fsf@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 09 Oct 2019 01:29:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?iso-8859-1?Q?Zolt=E1n?= Baldaszti <bztemail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-devel@nongnu.org, Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 08, 2019 at 10:00:57AM +0100, Alex Benn=E9e wrote:
>=20
> Philippe Mathieu-Daud=E9 <f4bug@amsat.org> writes:
>=20
> > Various logging improvements as once:
> > - Use 0x prefix for hex numbers
>=20
> You can use "%#"PRIxNN"" as an alternative I believe but anyway:
>

Unless the value given to the formatting string is zero, then the "0x"
prefix is not applied to the resulting string.

> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

