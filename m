Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18ACFC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 11:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D398420409
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 11:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WeTEioZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D398420409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHR4r-0006Uu-2E
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 07:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHR47-00064g-0Y
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHR45-0003T9-T0
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:52:50 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:41760)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHR45-0003Sf-Ns
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:52:49 -0400
Received: by mail-oi1-x233.google.com with SMTP id k9so5177629oia.8
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 04:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=5F7pU/iNHFxPZUOXk97wTO0Z+kKSwiD1wbYv/JMvFVw=;
 b=WeTEioZ/rYLQjAnYUfCH/OfB6ChfaMOLmOYOyrK3zFBlMWQYzrBPeUXdJUOqsp/l3J
 XjX1L2andbkqyLZaYv8Yz+sEtHTOkeSKtTIaV40RqBUp3sTd4lm22cLAngfx58+MjoGO
 60VhGx4tdokkwVLxxGwNem1OxCj/haS5hcbWWY/eye6MGl9XTrKA5XvsbJNPv2wISzE0
 Kt9tXkBIxspDoXDeB4zDtworMeCDQuoyPjT2mLNi6Dsv4Ra2oNHGGmUqs77Ehrt9GCqU
 sYW3M+d8+OE5K1NS3DsdXFmgCVXjIHaIyoOHmduz98CaBesT7OeIcCK0xU19Zo3VRBFc
 jD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=5F7pU/iNHFxPZUOXk97wTO0Z+kKSwiD1wbYv/JMvFVw=;
 b=qL7ZRO69ssP/wUqANKi6P/Hobzge3M1TShjA84DVHAeVN5OtF/2kk1LPuLhKnrtuXo
 ypY9o5kqNRdjKu0j4vFQQH6V520WvGUeh5QKRJq1Mtuxag2zjtv4TgeTGsmHUNfQNwEr
 f2yn/gjaD23d+yM3xWSJl22rfKcW4goGvuGUGQ6OzdLnvshGQTUtB2OGf6ppg1c288Pt
 oR96M9r8yMy+MYi1N+NieBU2EvPDZsEp0apDq273XcsWdsiC9eKiZTVp8xdL6ju40OSZ
 7OTvqmafQlQWravQqu3bsGxNV3xNiPS3LfdSD4zRBe35LUE2CV6Z1rY8h0AQ7vz6hWlD
 f3LA==
X-Gm-Message-State: ANhLgQ2JocZg/IRLVb/wMDxB7FeNEYn3K09lF+GiI3qS+dWL7mHcWVmC
 Xt1miuLB/8N0HGEBN+qReoc/mwJrxAXqWasbYAedGUw30X8=
X-Google-Smtp-Source: ADFU+vvIqmT7nqkxTGEoddvYrxsKIjtKlFnsNzh6B1BpOzACwBcslKOMY5D9eBxLWCywl8QvSD0PTOzhcf9ymWhJe9o=
X-Received: by 2002:a05:6808:8cb:: with SMTP id
 k11mr417018oij.48.1585223567745; 
 Thu, 26 Mar 2020 04:52:47 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2020 11:52:36 +0000
Message-ID: <CAFEAcA-oWBjOXWmnLvPww9wrty_QbSc+Xv3BY3sQAnEXFkfQbA@mail.gmail.com>
Subject: acpi_pcihp_eject_slot() bug if passed 'slots == 0'
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::233
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi; Coverity spots that if hw/acpi/pcihp.c:acpi_pcihp_eject_slot()
is passed a zero 'slots' argument then ctz32(slots) will return 32,
and then the code that does '1U << slot' is C undefined behaviour
because it's an oversized shift. (This is CID 1421896.)

Since the pci_write() function in this file can call
acpi_pcihp_eject_slot() with an arbitrary value from the guest,
I think we need to handle 'slots == 0' safely. But what should
the behaviour be?

thanks
-- PMM

