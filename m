Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C95C00454
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F9B21655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cujFDY+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F9B21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifoNh-0006wv-Um
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 12:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifoMc-0006M6-5E
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 12:04:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifoMZ-0008P7-TF
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 12:04:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20155
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifoMZ-0008OC-Pp
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 12:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576256663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RZT7mKlrrJvs6wCkbiK3Z4f60pKV4mJ6oeMUJT8OsSQ=;
 b=cujFDY+flv18wXnMvQKcFqoUIm1V0f0kY32R0sHlYjINj88FdrpY5LzaXdAsR7ikFE12zH
 SsjVCrCwP9s1DtDudcd69IAHSPtTJReOQZ4fpKjEq49CdvxsBH0JONrzstTZkVrWLDt29p
 18IELzsBVvTEcyAg4yE4l92eVr/eJWg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-3yx9deyPOF2Y961Cm-OoWg-1; Fri, 13 Dec 2019 12:04:21 -0500
Received: by mail-wr1-f70.google.com with SMTP id c6so2792193wrm.18
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 09:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XUiq4uJ2Xy7OvbOEdpiV9tYwd2TGjMstqgqamc0EQI0=;
 b=Lqg8RmN7ETpxPCD7omEwQ8AhI13vlHC9mJtaSGmUWwpjDnijcrM1d6A9cDpl3x21Wu
 n2W3Q+aeT5hZ6ShrJUqmnUoa70g6NBUPKSODBGo6EdvSo8hOD2sloxLyfWMrnLhofCSZ
 wNvh6zosWhKB/ND9aFvF6EJZCejAXJ97rGa+cFB1LNzuiStdTTfv5+HtrwcsVmEr28eF
 bjK6pQ2h7n5aPzcz+ohsRdJx9rZK4pewgUvbkG6iydXSVcup/efmf5c5wNseYvek791n
 ZZrCpO8tDEI70KDFyCgQ8L36w1QXEOVY05RiUqX0zZopnKbPs0ZPaUAH5KL1oOu25DOj
 PHrg==
X-Gm-Message-State: APjAAAVhjUdQLApAn/woOa0zvIWcjKQrhZyx1ImNLcybbhpnn6pp5ktW
 Fw4XLQ4+2iwGSoLLOC2ZBVcHApBflsllJTvhcHi3hIyMjhFAuQMVZgr4oTLYSzfsnuMaWGkfX6T
 VjwTdzXyEf1nNgC0=
X-Received: by 2002:a05:600c:2112:: with SMTP id
 u18mr14476732wml.100.1576256659830; 
 Fri, 13 Dec 2019 09:04:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqwHQcnqxCZRiLSpPveExbTVjVTIfuEOxqvf7hw8CwQ2CtspkWAwQyxun5V0SbspWmzbwX69pg==
X-Received: by 2002:a05:600c:2112:: with SMTP id
 u18mr14476695wml.100.1576256659537; 
 Fri, 13 Dec 2019 09:04:19 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id m10sm10695455wrx.19.2019.12.13.09.04.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2019 09:04:18 -0800 (PST)
Subject: Re: [PATCH v2 0/2] hw/arm: ast2600: Wire up eMMC controller
To: Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, qemu-arm@nongnu.org
References: <cover.fc3e5e495d85ebd919c1f06a1a2c7c7730518f9c.1576211124.git-series.andrew@aj.id.au>
 <16c90bb0-a3a9-06ec-e79a-bd98471d9e11@kaod.org>
 <1d96ac9b-5eb2-43ec-bf21-334ee3fa4420@www.fastmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d70b5f1a-08e3-4664-719f-dd5526a4135e@redhat.com>
Date: Fri, 13 Dec 2019 18:04:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1d96ac9b-5eb2-43ec-bf21-334ee3fa4420@www.fastmail.com>
Content-Language: en-US
X-MC-Unique: 3yx9deyPOF2Y961Cm-OoWg-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/13/19 8:37 AM, Andrew Jeffery wrote:
> On Fri, 13 Dec 2019, at 18:03, C=C3=A9dric Le Goater wrote:
>> On 13/12/2019 05:28, Andrew Jeffery wrote:
>>> Hello,
>>>
>>> The AST2600 has an additional SDHCI intended for use as an eMMC boot so=
urce.
>>> These two patches rework the existing ASPEED SDHCI model to accommodate=
 the
>>> single-slot nature of the eMMC controller and wire it into the AST2600 =
SoC.
>>>
>>> v2 contains some minor refactorings in response to issues pointed out b=
y
>>> Cedric.
>>  =20
>>
>> I think these patches are based on mainline. I fixed them locally on
>> my aspeed 5.0 branch and I plan to send them along with other aspeed
>> changes in the 5.0 timeframe.
>=20
> Yeah, they're based on Peter's tree. I'll base future patches on yours.

To help any reviewer, simply add a note in the cover on which tree your=20
series is based. This also works with individual patch, add the note=20
under the '---' separator.


