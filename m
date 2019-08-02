Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD801C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:44:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89F3C21726
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F3C21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htU6e-0004N0-Sz
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 05:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56586)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1htU68-0003oL-7D
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1htU67-0004Cz-81
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:43:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45118)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1htU67-0004Ci-2m
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:43:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3C10330832EA;
 Fri,  2 Aug 2019 09:43:38 +0000 (UTC)
Received: from [10.72.12.134] (ovpn-12-134.pek2.redhat.com [10.72.12.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4659C60BEC;
 Fri,  2 Aug 2019 09:43:24 +0000 (UTC)
To: Jens Freimann <jfreimann@redhat.com>
References: <20190802040606.22573-1-jasowang@redhat.com>
 <20190802040606.22573-3-jasowang@redhat.com>
 <20190802090319.qja4f23xmrigzow7@jenstp.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <38e1eec0-79cd-9f77-4e0f-e1433b7ebaeb@redhat.com>
Date: Fri, 2 Aug 2019 17:43:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802090319.qja4f23xmrigzow7@jenstp.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 02 Aug 2019 09:43:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH V5 2/6] virtio: device/driverr area size
 calculation refactor for split ring
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
Cc: yang.zhong@intel.com, tiwei.bie@intel.com, mst@redhat.com,
 qemu-devel@nongnu.org, maxime.coquelin@redhat.com, Wei Xu <wexu@redhat.com>,
 weiyshay@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/8/2 =E4=B8=8B=E5=8D=885:03, Jens Freimann wrote:
> In subject s/driverr/driver
>

Right, let me fix.

Thanks


>
> On Fri, Aug 02, 2019 at 12:06:02AM -0400, Jason Wang wrote:
>> From: Wei Xu <wexu@redhat.com>
>>
>> There is slight size difference between split/packed rings.
>>
>> This is the refactor of split ring as well as a helper to expanding
>> device and driver area size calculation for packed ring.
>>
>> Signed-off-by: Wei Xu <wexu@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>> hw/virtio/virtio.c | 16 ++++++++++------
>> 1 file changed, 10 insertions(+), 6 deletions(-)
>>
>
> Reviewed-by: Jens Freimann <jfreimann@redhat.com>
>
>
>

