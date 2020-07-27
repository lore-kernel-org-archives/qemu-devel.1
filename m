Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C72C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 05:47:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D120620656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 05:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4l/g7YS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D120620656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzvyY-0007ub-51
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 01:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jzvxn-0007O6-OF
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 01:46:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60231
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jzvxm-0006lL-Be
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 01:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595828773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=Eptem89ZkdnZqEqSQLVjZe7xH7w35ZWuqn3Z9TsZH4Q=;
 b=U4l/g7YSs62zJkL+pUDS+7NQMmfn8Re7HCQsko6x/o8GIHwp14TU3OPHQHq0RSocIU2jc9
 5VUiMW1TI6aSJmdUd4VlVbnDkF1NYm2kxqxfRgUy6RINZxz1Zt3bPgCB+cZ9ekT1M+Q8rN
 BQ9tpOacdE/QMbfqqTzNDVsC/gXU1G8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-E783xLubNkuoqWQqqRiNGA-1; Mon, 27 Jul 2020 01:46:11 -0400
X-MC-Unique: E783xLubNkuoqWQqqRiNGA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 285651005504;
 Mon, 27 Jul 2020 05:46:10 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-156.ams2.redhat.com [10.36.112.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B613310013D0;
 Mon, 27 Jul 2020 05:46:01 +0000 (UTC)
Subject: Re: [PATCH] qemu-options.hx: Fix typo for netdev documentation
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20200727045925.29375-1-tianjia.zhang@linux.alibaba.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d7eab1b6-4e30-2d23-7bec-0afedaeb60d4@redhat.com>
Date: Mon, 27 Jul 2020 07:46:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200727045925.29375-1-tianjia.zhang@linux.alibaba.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, mst@redhat.com, kraxel@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/07/2020 06.59, Tianjia Zhang wrote:
> This patch fixes the netdev document description typo in qemu-option.hx.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  qemu-options.hx | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 708583b4ce..92556ed96d 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2684,7 +2684,7 @@ SRST
>      disable script execution.
>  
>      If running QEMU as an unprivileged user, use the network helper
> -    helper to configure the TAP interface and attach it to the bridge.
> +    to configure the TAP interface and attach it to the bridge.
>      The default network helper executable is
>      ``/path/to/qemu-bridge-helper`` and the default bridge device is
>      ``br0``.

Reviewed-by: Thomas Huth <thuth@redhat.com>


