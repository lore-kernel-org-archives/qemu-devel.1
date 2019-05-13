Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E4CC04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 06:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C941B20879
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 06:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C941B20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51956 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ4bA-0003qj-0b
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 02:38:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hQ4Zh-00039J-4V
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hQ4Ze-0003rm-3N
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:36:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hQ4Zd-0003qO-QY
	for qemu-devel@nongnu.org; Mon, 13 May 2019 02:36:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C60A1C057F32;
	Mon, 13 May 2019 06:36:30 +0000 (UTC)
Received: from [10.40.204.20] (ovpn-204-20.brq.redhat.com [10.40.204.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6BDC35BBA1;
	Mon, 13 May 2019 06:36:24 +0000 (UTC)
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Kashyap Chamarthy <kchamart@redhat.com>
References: <20190510134203.24012-1-lvivier@redhat.com>
	<20190512142108-mutt-send-email-mst@kernel.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <3779f01f-8a5b-0785-254b-d1a4cfdf593c@redhat.com>
Date: Mon, 13 May 2019 08:36:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190512142108-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Mon, 13 May 2019 06:36:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 0/3] rng-builtin: add an RNG backend
 that uses qemu_guest_getrandom()
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
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>,
	Amit Shah <amit@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
	"Richard W . M . Jones" <rjones@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/05/2019 20:21, Michael S. Tsirkin wrote:
> On Fri, May 10, 2019 at 03:42:00PM +0200, Laurent Vivier wrote:
>> Add a new RNG backend using QEMU builtin getrandom function.
>>
>> This patch applies on top of
>>      "[PATCH v5 00/24] Add qemu_getrandom and ARMv8.5-RNG etc"
>> Based-on: 20190510012458.22706-1-richard.henderson@linaro.org
>>
>> v3: Include Kashyap's patch in the series
>>      Add a patch to change virtio-rng default backend to rng-builtin
>>
>> v2: Update qemu-options.hx
>>      describe the new backend and specify virtio-rng uses the
>>      rng-random by default
>>
>> Kashyap Chamarthy (1):
>>    VirtIO-RNG: Update default entropy source to `/dev/urandom`
>>
>> Laurent Vivier (2):
>>    rng-builtin: add an RNG backend that uses qemu_guest_getrandom()
>>    virtio-rng: change default backend to rng-builtin
> 
> 
> OK pls address Marku's comment on commit msg and I will merge.

Kashyap,

as this patch is from you, do you agree?

If so, I can update the message and send a new version of the series (or 
you canr esend your patch alone if you prefer).

Thanks,
Laurent

