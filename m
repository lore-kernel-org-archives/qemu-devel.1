Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC43C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C0BF20848
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJnNB1dK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0BF20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2B3G-00010F-8B
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 04:44:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j2B1Q-00072r-Es
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:43:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j2B1O-00019j-W3
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:42:59 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38414
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j2B1O-00019H-Re
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581586978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KyRax9WTiMAW7Zu3vAA5Nj0OKEpA3JbfVMnYVMZ/OpY=;
 b=ZJnNB1dK42L5xdSLLML5u77DAUYeeGYDU08KzfQM5v1x8MVYCrBe0oK+7zC+pjtsDB51Ed
 D5Ax2Axwl5jc+g63UhhHzMoAwWqnoaLQFnLXM/YmmnFuF0TZ+JVoUGFmgDWEpymrA2Gk73
 ZX3kzAW1s3OU2miUC4WXcGPwm9y6QaY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-XrWPDVpWO8S1ZCF-CMpVTg-1; Thu, 13 Feb 2020 04:42:57 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87D588018A5;
 Thu, 13 Feb 2020 09:42:55 +0000 (UTC)
Received: from [10.72.13.212] (ovpn-13-212.pek2.redhat.com [10.72.13.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8AB426E7B;
 Thu, 13 Feb 2020 09:42:49 +0000 (UTC)
Subject: Re: [Qemu-devel] [PATCH v3] hw: net: cadence_gem: Fix build errors in
 DB_PRINT()
To: Bin Meng <bmeng.cn@gmail.com>
References: <1565335544-23584-1-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKOyTXgs5uZuukZjAEqQkTtf1U+vD=u9_470+OgsfaQdqQ@mail.gmail.com>
 <CAEUhbmW0sCEN7mzSfCvUBSqhAGD3v5JyeDj2iSqs0MQJv13bag@mail.gmail.com>
 <67e917c9-d080-5af1-22ea-ba6d9af4daee@redhat.com>
 <CAEUhbmUswmWjiaAy+26mYkEMpciTP6u6=WDmVX2U9MKo=uR_qA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <91d39b2d-3077-a638-d253-be9acdb24f8a@redhat.com>
Date: Thu, 13 Feb 2020 17:42:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEUhbmUswmWjiaAy+26mYkEMpciTP6u6=WDmVX2U9MKo=uR_qA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: XrWPDVpWO8S1ZCF-CMpVTg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/2/13 =E4=B8=8B=E5=8D=885:39, Bin Meng wrote:
> Hi Jason,
>
> On Mon, Aug 19, 2019 at 1:40 PM Jason Wang <jasowang@redhat.com> wrote:
>>
>> On 2019/8/19 =E4=B8=8B=E5=8D=881:24, Bin Meng wrote:
>>> On Sat, Aug 10, 2019 at 9:58 AM Alistair Francis <alistair23@gmail.com>=
 wrote:
>>>> On Fri, Aug 9, 2019 at 12:26 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>>>>> When CADENCE_GEM_ERR_DEBUG is turned on, there are several
>>>>> compilation errors in DB_PRINT(). Fix them.
>>>>>
>>>>> While we are here, update to use appropriate modifiers in
>>>>> the same DB_PRINT() call.
>>>>>
>>>>> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>>>
>>> Ping?
>>>
>>> What's the status of this patch?
>>>
>>> Regards,
>>> Bin
>>
>> Applied.
> I checked latest qemu/master and found this patch isn't applied. Could
> you please take a look?
>
> Regards,
> Bin


For some unknown reason it was lost, I've applied in my tree and it will=20
be in the next pull request.

Sorry.


