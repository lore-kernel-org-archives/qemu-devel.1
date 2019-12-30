Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062BDC2D0CE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 08:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C533C207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 08:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScX1lvh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C533C207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilqci-000230-Ud
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 03:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ilqc8-0001dK-8p
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 03:41:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ilqc6-0007W8-JG
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 03:41:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24561
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ilqc6-0007VW-Fs
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 03:41:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577695281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RFbfgE1s7cnmutrzI2bPSs6+m48GkwY4+kPvIpCeMjc=;
 b=ScX1lvh4kXok0qDR/mMGNWQdYR4EtfxSTQimuz4Y7HmwOfyfZ08bC7U02BrWzUe8I3ofi7
 ETjsfWfC/48D0eY2thdBEOskZRBTDkVbfRSZN1CyDq/JGw4LWc5Fdzmw5vsS+eXqJJsjIU
 1Mray+tfpAVZQEXCCJV/f5/OLUW86v8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-wvni9LyjMcOuNnhqA5IsJg-1; Mon, 30 Dec 2019 03:41:17 -0500
Received: by mail-wm1-f71.google.com with SMTP id c4so1577871wmb.8
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2019 00:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lpqafBwSYJKY5Rj4ehzaV/V2/jXEUYarkKpXAul00jY=;
 b=EV2jZe0Xw1UAXHweeVENqxGpPYEfAu7QK3OHN4d2/GuuA28m9NP20vWTP0shtRBLKY
 Rowm0BMf57/B4iBEvTFJeBsXfFcPiN2huH/GeHeT/VhMA+OAsbaum1QN+x7vmvfk+aI9
 gCaT2MzSePcxQXy4wc9oabxl6OQObUlCHuHFrE1K9c5PJZfh/OmvW5/YypirBXXkmlVi
 e+607IS3sFZfdpsrbeTRQ/sIZuWrHQ0n3dOsENfXwdy99CTdjmb/9PNpkrgWlj1bNmh5
 5k/oFTJXFKpy78TFEzOmPkoM0MTxsTEr78AkAMCe8BDvDVG0/CMTkhXV99rX+yxs8Rpd
 RyuQ==
X-Gm-Message-State: APjAAAWkwB2lDxmqk/Qczwk0sv5m0zXiNWyI171To0NfddBDwYW4vAlr
 /xoxByFrKMUHSqmAKGJsub9TI+Ju6nI4A5lTAqZ+6oH0givIKWmp8X+XIRflpzv6BbmMdKd4PKz
 a/wUTRqWmyMJthO4=
X-Received: by 2002:a1c:6a07:: with SMTP id f7mr34233199wmc.171.1577695276146; 
 Mon, 30 Dec 2019 00:41:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqyueoww3dyzp1cqBPm9d11/q4jwhS0vobf/Yu7d3Wrs6noVdL3DboZdchtPKK9jQd10N/4sSg==
X-Received: by 2002:a1c:6a07:: with SMTP id f7mr34233182wmc.171.1577695275958; 
 Mon, 30 Dec 2019 00:41:15 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id b137sm20777127wme.26.2019.12.30.00.41.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2019 00:41:15 -0800 (PST)
Subject: Re: [PATCH] x86: Check for machine state object class before
 typecasting it
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
References: <7cc91bab3191bfd7e071bdd3fdf7fe2a2991deb0.1577692822.git.mprivozn@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bda93e70-f737-4384-0422-3901767b6330@redhat.com>
Date: Mon, 30 Dec 2019 09:41:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <7cc91bab3191bfd7e071bdd3fdf7fe2a2991deb0.1577692822.git.mprivozn@redhat.com>
Content-Language: en-US
X-MC-Unique: wvni9LyjMcOuNnhqA5IsJg-1
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
Cc: pbonzini@redhat.com, mtosatti@redhat.com, Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/30/19 9:00 AM, Michal Privoznik wrote:
> In v4.2.0-246-ged9e923c3c the SMM property was moved from PC

Typo v4.2.0-246-ged9e923c3c -> ed9e923c3c.

> machine class to x86 machine class. Makes sense, but the change
> was too aggressive: in target/i386/kvm.c:kvm_arch_init() it
> altered check which sets SMRAM if given machine has SMM enabled.
> The line that detects whether given machine object is class of
> PC_MACHINE was removed from the check. This makes qemu try to
> enable SMRAM for all machine types, which is not what we want.
>=20

Fixes: ed9e923c3c
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>   target/i386/kvm.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 0b511906e3..7ee3202634 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -2173,6 +2173,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>       }
>  =20
>       if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
> +        object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE) &&
>           x86_machine_is_smm_enabled(X86_MACHINE(ms))) {
>           smram_machine_done.notify =3D register_smram_listener;
>           qemu_add_machine_init_done_notifier(&smram_machine_done);
>=20


