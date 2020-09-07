Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F4CC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8785F206E6
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IG98KlAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8785F206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFGOE-00084B-Gh
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 08:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFGMg-0007Jh-4Q
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:35:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45118
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFGMe-0001uo-7a
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599482111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4StzUHKtUzuf1zJej7isgerwH/Zq3s4ignRq8PmSjtg=;
 b=IG98KlAX6PSJb3HTn6y7zhtwOGAEjAH5169Ymnk7fl6P09wtry7lV4DgTeym0hXQSAS/Km
 X8kHZfkBX25DfM4UjwDhsiKemXLeAR1BEqflBQ0JqDf4H/mjeBFewY6Allb7qwhm2/oV6H
 YV8vbIrZAwApyI7Avj+syPwoTVkroI0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-vqvh3BqiPLyWfRnhcPQzzA-1; Mon, 07 Sep 2020 08:35:09 -0400
X-MC-Unique: vqvh3BqiPLyWfRnhcPQzzA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 076FB80EF84;
 Mon,  7 Sep 2020 12:35:08 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-193.ams2.redhat.com [10.36.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F06C17EEDC;
 Mon,  7 Sep 2020 12:35:06 +0000 (UTC)
Subject: Re: [PATCH] tests/vm: Add Haiku test based on their vagrant images
To: Alexander von Gluck IV <kallisti5@unixzen.com>, qemu-devel@nongnu.org
References: <20200906143439.1924930-1-kallisti5@unixzen.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <56d46156-cba5-c6bd-8c58-5ea5b0b28f40@redhat.com>
Date: Mon, 7 Sep 2020 14:35:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200906143439.1924930-1-kallisti5@unixzen.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:05:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.825, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Carlier <devnexen@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/09/2020 16.34, Alexander von Gluck IV wrote:
> Signed-off-by: Alexander von Gluck IV <kallisti5@unixzen.com>
> ---
>  tests/keys/vagrant     |  27 +++++++++
>  tests/keys/vagrant.pub |   1 +
>  tests/vm/basevm.py     |   5 +-
>  tests/vm/haiku.x86_64  | 121 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 152 insertions(+), 2 deletions(-)
>  create mode 100644 tests/keys/vagrant
>  create mode 100644 tests/keys/vagrant.pub
>  create mode 100755 tests/vm/haiku.x86_64

In case you respin this patch: Please also add a line to the output of
"make vm-help" in tests/vm/Makefile.include.

Thanks,
 Thomas


