Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854BEC34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 07:05:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5013021D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 07:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bO2Fwlpj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5013021D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3wwq-00034n-HW
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 02:05:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3ww6-0002EI-FQ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 02:04:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3ww5-0000LV-BO
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 02:04:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56901
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3ww5-0000LH-7o
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 02:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582009488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sl+LzwbllqJoCfJWdFrKsh9oKxLPEyv+5dzcqtBHNZ8=;
 b=bO2FwlpjwbFCq/ZNuOv/4vPgUmZwJX8A38kge31q0oflwmti/Njcl17owC4rHZda6UYhA8
 90JUeRTKdjg0K2U17S+u3qgyWUpU2gtlpwt05p+oWJxFL/NXnIi/5JAjJZRL1XXXwpNw/4
 GlLswyKvHLw8ZgXYj+ilVCCzwAlIleA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-E29vrH16MI-pz8CAcdCqmg-1; Tue, 18 Feb 2020 02:04:42 -0500
Received: by mail-wr1-f69.google.com with SMTP id m15so10231595wrs.22
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 23:04:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/rDMu1ngeApJl5JH2kj1uGo+0GVlev9i7mEWw+S+G/Q=;
 b=D6FoSRJ4iCuNvLYnZe4kBQt/F6/0FG2IMoin5gLY5wTclbg/7bZHO+kwskzTkfj3BN
 gCEIlmuVND40s6hNCbh/3qRD+bbykapQXP+p/jEX8rwPnraLDpkp8NwxgEE7hV+xGejQ
 EU5JW0Aptn4POS1I7w6JkpYaV+RSLmISaF7IjMiXt/R15/N8OfUex60RJ99e3mSWtJFl
 modmq7gPoPLKXOjalbeBnyZV1duhxqxAHweC5E2XGfVi8VhpxyS6ef63NE1yBqkEZed7
 BZkitSmmZB5wvqK5oTkxtTRUbdYMzVsoNxpXjyDzHBjyUkCoLwdjMFHEGLHacEFOKAPq
 bhhg==
X-Gm-Message-State: APjAAAWU6GxaCe6TV0ZrJ9PvNQDWCRjcbiTB8CBGB2s1hXO0dBnncSAI
 3Myo2zCNq8cLdwJDqZiLXML0xZ81Qxh2rGYMz3MRWmckPTCijnlmJCVtJI2T8hZcpI3Cp+GK1G3
 5GDQ/etfwCd6Yq7A=
X-Received: by 2002:adf:db48:: with SMTP id f8mr25525960wrj.146.1582009480918; 
 Mon, 17 Feb 2020 23:04:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqwJGx5SY7ED7v+HLBgYLPrrscFmbAamqzEtoIuIvdrdUgyTR4uLxbKth+r7sO9GpUXlHcAfKw==
X-Received: by 2002:adf:db48:: with SMTP id f8mr25525945wrj.146.1582009480772; 
 Mon, 17 Feb 2020 23:04:40 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id w7sm2365457wmi.9.2020.02.17.23.04.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 23:04:40 -0800 (PST)
Subject: Re: [PATCH v5 49/79] m68k/next-cube: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-50-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a5704c70-7406-a822-c040-0298aa307ba7@redhat.com>
Date: Tue, 18 Feb 2020 08:04:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-50-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: E29vrH16MI-pz8CAcdCqmg-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 6:34 PM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>    MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Acked-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/m68k/next-cube.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


