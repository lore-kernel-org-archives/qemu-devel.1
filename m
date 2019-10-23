Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6EECA9EAE
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 03:33:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936EA2086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 03:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzqYQFKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936EA2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iN7Og-0000q2-O0
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 23:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iN7Nn-0000CC-Fu
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 23:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iN7Nl-0008Rp-2c
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 23:32:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24872
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iN7Nk-0008RN-Em
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 23:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571801538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aW2dqakuVjPADhhZiTpOHCbz4GPljLQF6yNnQYBWCyE=;
 b=SzqYQFKpziUeQ3OzqrofLbO64aOucPbJWbW7B4rOWS/uBa/C9x9ylofvbY9jn+pd6xbZgP
 5QEBcb2KNTPQrT2P1CwDCVPytmh6mHGPN5CSoXYAqkWwiwSSxQvGJvdm4llalipfYFJzMH
 yLnnWHIRR3u+yGT3ByFsiKMPxuxD2b4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-Rug6yglHOeSoREcJu7STUg-1; Tue, 22 Oct 2019 23:32:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22C73800D57;
 Wed, 23 Oct 2019 03:32:14 +0000 (UTC)
Received: from [10.72.13.17] (ovpn-13-17.pek2.redhat.com [10.72.13.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CB5F194BE;
 Wed, 23 Oct 2019 03:32:08 +0000 (UTC)
Subject: Re: [PATCH] net: add tulip (dec21143) driver
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191019173801.939-1-svens@stackframe.org>
 <f6cf2c88-ae77-2998-2b38-4716fe86f081@redhat.com>
 <CAFEAcA8W=ePk6vqErnXGwCXqOJ9ATz-00caAHDcCA-pgJ8Womw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <85511960-29b5-b81c-cab4-7950d21d1fe1@redhat.com>
Date: Wed, 23 Oct 2019 11:32:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8W=ePk6vqErnXGwCXqOJ9ATz-00caAHDcCA-pgJ8Womw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Rug6yglHOeSoREcJu7STUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Sven Schnelle <svens@stackframe.org>,
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/10/22 =E4=B8=8B=E5=8D=888:02, Peter Maydell wrote:
> On Tue, 22 Oct 2019 at 04:30, Jason Wang<jasowang@redhat.com>  wrote:
>> On 2019/10/20 =E4=B8=8A=E5=8D=881:38, Sven Schnelle wrote:
>>> This adds the basic functionality to emulate a Tulip NIC.
>>>
>>> Implemented are:
>>>
>>> - RX and TX functionality
>>> - Perfect Frame Filtering
>>> - Big/Little Endian descriptor support
>>> - 93C46 EEPROM support
>>> - LXT970 PHY
>>>
>>> Not implemented, mostly because i had no OS using these functions:
>>>
>>> - Imperfect frame filtering
>>> - General Purpose Timer
>>> - Transmit automatic polling
>>> - Boot ROM support
>>> - SIA interface
>>> - Big/Little Endian data buffer conversion
>>>
>>> Successfully tested with the following Operating Systems:
>>>
>>> - MSDOS with Microsoft Network Client 3.0 and DEC ODI drivers
>>> - HPPA Linux
>>> - Windows XP
>>> - HP-UX
>>>
>>> Signed-off-by: Sven Schnelle<svens@stackframe.org>
>>> ---
>> Applied.
> Hi Jason; I just sent some code review comments on this patch
> so you might want to hold off on applying it for now.
>
> thanks
> -- PMM
>

Sure.

Thanks


