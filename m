Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA15C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 22:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 786AF2133F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 22:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLXzO6if"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786AF2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG9q7-0007md-Iu
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 18:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iG9og-0006jf-GJ
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 18:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iG9od-0007s3-2A
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 18:43:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21216
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iG9oc-0007qe-Na
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 18:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570142594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TPHyYdWXMyZfWl3FIKTSge5fWJ3STVoFut6oYotNlZE=;
 b=BLXzO6ifJmlL5iVXg5D/jYoHxhSZ/Dy6emE2F6nxEXvJXNIauZAXiz4kJT4lo77C9lApOp
 OzeO2pxzseD9Ne5sW1FMu50SfJGVJIkFmZWCqYUgCMjXczOpRANYkogo59ONuGd7/SrUZB
 V9gle08sideCpsaWozbFnusIUy1m41c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-QRmZ2N7UO3WVGyvb5Wvxzw-1; Thu, 03 Oct 2019 18:43:11 -0400
Received: by mail-wm1-f69.google.com with SMTP id j125so1735308wmj.6
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 15:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oRizTL8a02zdlSYG4/14y4i9Gybhl/BAhXny1Q7DIT8=;
 b=sNEj/kaUiSPXjyxG5+XWx+2+3ZcS95nFAM9uCllX4F06SWhvLAKcOXeQ49SP6YKIPI
 ULHXD0QEx1fcbWNDkn4ERFDHM/prPEbFIUUW3zahL+jBdIxNHks/OqpGXgxIGEy1/Jyk
 rKwTo6ztDy7NOdikzlMalP1K74rI7N7264OwnZtwgihVEQiTvv0nBgFlkZVJWF7ODCXS
 TVRg9nB1XB/O8P3yZGCBSGciY+el5ihwGspPx4dHVj2HFcxbC4EZBxbe9e6GkAyfVRWy
 s4CnMfohJkz6Rc1RHaddwy8hI4RZKcxFnApjfeskOWcvalnOAaL1XOFiCvylCr7iULuI
 lk3w==
X-Gm-Message-State: APjAAAXOIyezGsWJPPtym3KDZ8C3LNtghtMBRtjOwtJzEXAMnQWF/QFD
 sAN8n9Gw3FwR4quYk7FUq3Y6fowh97XrxBddlqTkHdm16w7uSEHeIPv7quyM5fnHg04tq6IFF5w
 HE2WM+c2wiEg3bN8=
X-Received: by 2002:a05:600c:230d:: with SMTP id
 13mr8894496wmo.114.1570142590738; 
 Thu, 03 Oct 2019 15:43:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzakitGAAvtR9z4CSOFnuOFpxHiWGbmc6rbbfmfeEqknhpNxl9Br8uG3vn8WPoUKQgAYmCMXQ==
X-Received: by 2002:a05:600c:230d:: with SMTP id
 13mr8894487wmo.114.1570142590450; 
 Thu, 03 Oct 2019 15:43:10 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id s12sm7034356wra.82.2019.10.03.15.43.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2019 15:43:09 -0700 (PDT)
Subject: Re: [PATCH 00/97] Patch Round-up for stable 4.0.1, freeze on
 2019-10-10
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c41639e7-8c89-c5ad-d6d6-ffac2a8f03a9@redhat.com>
Date: Fri, 4 Oct 2019 00:43:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
Content-Language: en-US
X-MC-Unique: QRmZ2N7UO3WVGyvb5Wvxzw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/19 1:44 AM, Michael Roth wrote:
> Hi everyone,
>=20
> The following new patches are queued for QEMU stable v4.0.1:
>=20
>    https://github.com/mdroth/qemu/commits/stable-4.0-staging
>=20
> The release is planned for 2019-10-17:
>=20
>    https://wiki.qemu.org/Planning/4.0
>=20
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.
>=20
> Note that this update falls outside the normal stable release support
> window (~1 development cycle), but is being released now since it was
> delayed from its intended release date.

This commit fix data corruption introduced by ee5d0f89de3:

commit 04da973501b591525ce68c2925c61c8886badd4d
Author: Li Qiang <liq3ea@163.com>
Date:   Wed Apr 24 07:06:41 2019 -0700

     hw/nvram/fw_cfg: Store 'reboot-timeout' as little endian


