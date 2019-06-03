Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7ACC282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD31427400
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD31427400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39184 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXre7-0006fD-4T
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 14:25:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laine@redhat.com>) id 1hXrXh-0001sr-En
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:18:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laine@redhat.com>) id 1hXrXg-0001kv-DB
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:18:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laine@redhat.com>) id 1hXrXg-0001jk-59
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:18:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A80F30C31A3;
	Mon,  3 Jun 2019 18:18:38 +0000 (UTC)
Received: from vhost2.laine.org (ovpn-117-135.phx2.redhat.com [10.3.117.135])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DAC460487;
	Mon,  3 Jun 2019 18:18:24 +0000 (UTC)
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190520165657.2293c5d7@x1.home>
	<20190521072157.wpb77wlc5mhfcdes@jenstp.localdomain>
	<20190521073511-mutt-send-email-mst@kernel.org>
	<20190521184918.n4nnk6ack3ssp6jv@jenstp.localdomain>
	<d116bc65-0715-2c6a-2616-49f67cd685c8@oracle.com>
	<20190528225039-mutt-send-email-mst@kernel.org>
	<1c5f460e-a3b9-56c1-90f7-b3a5c3d0a0d3@redhat.com>
	<20190603140832-mutt-send-email-mst@kernel.org>
From: Laine Stump <laine@redhat.com>
Message-ID: <1fa683cc-02c6-c674-78ef-db6afa55026a@redhat.com>
Date: Mon, 3 Jun 2019 14:18:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190603140832-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Mon, 03 Jun 2019 18:18:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/4] add failover feature for assigned
 network devices
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
	aadam@redhat.com, qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>,
	si-wei liu <si-wei.liu@oracle.com>,
	Jens Freimann <jfreimann@redhat.com>, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/19 2:12 PM, Michael S. Tsirkin wrote:
> On Mon, Jun 03, 2019 at 02:06:47PM -0400, Laine Stump wrote:
>> On 5/28/19 10:54 PM, Michael S. Tsirkin wrote:
>>> On Tue, May 28, 2019 at 05:14:22PM -0700, si-wei liu wrote:
>>>>
>>>>
>>>> On 5/21/2019 11:49 AM, Jens Freimann wrote:
>>>>> On Tue, May 21, 2019 at 07:37:19AM -0400, Michael S. Tsirkin wrote:
>>>>>> On Tue, May 21, 2019 at 09:21:57AM +0200, Jens Freimann wrote:
>>>>>>> On Mon, May 20, 2019 at 04:56:57PM -0600, Alex Williamson wrote:
>>
>>>>>> Actually is there a list of devices for which this has been tested
>>>>>> besides mlx5? I think someone said some old intel cards
>>>>>> don't support this well, we might need to blacklist these ...
>>>>>
>>>>> So far I've tested mlx5 and XL710 which both worked, but I'm
>>>>> working on testing with more devices. But of course help with testing
>>>>> is greatly appreciated.
>>>>
>>>> It won't work on Intel ixgbe and Broadcom bnxt_en, which requires toggling
>>>> the state of tap backing the virtio-net in order to release/reprogram MAC
>>>> filter. Actually, it's very few NICs that could work with this - even some
>>>> works by chance the behavior is undefined. Instead of blacklisting it makes
>>>> more sense to whitelist the NIC that supports it - with some new sysfs
>>>> attribute claiming the support presumably.
>>>>
>>>> -Siwei
>>>
>>> I agree for many cards we won't know how they behave until we try.  One
>>> can consider this a bug in Linux that cards don't behave in a consistent
>>> way.  The best thing to do IMHO would be to write a tool that people can
>>> run to test the behaviour.
>>
>> Is the "bad behavior" something due to the hardware of the cards, or their
>> drivers? If it's the latter, then at least initially having a whitelist
>> would be counterproductive, since it would make it difficult for relative
>> outsiders to test and report success/failure of various cards.
> 
> We can add an "ignore whitelist" flag. Would that address the issue?

It would be better than requiring a kernel/qemu recompile :-)


Where would the whilelist live? In qemu or in the kernel? It would be 
problematic to have the whitelist in qemu if kernel driver changes could 
fix a particular card.

Beyond that, what about *always* just issuing some sort of warning 
rather than completely forbidding a card that wasn't whitelisted? 
(Haven't decided if I like that better or not (and it probably doesn't 
matter, since I'm not a "real" user, but I thought I would mention it).

