Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77310C10F11
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 03:07:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F5D217FA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 03:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F5D217FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50363 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJUjL-0005Fb-58
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 23:07:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hJUiW-0004qH-L0
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hJUcO-0007wp-QI
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:00:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hJUcO-0007vZ-Jf
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:00:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC2968DA28;
	Thu, 25 Apr 2019 03:00:10 +0000 (UTC)
Received: from [10.72.12.167] (ovpn-12-167.pek2.redhat.com [10.72.12.167])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 419AE5D706;
	Thu, 25 Apr 2019 03:00:05 +0000 (UTC)
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20190409055850.25797-1-jasowang@redhat.com>
	<20190424095058-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7d8971f7-4c50-5ea1-d168-3300a079caaa@redhat.com>
Date: Thu, 25 Apr 2019 11:00:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424095058-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Thu, 25 Apr 2019 03:00:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH V3] vhost_net: don't set backend for the
 uninitialized virtqueue
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: yuri.benditovich@daynix.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425030004.HUiaXA6sJao5Bdw26IAgSSDo75YFCLmW_Ytsh5aZgK4@z>


On 2019/4/24 =E4=B8=8B=E5=8D=889:51, Michael S. Tsirkin wrote:
> On Tue, Apr 09, 2019 at 01:58:50PM +0800, Jason Wang wrote:
>> We used to set backend unconditionally, this won't work for some
>> guests (e.g windows driver) who may not initialize all virtqueues. For
>> kernel backend, this will fail since it may try to validate the rings
>> during setting backend.
>>
>> Fixing this by simply skipping the backend set when we find desc is
>> not ready.
>>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
> Reviewed-by: Michael S. Tsirkin<mst@redhat.com>
>

Applied.

Thanks


