Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AFDC2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 13:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E122071E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 13:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4pVKGGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E122071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilvPX-00079l-U4
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 08:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ilvOv-0006jv-9A
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 08:48:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ilvOr-0007mE-NA
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 08:48:02 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48588
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ilvOr-0007l2-Jo
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 08:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577713680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BCHeHT62Ri6ZjIfOtM2LeNxMurApjbs16BnMzSBgGqw=;
 b=d4pVKGGRtRT1Ve//6KalOgXqx8HJOG1P1EexOn5dCzfFIYHApHFspZE2urE3Z7Xc5o6wz7
 LnW39jhgaDg1ejepSECzUpvVUsVXTNv/t3q8Y89n3sFu7TKigjdK4xiBwk6aL0LXelwOiZ
 RsB1rngLdBQlE5z+gm0aPRVUevI/oD4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-wffbEv9TPR2sM4NmtCNHMA-1; Mon, 30 Dec 2019 08:47:58 -0500
Received: by mail-wr1-f72.google.com with SMTP id h30so8943033wrh.5
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2019 05:47:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6TqDp3DZqiITk34NZiVcHjTr9IXE1mldSFwAouhqrZY=;
 b=nvY7B0ZiR/gpNhL9eChCYfTFu+EwUO0zHptrBwAFshBM55soDThnmreaSP7B0LyNBX
 FfJHCCb5h8Ol3LfhjFNvn/C2J9mMPzpZSRhWpSErP3Yh8VpA5LJZlX+oaiiKT7VVNOo8
 uUTLvmUUyXUakVwGuH/jWHJLKwa7GEA1SDFonPHD862+Al4XUoX644c9DPn3IIxvWCS7
 sl838JVu/GSs+9cKDL4Udl+3EPWeObDd1EFuuKcpIu0/s+MGe3EO5Pe1317Ro9sgFWBw
 J+oED4CI+QdYEgPI+8AFOooUlY6r+xrMGQf6TgIxlE5z9yV6Sq4n/AwntcaMk0k1YOop
 Tj1g==
X-Gm-Message-State: APjAAAUwIxK73Z+46EKUTLxAQd/dO9HmTeFinRzWyD4b9GW9AhNFR1rJ
 93gdd9KnA3U4a0ZqHhRfWXEBdfMeSWqewrbCfjZqiCgnb0AoATGhBIoqhmvAJepVHL808GdTE6p
 0XoHHFr/7qJba7sI=
X-Received: by 2002:a05:600c:210e:: with SMTP id
 u14mr34770799wml.28.1577713677697; 
 Mon, 30 Dec 2019 05:47:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzq41Jb0ICiuiALSoAkkAbBOkFtMbTKY+rnHEsFn65KSEh5d09o3e+/AnqPIRU6mcH78GvumQ==
X-Received: by 2002:a05:600c:210e:: with SMTP id
 u14mr34770782wml.28.1577713677378; 
 Mon, 30 Dec 2019 05:47:57 -0800 (PST)
Received: from [192.168.1.25] (abayonne-654-1-186-92.w92-134.abo.wanadoo.fr.
 [92.134.161.92])
 by smtp.gmail.com with ESMTPSA id k16sm47731181wru.0.2019.12.30.05.47.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2019 05:47:56 -0800 (PST)
Subject: Re: [PATCH] x86: Check for machine state object class before
 typecasting it
To: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>,
 qemu-devel@nongnu.org
References: <7cc91bab3191bfd7e071bdd3fdf7fe2a2991deb0.1577692822.git.mprivozn@redhat.com>
 <bda93e70-f737-4384-0422-3901767b6330@redhat.com>
 <e70937bd-15e9-aa75-d894-b32b43052b6a@redhat.com>
 <b718e77c-9b49-9c18-7b9b-55333ab0afe5@redhat.com>
 <337056f8-4c8f-9a18-5f58-13dc459f6346@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0b246032-9380-60af-f909-05f21e443baa@redhat.com>
Date: Mon, 30 Dec 2019 14:47:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <337056f8-4c8f-9a18-5f58-13dc459f6346@redhat.com>
Content-Language: en-US
X-MC-Unique: wffbEv9TPR2sM4NmtCNHMA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: pbonzini@redhat.com, mtosatti@redhat.com, Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/30/19 2:17 PM, Michal Pr=C3=ADvozn=C3=ADk wrote:
> On 12/30/19 10:45 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 12/30/19 10:35 AM, Michal Pr=C3=ADvozn=C3=ADk wrote:
>>> On 12/30/19 9:41 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 12/30/19 9:00 AM, Michal Privoznik wrote:
>>>>> In v4.2.0-246-ged9e923c3c the SMM property was moved from PC
>>>>
>>>> Typo v4.2.0-246-ged9e923c3c -> ed9e923c3c.
>>>
>>> This depends on how you format the hash :-)
>>> I've used 'git describe ed9e923c3c' because I find it more readable for
>>> us humans (at least we see what version the commit was introduced in).
>>> But I don't know what the praxis is in qemu.
>>
>> Hmm I never used it. Your explanation makes sense, but the tag confused
>> me because I don't have it locally. However git (and gitk) seems clever
>> enough to only use the useful part:
>=20
> The v4.2.0 tag is in origin. I wonder how come you do not have it.
>=20
>>
>> $ git show randomcrap-ged9e923c3c
>> commit ed9e923c3c9a2c50c4e82ba178b3fb1feba56867
>> Author: Paolo Bonzini <pbonzini@redhat.com>
>> Date:=C2=A0=C2=A0 Thu Dec 12 17:28:01 2019 +0100
>>
>>  =C2=A0=C2=A0=C2=A0 x86: move SMM property to X86MachineState
>>
>> FYI My output is different:
>>
>> $ git describe ed9e923c3c
>> pull-target-arm-20191216-1-199-ged9e923c3c
>=20
> You may want to use 'git describe --tags --match "v*" $commit'

Oh yes I have it :>

$ git describe --tags --match "v*" ed9e923c3c
v4.2.0-246-ged9e923c3c

The difference seems to be I have other tags between v4.2.0 and=20
ed9e923c3c, and git-describe choose the closest (newer?).

>=20
> But again, feel free to change it to whatever you/committer wants.

This is fine, no problem, today I learned something new :)


