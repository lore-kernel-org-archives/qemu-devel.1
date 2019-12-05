Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E538C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 13:52:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E867D224F8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 13:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LdWpiWde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E867D224F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icrYZ-0003sy-Kj
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 08:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1icrUB-0008Sp-3B
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:48:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1icrUA-0001yj-4B
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:48:02 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55869
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1icrU5-0001x1-O8
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575553676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=kd9+ydgiIiTStIgnDR8LmgTbuKjkeAZ7DJ2ZDSP9cNo=;
 b=LdWpiWdeTnTgS+nOyTbswiKPNDKrbmih2tiSL+MvoZTDOiFrlD0JYl8yCbdMxTB3tcaDur
 +f2PqJLRmRDdre4otSqqrxuX85MM55+MSWKYsBnYtM9NvTASWy6nsRKIh6pHI0JmZ8e9p9
 muv2LG7s37cNHA+ItuwB6V6ZAIHis+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-XgBdCTNKPVicCSBKQvtpxA-1; Thu, 05 Dec 2019 08:47:54 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B67F28017DF;
 Thu,  5 Dec 2019 13:47:53 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-87.ams2.redhat.com [10.36.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F4A11042AE7;
 Thu,  5 Dec 2019 13:47:52 +0000 (UTC)
Subject: Re: [QUESTION] "cpu" vs "core"
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAL1e-=hzSLWQ2_qTOXc30FpaMO65uKGqUP9agE+Ti1cfEU9j=A@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8a2b8d3e-e933-22b0-1d5d-11e5a5134b6a@redhat.com>
Date: Thu, 5 Dec 2019 14:47:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hzSLWQ2_qTOXc30FpaMO65uKGqUP9agE+Ti1cfEU9j=A@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: XgBdCTNKPVicCSBKQvtpxA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/12/2019 14.11, Aleksandar Markovic wrote:
> Hi, all.
> 
> Times are changing, and perhaps some words change their significance or
> are less in use.
> 
> What do you think of introducing a new option in our command line
> "-core", that would be (code-wise) a sinomym to "-cpu" (that becomes
> almost archaic)?

The QEMU command line is too overcrowded already, so let's please not
add redundant synonyms here. But if you think that -cpu is not clear
enough, I suggest you send some patches to improve the documentation
of that parameter instead.

 Cheers,
  Thomas


