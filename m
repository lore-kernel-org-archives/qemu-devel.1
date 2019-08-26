Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB63C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 13:40:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B47A7217F5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 13:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47A7217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2FEL-0003z7-VS
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 09:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i2FDX-0003Vv-CE
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i2FDW-00087U-AD
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:39:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35626)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i2FDU-00085T-02; Mon, 26 Aug 2019 09:39:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 20913308FC22;
 Mon, 26 Aug 2019 13:39:27 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C08F360BE2;
 Mon, 26 Aug 2019 13:39:19 +0000 (UTC)
Message-ID: <1d416bb16a97942526d53a1028f14f96be68ba92.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Eric Blake <eblake@redhat.com>, "Daniel P." =?ISO-8859-1?Q?Berrang=E9?=
 <berrange@redhat.com>
Date: Mon, 26 Aug 2019 16:39:18 +0300
In-Reply-To: <0cd8b90e-db47-676d-bb5a-25c70a1c1598@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-7-mlevitsk@redhat.com>
 <20190822110448.GK3267@redhat.com>
 <ba3ddc4c3c6dd18b7a7c913e55e52ddc8c9efeb0.camel@redhat.com>
 <cd92c8fe167d241255b3f61aca39b693364bf225.camel@redhat.com>
 <0cd8b90e-db47-676d-bb5a-25c70a1c1598@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 26 Aug 2019 13:39:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 06/13] qcrypto-luks: implement more
 rigorous header checking
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-08-26 at 08:31 -0500, Eric Blake wrote:
> On 8/25/19 11:08 AM, Maxim Levitsky wrote:
> 
> > > > I'd do a separate check for stripes and active fields, and then give a
> > > > specific error message for each. That way if this does ever trigger
> > > > in practice will immediately understand which check failed.
> > > > 
> > > > Also using '%d' rather than '%i' is more common convention
> > > 
> > > Done.
> > 
> > Note that I switched i,j to be size_t since you said that you prefer this,
> > and to print this I apparently need %lu.
> 
> Actually, for size_t, you need %zu. %lu/size_t will cause warnings on
> 32-bit platforms.
> 
> 
Thank you!
I have read something like that on the internet, but I wondered,
what actually is the most portable way.

Best regards,
	Maxim Levitsky


