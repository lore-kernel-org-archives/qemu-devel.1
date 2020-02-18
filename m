Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE25C34047
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFBC724658
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ci/jM/Dq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFBC724658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46Xh-0002N4-3I
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:20:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j46Vi-00089j-MZ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:18:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j46Vh-0001dT-Pt
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:18:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46773
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j46Vh-0001cy-M8
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582046292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eaM4dG9iSiBgIjGKLyt/+K3NarKsxcIp9ZbXuIGRaus=;
 b=Ci/jM/Dq/bY5xmZsjgyqdorrt8miNVYgV4KyMmHYYelduXkhh23Hie8kCXSUV2fwfYkChn
 2irwGt5p8prj80OMnMS3cAFITfqTinvsbOiHhpjIc8EaVjUTvGDokgLUuJW2BPN9RE0sj1
 7PnXUT2HJ1qVpZDH7ZVdKFON2t8mKaw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-qzLiYaDtMTiA1DVuCuOnKw-1; Tue, 18 Feb 2020 12:18:06 -0500
Received: by mail-wr1-f71.google.com with SMTP id r1so11121059wrc.15
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:18:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ALb0M1wXHcnYJ69IqHmiq56sL0YTSZJgAHCw9yHmgj4=;
 b=iWsB55CHopyFzYKtA9aDeFzUUjTUj5erzB0FI1vOixB1HKHvyfRDuqOd94TEpiDE28
 +Bihna9rKcqRNykwJB0yE6Aj8nnUSaQo2fmAMOlvSkgyzY12FkpVLU65nqkThkNTsNP1
 Lx5OmnPePYnyZuwM4kWj4Ih8rjnQfMHzLbrYUGI+1rN//l6kuuA7cDxoZie5Fk52TsVE
 aNr4SnAz8s3vucf9sGEOFmyMsMuySrH9vs9X96qEPoFqDDcEEb97cJ2dXkhpZZgOD3Jr
 725UVOc5A4FEdhvuFlxmRopOO35PaqOjKRXGFxxp4RIGV4XCjan+50dK4Yd+tfuZZO0P
 JjtA==
X-Gm-Message-State: APjAAAVJrWVsWQUq5HSmvrluS8MXSqnA+KfgB+ph0BL10IiZvcwdkas4
 7ql/jHp9Ef6DiXRsTS5J4jsPUJo01QgubHkrJqbC/iFCGMBDwmyT9b7TPcQLZ1z+E9JDykzK/5i
 beDXj7qzrz4pFCEE=
X-Received: by 2002:a05:6000:1252:: with SMTP id
 j18mr31908835wrx.103.1582046284301; 
 Tue, 18 Feb 2020 09:18:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqwG6i4YcgaFnlbv3WfRY5OJ+BLW7u4hWifWfupMQPybnAFUBY7mP9lNrgjJDN9H6whwAgv19g==
X-Received: by 2002:a05:6000:1252:: with SMTP id
 j18mr31908814wrx.103.1582046284097; 
 Tue, 18 Feb 2020 09:18:04 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id k7sm4025803wmi.19.2020.02.18.09.18.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:18:03 -0800 (PST)
Subject: Re: [PATCH v5 13/79] arm/digic_boards: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-14-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a8c8ea00-ec3a-4dac-5568-5c24ff83d15e@redhat.com>
Date: Tue, 18 Feb 2020 18:18:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-14-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: qzLiYaDtMTiA1DVuCuOnKw-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, antonynpavlov@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 6:33 PM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>    MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> PS:
>   remove no longer needed DigicBoardState
>=20
> PS2:
>   while at it add check for user supplied RAM size and error
>   out if it mismatches board expected value.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


