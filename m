Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28B5C3A589
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 03:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D6222087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 03:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6222087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzY30-0004IZ-K7
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 23:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1hzY2H-0003rP-16
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 23:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hzY2F-0004fj-LP
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 23:08:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57470)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hzY2F-0004eg-G5
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 23:08:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 70A26C049D62;
 Mon, 19 Aug 2019 03:08:41 +0000 (UTC)
Received: from [10.72.12.146] (ovpn-12-146.pek2.redhat.com [10.72.12.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0411582489;
 Mon, 19 Aug 2019 03:08:34 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190808143457.14111-1-philmd@redhat.com>
 <20455728-aeee-7009-ec42-c3f5db7ff55a@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a0a5ee9a-4729-0eb7-9eb1-508ca1d465f6@redhat.com>
Date: Mon, 19 Aug 2019 11:08:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20455728-aeee-7009-ec42-c3f5db7ff55a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 19 Aug 2019 03:08:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/6] net/eth: Remove duplicated tcp/udp_hdr
 structures
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
Cc: Zhang Chen <chen.zhang@intel.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/8/19 =E4=B8=8A=E5=8D=885:38, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Jason,
>
> On 8/8/19 4:34 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> This is a preparatory cleanup series.
>>
>> Commit 75020a70215 introduced 4 very equivalent structures:
>> - tcp_header and tcp_hdr,
>> - udp_header and udp_hdr.
>>
>> Choose the most widely use in the codebase, which happens to
>> provide convenient bitfields manipulation macros and is not
>> endian-specific.
>>
>> Philippe Mathieu-Daud=C3=A9 (6):
>>   hw/net/virtio-net: Use TCP_HEADER_FLAGS/TCP_HEADER_DATA_OFFSET macro=
s
>>   net/colo-compare: Use the tcp_header structure
>>   net/filter-rewriter: Use the tcp_header structure
>>   hw/net/vmxnet3: Use the tcp_header structure
>>   net/eth: Remove the unused tcp_hdr structure
>>   net/eth: Remove the single use of udp_hdr structure
> Are you OK to take this series?
>
> It got reviewed by Dmitry Fleytman.
>
> Thanks,
>
> Phil.


Yes. Applied.

Thanks



