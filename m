Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA128C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 01:58:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F389523A74
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 01:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeVqAV2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F389523A74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKXZe-00056I-1P
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 21:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kKXYD-0003vt-Ts
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 21:57:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32220
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kKXYB-0001Lt-R8
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 21:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600739819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1jmJqVTaCguvYRFK46oldC4CkptLT+47dIyz3YvyfiY=;
 b=XeVqAV2NQv6qFZmwp1f4ULO4QkpWzuaQ6iVhV8eaQV6GuIF8HyfbV0QGNGcZAqccaj2pD6
 R6OzJBod56n46tAn7TN4DjADqourRstqQXQ67xO1dbllm6eHZ4malyf2eLH8xZG5b12prx
 DTbvjElHhL53H7ZICnLlj3m3C0y/cW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-aP-2AhfUPU65ozQhwjOglA-1; Mon, 21 Sep 2020 21:56:57 -0400
X-MC-Unique: aP-2AhfUPU65ozQhwjOglA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3424580EDAF;
 Tue, 22 Sep 2020 01:56:56 +0000 (UTC)
Received: from [10.72.13.139] (ovpn-13-139.pek2.redhat.com [10.72.13.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFBD95DA30;
 Tue, 22 Sep 2020 01:56:51 +0000 (UTC)
Subject: Re: [PATCH 3/3] net: Add vhost-vdpa in show_netdevs()
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org
References: <20200917155851.20636-1-lulu@redhat.com>
 <20200917155851.20636-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <16ed2edf-e4db-8af2-0399-6a2faf510482@redhat.com>
Date: Tue, 22 Sep 2020 09:56:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917155851.20636-3-lulu@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 21:03:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/9/17 下午11:58, Cindy Lu wrote:
> Fix the bug that while Check qemu supported netdev,
> there is no vhost-vdpa
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   net/net.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/net/net.c b/net/net.c
> index 7a2a0fb5ac..794c652282 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1049,6 +1049,9 @@ static void show_netdevs(void)
>   #endif
>   #ifdef CONFIG_POSIX
>           "vhost-user",
> +#endif
> +#ifdef CONFIG_VHOST_VDPA
> +        "vhost-vdpa",
>   #endif
>       };
>   


