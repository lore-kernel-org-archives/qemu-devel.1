Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D55DC388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 12:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EECF8206CB
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 12:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csPOgDz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECF8206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc6Er-0007oG-RT
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 07:25:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kc6Dl-0006Z5-4Y
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 07:24:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kc6Dj-00083u-FG
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 07:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604924666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O3ncJjIKClnm4mdnUjMnVJ5nAhVWkAmYUe+T5xCdNbo=;
 b=csPOgDz10d4+nrySUU+wVYAZfZL6bPKoPCRVvDf40CEqqE1hIgFmpgxgkw9/a1RKE3IlkP
 7n4V5l4QsiFHq2N9S37QuJE0Z2VPHy4aBTRSL26FRYujfkTlBT+MsIVDtkHSwpxIto8KWY
 srDWFJC2ptnL0f9ahDqscAouxbXYPXw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-eB9y-6mhOYWJ8Wafo8rS1A-1; Mon, 09 Nov 2020 07:24:24 -0500
X-MC-Unique: eB9y-6mhOYWJ8Wafo8rS1A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 615F11019624;
 Mon,  9 Nov 2020 12:24:23 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-53.ams2.redhat.com [10.36.112.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CAD1C1002C01;
 Mon,  9 Nov 2020 12:24:21 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] fuzz: add virtio-blk fuzz target
To: Dima Stepanov <dimastep@yandex-team.ru>, qemu-devel@nongnu.org
References: <cover.1604920905.git.dimastep@yandex-team.ru>
 <e2405c459302ecaee2555405604975353bfa3837.1604920905.git.dimastep@yandex-team.ru>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ab97459c-f0e4-5f0d-455a-362001cca6ba@redhat.com>
Date: Mon, 9 Nov 2020 13:24:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <e2405c459302ecaee2555405604975353bfa3837.1604920905.git.dimastep@yandex-team.ru>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: stefanha@gmail.com, alxndr@bu.edu, yc-core@yandex-team.ru,
 darren.kenny@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/11/2020 12.25, Dima Stepanov wrote:
> The virtio-blk fuzz target sets up and fuzzes the available virtio-blk
> queues. The implementation is based on two files:
>   - tests/qtest/fuzz/virtio_scsi_fuzz.c
>   - tests/qtest/virtio_blk_test.c
> 
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  tests/qtest/fuzz/meson.build       |   1 +
>  tests/qtest/fuzz/virtio_blk_fuzz.c | 234 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 235 insertions(+)
>  create mode 100644 tests/qtest/fuzz/virtio_blk_fuzz.c

Thanks, I can add this to my next qtest-related pull request.
Note: I just spotted your patch by accident ... please put me on CC: if you
want me to merge qtest/fuzzer related patches.

 Thomas


