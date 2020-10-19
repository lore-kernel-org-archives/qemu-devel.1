Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA630C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:02:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A1B02224D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDIXHew3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1B02224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUQ7k-0007N0-WB
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 04:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kUPyd-0005dT-O2
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 03:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57221)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kUPyc-0008Ff-47
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 03:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603093985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Zu5tp+UAqJXRLmC/gjEEk0Yk0xcpGXPYMcUQ0cnrAs=;
 b=CDIXHew35bF7UmJNROkWV60ZqXUYCuWnJB8mgM3FiHvbR4ot6NvqOR/+G6UfsS22ZbkvCV
 0PG63e2Osu8WXXLyckiic8DFftBvAk35gvmLqyvu1sW29LxmLwifPCAA04s6iUdH4GPWFy
 cosNcgIodUb0RUknzVIlPFBmtyAAw0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-hvQahg3lNIKRtBe_jbIC_Q-1; Mon, 19 Oct 2020 03:53:03 -0400
X-MC-Unique: hvQahg3lNIKRtBe_jbIC_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9068987952A;
 Mon, 19 Oct 2020 07:53:02 +0000 (UTC)
Received: from [10.72.13.124] (ovpn-13-124.pek2.redhat.com [10.72.13.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 083D55D9EF;
 Mon, 19 Oct 2020 07:53:00 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] net: Add vhost-vdpa in show_netdevs()
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org
References: <20201016030909.9522-1-lulu@redhat.com>
 <20201016030909.9522-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <26d1c801-e304-e8e7-8943-83d636bc1036@redhat.com>
Date: Mon, 19 Oct 2020 15:52:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016030909.9522-2-lulu@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/10/16 上午11:09, Cindy Lu wrote:
> Fix the bug that while Check qemu supported netdev,
> there is no vhost-vdpa
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
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


Acked-by: Jason Wang <jasowang@redhat.com>


>   


