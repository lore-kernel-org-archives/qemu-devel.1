Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720E0C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 13:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 375EA217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 13:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rd+Gqi3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375EA217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDqe4-0004F4-Gk
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 09:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDpy4-0007aR-PI
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDpy3-0005GR-6n
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:07:28 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41609)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDpy3-0005G9-28
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:07:27 -0400
Received: by mail-oi1-x243.google.com with SMTP id w17so5111659oiw.8
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 06:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HLTVzSrf+tbOprGdeY1EjMH96uf7xbbND9M4/9Ikjn4=;
 b=Rd+Gqi3/pPuFt7kwr0q0RraaxEG267+jQaryTZLaqgIJViiinTjMjBtAnC/J0hmZhA
 6pxNNfgUpdIu3htRSsgYBbjxF3tkNHSLkWNYrbdeBqHIYiKKTfSQjn3aP3+wRt4ajjUv
 m3kPTQV24J5ce+aDb9Q5hLUEWd7dPRxa92WLkbfkgCpYIE91b58MQkFLgLuTwXFmhvSb
 HR60wxBOxB/n5XWJQiksaXzY6VneQ3IHGRybKKkQhEBhjJz9+9PZm2K1Ey+soOW7CG5/
 VeNs/3lD8tudN1+mn820BvYQ80h3M0qy+o6busz/ml7l8yXrlBkPICrP8pzqfvCfvxaO
 Hn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HLTVzSrf+tbOprGdeY1EjMH96uf7xbbND9M4/9Ikjn4=;
 b=rz4/61SqdkjzU9GuN27BBRfrr1ORXa1ySBFL+/ijO1d7iORk9tNmLcr16koLSgJCVa
 2l/jAF+mx30SlCIpFGeWA+Q5CKMuplM7eyO0tbbNYI5ssQWDgZbdcUKVGdela1A9XJ0D
 o7iCyR486qj8y3I1QAIfSyDA4gjDg2zwtYZ9NPKlYJwI4diPP5w16auW5NcJLq6wYCvP
 6N4bKnJjEXXVe43fmcTNjSZBfp1vnhN1DM0XxFqXYP8NFeCK8WktDwAR4l3edxuJ5MCu
 dNkjip/RttVklagoj7EEBIHg7K3WEaAwPX6UZ77avh1So+ZS6c4762oL60RO/HdRaxxd
 D+Lw==
X-Gm-Message-State: APjAAAUJXSzjZsp7b6Ht4mSeZFsmu/FZulTxkcs+8STzmTxFICsNy2eN
 dPUUBZKSBLVHz32R7aia049knETFumv8MoID3YTfIA==
X-Google-Smtp-Source: APXvYqyoFOWi5vdyYPAovY+C9UEwY4lb1Y8ASGUje2FU7MtBHTEVihasNfnDXXkhoDyk1IVtY15H14QbxO/lmXRVG6o=
X-Received: by 2002:aca:50d8:: with SMTP id e207mr6573765oib.48.1569589645543; 
 Fri, 27 Sep 2019 06:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190821163341.16309-1-damien.hedde@greensocs.com>
 <20190821163341.16309-3-damien.hedde@greensocs.com>
 <20190911080642.GC13785@umbus.fritz.box>
 <1a3b4d7b-77a9-46af-e6f4-dc7b3ba13b4f@greensocs.com>
 <20190918091135.GA22790@umbus.fritz.box>
 <f482912f-9541-f90c-bd80-5c95322e670d@greensocs.com>
In-Reply-To: <f482912f-9541-f90c-bd80-5c95322e670d@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Sep 2019 14:07:14 +0100
Message-ID: <CAFEAcA8pja6bOh4vwqWco=1ZtqR0mJFUuZT+WjJwYuA5AZZuQg@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] hw/core: create Resettable QOM interface
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Edgar Iglesias <edgar.iglesias@xilinx.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Sep 2019 at 12:21, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Hi All,
>
> Do you think I should respin with the sugestions made by David so far ?
>
> + reset type removal
> + s/init/enter/ for the phases terminology
> + handling of parent changes during reset

My takes:
 * I think we should keep the reset type. Among other things,
   we probably want a reset type for "PCI bus reset" and
   "SCSI bus reset", when we come to conversion of those
 * I don't have an opinion about the phase names
 * I think we should look at what we're doing for dynamic
   changes of the reset tree. This falls into two parts,
   both of which have come up in this thread:
    - hotplug, ie what state should a hotplugged device
      get set up to if it's plugged into a bus that's
      currently in reset
    - the modification of the qbus tree during reset,
      like the raspi sd card thing
   These feel related to me, so maybe handling the first
   gives a better answer to handling the second ?

thanks
-- PMM

