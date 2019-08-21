Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C03C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 10:32:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1E0233A1
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 10:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1E0233A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Nuj-00032x-Vu
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 06:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0Ntu-0002TZ-V3
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 06:31:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0Ntt-0005To-2b
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 06:31:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54140)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i0Nts-0005OS-1l
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 06:31:33 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B45DC7E43D
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:31:30 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id 19so1010300wmk.0
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 03:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sAZfJIekTAWS7/fP5s+3zKlUYvkuKLUTU/Bjt5rpWAc=;
 b=WGMOFmiIhvTCPV+4xQbYMzxDCzJNPpPUOF9ttVrklHwuYLXpwCu/I86amvabQJcAJr
 Iej3ZGI0CrzE+4q2gix15Mfm45YOlb2QKVqUvKNnV000qDcHdROay+liDA9Zq1/90/zn
 xzliCAgfWwC5Uq09TMphyVu81om5alF0ZXzpdmdmUspHnsVmQi1x6P8k0hO+Kx2fFBdD
 IjcKfzRLqEEl8KBMCkex8KLNdumtd/UdosxCMCdrEjP/Hs9A8LclzmRvmCT/EQrwc6Px
 Ac8QazNVm3eDSmHMioqfBHPvFu3CRnIrj08fO8bpHJyGOCVN9ujCbs6cJVqr1iNkTVS3
 jn1Q==
X-Gm-Message-State: APjAAAUJ4r5sMKLbbxTjUX+Hvi+uYjp4Cs/AuROhKZw30Dm4eNc8Ai/m
 vLii8D4rxCbwN49871uOMOWTIercrYIltq0Kk+lEyr1H4muYUz7VYXtW4p2WxVS5Q5ZpvW7oTb5
 bCYNJIbhX4/uhCW0=
X-Received: by 2002:a5d:4b0e:: with SMTP id v14mr40928849wrq.24.1566383489438; 
 Wed, 21 Aug 2019 03:31:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxNWHHOLufwnMML/o5nz5AtQB/WKOx4t6qFyn35ImNKemvjTGlu09Dx12BXvdjNUGsXfgYPQg==
X-Received: by 2002:a5d:4b0e:: with SMTP id v14mr40928832wrq.24.1566383489287; 
 Wed, 21 Aug 2019 03:31:29 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id s64sm7216182wmf.16.2019.08.21.03.31.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2019 03:31:28 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>
References: <20190812113739.16587-1-philmd@redhat.com>
 <20190812113739.16587-3-philmd@redhat.com>
 <20190821090019.exsa646p7go2cdgn@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9d5079d6-2ab2-8e44-e943-cc801522b018@redhat.com>
Date: Wed, 21 Aug 2019 12:31:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190821090019.exsa646p7go2cdgn@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/display: Compile various display
 devices as common object
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

On 8/21/19 11:00 AM, Gerd Hoffmann wrote:
> On Mon, Aug 12, 2019 at 01:37:38PM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
>> Various display devices are not target-specific and can
>> be compiled once for all the targets.
>> After this commit, the 'make world' target is reduced by
>> 54 objects
>=20
> Doesn't apply, needs a rebase.

Laurent fixed the trivial conflict in patch #1.

Since patch #2 depends of patch #1, can you Ack it so Laurent queue it
in his trivial queue?

Thanks,

Phil.

