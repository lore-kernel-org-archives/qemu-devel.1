Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DFDC47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 09:28:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B922071C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 09:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wzHVDfSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B922071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jURyQ-00039V-Fl
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 05:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jURxg-0002fj-SK
 for qemu-devel@nongnu.org; Fri, 01 May 2020 05:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jURxf-0006VP-Bc
 for qemu-devel@nongnu.org; Fri, 01 May 2020 05:28:00 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44974)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jURxe-0006O8-Nt
 for qemu-devel@nongnu.org; Fri, 01 May 2020 05:27:58 -0400
Received: by mail-ot1-x341.google.com with SMTP id j4so2114142otr.11
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 02:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RWwXdGHhNX+vGhb3mpssz8Z0Y9eo8m+GEdCebcygN+A=;
 b=wzHVDfSfVPjSHNJOHYb9OZPA0/LiJx9+kIt2Qihu5G2iXi1LPzv409l27L+e+K4/ZZ
 7rnJI4MZQCVA/W0b5YMAh3u1OE8hBSyBn+cRKql8hkhlqSolN4V7S1Y79NZmpNVv22oT
 Rkzo1Ydn1hA72qABd6QqoOBU3MUSi7pxcHJ+jgTN+OeNUFMQoYXDqHmzy5JvdooSZe1W
 pKa8fWN/G8xzUE/W94zAlwiFRCI6uZW690/CH9lE5DLbUfuG8k3mCycyHhH2bpmLLvhD
 +l2Ssijgo+POoKZHNDCVY9WmBtEp5lpt2yN7Etdjou2GaDsU83Q+Xv8OuLzluwfbpAL4
 oWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RWwXdGHhNX+vGhb3mpssz8Z0Y9eo8m+GEdCebcygN+A=;
 b=YMQJ8QQIB91XnnVH6Hp86DuI9anvfXxJStoDmXtestTb/kJbxJxcT2o4XVL+Ghx8dC
 2aafwPGXq883Mjb5LT1Ko7w0elNYa15F6eRrMzCDnzJU0x3iAJuMrywXvYiaRh0+whZb
 Ez3kE/MrbvZhEQA4uU8GW1kdzk25IQOxYczPcwfVdZqrOfOns7F5mDQW5aG+0xNtihFF
 FlD6sPGkofZS/mKdOTCuCc3IYZQd4FHckXLdFToGG7r3tUZkzXscibob+BKRVrcIrA1w
 rQWAoDyWaYmoNzWXv5tvo2ktMu+l33TwGWriy0cmggg4+IfVa+CHHRGJ1xdC4YTmkPhb
 Azbg==
X-Gm-Message-State: AGi0PuaPxrhqRlAJM7GUVu7imAXjMcuUjdoIboOIWBDw88Kxsd7L+jts
 QjtWWmYzBan7XD1PoFu04ma94qO2t6z2AzWix7Fydg==
X-Google-Smtp-Source: APiQypKgSNnY0h0VyJKGdcgJMNh5BJi0j2iOwgP0JQi/CDU5pLf+6w9USWQceitUBYvoHu1kI4tVA45fUSgwlnK6Lzc=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr2710215otc.221.1588325276992; 
 Fri, 01 May 2020 02:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200430155231.473156-1-kwolf@redhat.com>
In-Reply-To: <20200430155231.473156-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 May 2020 10:27:46 +0100
Message-ID: <CAFEAcA97t0Rx=tk0BfPde7rWWFc9xkL1uCvLb4JXpY5NRkVpQA@mail.gmail.com>
Subject: Re: [PULL 00/15] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Apr 2020 at 16:52, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 16aaacb307ed607b9780c12702c44f0fe52edc7e:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200430' into staging (2020-04-30 14:00:36 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to eaae29ef89d498d0eac553c77b554f310a47f809:
>
>   qemu-storage-daemon: Fix non-string --object properties (2020-04-30 17:51:07 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - Fix resize (extending) of short overlays
> - nvme: introduce PMR support from NVMe 1.4 spec
> - qemu-storage-daemon: Fix non-string --object properties
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

