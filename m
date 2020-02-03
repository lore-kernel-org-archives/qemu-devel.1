Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5F7C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:23:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90ECA20674
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLokPwCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90ECA20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iybgy-000679-Qt
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 08:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iybfw-0005F7-9R
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:22:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iybfv-0002DI-5Z
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:22:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39881
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iybfv-0002CQ-1G
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:22:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580736122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=oPrxhSO9q5RhaQCB8RH17g5fsteSmwbISw++NJUCjec=;
 b=KLokPwCLi0TLLLx18VbLIT+orMJ8VPJ421Q3qHm/3Ud7cHhoc0m/MA2rczDEyFZdAlTIbD
 LszkIDVRkgGJbXT8vuFmyhrXkooAPQEU1pD6ffJQc82gDJYIit/cKonwTctVPpX+G9YztC
 8N7qda5Nw91O1mi5YFvphx9V54Az4Nw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-gmUzFSjWMICNyOctG7h7rw-1; Mon, 03 Feb 2020 08:21:59 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2533107ACCC;
 Mon,  3 Feb 2020 13:21:57 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-129.ams2.redhat.com [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E0232103;
 Mon,  3 Feb 2020 13:21:54 +0000 (UTC)
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
Message-ID: <ef53558f-4126-2144-19bf-8955a2184743@redhat.com>
Date: Mon, 3 Feb 2020 14:21:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8ai76afSyMhFr0u4fMtD7iR3mAi3EUsGA1-NBZ5bCeOg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: gmUzFSjWMICNyOctG7h7rw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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

I've now sent a patch ("[qemu-web PATCH] Update the documentation
links to point to our generated docs"), but I decided to keep the
"Manual" link there so that the footer does not look so empty (but
of course I've updated the link to the new location instead).

 Thomas



