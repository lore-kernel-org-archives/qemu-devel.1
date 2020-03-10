Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72525C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 381B12465A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EUqlPL2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381B12465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBbPI-00072P-B1
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBbOi-0006au-AY
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBbOh-00080T-5B
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:41:59 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33801)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBbOg-0007y5-V1
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:41:59 -0400
Received: by mail-oi1-x241.google.com with SMTP id g6so13211495oiy.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 02:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vbizKraB0QJq46h0lqJSkD27wvolg+jD+H/xagV+SDM=;
 b=EUqlPL2anjzKJV8ZivBASlidEAjI0jkbdkUIQSBaHXOC3T26r5RvqcRYi+FiIcBrX1
 AbdT2s2BakhP/wjCcRpG+GjZiwji1M1mFY9HvDKNOAGEk6dXCdw7bk8SbhFBd4YOUw+Z
 2GoGycf/19pL3wewP0VViiN2GbIsgLB6/m5GKcsWpa5z2tZk05MNTqHwRnSgmsaRMWmh
 KsdlkSt5xN5qOgWK9uhBpzwwI3YBTQtpxsmmqWhXA4UszWg+sPiNyirJgcMlPVllptPn
 dZqeUTQnU73OsqohkHD+UBkoDWjZMORuNVRhi+F6pR7/AXWoC8tp7aikKYhvrmcPZeaz
 46QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vbizKraB0QJq46h0lqJSkD27wvolg+jD+H/xagV+SDM=;
 b=C5Mh884Az4WgOIKOOdYknE8sH74xtJvPBbHiAaedFUqLj5SGzslMpbK7jSyLGJnLgZ
 I1skB1I8mTkZg/lqbWKseasAxo67xtcgUr6eua0I3oYbTnc9EbJdOwKbP/bnGWRGG/jQ
 /4GZjNDyA8EPbagCuoS/regpMNSSzEhc1jmp8PmvDyt/8f/GuI15g+RXH13Zdu+uPMTj
 4HEtuzd8mF+xV8LpnO0I7fLZRfu4B6HBoexIbpcyzJu9jQ7RK94hjferWdkPuRnFhVJl
 HMj5DjOjQsdRwxpiPT3Hm/gPr5ZdruFNoFNJ+oHBf3U4zGYdWLRYrsl+wT0319fyiXZp
 F/Ig==
X-Gm-Message-State: ANhLgQ3QD1CKV2kOqfdzixFzNiMvkga85FHgXIcAj+mAoWN6mURDwZAa
 Yyy8hSEDIchta5AypYyU09uO/KD6oTHH0nKpz6fDtw==
X-Google-Smtp-Source: ADFU+vsWnCxEDNSl1TKLksvEeHFxdYF23Qa5aNR+XRXGxhSEoIrtM+C760nNKJoUj7lmGQEDzFd7e+rtgbEwXHY34m0=
X-Received: by 2002:a54:478b:: with SMTP id o11mr465050oic.146.1583833317902; 
 Tue, 10 Mar 2020 02:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-3-pannengyuan@huawei.com>
 <CAFEAcA_twjUHpvf5ZpzA_bKyf8MZ4BuSY0MvNTgSEyVTYf9mXQ@mail.gmail.com>
 <0b2d3222-d122-e0db-db04-1c4e3028f8f8@huawei.com>
 <CAFEAcA9PQd=PwuF+j=3kOA_eCiRd_8TLEwPx8qB-jWvV_9CcMQ@mail.gmail.com>
 <0c3ae5aa-36c3-a809-4a42-159348f44780@huawei.com>
 <CAFEAcA8_RkECOT=YJ3ML0wxBrKiqVw=CssORU=jyryfcNueB0w@mail.gmail.com>
 <871rq08tn9.fsf@dusky.pond.sub.org>
In-Reply-To: <871rq08tn9.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2020 09:41:46 +0000
Message-ID: <CAFEAcA_Hfu-M330faf=5fSZSsJGFgJKZm1N-8ttj29FwWpomZw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mac_via: fix incorrect creation of mos6522 device
 in mac_via
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Pan Nengyuan <pannengyuan@huawei.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Mar 2020 at 09:08, Markus Armbruster <armbru@redhat.com> wrote:
> We have >200 calls of sysbus_init_child_obj() in some 40 files.  I'm
> arbitrarily picking hw/arm/allwinner-a10.c for a closer look.
>
> It calls it from device allwinner-a10's .instance_init() method
> aw_a10_init().  Side effect, clearly wrong.

Huh. This implies that sysbus_init_child_obj() is a fundamentally
broken API. It bundles up two things: (a) init the child object and
(b) say it is on the sysbus. But (a) should be done in 'init' and (b)
should be done in 'realize'. So that's another line of boilerplate
code needed, plus because "put the thing on the sysbus" has
to be its own call it's easier to forget. That's a shame, as
"this object has a child object" is already pretty boilerplate-heavy,
and now it looks like:
 * in init, call object_initialize_chid()
 * in realize, call qdev_set_parent_bus()
 * in realize, realize child (which is 5 lines of code because
   of the "if (err != NULL) { error_propagate(errp, err); return; }")

It's a shame we didn't realize sysbus_init_child_obj() was
fundamentally broken before we did a lot of conversion
of code to use it...

thanks
-- PMM

