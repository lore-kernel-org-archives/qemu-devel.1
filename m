Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CAEC00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 03:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AE7A2078E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 03:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KjG9MZd6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE7A2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaWPW-0002wt-TO
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 22:58:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kaWOK-0002Vt-Dc
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 22:56:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kaWOI-0006X4-L6
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 22:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604548608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kM0vnSLj2Deq/lY1HeYmAENW05HDfoTpwTNMkFu9GXM=;
 b=KjG9MZd6VY0oewormyn9xVVATqkj6+j5KS8GmLnuoeaR/rCx1X3ocB2k9YjEJYRNH5h6M2
 7p3+8LVcqSa8DTi044KzY66NcaxMcAZA3rB5tnEdEMpfyAFPagC394OUv2X5Gx/WiksHTt
 +3dE3mYU+MmGvIHCls40yO379Y/1NG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-bN7DakEpOzSRQjza-sSk3w-1; Wed, 04 Nov 2020 22:56:45 -0500
X-MC-Unique: bN7DakEpOzSRQjza-sSk3w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C36E28049CA;
 Thu,  5 Nov 2020 03:56:43 +0000 (UTC)
Received: from [10.72.13.154] (ovpn-13-154.pek2.redhat.com [10.72.13.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F6EA1002C06;
 Thu,  5 Nov 2020 03:56:38 +0000 (UTC)
Subject: Re: [RFC PATCH 6/6] docs: Added eBPF documentation.
To: Andrew Melnychenko <andrew@daynix.com>, mst@redhat.com
References: <20201102185115.7425-1-andrew@daynix.com>
 <20201102185115.7425-7-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <af85ed7a-1394-e1a4-e224-6ad232328800@redhat.com>
Date: Thu, 5 Nov 2020 11:56:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102185115.7425-7-andrew@daynix.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: yan@daynix.com, yuri.benditovich@daynix.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/11/3 上午2:51, Andrew Melnychenko wrote:
> From: Andrew<andrew@daynix.com>
>
> Also, added maintainers information.
>
> Signed-off-by: Yuri Benditovich<yuri.benditovich@daynix.com>
> Signed-off-by: Andrew Melnychenko<andrew@daynix.com>
> ---
>   MAINTAINERS       |   6 +++
>   docs/ebpf.rst     |  29 +++++++++++
>   docs/ebpf_rss.rst | 129 ++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 164 insertions(+)
>   create mode 100644 docs/ebpf.rst
>   create mode 100644 docs/ebpf_rss.rst
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2c22bbca5a..464b3f3c95 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3111,6 +3111,12 @@ S: Maintained
>   F: hw/semihosting/
>   F: include/hw/semihosting/
>   
> +EBPF:
> +M: Andrew Melnychenko<andrew@daynix.com>
> +M: Yuri Benditovich<yuri.benditovich@daynix.com>
> +S: Maintained
> +F: ebpf/*
> +


If it's possible, I would like to be one of the maintainer or at least 
reviewer :)

Thanks


