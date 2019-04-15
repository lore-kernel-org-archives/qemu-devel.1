Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37340C10F13
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 03:30:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E59282084E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 03:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59282084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44042 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFsKZ-0005m0-Gg
	for qemu-devel@archiver.kernel.org; Sun, 14 Apr 2019 23:30:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hFsJj-0005QF-JX
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 23:30:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hFsJi-0002Mw-Mu
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 23:29:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hFsJi-0002MH-Cu
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 23:29:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D45C7308FC4E;
	Mon, 15 Apr 2019 03:29:55 +0000 (UTC)
Received: from [10.72.12.200] (ovpn-12-200.pek2.redhat.com [10.72.12.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 136E41001DDE;
	Mon, 15 Apr 2019 03:29:53 +0000 (UTC)
To: Stefano Garzarella <sgarzare@redhat.com>,
	Mark Kanda <mark.kanda@oracle.com>
References: <1554391286-26981-1-git-send-email-mark.kanda@oracle.com>
	<20190405103105.c2ohp53bitfgamax@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c2f53410-b1ea-d2a4-d28a-ffb8f1ccdd6d@redhat.com>
Date: Mon, 15 Apr 2019 11:29:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405103105.c2ohp53bitfgamax@steredhat>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 15 Apr 2019 03:29:55 +0000 (UTC)
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
Message-ID: <20190415032946.MGYpwTMhO5RIX0Qu11My-pjHtqtPxBOBIZj4xXg0QtA@z>


On 2019/4/5 =E4=B8=8B=E5=8D=886:31, Stefano Garzarella wrote:
> On Thu, Apr 04, 2019 at 10:21:26AM -0500, Mark Kanda wrote:
>> From: Chris Kenna <chris.kenna@oracle.com>
>>
>> In situations where e1000 receives an undersized Ethernet frame,
>> QEMU increments the emulated "Receive Undersize Count (RUC)"
>> register when padding the frame.
>>
>> This is incorrect because this an expected scenario (e.g. with
>> VLAN tag stripping) and not an error. As such, QEMU should not
>> increment the emulated RUC.
>>
>> Fixes: 3b2743017749 ("e1000: Implementing various counters")
>>
>> Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
>> Reviewed-by: Bhavesh Davda <bhavesh.davda@oracle.com>
>> Signed-off-by: Chris Kenna <chris.kenna@oracle.com>
>> ---
>>   hw/net/e1000.c | 1 -
>>   1 file changed, 1 deletion(-)
> CCing Jason.
>
> LGTM, if we don't discard it, we shouldn't increase the RUC counter.
>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>
> Thanks,
> Stefano
>

Applied.

Thanks


