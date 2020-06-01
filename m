Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11FCC433E3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DBF620679
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZV9jK2zE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBF620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfpY6-0003uT-Q0
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jfpXG-0003VH-Lm
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 14:51:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36277
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jfpXF-0003LA-8p
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 14:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591037502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=giF9zrkt85KKHKiC3HJqMPGwOm/gXy3AZLwzZPnDfvc=;
 b=ZV9jK2zEx76pTwYhBRO/jNJRNzTAuFG+uWb0QFy9v1NLK1ZeSKiKQeXl8UNTkbB/OzT8+x
 GOqdiIGpLGby8FiuDDttiyFvdiYH0kGn/V/+sgKkv7fUAH5FrypMc5gxjfQd5CfCkojlcv
 M9udclpD9ZfXpRfrG4aT+0xOnA+7lkQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-AJDNfieoN0OzzYxoeRZq5g-1; Mon, 01 Jun 2020 14:51:41 -0400
X-MC-Unique: AJDNfieoN0OzzYxoeRZq5g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B53A58014D4;
 Mon,  1 Jun 2020 18:51:39 +0000 (UTC)
Received: from work-vm (ovpn-113-144.ams2.redhat.com [10.36.113.144])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A7AC60C81;
 Mon,  1 Jun 2020 18:51:38 +0000 (UTC)
Date: Mon, 1 Jun 2020 19:51:35 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com>,
 brijesh.singh@amd.com, pbonzini@redhat.com
Subject: Re: [PATCH 0/2] Add support for SEV Launch Secret Injection
Message-ID: <20200601185135.GC2738@work-vm>
References: <20200528205114.42078-1-tobin@linux.vnet.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200528205114.42078-1-tobin@linux.vnet.ibm.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 13:44:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
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
Cc: jejb@linux.ibm.com, tobin@ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cc'ing in Brijesh for SEV stuff, and also Paolo.

* Tobin Feldman-Fitzthum (tobin@linux.vnet.ibm.com) wrote:
> This patchset contains two patches. The first enables QEMU
> to facilitate the injection of a secret blob into the guest
> memory.
> 
> The second enables QEMU to parse the guest ROM to determine
> the address at which the secret should be injected.
> 
> Tobin Feldman-Fitzthum (2):
>   sev: add sev-inject-launch-secret
>   sev: scan guest ROM for launch secret address
> 
>  include/sysemu/sev.h       |   2 +
>  qapi/misc-target.json      |  20 +++++++
>  target/i386/monitor.c      |   8 +++
>  target/i386/sev-stub.c     |   5 ++
>  target/i386/sev.c          | 113 +++++++++++++++++++++++++++++++++++++
>  target/i386/sev_i386.h     |  16 ++++++
>  target/i386/trace-events   |   1 +
>  tests/qtest/qmp-cmd-test.c |   6 +-
>  8 files changed, 168 insertions(+), 3 deletions(-)
> 
> -- 
> 2.20.1 (Apple Git-117)
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


