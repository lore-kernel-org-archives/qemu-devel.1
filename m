Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034AEC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 11:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2CEB2082E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 11:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IiCsx6Wc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2CEB2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihBOq-0007c3-Uf
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 06:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ihBOE-0007Dc-AO
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 06:51:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ihBOC-00048n-VY
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 06:51:46 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:42654)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ihBOC-00045d-HM
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 06:51:44 -0500
Received: by mail-oi1-x22e.google.com with SMTP id j22so5153378oij.9
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 03:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nyvy3MQAEiB7N3HDPy09KD1ny7mv1/A3Bg5IZhu27oY=;
 b=IiCsx6WcUe2uram9iWdePtrEF3jvVS8FOYE0GcIwmViSMEh4I6ZL6Mkep6m6YKlqPV
 fjw9pElWECA2RhzwCrINT38M/3ekNVwa8I9ndEH4vylGg0666fk1Fxc69Woe63R9hJ4k
 4OFunMpPx1Z1BU7Low4L2cfapYYxDM3cGj2nuCERME1nH8AYYB4T04DljOzvvbtVNrBZ
 PZzJbDN4QlbMEekQlIA8IxLmWYcM0Pt6/8NyRB8xrTNIjv1niHcqnNYwyTfQFZGkZ97w
 S+Ezqz9TlgcF84AxleoqxRLVlXjqzzjIbfvuB9IpjfYmawtaN3vYNntnZFPdwQY6F2+K
 VGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nyvy3MQAEiB7N3HDPy09KD1ny7mv1/A3Bg5IZhu27oY=;
 b=PWIxholNAIuKQZJ82joCU0DOBbZyinIfejdpz6Z5PCmkXEDXHALysy6WRwJFMOJ6d0
 5FhY3/QInrZLR067SGJtzI1YGms4eH121o90NrpkajyCuOUtBSEvGQ9rkOAltxlGc7EN
 Xeodr2+cCBMHQrpFys1pmhicCcUdwvQmpVcdq3cVq3wQ0EhiqIGxCm5tQ6+IpgQHkNUV
 Spmy14zDDKLLbbdfypmgnVbTS3o4ED9/vZkqa9NPQ11zn7zYTNFoVgpjmur1f2EE7XNv
 UEWig91hOWC+4iz9emNQBgSsbT1pXceWfTehVzj54DruyuVtHCFKydoLN6eNXy0YXA6s
 qJcA==
X-Gm-Message-State: APjAAAURsduSh0IuY/QPFoZ0fFjAlTPFOknczPhIbQtt6pHAwXv68q9d
 bBrzpPjcqWDEL0shq8N2RHnReltJ5DNCXPy8QZC42Q==
X-Google-Smtp-Source: APXvYqzp5F2Ttvw9TCMnbE5bcyogCFU3QSIDM9GNGsrT+6qlbWdTW1IYIonnBk5ixtqXUA1U6DwmbFMPZOxsfgwxfdM=
X-Received: by 2002:aca:edd5:: with SMTP id l204mr1374372oih.98.1576583503217; 
 Tue, 17 Dec 2019 03:51:43 -0800 (PST)
MIME-Version: 1.0
References: <20191216193825.1794153-1-ehabkost@redhat.com>
In-Reply-To: <20191216193825.1794153-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2019 11:51:32 +0000
Message-ID: <CAFEAcA8_=GR+FeOuYQ+18_inZb26NMwurTN58wnS68dsvNziVQ@mail.gmail.com>
Subject: Re: [PULL 0/4] x86 queue, 2019-12-16
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Dec 2019 at 19:38, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 4148d142a8cbbce10bb77e560997ae6b482e5edf:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-virtiofs-20191213a' into staging (2019-12-13 15:58:54 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
>
> for you to fetch changes up to 88703ce2e6bbc8cc00c90c1bb8af1f3cd964ac9c:
>
>   i386: Use g_autofree in a few places (2019-12-13 16:32:19 -0300)
>
> ----------------------------------------------------------------
> x86 queue, 2019-12-16
>
> Feature:
> * Cooperlake CPU model
>
> Cleanups:
> * Use g_autofree in a few places
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

