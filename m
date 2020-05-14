Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F0CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55002205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FV6eoV7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55002205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ7g3-0003Io-Fa
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jZ7f9-0001vj-CH
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:48:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60917
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jZ7f8-0004lR-AZ
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589438889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OKaumr5EXNcZi+ukxrme9UKCcCxboPvshd3EtOFXab8=;
 b=FV6eoV7t14NmVQC9zHCRE/IoAxg/CfkfvLGNqaEGjZhRXYd3G73jSXI44QQMXAGIleU0cO
 +1SAhtJS7TGlHU+3GU1aEcHvXOebu204tkNqyfAwECRfsh7bcGVgwnCGX/jIKCEkDjTqBx
 3XK16xfnQO+0CzcsMi6qEM9hbnBaXPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-FXljx_hvM3GlYh1B_TKwBQ-1; Thu, 14 May 2020 02:48:05 -0400
X-MC-Unique: FXljx_hvM3GlYh1B_TKwBQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3148805721;
 Thu, 14 May 2020 06:48:03 +0000 (UTC)
Received: from [10.72.12.133] (ovpn-12-133.pek2.redhat.com [10.72.12.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4623D6E712;
 Thu, 14 May 2020 06:48:00 +0000 (UTC)
Subject: Re: [PATCH v5 00/12] Cadence GEM Fixes
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
References: <1589295294-26466-1-git-send-email-sai.pavan.boddu@xilinx.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <78cdc918-5c0a-a0bc-1d90-69e49dbfe0cb@redhat.com>
Date: Thu, 14 May 2020 14:47:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589295294-26466-1-git-send-email-sai.pavan.boddu@xilinx.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/12 下午10:54, Sai Pavan Boddu wrote:
> Hi,
>
> Following patch series fixes issues with priority queues,
> Adds JUMBO Frame support,
> Makes Debug statements compilable &
> Fixes related to multicast frames.
>
> Changes for V2:
> 	Fixed build failure on fedora docker machine
> 	Fix buggy debug print to use sized integer casting
> Changes for V3:
> 	1/10: Fixed debug statments to use %u and %zd
> 	      Remove rxoffset for buffer address
> 	2/10: Add inline functions to get tx/rx queue base address.
> 	4/10: fix read only mask
> 	5/10: Move packet buffers to CadenceGEMState
> 	6/10: Add JUMBO MAX LEN register
> Changes for V4:
> 	7/11: Fix up the existing code style in register defines
> 	8/11: jumbo-max-len property sets the default value of jumbo frame
> 	      Add frame lenght checks for tx and rx
> Changes for V5:
> 	8/11: Add a cap on jumbo frame size and print guest errors if exceeded.
>                Move jumo_max_len property into static properties section.
>
> Sai Pavan Boddu (11):
>    net: cadence_gem: Fix debug statements
>    net: cadence_gem: Fix the queue address update during wrap around
>    net: cadence_gem: Fix irq update w.r.t queue
>    net: cadence_gem: Define access permission for interrupt registers
>    net: cadence_gem: Set ISR according to queue in use
>    net: cadence_gem: Move tx/rx packet buffert to CadenceGEMState
>    net: cadence_gem: Fix up code style
>    net: cadence_gem: Add support for jumbo frames
>    net: cadnece_gem: Update irq_read_clear field of designcfg_debug1 reg
>    net: cadence_gem: Update the reset value for interrupt mask register
>    net: cadence_gem: TX_LAST bit should be set by guest
>
> Tong Ho (1):
>    net: cadence_gem: Fix RX address filtering
>
>   hw/net/cadence_gem.c         | 458 ++++++++++++++++++++++++-------------------
>   include/hw/net/cadence_gem.h |   6 +
>   2 files changed, 265 insertions(+), 199 deletions(-)
>

Applied.

Thanks



