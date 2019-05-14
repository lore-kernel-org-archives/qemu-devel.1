Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDC0C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 08:16:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D492084A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 08:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D492084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41931 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQScL-0002dM-4l
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 04:16:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hQSb8-00026Z-95
	for qemu-devel@nongnu.org; Tue, 14 May 2019 04:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hQSb7-0002UN-ET
	for qemu-devel@nongnu.org; Tue, 14 May 2019 04:15:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hQSb7-0002TH-7S
	for qemu-devel@nongnu.org; Tue, 14 May 2019 04:15:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B5E1A3082B40;
	Tue, 14 May 2019 08:15:39 +0000 (UTC)
Received: from [10.40.205.6] (unknown [10.40.205.6])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 56F7E608A6;
	Tue, 14 May 2019 08:15:33 +0000 (UTC)
To: Kashyap Chamarthy <kchamart@redhat.com>
References: <20190514075602.7674-1-lvivier@redhat.com>
	<20190514075602.7674-2-lvivier@redhat.com>
	<20190514080854.GD17214@paraplu>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <2c68e2a2-384b-e107-03ff-42d09df558a7@redhat.com>
Date: Tue, 14 May 2019 10:15:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190514080854.GD17214@paraplu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Tue, 14 May 2019 08:15:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 1/3] VirtIO-RNG: Update default entropy
 source to `/dev/urandom`
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
	"Michael S. Tsirkin" <mst@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Amit Shah <amit@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	"Richard W . M . Jones" <rjones@redhat.com>,
	qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/05/2019 10:08, Kashyap Chamarthy wrote:
> On Tue, May 14, 2019 at 09:56:00AM +0200, Laurent Vivier wrote:
>> From: Kashyap Chamarthy <kchamart@redhat.com>
>>
>> When QEMU exposes a VirtIO-RNG device to the guest, that device needs a
>> source of entropy, and that source needs to be "non-blocking", like
>> `/dev/urandom`.  However, currently QEMU defaults to the problematic
>> `/dev/random`, which on linux is "blocking" (as in, it waits until
> 
> OCD nit: s/linux/Linux/
> 
> Maybe Michael can do the touch up when applying.

A little reminder: this patch can be applied alone, but the followings 
need the series from Richard to be applied first.

Thanks,
Laurent

