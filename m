Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCB3C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:47:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 287162082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AafuSb/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287162082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyb8v-0001QR-AI
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:47:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iyb7e-0008VZ-Aj
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:46:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iyb7c-0001fW-LA
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:46:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31521
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iyb7c-0001do-El
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580733995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=C4gbx/VTjAgZBJEp/xlYvv0z/jGtZQ0E7zCAlE2r2qU=;
 b=AafuSb/RzjIeEoPlOGpbkHqPGGUOtBQ7I3SWHEeDkQrZ3PzhfeIwLKDlzIUw9k1KwzNoVW
 K6LhZVTaPhmC+TrOdRXypFLb2Bs/+rg0w4i3k76cZMhmk7jr0LXKlz3t2jjjHSs/VC3FTi
 tkzU3SUO0dm0quCpKhXpp7iEdLtnbYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-XOHBl5YrP-GxRuU0ie5RDA-1; Mon, 03 Feb 2020 07:46:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 072D5801A0F;
 Mon,  3 Feb 2020 12:46:27 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-129.ams2.redhat.com [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65F4489F08;
 Mon,  3 Feb 2020 12:46:23 +0000 (UTC)
Subject: Re: [qemu-web PATCH] documentation: update links to readthedocs
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200113103550.1133-1-alex.bennee@linaro.org>
 <2331e0b7-cad9-7b53-3d30-7fb88d692c8a@redhat.com>
 <20200115111042.GA163546@stefanha-x1.localdomain>
 <CAFEAcA9Q5nsD5iTPwsVVx73HPUD6aGKd0Sf2FUkAFqjAZhGMGw@mail.gmail.com>
 <82f0aa8e-b445-ad7f-1b17-03f4bb180a85@redhat.com>
 <CAFEAcA8pHXeqtC3WT67vwC=g4Vw7BsYpDxUih1XWYzC+dAjoGg@mail.gmail.com>
 <31ba2839-a7c1-28dd-8319-1ea6defb5daa@redhat.com>
 <CAFEAcA-kDpwAWzqME7-uKy7svu7wrJ8Vq2jxOqmjdsKXvO2grA@mail.gmail.com>
 <CAFEAcA8ai76afSyMhFr0u4fMtD7iR3mAi3EUsGA1-NBZ5bCeOg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f5eb53e6-c282-f183-0056-6557e5a684e1@redhat.com>
Date: Mon, 3 Feb 2020 13:46:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8ai76afSyMhFr0u4fMtD7iR3mAi3EUsGA1-NBZ5bCeOg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: XOHBl5YrP-GxRuU0ie5RDA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/02/2020 13.44, Peter Maydell wrote:
> On Mon, 3 Feb 2020 at 12:38, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Mon, 3 Feb 2020 at 12:12, Thomas Huth <thuth@redhat.com> wrote:
>>> Ok. Should we then just remove https://www.qemu.org/documentation/
>>> completely and make the "Documentation" link in the "menu" point
>>> directly to https://www.qemu.org/docs/master/ instead?
>>> We could simply mention the Wiki in docs/index.html.in, too, I think?
>>
>> I think I'd keep the current documentation/ page for now
>> (we probably don't want index.html.in to refer to the
>> developer documentation or the git tree).
> 
> There's also a 'Manual' link in the footer thingy on every page
> which currently goes to https://qemu.weilnetz.de/qemu-doc.html;
> since we already have a 'Documentation' link to
> https://www.qemu.org/documentation in the footer, I guess the
> simplest thing there is to just delete the 'Manual' line.

Ok, I'll try to cook a patch...

 Thomas


