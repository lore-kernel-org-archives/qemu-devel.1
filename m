Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B5CC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3407D218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 10:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3407D218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAXaN-0008DE-DG
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 06:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAXZM-0007V3-II
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 06:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAXZK-0002Cy-Db
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 06:52:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47846)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAXZK-0002CF-5a
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 06:52:18 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 336797FDE5
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 10:52:16 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id k184so932010wmk.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 03:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UQ2Y6VQpqh/1DWGeGRRgQsyoDgxpXOFSiVOtuKw+2sk=;
 b=e3r7JRwaYmI5e06cVBrb77o2JfZd6piIqU/gE6TxaE0A9xERYk6oyO/xz6v0PpHRdf
 wiUqQ4vzXYMS935cfo+RbrJRFRKBKYro/HR4HJoadaOjsii/MaHY5uFtDourJu/waVt4
 PRPLE5DrApmcN1byGyfA1Y5mof6AFO32JCuoBIC6pKv+YbkvGr+Q05D03dcuY+jebeRp
 NX2N6ggAJh99ZY3C2jJBrg+Vng/PWEGGQbNxKNVDMo2538dNWwkRRbvJZkvj+HkDnNWg
 gMOBxydmIZsaS+w9U6AU7aLdDUrQDt2SSbzQP1b014xs3cOb/ftOwA7EBvs05S5J4j6W
 Ehrg==
X-Gm-Message-State: APjAAAVAcb3tWmapH6o2iBtC6NARAXsLZkpj9EltqsbrGRPxAijUNe3s
 AOGOTxnBFvZtJFKAVEebbYq3tKxPoj5Z1RloajIXt34vM36e6A9rxsdVV58SEYUO0umYxmMiNCD
 cHD3IOSc2XEQQeqY=
X-Received: by 2002:a5d:6951:: with SMTP id r17mr2488708wrw.208.1568803934953; 
 Wed, 18 Sep 2019 03:52:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzlyH/ASzn2pfs4cumr7vwMvs28X3d0MPHc8IpbU0l3C3NnGZG6CidznXOZgbLuZtOXYCLmAg==
X-Received: by 2002:a5d:6951:: with SMTP id r17mr2488695wrw.208.1568803934779; 
 Wed, 18 Sep 2019 03:52:14 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id l18sm4773752wrc.18.2019.09.18.03.52.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2019 03:52:13 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190916154847.28936-1-philmd@redhat.com>
 <20190916154847.28936-4-philmd@redhat.com>
 <dd8bdcd6-9e43-3721-7b39-f53d906988b3@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <221be2fe-f55b-1197-a477-eb503d99930d@redhat.com>
Date: Wed, 18 Sep 2019 12:52:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <dd8bdcd6-9e43-3721-7b39-f53d906988b3@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 03/13] hw: Move MC146818 device from
 hw/timer/ to hw/rtc/ subdirectory
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/19 10:32 PM, Richard Henderson wrote:
> On 9/16/19 11:48 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>  include/hw/rtc/mc146818rtc.h                 | 38 +++++++++++++++++++=
+
>=20
> Same rebase failure as for patch 4?

This one is actually correct, it got moved from:

 include/hw/timer/mc146818rtc.h               | 14 --------

The difference is the addition of missing copyright/license.

