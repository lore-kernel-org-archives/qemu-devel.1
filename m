Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA091C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 15:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C262082F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 15:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdjuOmKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C262082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6FTG-0007yE-QU
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 10:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6FSe-0007R6-4P
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 10:15:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6FSc-0000jn-Sr
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 10:15:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25920
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6FSc-0000j6-P7
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 10:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582557354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yy2QMxGQRY+kMn35Yar9z0kVHyOsXZN4SsSqJLN257o=;
 b=GdjuOmKNfDW65QfmiuHOZjOD+OhYfTPtVZnzvD8IpSzjb6tcX+sVIlfFId9k2rZhiDy329
 yTOK/YW2iFbiq8utIU5J0XTtI0mTEuV7NasBpWm/ji6NxOtFlSZp8xSLrXR++8uc5DBRQM
 FrMXNi/l9dA7n+yFFV/FosR5h2KxyJs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-9L4h1zVrOoOBEIikuDm0Sw-1; Mon, 24 Feb 2020 10:15:50 -0500
X-MC-Unique: 9L4h1zVrOoOBEIikuDm0Sw-1
Received: by mail-wr1-f71.google.com with SMTP id e5so4110054wro.12
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 07:15:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qLPb652ilZnfhoXxmeMZhgHqHBa5ikhFuC62UM8HZJs=;
 b=cV45GlGmM8JRRq0VGV5bqgzAoVndwDU6YwtyAyV3KCLWogPWHSWFFoG3EJ+qhGX5So
 zlkD0YMpOhSqkt1p35++kHl0PymsfwvTrk0K3Req3jrvIPXJSY/Qih2I3+TIZDJFN0Lv
 qzYqR2RhEL0/OdHu2U6RSfZD0pk05fjMdT6pmptgpdV0m+g/1XUnuGs6YP6lvBGL4b46
 T4ceqFFD03XRLgJad4rC8VAOx7jUrcBlVcg4T/vIFmuxKbFas+6AA8Kr14u637NLfpHD
 bVduPDncuHp85LMLBr5LMFEBPDEa+gxP43+0bLEKZFe3xVDMaF1FPt0OUBtGqxrp14+I
 8mBw==
X-Gm-Message-State: APjAAAU1y3joEuxb7kQ1yY0ioUMQhdRJjOLI9Qudda+cOI5mooAgOWgk
 0wTYifBihS3NFptvUoguRP6G3fc+wMj0EGuhfZ3mXrDw/YyX9AC2u0olNUehiBbLxuVzOFY3M9R
 PqjD7rgjyYb4DCtI=
X-Received: by 2002:adf:f10b:: with SMTP id r11mr67560932wro.307.1582557349022; 
 Mon, 24 Feb 2020 07:15:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqx6ClK3kBQ0bDi85Vrit5OcNPacN+ypVCURxbePGegiczyPgzTs9/wS9QfT96aLTHBujG5iWg==
X-Received: by 2002:adf:f10b:: with SMTP id r11mr67560917wro.307.1582557348775; 
 Mon, 24 Feb 2020 07:15:48 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id c9sm19115695wrq.44.2020.02.24.07.15.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 07:15:48 -0800 (PST)
Subject: Re: [PATCH v31 20/22] Add rx-softmmu
To: Eric Blake <eblake@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200223065102.61652-1-ysato@users.sourceforge.jp>
 <20200223065102.61652-21-ysato@users.sourceforge.jp>
 <da7b0c50-4466-a491-8487-2c3a11984077@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <598cc17a-9686-e9c5-72b5-5153d29d5a52@redhat.com>
Date: Mon, 24 Feb 2020 16:15:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <da7b0c50-4466-a491-8487-2c3a11984077@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: richard.henderson@linaro.org, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/24/20 4:11 PM, Eric Blake wrote:
> On 2/23/20 12:51 AM, Yoshinori Sato wrote:
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Message-Id: <20190607091116.49044-17-ysato@users.sourceforge.jp>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> pick ed65c02993 target/rx: Add RX to SysEmuTarget
>> pick 01372568ae tests: Add rx to machine-none-test.c
>> [PMD: Squashed patches from Richard Henderson modifying
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qapi/common.json and tests/machine-=
none-test.c]
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>=20
>> +++ b/qapi/machine.json
>> @@ -26,7 +26,7 @@
>> =C2=A0=C2=A0=C2=A0 'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa',=
 'i386', 'lm32',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
>=20
> Missing mention of the new enum member with a 'since 5.0' designation in=
=20
> the documentation.

Is this something we can automate? Maybe dumping all the qapi data when=20
we do a release, then check the differences before the next release?


