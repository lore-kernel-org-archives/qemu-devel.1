Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47E4C432C3
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 20:05:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 915F020732
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 20:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gb/22bB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 915F020732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ib8zH-00060D-PT
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 15:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ib8y5-0004z9-I4
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 15:03:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ib8y2-0005Gb-DW
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 15:03:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50245
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ib8y2-0005Fn-9s
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 15:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575144225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xrbM0tw3wDzFHwKJMSmnVA6OKhMPAkjiHIhiJ5fZ/lk=;
 b=Gb/22bB4NB2X6+38oWYHkFO0KzUQOT2x3kS/XXKh8XI9bsScaKaQkxuQHn2V1jXJduIFSG
 wnw0KZBHY4PqS2r+5RT+ni4X0aVlI5RC9sxFGJpgljQYjHQ3UBsr/z6Hhwm9TLYm2BJXK+
 Bi8Y0NMSAlTWaIDyratVmJBeOGl/3No=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-ylWKit13NdqRIrJXU8nbqQ-1; Sat, 30 Nov 2019 15:03:43 -0500
Received: by mail-wr1-f72.google.com with SMTP id d8so13701801wrq.12
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2019 12:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zsCDKxtthwMDqFe+uR0XKu7+qlBT14Iy6p2epB6Sh4M=;
 b=D9HchMsnB/NezQZTDNG7ofi+6JFBKJ+z/2Be0mMhZmhIMmSBDISob3LU73zwNtcddQ
 Gny7k8uf5vqAwnwNwymRkpPHjVLEovoImKe9+Qv3RgkRj7KsGDHpPG1ZDj7NGceT3bel
 j2TixgDPQvsWf1y5ZHM6z16dxE0nr+MD15Ve+2tnqnxCejuwLqhHJA+43EII70YpMjXf
 MN8aOIAtTUJe5rkUTmzdI/baboQyHzbQuTX8is8KptuqpcMb5Fu+RUuuV57vCrPslLxi
 TMpkmVD2GaR5JbECs+x6u64p5BpcLXXqR0d4DkgbDejeUEnyDQQIMmAsm/oDR44pzQnL
 Durw==
X-Gm-Message-State: APjAAAWZFAzdoW+6MJk5djlBc7IgFR0CqWhh8tloQkXtIVE0osyGFP7i
 6lLicYy/o0VyL6ABiQjvo4Rci+hvAgIZByChjum5VkwerwyxZr3meu2yMmqzsl9BJP9C+KmoY3L
 yWzJ7cdO4haooSG0=
X-Received: by 2002:a1c:740a:: with SMTP id p10mr20570899wmc.121.1575144222645; 
 Sat, 30 Nov 2019 12:03:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqyzuNHzH73JYhQo/F8FbIrieSEdq+qXEJj4iu1uoKJUMnzo6t/2LhypXDKZaxHOe8Gjupsa0A==
X-Received: by 2002:a1c:740a:: with SMTP id p10mr20570894wmc.121.1575144222457; 
 Sat, 30 Nov 2019 12:03:42 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id p17sm1125329wrx.20.2019.11.30.12.03.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Nov 2019 12:03:41 -0800 (PST)
Subject: Re: [PATCH 19/21] error: Clean up unusual names of Error * variables
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-20-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dcb82438-a73f-307b-73cb-75f6152a7506@redhat.com>
Date: Sat, 30 Nov 2019 21:03:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191130194240.10517-20-armbru@redhat.com>
Content-Language: en-US
X-MC-Unique: ylWKit13NdqRIrJXU8nbqQ-1
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
Cc: vsementsov@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/30/19 8:42 PM, Markus Armbruster wrote:
> Local Error * variables are conventionally named @err or @local_err,
> and Error ** parameters @errp.  Naming local variables like parameters
> is confusing.  Clean that up.
>=20
> Naming parameters like local variables is also confusing.  Left for
> another day.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/intc/s390_flic_kvm.c    | 10 +++++-----
>   hw/ppc/spapr_pci.c         | 16 ++++++++--------
>   hw/ppc/spapr_pci_nvlink2.c | 10 +++++-----
>   tests/test-blockjob.c      | 16 ++++++++--------
>   4 files changed, 26 insertions(+), 26 deletions(-)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


