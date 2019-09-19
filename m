Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC425C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A839921929
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GoGtPHlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A839921929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAudG-0004Bp-2D
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 07:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAuaK-0000dJ-D9
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:26:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAuaJ-0002Cc-15
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:26:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36483
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAuaI-0002BW-Qy
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1568892409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=V/BffB31lVpDDTHXON2h+WYJBrw+b5jOySxVB0LM4rI=;
 b=GoGtPHlO1PC/VkmCim3CYEnCCQT6oDykMvJsGIx27Ek04e+fSpHMgTmbyt4PxEW0nkXGmO
 GfT54Yv3jY1Vy+KMSy/MgLXYQWcoBTbR+8zMjaKnYnU+rgRMmDTbwDjSCEqUZaiSPa+scx
 qCuMdvET+Y1+6M/1Peg3WAiuPhZuRm4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-TDly9ShrPPyf24T4s-rY6A-1; Thu, 19 Sep 2019 07:26:48 -0400
Received: by mail-wm1-f72.google.com with SMTP id k9so1611427wmb.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 04:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tLNKBcGvOcugw6Jnek+jrrm29xCgPjORNAP/3HW0eOI=;
 b=i6rBDcSE7GlMKCE9cmJzbGpiP4MHR0jVgtg0FRgQbzn8AJaCrzBJU9FLutsjLY5nDF
 QoDJnCbrAwlz3EDzoWGaKMpKRfWEhtLMyJot60uKXYA4+vLTGNdq+mi/Imuxb/WCjCGC
 mBkLaTULLTwrRJZXEV/gFecVXW1sZ8/83SxuEIFhBfEeoUHXiMU35wAIeDIXHJoRAoHy
 v7KOKNayAfw1sYePrkM2CdMRTD3ccgNJAln5kkbSBnDLpXJyAWFawvBG7YuPMbzCUxdq
 GThfle+DK+JPTLd3HLEp8xn8XIcnZLjWwDbZty2wpzp4I0gI4OLfGRurnVRb/ZWkqhrp
 gcxw==
X-Gm-Message-State: APjAAAWXJ7YNrIltLKquC7ISmDY91sA0QUuWp0EUfkFW78B2YpjauNwx
 lnrpn4gpS8zW6p9/kRldEFzXXWqbHcFiKmwvj0tQYzaVGZrBHREHDBdtNbfVdiVzCbbODqVJvYz
 eyGjP9C5TuuqrZdw=
X-Received: by 2002:a1c:cbc3:: with SMTP id b186mr2491040wmg.130.1568892406862; 
 Thu, 19 Sep 2019 04:26:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzGdvC+l9q8hHTx1i0eodS8UjJcLHBygqtxpLlzZtncMvCYs/9CgeYP2wF1xTJM496lWOfp8g==
X-Received: by 2002:a1c:cbc3:: with SMTP id b186mr2491028wmg.130.1568892406693; 
 Thu, 19 Sep 2019 04:26:46 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id e17sm5695830wma.15.2019.09.19.04.26.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 04:26:46 -0700 (PDT)
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
References: <20190919105932.19412-1-philmd@redhat.com>
 <04454c37-ad8b-b69b-3f40-bb78f0c20ef2@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0806fcfd-9468-07ec-4695-25ee35005a64@redhat.com>
Date: Thu, 19 Sep 2019 13:26:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <04454c37-ad8b-b69b-3f40-bb78f0c20ef2@weilnetz.de>
Content-Language: en-US
X-MC-Unique: TDly9ShrPPyf24T4s-rY6A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
Subject: Re: [Qemu-devel] [PATCH 0/2] testing: Build WHPX enabled binaries
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
Cc: Fam Zheng <fam@euphon.net>, Lucian Petrut <lpetrut@cloudbasesolutions.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Ilias Maratos <i.maratos@gmail.com>, Justin Terry <juterry@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/19 1:18 PM, Stefan Weil wrote:
> Am 19.09.2019 um 12:59 schrieb Philippe Mathieu-Daud=C3=A9:
>> Add a job to cross-build QEMU with WHPX enabled.
>>
>> Use the Win10SDK headers from the Android Project, as commented
>> in https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03842.html
>>
>> Based-on: <20190918121101.30690-1-philmd@redhat.com>
>> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03844.html
>>
>> Philippe Mathieu-Daud=C3=A9 (2):
>>   tests/docker: Add fedora-win10sdk-cross image
>>   .shippable.yml: Build WHPX enabled binaries
>>
>>  .shippable.yml                                |  2 ++
>>  tests/docker/Makefile.include                 |  1 +
>>  .../dockerfiles/fedora-win10sdk-cross.docker  | 21 +++++++++++++++++++
>>  3 files changed, 24 insertions(+)
>>  create mode 100644 tests/docker/dockerfiles/fedora-win10sdk-cross.docke=
r
>>
>=20
> Please note that the required header files are part of the Win10SDK
> which is not published under a free license, so I am afraid that they
> cannot be used with QEMU code to produce free binaries.

Yes :S

> I have addressed that some time ago, and Justin Terry is still looking
> for a solution on the Microsoft side.

Oh this is a good news, thanks for caring about this issue,
and thanks Justin for looking for a solution!

Trying to understand how WHPX is used, I noticed there are much many
Windows QEMU users than I thought, and it would be nice if we can have
some upstream CI testing to not break the various projects using it.

Regards,

Phil.


