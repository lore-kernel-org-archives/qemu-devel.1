Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8EDC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7C120754
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9/xLkGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7C120754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO3GH-0008WR-DN
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 14:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kO396-00027b-Fp
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 14:17:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kO394-0002HC-41
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 14:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601576252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UXzznIjJVNS9qNIq9jmUcprvdsno5DoL8tPNsUgnK3Q=;
 b=C9/xLkGcHoSy3JcFrzcDeKoijG6sazLDT7HO02F6a/C5jXuwmh814pgjq/0PBOQWcagH0F
 CB7vBHa4IMFe4KQBUjfeNm7BitC1zyI9FNUPHafKilO7CEBPjNgWgrnSXISYROO74EXnhv
 otQsmgDVGBZEmUKgxAIqcwKTTZKc8fQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-AlIoXtmlNgOKY6xO0f9DIQ-1; Thu, 01 Oct 2020 14:17:28 -0400
X-MC-Unique: AlIoXtmlNgOKY6xO0f9DIQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8468210082EC;
 Thu,  1 Oct 2020 18:17:27 +0000 (UTC)
Received: from kaapi (unknown [10.40.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99C9A10013D7;
 Thu,  1 Oct 2020 18:17:24 +0000 (UTC)
Date: Thu, 1 Oct 2020 23:47:21 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Darren Kenny <darren.kenny@oracle.com>
Subject: Re: About 'qemu-security' mailing list
In-Reply-To: <m2mu166uyg.fsf@oracle.com>
Message-ID: <nycvar.YSQ.7.78.906.2010012320290.830962@xnncv>
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
 <CAFEAcA_9BVbqFCHJqS8jj6L3OqVNc60NCjAjRs516VyLH2EFfw@mail.gmail.com>
 <20200914101517.GD579094@stefanha-x1.localdomain>
 <nycvar.YSQ.7.78.906.2009151536090.10832@xnncv>
 <20200916111025.GA756728@stefanha-x1.localdomain>
 <nycvar.YSQ.7.78.906.2009181031500.10832@xnncv> <m2362z8dvx.fsf@oracle.com>
 <nycvar.YSQ.7.78.906.2010011502290.830962@xnncv> <m2mu166uyg.fsf@oracle.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ppandit@redhat.com;
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Thu, 1 Oct 2020, Darren Kenny wrote --+
| The storage of reproducers would indeed be good to have in something
| like Gitlab - but that'd require someone to extract it and store it, but
| under what naming would be another issue... But really that's behind the
| scenes.

  Yes.
 
| > Maybe we could start with a moderated list and improvise as we go forward?
| 
| I really think that encryption of the details of a vulnerability is 
| important, if somehow it gets intercepted - which is not that difficult with 
| e-mail - then there is the potential for a malicious party to exploit it 
| before a fix is available to distros, and deployed.

  Encrypted list, open to receive non-encrypted reports seems okay. Will have 
to check how to set it up and its workflow.
 
| Something that has happened since the Intel Spectre/Meltdown vulnerabilities 
| were initially brought to light is more communication between security teams 
| in various orgs. To do this those discussions have started being done on 
| Keybase, which provides secure chats as well as secured Git repos.
| 
| Has anything like that being considered as the point for subsequent 
| discussions on issues post the initial disclosure?

  That has not come up for QEMU issues yet. Maybe we could consider it in 
future if required.

+-- On Thu, 1 Oct 2020, Konrad Rzeszutek Wilk wrote --+
| The problem with Keybase was how to review patches. Now if they had a 
| encrypted mailing list as part of their Git repos that would be awesome. 
| (Trying to find a "Feature request" but not having much luck :-()

 True. Email + PGP/GPG has been around for so many years, yet there is no 
seamless combination of the two. :(

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


