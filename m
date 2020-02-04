Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FC9C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:05:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CEC12192A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="jWdXsFWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEC12192A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyv4x-0002wC-Ij
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:05:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dme@dme.org>) id 1iyuuW-0000Da-80
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:54:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dme@dme.org>) id 1iyuuV-0002mf-2L
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:54:24 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dme@dme.org>) id 1iyuuU-0002kx-P4
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:54:23 -0500
Received: by mail-wm1-x341.google.com with SMTP id f129so2740096wmf.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 01:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:subject:in-reply-to:references:from:date:message-id:mime-version;
 bh=Jpmp61ScHC4P4mGaxJ6D+sxtf3B4FcRVQ9Y+VnCUr5s=;
 b=jWdXsFWZNzlGeBf93M3d9DijDT3lsQ4semNVg6/LFaG87J5TKaMuUuZGkdaJu1qqrX
 s16P2PmYUV/HXQ9r7lgBxtkz3E0R9P0ODxnOrxOXQMVXUpQmNJ8KQu2/vIRzwtVfDCjC
 K+tGxKohm5V+xyKd+9U6JQqONAEwqyK2Dvzk8l7rp3A3zOFD69I2cuWSG1Msm/IfG9u7
 48pFB+PBnkdPyCQq1fL+qJyKouX5xOzPfUnbvC65IHjjQhPN3BlEMSCD82ALkpgm8ACu
 B/24Gui/eJpsPyf9OAgj56EDZ3fGZPkMmAZRAhDewjw0tHRmOxaRPLR48M60cCHyod/b
 Ozmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=Jpmp61ScHC4P4mGaxJ6D+sxtf3B4FcRVQ9Y+VnCUr5s=;
 b=F5Js2clKuk8bWRTj/Y+RnyND+RZ1ZyadDwIWmEVQa8QbKJ1YFWH6xM/zlGWZ6E2ONR
 PpHQTSAQAuzF8EoukEuIZ0j/j/98BZU95p2J+46aU+lMflxo3Dx7I087/adqSuNVyh9D
 SJNuXBH5u/8OvCSaDrRx6tSsBhhUCGPk0iOWdPSuh0CCXQ2KxI7j3viCIP+yEF/180cC
 xw+1dxIFM9X9d7PxxDK/FUBVylRLVS4bOWsfx3jlLb9Ru50Ra3fKcCM8HPQHS91rRhPw
 7IwjqM7cf/9vokE02mzpMfQG1MW+ZnbISg823vbrteNo/Z6uAOcBTABSQhLefcierS02
 wrWw==
X-Gm-Message-State: APjAAAXYktIrN8BDKNGnNg1zv7+WECjHoVfkxzbsHmCvaquPGKLCLbHq
 yWn0zlnhr5CoQkhnb4QhhUdQ6Q==
X-Google-Smtp-Source: APXvYqxnqbeRcGvT93o7ZqVj+E+9K2cdQpb99m22/1y4FDdPTlJ0ya2yrE3U62qig9a0YH9LBqtdCg==
X-Received: by 2002:a1c:638a:: with SMTP id x132mr4688228wmb.43.1580810060890; 
 Tue, 04 Feb 2020 01:54:20 -0800 (PST)
Received: from disaster-area.hh.sledj.net (disaster-area.hh.sledj.net.
 [81.149.164.25])
 by smtp.gmail.com with ESMTPSA id 124sm3285185wmc.29.2020.02.04.01.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 01:54:20 -0800 (PST)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 97cf707e;
 Tue, 4 Feb 2020 09:54:19 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH v2 1/2] qemu-img: Add --target-is-zero to convert
In-Reply-To: <4b23f9d9-efe4-000d-0d68-66028ad3d2f3@virtuozzo.com>
References: <20200124103458.1525982-1-david.edmondson@oracle.com>
 <20200124103458.1525982-2-david.edmondson@oracle.com>
 <4b23f9d9-efe4-000d-0d68-66028ad3d2f3@virtuozzo.com>
X-HGTTG: gag-halfrunt
From: David Edmondson <dme@dme.org>
Date: Tue, 04 Feb 2020 09:54:19 +0000
Message-ID: <cuno8uesmno.fsf@gag-halfrunt.hh.sledj.net>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Monday, 2020-02-03 at 21:20:16 +03, Vladimir Sementsov-Ogievskiy wrote:

> 24.01.2020 13:34, David Edmondson wrote:
>> In many cases the target of a convert operation is a newly provisioned
>> target that the user knows is blank (filled with zeroes). In this
>> situation there is no requirement for qemu-img to wastefully zero out
>> the entire device.
>> 
>> Add a new option, --target-is-zero, allowing the user to indicate that
>> an existing target device is already zero filled.
>
> Hi! qemu-img.c part looks OK for me, but other doesn't apply on master now.

Updated v3 just sent.

dme.
-- 
But he said, leave me alone, I'm a family man.

