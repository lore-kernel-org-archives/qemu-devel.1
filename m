Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AB0C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:11:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F032224F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ymd9PImY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F032224F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUsM5-00014F-BH
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 10:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kUsJy-0008KD-SW
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 10:09:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32072)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kUsJv-0005u3-PT
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 10:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603202939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0N96Rd726+74B/Tl0yla2QtpD2xDW5Elm8YFTtptrpI=;
 b=Ymd9PImYmAUDhfrbaCW4ON6nhwhu1rEkuVWM51XrORKJNHIiE2wMysl51MOIxqtiXrIMoT
 gEesjJiX7qp9VH8jPh9aoUjvb130ScosaNONSj2l84dF7h0zXOncqZahhkWGkvNc8efuJD
 VBSYeE/yUmIH/jM7jXo6R+qO8iReSQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-x3shb2MVOqmzpFSo0lqVMw-1; Tue, 20 Oct 2020 10:08:57 -0400
X-MC-Unique: x3shb2MVOqmzpFSo0lqVMw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF4091006C8D;
 Tue, 20 Oct 2020 14:08:55 +0000 (UTC)
Received: from kaapi (ovpn-112-157.phx2.redhat.com [10.3.112.157])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F6C127C2A;
 Tue, 20 Oct 2020 14:08:52 +0000 (UTC)
Date: Tue, 20 Oct 2020 19:38:49 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Stefan Hajnoczi <stefanha@gmail.com>, peter.maydell@linaro.org
Subject: Re: About 'qemu-security' mailing list
In-Reply-To: <nycvar.YSQ.7.78.906.2010161910530.1246156@xnncv>
Message-ID: <nycvar.YSQ.7.78.906.2010201935590.1506567@xnncv>
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
 <CAFEAcA_9BVbqFCHJqS8jj6L3OqVNc60NCjAjRs516VyLH2EFfw@mail.gmail.com>
 <20200914101517.GD579094@stefanha-x1.localdomain>
 <nycvar.YSQ.7.78.906.2009151536090.10832@xnncv>
 <20200916111025.GA756728@stefanha-x1.localdomain>
 <nycvar.YSQ.7.78.906.2009181031500.10832@xnncv> <m2362z8dvx.fsf@oracle.com>
 <nycvar.YSQ.7.78.906.2010011502290.830962@xnncv> <m2mu166uyg.fsf@oracle.com>
 <nycvar.YSQ.7.78.906.2010012320290.830962@xnncv>
 <nycvar.YSQ.7.78.906.2010161910530.1246156@xnncv>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Darren Kenny <darren.kenny@oracle.com>,
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Fri, 16 Oct 2020, P J P wrote --+
| * So ie. we need to:
| 
|   1. Create/setup a regular non-encrypted 'qemu-security' list.
| 
|   2. Invite representatives from user/downstream communities to subscribe to 
|      it.
| 
|   3. Collect & store their PGP public keys. Also create a key for the list.
| 
|   4. Write 'encrypt & email' automation tool(s) to provide encryption support.
| 
|   5. Document and publish above details and list workflow on a page.
| 
| ...wdyt?

Ping..! (just checking; probably folks are buys with KVMForum I guess)
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


