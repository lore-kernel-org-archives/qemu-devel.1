Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6006C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 21:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81827222DD
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 21:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xg0fDgG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81827222DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWoV4-0001S1-OL
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 16:23:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iWoRU-0005Ey-Ed
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iWoRQ-0000n7-Ss
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:20:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47625
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iWoRQ-0000mt-P9
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:20:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574112012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XEQc9GGzVfCgyalPiZuLfcDhEacdHWuMQLAmd9twLL0=;
 b=Xg0fDgG+uIEj7X1xxs0WdasgCfGyj8akOQ5/j5a4HI2TLmShM6ijlP3ZKIB1vhBlmb63h8
 2SH/IbueBvwEj5SmPWMEoYsgpTRfkAedCDZLyrwFS9g0ncjnZh/lyU7l6hOSvyWmgbmjAv
 I0MDSzKgdcuf7UfQAxk3ptYRgaia3qs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-a_Ynj4_2P_ubmKxW7EcAXw-1; Mon, 18 Nov 2019 16:20:09 -0500
Received: by mail-wr1-f71.google.com with SMTP id b4so16586506wrn.8
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 13:20:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UE6EDNxk6yJJwC1ODVz8xYg0z0mT9tmWkRSkmchqceI=;
 b=L9FjCSUzp1UCCXFKUdigmHL3Elx0OyRoD83BSG+2wfF731WwRzZJTYjbXu9qi2wKdL
 kT3nEeFcWLzLDIPmGEC07det7fawt88OGSYXQcSqW/Jj8ME+dIYNguC+DwvNhajG7fBM
 wZLazlCjIguwjXQ9ic1C9RCnr3YNfVv5AfBzgTLmEqXtKUvWHv90WP/eS2HTlZXZ9Grn
 pJYPBiAwgoDvA/FTRuXOQF32fZjMzT9DlzAR/LWlRTe9SPq0Ncap1L4u/h9DiyosZoDH
 Cq4rhd0mzBxJsAhudeS5QtbXOcvBOibRsFwWCRbmKW5yhTRR3RapgHlwM0N5QQ5f4clJ
 8a9Q==
X-Gm-Message-State: APjAAAX73V/dByqJqoZBd0WxyCqef/s9FKVQ48s07VRHM5K+ZYzNqk7K
 ALC4EcSJK4TQcwT01Wse79asrxFFkAgG43ilJ8sOvAtDlfBmeLa+oawZS1YcqAYkDSwvpWLXEUV
 mDJoxVYxU+dZeoW0=
X-Received: by 2002:a5d:558e:: with SMTP id i14mr32392317wrv.140.1574112008059; 
 Mon, 18 Nov 2019 13:20:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqwcXhU9edVPeNF/1OGXCQZgO02XAnD+EBjs31Ku5IKPG7GjUemOTZtDBiR6qhu3IDqtZXFjmg==
X-Received: by 2002:a5d:558e:: with SMTP id i14mr32392291wrv.140.1574112007809; 
 Mon, 18 Nov 2019 13:20:07 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id c4sm24623432wrp.86.2019.11.18.13.20.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2019 13:20:07 -0800 (PST)
Subject: Re: [PATCH-for-4.2 v3 1/3] hw/block/pflash: Remove dynamic field
 width from trace events
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20191118210458.11959-1-philmd@redhat.com>
 <20191118210458.11959-2-philmd@redhat.com>
 <833a3e22-2bbb-f646-eb9b-5c56dfeb43e6@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4a859ab8-a717-6b92-fb63-92ac6bb19fe8@redhat.com>
Date: Mon, 18 Nov 2019 22:20:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <833a3e22-2bbb-f646-eb9b-5c56dfeb43e6@redhat.com>
Content-Language: en-US
X-MC-Unique: a_Ynj4_2P_ubmKxW7EcAXw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/18/19 10:15 PM, Eric Blake wrote:
> On 11/18/19 3:04 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Since not all trace backends support dynamic field width in
>> format (dtrace via stap does not), replace by a static field
>> width instead.
>>
>> We previously passed to the trace API 'width << 1' as the number
>> of hex characters to display (the dynamic field width). We don't
>> need this anymore. Instead, display the size of bytes accessed.
>>
>> Reported-by: Eric Blake <eblake@redhat.com>
>> Buglink: https://bugs.launchpad.net/qemu/+bug/1844817
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> Is it worth a Fixes: XXX calling out the commit that introduced the '*'?

Yes, good idea.

>=20
> /me goes and searches
>=20
> Fixes: e8aa2d95ea
> Fixes: c1474acd5d

Similarly the next patch (hw/mips/gt64xxx_pci.c) fixes ab6bff424f4.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


