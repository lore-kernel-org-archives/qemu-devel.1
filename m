Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAE5C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 15:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EC5720685
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 15:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC5720685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55217 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIx5w-0002ke-Qe
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 11:12:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hIx4x-0002Ff-Pk
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hIx4w-0000zt-TX
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:11:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hIx4w-0000yo-Mq
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:11:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9BAF73086232;
	Tue, 23 Apr 2019 15:11:24 +0000 (UTC)
Received: from [10.36.116.188] (ovpn-116-188.ams2.redhat.com [10.36.116.188])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 521315D6A9;
	Tue, 23 Apr 2019 15:11:21 +0000 (UTC)
To: Cornelia Huck <cohuck@redhat.com>
References: <20190409155831.18764-1-eric.auger@redhat.com>
	<20190412133111.028a9c6d.cohuck@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e4e20c42-5b6e-7072-8105-486650aaf95b@redhat.com>
Date: Tue, 23 Apr 2019 17:11:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190412133111.028a9c6d.cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 23 Apr 2019 15:11:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1] vfio/common: Introduce
 vfio_set_irq_signaling helper
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
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qemu-devel@nongnu.org,
	eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423151119.bj-ycendfe1tntds0KUfuGdpozbCRohd1VdYHm4LzEU@z>

Hi Cornelia

On 4/12/19 1:31 PM, Cornelia Huck wrote:
> On Tue,  9 Apr 2019 17:58:31 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> The code used to assign an interrupt index/subindex to an
>> eventfd is duplicated many times. Let's introduce an helper that
>> allows to set/unset the signaling for an ACTION_TRIGGER or
>> ACTION_UNMASK action.
> 
> I like that, and it looks like ccw can use the new function as well. (I
> can do a patch on top.)

Thanks! Yes, feel free to proceed with the ccw patch once this gets
merged.
> 
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> This is a follow-up to
>> [PATCH v2 0/2] vfio-pci: Introduce vfio_set_event_handler().
>> It looks to me that introducing vfio_set_irq_signaling() has more
>> benefits in term of code reduction and the helper abstraction
>> looks cleaner.
>> ---
>>  hw/vfio/common.c              |  61 +++++++++
>>  hw/vfio/pci.c                 | 224 ++++++++--------------------------
>>  hw/vfio/platform.c            |  55 +++------
>>  include/hw/vfio/vfio-common.h |   2 +
>>  4 files changed, 134 insertions(+), 208 deletions(-)
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Thanks

Eric
> 

