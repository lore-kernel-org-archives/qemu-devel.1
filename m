Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFCCC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 525AC2071B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZqN5kcMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525AC2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw0TA-0007ji-IF
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 05:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jw0SB-0007I9-R8
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 05:45:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31246
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jw0S9-0005Mf-L0
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 05:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594892719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qnemkRmGF1INhsfEE4Qxt1F9i3Sg+u9+XjiwjF4eaXA=;
 b=ZqN5kcMHd3AYyEuuikZ4IXi6Abi9SjZkMeWVCgStcdCylXGTxvOFMKr8ctZTxN9sGsoyWl
 m2MtrTHTXrHjZvdbCz1TAYvhKTOGhZuc+8ZfoX48EL2goFFLChrGTm4f16uMIFSOn+4dup
 Yw2oCNrz459SZERBtq1AehGVee1wr0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-53zU5oyYMvOEeiFVJDOJaw-1; Thu, 16 Jul 2020 05:45:18 -0400
X-MC-Unique: 53zU5oyYMvOEeiFVJDOJaw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A44B08027F4;
 Thu, 16 Jul 2020 09:45:16 +0000 (UTC)
Received: from kaapi (unknown [10.40.192.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C84AC72AD9;
 Thu, 16 Jul 2020 09:44:54 +0000 (UTC)
Date: Thu, 16 Jul 2020 15:14:51 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: introduce cve or security quotient field
In-Reply-To: <20200716085656.GA7813@work-vm>
Message-ID: <nycvar.YSQ.7.78.906.2007161503230.950384@xnncv>
References: <20200714083631.888605-1-ppandit@redhat.com>
 <20200714083631.888605-2-ppandit@redhat.com> <20200716085656.GA7813@work-vm>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:55:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Thu, 16 Jul 2020, Dr. David Alan Gilbert wrote --+
| > +	C: CVE/Security/Trust Quotient
| > +	   H:High - Feature (or code) is meant to be safe and used by untrusted
| > +	            guests. So any potential security issue must be processed with
| > +	            due care and be considered as a CVE issue.
| > +	   L:Low  - Feature (or code) is not meant to be safe OR is experimental
| > +	            OR is used in trusted environments only OR is not well
| > +	            maintained. So any potential security issue can be processed
| > +	            and fixed as regular non-security bug. No need for a CVE.
| 
| That's a lot of OR's and it causes problems;
| ....

  Yes, I started with the MAINTAINERS file thinking at least some segregation 
would be a step forward than nothing.
 
| >  QMP
| >  M: Markus Armbruster <armbru@redhat.com>
| >  S: Supported
| > +C: Low
| >  F: monitor/monitor-internal.h
| >  F: monitor/qmp*
| >  F: monitor/misc.c
| 
| QMP is critical to many uses, so you wouldn't want to exclude it from a secure build;
| any security issue with it (e.g. misparsing an argument) would be very
| serious and would need to be looked at;

   No, High OR Low was not for excluding it from any build. It was merely an 
indication to a user to decide whether an issue should be treated as a CVE one 
or can be fixed as regular bug.

| but QMP is expected to be talking to another trusted endpoint.

  True; I set it to Low as QMP interface access is mostly given to privileged 
trusted users.


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


