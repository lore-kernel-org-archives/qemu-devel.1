Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C9BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:00:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37F0520789
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AawXM3fl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F0520789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3yG-0000i7-0l
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 05:00:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kc3vK-0006Xe-Sk
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:57:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50126)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kc3vJ-00078g-3b
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604915836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7I5wIb8Vmj8xNMgAvSDuwr8jznckF+9Q0z4yOcl8fhs=;
 b=AawXM3fl92keGQWEapZQ+YB4Xq7ApJ7Ovun0Bzx8c4pv7cHz0yTyp4M+QWRa/yaUjiot7T
 kWwEBjWOdctDf2ToI0+0sHbfrW+ascrAw6lloVmbcgNF/8Rl7P7RNUEavNftvsG7Cyc70X
 FWHXJQrPoxdv+YbDVEh5J6xk4soNx9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-Vh3jmKRgMdqCjXk6NK3uAg-1; Mon, 09 Nov 2020 04:57:12 -0500
X-MC-Unique: Vh3jmKRgMdqCjXk6NK3uAg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99D8E1868424;
 Mon,  9 Nov 2020 09:57:10 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-53.ams2.redhat.com [10.36.112.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C0E21002C00;
 Mon,  9 Nov 2020 09:57:06 +0000 (UTC)
Subject: Re: [PATCH v3 09/11] gitlab-ci: Add rules to select cross-jobs to
 build
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201108221925.2344515-1-philmd@redhat.com>
 <20201108221925.2344515-10-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2e1683bb-4d38-eb31-cbe5-e3ba4eecc93b@redhat.com>
Date: Mon, 9 Nov 2020 10:57:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201108221925.2344515-10-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/11/2020 23.19, Philippe Mathieu-Daudé wrote:
> Add rules to select some crossbuild jobs.
> 
> The following tags are available to restrict the CI jobs:
> - all    (select all jobs, this is default)
> - cross  (select all cross-jobs)
> - system (select all cross-system jobs)
> - user   (select all cross-user jobs)
> - $ARCH  (select an architecture: arm/mips/ppc/sparc/...)
> 
> Developers can combine tags in the QEMU_BUILD variable when
> pushing a branch (or tag) to repositories. Examples:
> 
>   $ git push -o ci.variable="QEMU_BUILD=user"        myrepo mybranch
>   $ git push -o ci.variable="QEMU_BUILD=user,system" myrepo mybranch

That looks interesting, but I think the changes are too big for including
them at this point in time, so I'd like to postpone this to the 6.0 cycle
(so please respin the series after the 5.2 release).

Also this certainly needs to be documented in a file in the docs/ folder -
otherwise you'll be the only one who's using this feature, I guess...

 Thanks,
  Thomas


