Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11434C10F13
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 03:36:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB4A72084E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 03:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4A72084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44090 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFsQ3-0006tw-2S
	for qemu-devel@archiver.kernel.org; Sun, 14 Apr 2019 23:36:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hFsPD-0006YZ-M0
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 23:35:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hFsPC-0004UC-Oc
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 23:35:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hFsPC-0004Te-GJ
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 23:35:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D2DB30820DD;
	Mon, 15 Apr 2019 03:35:37 +0000 (UTC)
Received: from [10.72.12.102] (ovpn-12-102.pek2.redhat.com [10.72.12.102])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A9AC55C1B4;
	Mon, 15 Apr 2019 03:35:35 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	Mark Kanda <mark.kanda@oracle.com>
References: <1554391286-26981-1-git-send-email-mark.kanda@oracle.com>
	<20190405103105.c2ohp53bitfgamax@steredhat>
	<c2f53410-b1ea-d2a4-d28a-ffb8f1ccdd6d@redhat.com>
Message-ID: <283e6745-0e03-6fd5-f35e-909725815d30@redhat.com>
Date: Mon, 15 Apr 2019 11:35:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c2f53410-b1ea-d2a4-d28a-ffb8f1ccdd6d@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Mon, 15 Apr 2019 03:35:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] e1000: Never increment the RX undersize
 count register
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
Cc: bhavesh.davda@oracle.com, Chris Kenna <chris.kenna@oracle.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415033525.2Xe25RzihHZRDhN0lukJ_Ek-P8mvCvuqLEiBGr-bK-M@z>


On 2019/4/15 =E4=B8=8A=E5=8D=8811:29, Jason Wang wrote:
>
> On 2019/4/5 =E4=B8=8B=E5=8D=886:31, Stefano Garzarella wrote:
>> On Thu, Apr 04, 2019 at 10:21:26AM -0500, Mark Kanda wrote:
>>> From: Chris Kenna <chris.kenna@oracle.com>
>>>
>>> In situations where e1000 receives an undersized Ethernet frame,
>>> QEMU increments the emulated "Receive Undersize Count (RUC)"
>>> register when padding the frame.
>>>
>>> This is incorrect because this an expected scenario (e.g. with
>>> VLAN tag stripping) and not an error. As such, QEMU should not
>>> increment the emulated RUC.
>>>
>>> Fixes: 3b2743017749 ("e1000: Implementing various counters")
>>>
>>> Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
>>> Reviewed-by: Bhavesh Davda <bhavesh.davda@oracle.com>
>>> Signed-off-by: Chris Kenna <chris.kenna@oracle.com>
>>> ---
>>> =C2=A0 hw/net/e1000.c | 1 -
>>> =C2=A0 1 file changed, 1 deletion(-)
>> CCing Jason.
>>
>> LGTM, if we don't discard it, we shouldn't increase the RUC counter.
>>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>
>> Thanks,
>> Stefano
>>
>
> Applied.
>
> Thanks


Actually queued for 4.1 consider it was not a series issue.

Thanks


