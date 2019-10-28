Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9A3CA9EC2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88D5D20862
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwBHfNZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D5D20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP5Lf-0005Kk-TO
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 09:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iP51g-0004o9-KW
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 09:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iP51e-0005tO-Ae
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 09:25:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28270
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iP51e-0005nh-6U
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 09:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572269133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jGTExe9HJDAOZ8M1MhceSTlYxngBe6RqqAEIHsZHR7A=;
 b=IwBHfNZ07gETF6E2TJZD9ixHA4OgdpVYCDiDKZRkJfdErpubN/2OJZWQuXHj6mYSOJf69k
 RlIojzUJqAIuE1F0xdNdkUIT4Zp2YFBruJyqPP3ldTpuU5xo24fG3MTtfNWZV/yoz4a5JK
 ZxEfsuYdj1QMziM1YV147DxEx3coNzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-RndUgKpaNwmHj-bY5TNQMg-1; Mon, 28 Oct 2019 09:25:29 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6053801E56;
 Mon, 28 Oct 2019 13:25:28 +0000 (UTC)
Received: from work-vm (ovpn-116-216.ams2.redhat.com [10.36.116.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22D082634E;
 Mon, 28 Oct 2019 13:24:59 +0000 (UTC)
Date: Mon, 28 Oct 2019 13:24:56 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 00/30] virtiofs daemon (base)
Message-ID: <20191028132456.GA2961@work-vm>
References: <20191021105832.36574-1-dgilbert@redhat.com>
 <20191027091007-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191027091007-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: RndUgKpaNwmHj-bY5TNQMg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-devel@nongnu.org, piaojun@huawei.com, stefanha@redhat.com,
 marcandre.lureau@redhat.com, eguan@linux.alibaba.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Mon, Oct 21, 2019 at 11:58:02AM +0100, Dr. David Alan Gilbert (git) wr=
ote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > Hi,
> >   This is the 1st set for the virtiofsd - a daemon
> > that implements the user space side of virtiofs.
> >=20
> >   The kernel and qemu device parts recently went in,
> > so the daemon is the only thing missing to have a working
> > set.
> >=20
> >   This set is the absolute minimal base set of patches;
> > it's not yet safe to use (from security or correctness);
>=20
> So based on this I'm guessing we don't want to rush this in
> before the soft freeze.
> If you have a different opinion, let me know pls.

With the 2nd set that I posted on thursday, the '(security)' set
it becomes safe - with full sandboxing and path verification.
Now, we do have a pile of separate small fixes, and threading code
stuff; but we cna leave those off.

Dave

> --=20
> MST
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


