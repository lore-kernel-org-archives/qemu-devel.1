Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21CEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 06:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0F72082F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 06:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eh8O8xYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0F72082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlRRc-0002ye-O7
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 02:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jlRQO-0001nu-KY
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 02:19:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31865
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jlRQM-0000Ja-Sw
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 02:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592374789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hEGrA0kqVzkdnM3PlVLlC85eopAQAB99isxxcW7F2Q0=;
 b=Eh8O8xYVKZ3MS6zjzfPswb2cffV6F/SLDSW7djMXZ4Zi3EduZdWifjpIaeGGXxbHhSpNDq
 PCstDOaFDJVEkeG9H5FsD1mm42Fnm1kpUsHkZPTCfuCw5iiOe9C9XqHnKMge3ALV3OhgEG
 kxjmcflgS23fZZgd9v7tJRZYrBoQaGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-X878fb3aOye3Aal7zAHdyw-1; Wed, 17 Jun 2020 02:19:45 -0400
X-MC-Unique: X878fb3aOye3Aal7zAHdyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 032921883626;
 Wed, 17 Jun 2020 06:19:44 +0000 (UTC)
Received: from [10.72.13.217] (ovpn-13-217.pek2.redhat.com [10.72.13.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1AEA17FE82;
 Wed, 17 Jun 2020 06:19:42 +0000 (UTC)
Subject: Re: [PULL 00/33] Net patches
To: Peter Maydell <peter.maydell@linaro.org>
References: <1592289944-13727-1-git-send-email-jasowang@redhat.com>
 <CAFEAcA-7sG8_oOL+f=Q8dSevX-c26GeAcrLU6Ah6mOApfzizKQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <26e8805c-08ba-5f09-85b9-dbe973e58164@redhat.com>
Date: Wed, 17 Jun 2020 14:19:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-7sG8_oOL+f=Q8dSevX-c26GeAcrLU6Ah6mOApfzizKQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/6/16 下午8:32, Peter Maydell wrote:
> On Tue, 16 Jun 2020 at 07:45, Jason Wang <jasowang@redhat.com> wrote:
>> The following changes since commit 7d3660e79830a069f1848bb4fa1cdf8f666424fb:
>>
>>    Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-06-12 23:06:22 +0100)
>>
>> are available in the git repository at:
>>
>>    https://github.com/jasowang/qemu.git tags/net-pull-request
>>
>> for you to fetch changes up to 955aab203f932b8a7c23ff9c58ba036997cb3ed8:
>>
>>    net: Drop the NetLegacy structure, always use Netdev instead (2020-06-16 14:40:40 +0800)
>>
>> ----------------------------------------------------------------
>>
>> ----------------------------------------------------------------
> Hi; I'm afraid this fails to build (all hosts):
>
> hw/net/virtio-net.o: In function `virtio_net_device_realize':
> /home/pm215/qemu/hw/net/virtio-net.c:3380: undefined reference to
> `net_rx_pkt_init'
> hw/net/virtio-net.o: In function `virtio_net_device_unrealize':
> /home/pm215/qemu/hw/net/virtio-net.c:3418: undefined reference to
> `net_rx_pkt_uninit'
> hw/net/virtio-net.o: In function `virtio_net_process_rss':
> /home/pm215/qemu/hw/net/virtio-net.c:1607: undefined reference to
> `net_rx_pkt_set_protocols'
> /home/pm215/qemu/hw/net/virtio-net.c:1609: undefined reference to
> `net_rx_pkt_get_protocols'
> /home/pm215/qemu/hw/net/virtio-net.c:1625: undefined reference to
> `net_rx_pkt_calc_rss_hash'
> /home/pm215/qemu/hw/net/virtio-net.c:1613: undefined reference to
> `net_rx_pkt_get_ip6_info'
> /home/pm215/qemu/hw/net/virtio-net.c:1610: undefined reference to
> `net_rx_pkt_get_ip4_info'
> collect2: error: ld returned 1 exit status
>
> thanks
> -- PMM
>

Sorry for the failure.

This is because net_rx_pkt.c and net_tx_pkt.c are not complied when 
CONFIG_VIRTIO_NET is set. And it may work by chance if E1000E and 
VMXNET3 is enabled which is the case I test.

Will send V2.

Thanks



