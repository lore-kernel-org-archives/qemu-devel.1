Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936A7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CECF206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rwxwMR7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CECF206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYZb-0006Pu-N0
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtYTo-0003Uv-In
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:28:56 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:32818)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtYTm-0002U0-PB
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:28:56 -0400
Received: by mail-ot1-x343.google.com with SMTP id h13so1992883otr.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 08:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BTyLHhArpXEUwFGk+9wOG4vM5g66VkONNqi6pPLl18U=;
 b=rwxwMR7QqtFZ4SCpB2s4BWli0ZGwM/SZUsM65D766MOemodfvLMbnb0fQDm/8vkBID
 qcu2hFznNJJ+2GfpN3zxk2avt30ZnRcm6I9CuCvc6B8meYiNEGBj6Q06Kl5WKTbsM9Lr
 vwNY5jccZbzFbe0S8ZuC8oaToMUh8IqSbNwkC4kZ0yKjU7vGjplFYYd+fA/izyIMdyeq
 TvNQfkYUhisD5dpftN6Oq9WGqgMTdte8lAUd6DudCHLt2GvdoNfNCUFN+ZTcREEL+Sq/
 jU9py4SCbfWUNf8a+sgGuaGPfYP95FB4lMT1Hlqb5I6Z1oWMvKBZ4XnnqUi7p4mN/o/r
 AUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BTyLHhArpXEUwFGk+9wOG4vM5g66VkONNqi6pPLl18U=;
 b=UivP8bNnp6+PQJhoExW4t+oqL2rnQWSAjibleseQHQut46Kq1moER5wXqozLN9Jsl2
 /2JLdbCzXyLvKSLoMYonN4ta+go+mpjDD5/GTbw1B2oeWs60A70Ep12zDSNDTTn2L+VU
 4qYPQVTKSXN0VeJA8dLri5cjaFqZ0tSiztZLLmEE8z5iz9RfzLXwW8fjhRT5Xz3SObgG
 6LJ8WDBpLHshc2BTkgU0N5VYeSsTBSfo79o1mJQIV+PRRWOmPKd5Tl9a/8D4ew5HTLsk
 nl0AsqiERIomksMiqDnDC+G/owNCzB23Fyop6ejiHt6rqGKygDXe0EiXvKIoLcbWvxNi
 NR0w==
X-Gm-Message-State: AOAM533R/GlXtxXceBZ9Abn/Ojk6GYTW0C2VGyQpu7pJTV/OIC/h1JlG
 +axSIEhjxZ7cgQ+GQBQCRwFI8oU2e+3rgtK+rVwtOg==
X-Google-Smtp-Source: ABdhPJyyxmZPUgP9ohAgi9GxKe9P5xqG9Hnj3WrItIWM06pcJiXIfyuaZlEyOqnrhvmZOAoFLIR3fPOCz0Mq612XWB0=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr46764423otk.221.1594308533646; 
 Thu, 09 Jul 2020 08:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200706211314.20018.89695.stgit@localhost.localdomain>
 <20200706211407.20018.51061.stgit@localhost.localdomain>
 <CAFEAcA9O-oYay+-ttJHQDcFJU-=pX76Tize-KQjhPEinKNFrZA@mail.gmail.com>
In-Reply-To: <CAFEAcA9O-oYay+-ttJHQDcFJU-=pX76Tize-KQjhPEinKNFrZA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 16:28:42 +0100
Message-ID: <CAFEAcA_-yDUnZLz_fpC6vRKQtRa5kpb9KB1Hrhqx6uGzUBRx8A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] virtio-balloon: Add locking to prevent possible
 race when starting hinting
To: Alexander Duyck <alexander.duyck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 Jul 2020 at 16:23, Peter Maydell <peter.maydell@linaro.org> wrote:

Side note: the virtio-dev mailing list produces an error
including a random mysqldb related failure if you try to post
to it as a non-list-member, which makes it awkward to cross-post
to it and to a public list like qemu-devel:

<virtio-dev@lists.oasis-open.org>: permission denied. Command output: Traceback
    (most recent call last):   File "/home/oasis/bin/kmlm_crosspost_issubn",
    line 14, in <module>     import MySQLdb ImportError: No module named
    MySQLdb Sorry, only subscribers may post. If you are a subscriber, please
    forward this message to virtio-dev-owner@lists.oasis-open.org to get your
    new address included (#5.7.2) ERROR: postqmail-local Error #77

thanks
-- PMM

