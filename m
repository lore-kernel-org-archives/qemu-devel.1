Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D16C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:29:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF7920754
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwA9yCju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF7920754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNyeE-0001VN-Me
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 09:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kNyd2-0000fB-Mv
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:28:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kNycw-00008K-NI
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601558885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tCCgH6JA2ANz0qAz6wAuWvx3wegQkvkMcm9dhLEVU+Q=;
 b=IwA9yCjuveOIGGij+jT95KOMNdvxBZ4HDAEdRr2QlRe+PAnHOm3q9KyYE2G0gHuZBf0lbF
 PHNaZ9cBbneReLUrj3BJqU9nrnzMWDZikxLAPOndDGeJa6FSxNKOQk5XpikOyln9zbPCF3
 JckPKMK14fsNIicCosd6cLRp91ilUrU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-X1LnKNe2NVOxfr0gxS2XcQ-1; Thu, 01 Oct 2020 09:28:04 -0400
X-MC-Unique: X1LnKNe2NVOxfr0gxS2XcQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35267107466B
 for <qemu-devel@nongnu.org>; Thu,  1 Oct 2020 13:28:03 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-92.ams2.redhat.com [10.36.114.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B0C25C1DA;
 Thu,  1 Oct 2020 13:27:59 +0000 (UTC)
Date: Thu, 1 Oct 2020 15:27:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] block/export: fix QAPI doc indentation style violation
Message-ID: <20201001132757.GA41938@linux.fritz.box>
References: <20201001131439.386431-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201001131439.386431-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 01.10.2020 um 15:14 hat Stefan Hajnoczi geschrieben:
> Since commit a69a6d4b4d4fae2e3d2506241e22a78ff1732283
> ("scripts/qapi/parser.py: improve doc comment indent handling") the QAPI
> generator emits an error when unindented text follows "Returns:".
> 
> Fix block-export.json by moving the comment to make the QAPI generator
> happy.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Based-on: git://repo.or.cz/qemu/kevin.git block

Sorry, this is a mismerge in my patches. When resolving the conflict, I
moved the paragraph up in the wrong definition: Should have been for
nbd-server-start, but I did it for NbdServerOptions (where it is still
at the bottom in master).

I'll fix up the broken commit instead of applying this on top. And I'll
leave in the unintentional change, because it actually makes sense, too.

Kevin


