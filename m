Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF5DC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:11:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A7D421823
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yy4eDk86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7D421823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icrqZ-0005JP-6x
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 09:11:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1icrlw-0008Kv-L5
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:06:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1icrlv-0000WC-7R
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:06:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40606
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1icrlu-0000TW-UP
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:06:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575554782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NLRko2/oQTzK9BJwSE/ikxWjurLXgr2kyfOXgtePXp0=;
 b=Yy4eDk86vfviu2XvuEQpRqAU5CN8lyc2NQJj5BnBPAM0B1TGsmCji30JO1A6tIA6haHRX2
 H2xY+61U0lPQtvC8KaRkclmuLy7ueCiNgJxRuE+t/XEdu5GHQIIxRrA+SOqv2qqVSgcfHS
 gCnUZ/L6AzE2z4BY5r64UuFMv9EDB+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-Rvc7Il-UOk2M4BUmu0_qfQ-1; Thu, 05 Dec 2019 09:06:19 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EBC6186E658;
 Thu,  5 Dec 2019 14:06:17 +0000 (UTC)
Received: from [10.72.12.127] (ovpn-12-127.pek2.redhat.com [10.72.12.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 737C55D6A5;
 Thu,  5 Dec 2019 14:06:11 +0000 (UTC)
Subject: Re: [PATCH] net/imx_fec: Updating the IMX_FEC IP to support loopback
 mode.
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191129150508.24404-1-bilalwasim676@gmail.com>
 <afe9efde-7ac1-8607-446a-8fbf10accece@redhat.com>
 <8c956ae31e8f44a2b831a5030b2448b4@SVR-IES-MBX-03.mgc.mentorg.com>
 <CAP+75-X_POJfTO=gOUu1zCPtcfnQ5yemQo0hqB_s3jy_C17o9g@mail.gmail.com>
 <db2c5074-307c-d20e-73f2-9c2b44612d6f@redhat.com>
 <CAFEAcA89Zw+MUJzhwSx39qVv8cRVNgRf7fe1K1oLYVjZfur9Wg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4d9b3cb3-db73-5a58-c32c-594984508a68@redhat.com>
Date: Thu, 5 Dec 2019 22:06:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA89Zw+MUJzhwSx39qVv8cRVNgRf7fe1K1oLYVjZfur9Wg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Rvc7Il-UOk2M4BUmu0_qfQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "bilalwasim676@gmail.com" <bilalwasim676@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "aa1ronham@gmail.com" <aa1ronham@gmail.com>,
 "jcd@tribudubois.net" <jcd@tribudubois.net>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "Wasim,
 Bilal" <Bilal_Wasim@mentor.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "linux@roeck-us.net" <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/12/4 =E4=B8=8B=E5=8D=8811:11, Peter Maydell wrote:
> On Wed, 4 Dec 2019 at 02:15, Jason Wang<jasowang@redhat.com>  wrote:
>> On 2019/11/30 =E4=B8=8A=E5=8D=8812:04, Philippe Mathieu-Daud=C3=A9 wrote=
:
>>> On Fri, Nov 29, 2019 at 4:59 PM Wasim, Bilal<Bilal_Wasim@mentor.com>  w=
rote:
>>>> Thanks for the pointers philippe.. Is the patch okay to be merged with=
out it or do I need to do a re-submission with the updated username ?
>>> If there are no review comments on your patch, I think the maintainer
>>> taking your patch can fix this details directly, no need to resend.
>>>
>>>> -----Original Message-----
>>>> From: Philippe Mathieu-Daud=C3=A9 [mailto:philmd@redhat.com]
>>>> Sent: Friday, November 29, 2019 8:38 PM
>>>> To:bilalwasim676@gmail.com;qemu-devel@nongnu.org
>>>> Cc:peter.maydell@linaro.org;aa1ronham@gmail.com;jcd@tribudubois.net;qe=
mu-arm@nongnu.org; Wasim, Bilal<Bilal_Wasim@mentor.com>;linux@roeck-us.net;=
 Jason Wang<jasowang@redhat.com>
>>>> Subject: Re: [PATCH] net/imx_fec: Updating the IMX_FEC IP to support l=
oopback mode.
>>>>
>>>> Hi Bilal,
>>>>
>>>> Cc'ing Jason, the maintainer of network devices.
>>>>
>>>> On 11/29/19 4:05 PM,bilalwasim676@gmail.com  wrote:
>>>>> From: bwasim<bilal_wasim@mentor.com>
>>>> Your git setup misses your 'user.name', you could fix it running:
>>>>
>>>>      git config user.name "Bilal Wasim"
>>>>
>>>> (eventually with the --global option).
>>>>
>>>> The patch looks good otherwise.
>>>>
>>>> Thanks!
>> Applied with the fix for user.name.
> Could you fix up the non-standard block comment formatting too?
>
> thanks
> -- PMM
>

Yes, fixed.

Thanks


