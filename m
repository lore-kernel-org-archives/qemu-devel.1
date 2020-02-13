Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BC7C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 953F32073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lx7l+IjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953F32073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2BAT-0008Kp-Rq
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 04:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j2B9Z-0007Tk-Ra
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j2B9S-0001iT-Rp
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:51:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58093
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j2B9S-0001hF-OP
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581587478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TP0m2c13yyONsZNdLdHsAJAuP1rHHUZwpMtw2OLT8bE=;
 b=Lx7l+IjUJJYBrvzb8CAlitZVxxCwxiXd2Fv/OprhCspAL9GRm0x2d15JI26vdfeo9nER3R
 uLeE7Lro1BwDbL9pp5OoL42nM/hBL1x3835F/R9wv7teYXKrWeSytq69EcYTmYO5hlfF2f
 BSKDpCVny8pJFGX8E7SAZ6bYklLKR0M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-9R701eP4N5OjDJ_R0G8gmw-1; Thu, 13 Feb 2020 04:51:15 -0500
Received: by mail-wr1-f70.google.com with SMTP id w6so2108040wrm.16
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 01:51:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cmm16DNMsP8pVSAp45gWrcl4ndwwoJBsG0NSvPreCwU=;
 b=iGtkBfnlJpgsMRf5IbIj3iG3A5s+YvRua9MEEejIX8uoAX6RR9XFTckj15bSl03Sov
 RUHijz0t5VG7Iyb+Cvo6KNVkCb4/YBgI5vszrXK6dla57/ScgjIwuG7bDUsRB65dmH3x
 NZU0rg80/oPudcxKxOjzHjpPMirLhO4S662BtL0YWCqKX5ii3xD5KzAdHT89BNbKXj48
 Iu7BFQ0lCyGfUT8synwtYav9pMy7FhjHiLXEMfBI5pkNhEi4GHzHnJdmro8lAJrfks5M
 fJM84BrotNqR2wJ2iOzHI3xmWmKd/h9TWyzR4rkbr0LXVM8yGxQRW+VnfM9WwkkkqLMs
 wF9g==
X-Gm-Message-State: APjAAAXL4srIcNkk0GV7C+APGgrOwmzTVraLaXZ1/57jbxt/wuj24bNd
 z91wfs2XunJ0iL7zojGLn2pqIgpy3oN70CTmgez/Aa5bBcLdtYqBRNipDpuPlY4cGI2Ik92FCCF
 qxyMI8CJKbmcXKoA=
X-Received: by 2002:a1c:9cce:: with SMTP id f197mr5089016wme.133.1581587474828; 
 Thu, 13 Feb 2020 01:51:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqxm+tc9KyzaZUic3nO7OU0rqKF1OZC4zCWwwrLZsZp+R/FhiQCSVz4EixLhYZQJga4mmbDFbg==
X-Received: by 2002:a1c:9cce:: with SMTP id f197mr5088979wme.133.1581587474547; 
 Thu, 13 Feb 2020 01:51:14 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id e16sm2208668wrs.73.2020.02.13.01.51.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2020 01:51:13 -0800 (PST)
Subject: Re: Question about (and problem with) pflash data access
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>
References: <20200212184648.GA584@roeck-us.net>
 <504e7722-0b60-ec02-774d-26a7320e5309@redhat.com>
 <20200212230918.GA27242@roeck-us.net>
 <560224fe-f0a3-c64a-6689-e824225cfbb9@redhat.com>
 <279d959f-f7e5-65e1-9c68-459f3fed56d3@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <52f0b829-151a-3dd0-0ec7-c3155185510c@redhat.com>
Date: Thu, 13 Feb 2020 10:51:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <279d959f-f7e5-65e1-9c68-459f3fed56d3@ozlabs.ru>
Content-Language: en-US
X-MC-Unique: 9R701eP4N5OjDJ_R0G8gmw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/02/20 08:40, Alexey Kardashevskiy wrote:
>>>
>>> memory-region: system
>>> =C2=A0=C2=A0 0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>> =C2=A0=C2=A0=C2=A0=C2=A0 0000000000000000-0000000001ffffff (prio 0, rom=
d): omap_sx1.flash0-1
>>> =C2=A0=C2=A0=C2=A0=C2=A0 0000000000000000-0000000001ffffff (prio 0, rom=
): omap_sx1.flash0-0
>> Eh two memory regions with same size and same priority... Is this legal?
>=20
> I'd say yes if used with memory_region_set_enabled() to make sure only
> one is enabled. Having both enabled is weird and we should print a
> warning.

Yeah, it's undefined which one becomes visible.

Paolo


