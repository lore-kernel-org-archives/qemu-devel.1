Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93456C388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:23:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCB86208B6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSCCsS/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB86208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZuOw-0007n6-Kd
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 06:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kZuL7-0006Nx-3z
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:19:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kZuL4-0003iU-1o
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:19:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604402335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EAeQ5/Jo2c/2thI0ZrCMUz59e04yd31oXdxP1WgsShQ=;
 b=SSCCsS/iBC+8boiUbfNCyyws+5+pLmFFHBfrbMubitPF5I0dHyUWYwwuEx+vmnhS0kifdK
 iXqCuGWLAPU5XP3M72J3nxlkeLnq4C8dgBCLsj4+My8Xl+ZL/+G6uHLpZ5VW+RSVfMtp23
 pmu7xiwfZ+jkziJE8Uj3NXntXFCGgzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-lUuFpB6CNwGy6n6uCJWFJA-1; Tue, 03 Nov 2020 06:18:54 -0500
X-MC-Unique: lUuFpB6CNwGy6n6uCJWFJA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDA6E1084D6F;
 Tue,  3 Nov 2020 11:18:52 +0000 (UTC)
Received: from kaapi (unknown [10.33.36.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F33755794;
 Tue,  3 Nov 2020 11:18:50 +0000 (UTC)
Date: Tue, 3 Nov 2020 16:48:47 +0530 (IST)
From: P J P <ppandit@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: About 'qemu-security' mailing list
In-Reply-To: <nycvar.YSQ.7.78.906.2010201935590.1506567@xnncv>
Message-ID: <rrq49r0-qr6p-23o0-n1pr-364189541118@erqung.pbz>
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
 <CAFEAcA_9BVbqFCHJqS8jj6L3OqVNc60NCjAjRs516VyLH2EFfw@mail.gmail.com>
 <20200914101517.GD579094@stefanha-x1.localdomain>
 <nycvar.YSQ.7.78.906.2009151536090.10832@xnncv>
 <20200916111025.GA756728@stefanha-x1.localdomain>
 <nycvar.YSQ.7.78.906.2009181031500.10832@xnncv> <m2362z8dvx.fsf@oracle.com>
 <nycvar.YSQ.7.78.906.2010011502290.830962@xnncv> <m2mu166uyg.fsf@oracle.com>
 <nycvar.YSQ.7.78.906.2010012320290.830962@xnncv>
 <nycvar.YSQ.7.78.906.2010161910530.1246156@xnncv>
 <nycvar.YSQ.7.78.906.2010201935590.1506567@xnncv>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
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
Cc: peter.maydell@linaro.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Darren Kenny <darren.kenny@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Tue, 20 Oct 2020, P J P wrote --+
| +-- On Fri, 16 Oct 2020, P J P wrote --+
| | * So ie. we need to:
| | 
| |   1. Create/setup a regular non-encrypted 'qemu-security' list.
| | 
| |   2. Invite representatives from user/downstream communities to subscribe to 
| |      it.
| | 
| |   3. Collect & store their PGP public keys. Also create a key for the list.
| | 
| |   4. Write 'encrypt & email' automation tool(s) to provide encryption support.
| | 
| |   5. Document and publish above details and list workflow on a page.
| | 
| | ...wdyt?
|

Ping...!
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


