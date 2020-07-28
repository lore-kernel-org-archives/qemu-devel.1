Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB650C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99CCE20775
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YrV9B8/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99CCE20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0LWE-00032l-Sr
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 05:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k0LVZ-0002UD-Ll
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:02:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31787
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k0LVX-0005Jm-3M
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595926965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WJZmsGpvIYXxGLW6A5hhSBkKhBOX5jJRVfVdEaPY5I0=;
 b=YrV9B8/r7rNvCe25cz1MTyFbYgGmq/ieMmg8WR/5cK8+9M8hmeP/8uqnusftEYyhY6ngZv
 q61BgaJiuz+E2swVFkeotwAo0dkPTE6tPoFK1XpKssJIYpkg/90b0t1Ufh8qoa8R2Y2scA
 74og97yi1dknCGLcta4+Yoi9EwYC97Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-Daoe-UDCP1ev4MuwBsGCIg-1; Tue, 28 Jul 2020 05:02:42 -0400
X-MC-Unique: Daoe-UDCP1ev4MuwBsGCIg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 307B0106B244;
 Tue, 28 Jul 2020 09:02:41 +0000 (UTC)
Received: from [10.72.13.242] (ovpn-13-242.pek2.redhat.com [10.72.13.242])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D4BA5D9CD;
 Tue, 28 Jul 2020 09:02:39 +0000 (UTC)
Subject: Re: [PULL 0/4] Net patches
To: peter.maydell@linaro.org
References: <1595915878-22568-1-git-send-email-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3fb598f8-93f2-2a11-d5b2-1da85b6bb7b3@redhat.com>
Date: Tue, 28 Jul 2020 17:02:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595915878-22568-1-git-send-email-jasowang@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 00:06:48
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/28 下午1:57, Jason Wang wrote:
> The following changes since commit 9303ecb658a0194560d1eecde165a1511223c2d8:
>
>    Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200727' into staging (2020-07-27 17:25:06 +0100)
>
> are available in the git repository at:
>
>    https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 7142cad78d6bf4a1cbcb09d06b39935a7998c24e:
>
>    net: forbid the reentrant RX (2020-07-28 13:50:41 +0800)
>
> ----------------------------------------------------------------
> Want to send earlier but most patches just come.
>
> - fix vhost-vdpa issues when no peer
> - fix virtio-pci queue enabling check
> - forbid reentrant RX
>
> ----------------------------------------------------------------
> Jason Wang (2):
>        virtio-net: check the existence of peer before accessing vDPA config
>        net: forbid the reentrant RX
>
> Laurent Vivier (1):
>        virtio-pci: fix virtio_pci_queue_enabled()


Just notice this has been merged.

Will send a V2.

Thanks


>
> Yuri Benditovich (1):
>        virtio-pci: fix wrong index in virtio_pci_queue_enabled
>
>   hw/net/virtio-net.c        | 30 +++++++++++++++++++-----------
>   hw/virtio/virtio-pci.c     |  4 ++--
>   hw/virtio/virtio.c         |  7 ++++++-
>   include/hw/virtio/virtio.h |  1 +
>   net/queue.c                |  3 +++
>   5 files changed, 31 insertions(+), 14 deletions(-)
>
>


