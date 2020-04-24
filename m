Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E74C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 10:15:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79BD20776
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 10:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+qJSUzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79BD20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRvMa-0003AX-S4
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 06:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRvLY-00025J-Lz
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRvLX-0002u9-Ik
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:14:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49365
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRvLX-0002pL-2b
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 06:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587723249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63D2xrbzfDfeap0RkPGGOz7/mJzQqDcDBzsopTOsES0=;
 b=f+qJSUzOQcn2zdrS9kAyKbs7dBO9yDcfsgdJRJB8+Pp/imHaBEMQql/bg7oNBY5eHxAV8B
 X8ApnfybE6UiPcQNi+nzvyuwn3TOGmtGvtOkPJfChm+/lSJqDQVXPzJTZZeW+P6BT1XZ3N
 buXpiscFoy7I6qXBxp2HbbqNS4Or/B8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411--djxaBBdMJSuBldvhCXx9Q-1; Fri, 24 Apr 2020 06:14:03 -0400
X-MC-Unique: -djxaBBdMJSuBldvhCXx9Q-1
Received: by mail-wr1-f70.google.com with SMTP id a3so4545312wro.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 03:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fgU6Gydgw23BHBALbtBFWugmWXi6XtBwuJE4RkleHs8=;
 b=F3uqEyLHxkrGvFDbRVx/AdC2ULSZv/CpfG3Py8axHpkg4BbkHHe2paMs4d37I7xpBa
 5IotHfMIzTYqF4wCrpQFfdgycdg2nmv+lvHCXyp+bcJemXxG5LcHx0rj6sE7LIIxVWlW
 +WWmu410yGzrRMJkrDVM26555wZ42jYVF50jxxO3ZkNbHpEe3ztoAZ8CjPAyDLKtLh8B
 vL4Ied07Lzg0e72+90set4BkAq574pGv4HdQMJwBeeK/86oSwmfuq3wvKyHLvs8nGEOz
 3dgPpTV662SdZrV3gg37KO/MStJeR2vcMjOcDo1GAugcCva8CbrswZlnZVnCWbCtkpqI
 Ytyw==
X-Gm-Message-State: AGi0PubyyDcqwezInYHmJAzEm3LrmGyypW6SKPKCVNBnxPr9NC78QFLY
 rcwdI4s8FqvCN6jAd7MTytgfPvB4nLAA39ml2SGtPo5JqtSuAnznw+TXpt319pVXTQ2b+S3utPj
 98Zcdc/aUloFnolk=
X-Received: by 2002:adf:f350:: with SMTP id e16mr9739108wrp.332.1587723242166; 
 Fri, 24 Apr 2020 03:14:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypIX5k4Fasb85M3Jdny3fxbt72njeOT6Q72VSaaSSn+hNFlB1XYPxTvRqwgwKor1nMmO6Slwdw==
X-Received: by 2002:adf:f350:: with SMTP id e16mr9739071wrp.332.1587723241828; 
 Fri, 24 Apr 2020 03:14:01 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id c10sm7313717wru.48.2020.04.24.03.14.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2020 03:14:01 -0700 (PDT)
Subject: Re: [PATCH v2 13/16] nvme: factor out namespace setup
To: Klaus Birkelund Jensen <its@irrelevant.dk>
References: <20200415130159.611361-1-its@irrelevant.dk>
 <20200415130159.611361-14-its@irrelevant.dk>
 <b05fdbb7-2f74-be05-e108-36b14abce0be@redhat.com>
 <20200415132004.zei3gqxg5l6r5c6y@apples.localdomain>
 <075d6fbf-f4a0-fa71-f8c0-978b262b5d63@redhat.com>
 <20200416060330.46nqnva2azi3yhev@apples.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7a13ab39-3d61-e8f3-b058-1ba224cdb767@redhat.com>
Date: Fri, 24 Apr 2020 12:13:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200416060330.46nqnva2azi3yhev@apples.localdomain>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:07:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/16/20 8:03 AM, Klaus Birkelund Jensen wrote:
> On Apr 15 15:26, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 4/15/20 3:20 PM, Klaus Birkelund Jensen wrote:
>>>
>>> I'll get the v1.3 series ready next.
>>>
>>
>> Cool. What really matters (to me) is seeing tests. If we can merge tests
>> (without multiple namespaces) before the rest of your series, even bette=
r.
>> Tests give reviewers/maintainers confidence that code isn't breaking ;)
>>
>=20
> The patches that I contribute have been pretty extensively tested by
> various means in a "host setting" (e.g. blktests and some internal
> tools), which really exercise the device by doing heavy I/O, testing for
> compliance and also just being mean to it (e.g. tripping bus mastering
> while doing I/O).
>=20
> Don't misunderstand me as trying to weasel my way out of writing tests,
> but I just want to understand the scope of the tests that you are
> looking for? I believe (hope!) that you are not asking me to implement a
> user-space NVMe driver in the test, so I assume the tests should varify
> more low level details?

I was thinking about something rather simple.

So you are adding the "multiple namespaces" feature, we want to test it.

If you can demonstrate it works with few I/O calls you could try with=20
qtest, such:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg695421.html

If it requires complex commands, since the user-space tools already=20
exist, you can use an acceptance test booting Linux, installing the NVMe=20
tools and use them. See tests/acceptance/linux_ssh_mips_malta.py or
https://www.mail-archive.com/qemu-devel@nongnu.org/msg656319.html

Regards,

Phil.


