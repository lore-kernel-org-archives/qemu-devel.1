Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0287AC5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEFD72166E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bRGMLwIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFD72166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSe1J-0001Dr-Uh
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 04:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iSdyi-0000Dk-B0
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:21:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iSdyB-0003DZ-1z
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:20:48 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:43923)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iSdyA-0002xj-S4
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:20:47 -0500
Received: by mail-oi1-x22f.google.com with SMTP id l20so1328486oie.10
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 01:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kpVnmwX1mi1PjRF1p2++ZxJlBDEtICEshq2+RL2FkxM=;
 b=bRGMLwIQlYPeoa+/B82c6Al4HYxJT0ufVIRnm2snpAx49X9tioXcl4PtLlV4Wtb6RZ
 +ia4+EnN8V3Rq+pIR6UVtGi1reAr8NPXbD7oiyemjB/SIOFeZMN5oTJRUz21x5vtDEha
 owG8gf3Uaya3LNPXEAF9bJch60UxSlxDW2S/5hUHKCdVzIfMnjOlv5L7vp7VN1QKlUIL
 t8+YjV+JS2k7TSxcEtoGNicfRZ4nAz3sBEqpjqKPi0NxBs+J2HcatYMbyeVUaV5fwDZU
 ois2b5diMrJivU0RZB78v/NB5jtix5E2MiW7rc7zzl9BHkAZCR+sxG5VRHwVgSKtGZvn
 x5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kpVnmwX1mi1PjRF1p2++ZxJlBDEtICEshq2+RL2FkxM=;
 b=rEgoHt5NXX8s6raM/hxPk+CMXcbfak7HYr6Dc55NcnP4egIvexgkC+UtZIxqskvol8
 oMoprK7vYdBXwMXlOY2LdP/xdmYJeo74u+SJzINJuUYAGPTmcw/l8/RDPwLEOwYIpZ9Q
 MVBX5mMLqV0oFEyM0sVAGwIGkWvdmuu7CLIV3UcboFcN2nYXobE6iYq7WrMgUKAfebi1
 vhIbCPyVEvpJciNT4eQfgYT2G3VepiE3ByPLIzOtAY3+3XRefjmkNbL8SH+rwx17VlTw
 VHxkFIAozKN2dAqJfrdsd8Dbza6LFkaeZISv454dGjLJJ4KNB5/xKu7ITwdah+ydJCQx
 PGqg==
X-Gm-Message-State: APjAAAVWbcDTdoViLewgL67KN/iW+sdI2pTGN7F1YKRsTLEBqbWjDNd5
 axf5k3swydq9HYkMUU/2iO/PE8UJG9pdtI5+qL6TQA==
X-Google-Smtp-Source: APXvYqz0yoB14iiRdVV8KvXpbfbW0AIIG+hVaACo07JmLDi/6XEdJ/5YSC+sIkqSRRibmuiGQHUCHMr9PjQcyFTuFGY=
X-Received: by 2002:aca:cf12:: with SMTP id f18mr2401925oig.48.1573118443696; 
 Thu, 07 Nov 2019 01:20:43 -0800 (PST)
MIME-Version: 1.0
References: <20191106070712.2679-1-kraxel@redhat.com>
In-Reply-To: <20191106070712.2679-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2019 09:20:33 +0000
Message-ID: <CAFEAcA_tGLyAqYmEhOUdoeccdULkJv60j_Mh2CTmVQAi2BvGyA@mail.gmail.com>
Subject: Re: [PULL 0/1] Ui 20191106 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
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

On Wed, 6 Nov 2019 at 07:08, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 36609b4fa36f0ac934874371874416f7533a5408:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/palmer-for-master-4.2-sf1' into staging (2019-11-02 17:59:03 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20191106-pull-request
>
> for you to fetch changes up to 88b40c683fda6fa00639de01d4274e94bd4f1cdd:
>
>   qemu-options: Rework the help text of the '-display' option (2019-11-05 12:10:42 +0100)
>
> ----------------------------------------------------------------
> ui: rework -display help text
>
> ----------------------------------------------------------------
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

