Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45883C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 06:32:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C099208C4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 06:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C099208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvyRX-0001Gy-7b
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 02:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45287)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvyR9-0000p8-DU
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvyR8-00052K-Df
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:31:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59676)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvyR8-00051G-8N
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:31:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A5FC93073A23;
 Fri,  9 Aug 2019 06:31:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6100460BF1;
 Fri,  9 Aug 2019 06:31:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D14AE113864E; Fri,  9 Aug 2019 08:31:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20190808164117.23348-1-alex.bennee@linaro.org>
Date: Fri, 09 Aug 2019 08:31:20 +0200
In-Reply-To: <20190808164117.23348-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Thu, 8 Aug 2019 17:41:10 +0100")
Message-ID: <87lfw2alzb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 09 Aug 2019 06:31:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH  v1 0/7] softfloat header cleanups
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Hi Markus,
>
> As promised here is a softfloat specific follow-up to your headers
> clean-up series:
>
>   From: Markus Armbruster <armbru@redhat.com>
>   Date: Tue,  6 Aug 2019 17:14:06 +0200
>   Message-Id: <20190806151435.10740-1-armbru@redhat.com>
>   Subject: [Qemu-devel] [PATCH v2 00/29] Tame a few "touch this, recompil=
e the world" headers
>
> The first few patches do a little light re-organising of the header
> files and some renaming. The remaining patches then rationalise the
> header usage in the targets mostly by removing the inclusion of
> softfloat.h from cpu.h which is most likely to trigger the largest
> number of rebuilds.

Neat!

> I'm happy for you to pull these straight into your larger series if
> you want otherwise I'll collect tags and submit once the tree
> re-opens.

What about this: I post my v3 of my series to address the reviews of v2,
you post a v2 of yours if necessary.  Once both are ready, I do the pull
request.  If yours is ready, but mine needs another respin, I can pick
yours into my respin, to take it off your hands.  Okay?

