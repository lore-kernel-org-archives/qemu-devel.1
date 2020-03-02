Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AC5C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 10:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FBE121D56
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 10:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LWhzNsyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FBE121D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8iai-0004rq-Dx
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 05:46:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8ia1-0004Nu-Ll
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 05:45:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8iZz-0000A5-MT
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 05:45:45 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:45274)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8iZy-00008s-L9
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 05:45:43 -0500
Received: by mail-oi1-x230.google.com with SMTP id v19so9775457oic.12
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 02:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dfk8/xKTDMwOEo6jpmPSF9z2cnieDBG0c127nTKyvEM=;
 b=LWhzNsyNNPR1hH9sjIBvcq1vJgc4YEH8JfHBGWkT99CdxtcXnZLKz5An0T04DmZavj
 n2a6STlnwN7vVoxwnP9JrKgVwCcHXELqkTq52iDUT4wMMJDqavxjewIRI+LxGefbZUgL
 nTQzEGzw+duQBeD16QNUqO3+k+AlhqnTLjheIJgOWMpxG3pkSHSZUe02pmG89nXecpsy
 3KtHtbXIjys6dfIwhNqHriq2FiaH9k24WuhufSboKUptYQuDjKBFT2/Cg+9SEhCWEYaO
 fnSRJObVNtb/K8TnYv9UzT5Ypo63VkUH/vQop9ROTnqiOrx9SKBsgzfiIFiOIYzPkwn4
 eETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dfk8/xKTDMwOEo6jpmPSF9z2cnieDBG0c127nTKyvEM=;
 b=Ccd65xIbkKcll/f+6bLgBD0r4InZvjVA+OmxwLF4Ays4tGisfVJXEJKMJHeDZHEX6R
 eSoQwmETUUsU9F3GGWSW75DqFxSEG0G1vdcxntHCi/Ye+Nn5s1Yoo3GY2aTJy3Ya+cmy
 uZKe35sHNFxFD3D5IKm94BwcC0lNjChcuzF6a0rt5tO4dUzfzhZ3NOKJcIYW5AuKQ8nu
 UqkuDRBedCRV8KFeEfYHld4YTmedIpWOdwBaBM/b82sn/12jqIW5xOwKC+RYHYsRtN5f
 nWBqtSJXEZZ0d3LaVzH3LaWAzE3rSosVTsWByS+H0znG43jFKAFv+OW3TIyrk6PGoMAB
 Yp0A==
X-Gm-Message-State: APjAAAVqM2btbxulD96M9gfnl0AhfRQSQYPoJE/zRXG5FFHAdc9DHMvO
 IbcxTNKR1C0fUnqYdqKwfkjbHw7PEnMA1cvVZCsVrg==
X-Google-Smtp-Source: APXvYqwsbRndvP+ZpWWX8PN4s/536PphCIg06WlbUaLRUlnprDKI4wiu+GhJ2I8b2FXNOIEMQsoPTRYYDUCE3Jjg3HY=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr10658541oie.146.1583145939724; 
 Mon, 02 Mar 2020 02:45:39 -0800 (PST)
MIME-Version: 1.0
References: <20200228210427.474606-1-ehabkost@redhat.com>
In-Reply-To: <20200228210427.474606-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 10:45:28 +0000
Message-ID: <CAFEAcA-BTNVaBZdiaCw-KNLaNTMyJjj6uDSYcKbGPWabWMxtHQ@mail.gmail.com>
Subject: Re: [PULL 0/4] Machine queue, 2020-02-28
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::230
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Feb 2020 at 21:04, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit e0175b71638cf4398903c0d25f93fe62e06063=
89:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-202=
00228' into staging (2020-02-28 16:39:27 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 6db1857ec9960c63024f4ce6329d947f727bad39:
>
>   vl: Abort if multiple machines are registered as default (2020-02-28 14=
:57:19 -0500)
>
> ----------------------------------------------------------------
> Machine queue, 2020-02-28
>
> Cleanups:
> * Fix NMI() macro (Philippe Mathieu-Daud=C3=A9)
> * Make MachineClass::is_default boolean, refuse multiple
>   default machines (Philippe Mathieu-Daud=C3=A9)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

