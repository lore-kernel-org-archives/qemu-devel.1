Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839CBC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09316206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0Nro5xM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09316206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZW6e-0001BJ-2k
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 04:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZW5f-0000DB-1A
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:53:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49803
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZW5e-000530-An
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589532789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mJrSPM0o1vyfK/vK0WB1FpLtxusbMiSCx6LhemgltHU=;
 b=Z0Nro5xM1UBKZ6tBWUpK+0TiHMXoJyOHEXi4C1FFxMa52cNw/3CziA64BWNcN8CMt5AwBB
 nezmIivmmIRdvR0DQ9TFsF88AEte7H+Gd0J3LaC5EuUwEF0xPONFYIlk/VyJ6OoWyb1E0W
 qfFJZt8rL56j1TRkKZmn1AiFk3mS8x8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-qaIoIIapO9-oif-Lsj8IEg-1; Fri, 15 May 2020 04:53:08 -0400
X-MC-Unique: qaIoIIapO9-oif-Lsj8IEg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B4C1800053;
 Fri, 15 May 2020 08:53:07 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-110.ams2.redhat.com [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 221AB1057FCB;
 Fri, 15 May 2020 08:53:05 +0000 (UTC)
Date: Fri, 15 May 2020 10:53:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2] bitmaps: Update maintainer
Message-ID: <20200515085304.GB93011@linux.fritz.box>
References: <20200514180003.325406-1-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200514180003.325406-1-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.05.2020 um 20:00 hat Eric Blake geschrieben:
> Dirty bitmaps are important to incremental backups, including exposure
> over NBD where I'm already maintainer.  Also, I'm aware that lately I
> have been doing as much code/review on bitmaps as John Snow who is
> trying to scale back in order to focus elsewhere; and many of the
> recent patches have come from Vladimir, who is also interested in
> taking on maintainer duties, but would like to start with
> co-maintainership.  Therefore, it's time to revamp the ownership of
> this category, as agreed between the three of us.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Not sure if the opinion of the overall block maintainers even matters,
but just in case:

Acked-by: Kevin Wolf <kwolf@redhat.com>


