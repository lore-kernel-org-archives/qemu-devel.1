Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90033C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 09:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58FEA206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 09:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="umlJOWFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FEA206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUSvH-0007Au-GU
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 04:57:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iUSuf-0006jC-GW
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:56:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iUSue-0007Qx-9Z
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:56:41 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37890)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iUSue-0007QU-45
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:56:40 -0500
Received: by mail-oi1-x241.google.com with SMTP id a14so14245062oid.5
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 01:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+qQ7U7N0vkKUJMDlT+UKnYLKZ9+HFAaytOYXlGys/K0=;
 b=umlJOWFJTmo6JiqNXGi6GR0KHDhuvi4HbXWQ7CNMLpjUFnAYx+80Z1mJEiR9ntopGJ
 D0BsxiGgG0yBC9ncAph5zT+caVJq7OuOl1g6k+eCE1jAYgHT6fPV8Sc7y9sdtceUn/7w
 MkG4rE+qx+n8j7Mu8bmbnLIh6+T0huKwe93SfSd4PLdPTfu8YBJPqywk+2ySTcLVxOJT
 T6nCHb+fVeFYs1WDWTBUDuyeidfY4R88cogLlyy6JU1Pkc5gAUn3Vq5F66YGOGC9Rjjw
 W8ofS37GS3AysiohTSb+xanvi3qDbQ2/8aJ3H7vniXnfvvPTc73D6md11AW5NFqcaGWr
 aouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+qQ7U7N0vkKUJMDlT+UKnYLKZ9+HFAaytOYXlGys/K0=;
 b=Kqk+9rbgWjvewCpVkWQ4RAiO6cZf/jrq6r71ykpoCb7woMaY2i9web2r07600IGOd0
 8O/YGOZkEE+oAjjt56dETmPZQm8G7Cx/V9cMwvgfjRwLxsJewMyYRYzfvYxZxIEC2Aw8
 Exftko+wfst6LWPXI+lzXgMeMQC+BL72VwynRWeFX8CkmpZyE4YJ7uPqv/sgEfAwxVav
 1O+pafygVKF1qtEmq8iZvbU7WzpcbctF62hriOFiRE3KG/J+deKHQx9J7LI9pnLCwONB
 XOJIqZE1TTdHQhcplZCdf4WMxqmnxN0b3jP5dV/nP1ubrYhtcT8rtbGpKMlTcg6OTBgh
 nlGQ==
X-Gm-Message-State: APjAAAXz93B8vC8+gPVcc/SkwoSa5Ut+yXOlbXuzD9qRsL78uqx7nUlO
 opvUSUI1HKyC4ugAm4UdK6PqHdw1kmrXRR6aBjW8+Q==
X-Google-Smtp-Source: APXvYqx0YOLvCxoBmcuJ+xanyzFc0FKXrXK3iVPG3zjm2whEQH5C1oriNLXz1ZHs23+fe2a2ble3UYG191cYbl1iDZk=
X-Received: by 2002:aca:451:: with SMTP id 78mr3321021oie.170.1573552599122;
 Tue, 12 Nov 2019 01:56:39 -0800 (PST)
MIME-Version: 1.0
References: <20191111203524.21912-1-eblake@redhat.com>
In-Reply-To: <20191111203524.21912-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Nov 2019 09:56:27 +0000
Message-ID: <CAFEAcA99d8ArWGBDFZ1ZK-i6X14M3U9+ZqPyk=fi+d7cQk8E4w@mail.gmail.com>
Subject: Re: [PATCH] qemu-coroutine-sleep: Silence Coverity warning
To: Eric Blake <eblake@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 Nov 2019 at 20:35, Eric Blake <eblake@redhat.com> wrote:
>
> Coverity warns that we store the address of a stack variable through a
> pointer passed in by the caller, which would let the caller trivially
> trigger use-after-free if that stored value is still present when we
> finish execution.  However, the way coroutines work is that after our
> call to qemu_coroutine_yield(), control is temporarily continued in
> the caller prior to our function concluding, and in order to resume
> our coroutine, the caller must poll until the variable has been set to
> NULL.  Thus, we can add an assert that we do not leak stack storage to
> the caller on function exit.
>
> Fixes: Coverity CID 1406474
> CC: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>
> I don't know if this actually shuts Coverity up; Peter, since you
> reported the Coverity issue, are you in a better position to test if
> this makes a difference?  At any rate, the tests still pass after
> this is in place.

The only way to test is to commit it to master and wait for
the next run...

-- PMM

