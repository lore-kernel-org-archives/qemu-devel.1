Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11054C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:28:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE67720820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oplEybGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE67720820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCPJr-0006g2-Rg
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 10:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iCPIX-0005tI-1Z
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iCPIV-00059S-J6
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:26:40 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:46213)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iCPIV-000593-E0
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:26:39 -0400
Received: by mail-oi1-x230.google.com with SMTP id k25so7688058oiw.13
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 07:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pUJMIwlRC35F16IRiTlQDkb1yg7LBO645U7ovCDYNHY=;
 b=oplEybGOj94kRtAl4BAk7qozkQ5wwZHAIBCbTI24++1ZEMimGNWmG8T9MJQzVSuygc
 dABvyyzpx881DTImAelxjfs8xaBIQoAwgCW8Jc/opmHQli3cFHNMBtyCn/qsFHMYb9YB
 187HBaKYObLcQXVwqSB0X1zozWMYEDx4w1ltHpXd/I2S5vAG+K9iGSQnqZYF18oF+7dC
 pRBp1MRuAMsE5ymirR6ECoPwMd1Y93RXy3Wi2I0qCd6IxhSolODnbyUIiHR8vPM1vKVt
 MAKfY6uERcCRmxmxKK4fXReLfuBGKajevx2vNgqlgEuHFHmsGK/s7t5LeBRCxh/1TUFP
 3xJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pUJMIwlRC35F16IRiTlQDkb1yg7LBO645U7ovCDYNHY=;
 b=r2NESlQfFqj+gh10rKZHFwGR2cMPvsvML5zI7nnKKJzWjVRgrY+tsQSab6upeKzboy
 vnMO8mrt7CbujofXga5JnLBJKHc+Sl9XJ8J6JA4TmQq1hrXp+l9kt4tWaFbY1uaJDf3a
 8bCmo7rRAxDOZ05LHacqQSvKjExJB80hxt+KbNPvW2A72il3jmBGomRCJzSmea+2q4kr
 lG9GZnANd9KPh87cNwol4cqGxpCVsjyEbpIqH8rky8otmj/cv808QesOkH7jU0vaszZ1
 j/HbdM0EfN0wRvVo8JNFUYBeCzMOLGbVhMW25bcB7Db/zlhIgwn43cxAVcH/LWRIZEdQ
 tJbg==
X-Gm-Message-State: APjAAAWv1xkNAH67Pm2HHEWMUSloxhgcnrS6Mm35NPYZ4fxulGaSzq3W
 07hcwv9Vbl5C90fty7xkdC7zpsZr8pFTPdXWA9o9Xg==
X-Google-Smtp-Source: APXvYqwbT+rb+p2T2DHMlCQ7A19q3SBaFY7NfS+flRFNR9vrv55gkSExQuB/frLaIPbizj1hPm2MLz/9MA2SmOYWgQo=
X-Received: by 2002:aca:53d4:: with SMTP id h203mr268247oib.146.1569248796367; 
 Mon, 23 Sep 2019 07:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190923073921.13357-1-borntraeger@de.ibm.com>
In-Reply-To: <20190923073921.13357-1-borntraeger@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Sep 2019 15:26:25 +0100
Message-ID: <CAFEAcA-nxLF2HooiEUkVAnL_q04zAOMzVkvfug7ed4Q0pXcrKQ@mail.gmail.com>
Subject: Re: [PULL 0/5] s390x update
To: Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Yifan Luo <luoyifan@cmss.chinamobile.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Sep 2019 at 08:39, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
> Peter,
>
> here is the non-tcg subset of the s390x updates.
>
>
> The following changes since commit 4300b7c2cd9f3f273804e8cca325842ccb93b1ad:
>
>   Merge remote-tracking branch 'remotes/cleber/tags/python-next-pull-request' into staging (2019-09-20 17:28:43 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/borntraeger/qemu.git tags/s390x-20190923
>
> for you to fetch changes up to 7505deca0bfa859136ec6419dbafc504f22fcac2:
>
>   s390x/cpumodel: Add the z15 name to the description of gen15a (2019-09-23 09:15:28 +0200)
>
> ----------------------------------------------------------------
> - bugfixes in ccw bios
> - gen15a is called z15
> - officially require a 3.15 kernel or later for kvm
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

