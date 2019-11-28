Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6ABC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 16:14:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A09217BC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 16:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mqxjlPI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A09217BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaMRE-0006D0-Jf
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 11:14:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iaMDh-0006fk-3W
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:00:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iaMDT-0007wJ-6K
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:00:34 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:37103)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iaMDS-0007OB-Uz
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:00:27 -0500
Received: by mail-ot1-x334.google.com with SMTP id k14so6847585otn.4
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 08:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=9il/xf8ahZhtDf0TuOELB4AUBe0OF+KOYzdH/3RJ5OE=;
 b=mqxjlPI4oRtmYX0XbGK6S9JHyYne8OjUC9zh3xPG6eRDRskBNqAj5xGqIZmQNl1KN0
 YwzKZPJWqyBUpWsMP0xX/8hf2ZXfI+tj6briXBD/QWI3VDexaZnSJufMeYO8sa1ieggO
 S/SQzARiWU/QCYfzNo11qAZdNz6IRKjIC/mOqw7OAkQVDNFp6rIaoCs7ZbOl1Di08nr0
 my+nmcQmDS8y4iZur/oTA+j/2ZkFkDILSCRKGD9aOOa5nJTN1i2bfNxtFqY1zDfqPw94
 USQ4kMs69CUh/KcjwUUxBg4wm67EDbCGIr8QtGf6s9QDwz+aMq53y2++pGN+OzMB2LDH
 J1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=9il/xf8ahZhtDf0TuOELB4AUBe0OF+KOYzdH/3RJ5OE=;
 b=Q6lY1s1K5s1yN69zby2CTJPEP8Hy7rXr+L24aHA/wTsH6fCn4DtzUmSoV3sZPMyDIF
 GjUpDUcv1wVb8nhD5lwq8n5c46I3ykdbWUrU8QLv5unbRW+jQo1sGPdL2oNbMHXuQdKd
 tgJ6KJNUyPuvQ5Qe1NcODuj3tIkfhSBbF6ye3IPNBg5NtvAcZBkGAxZvmt9A1X4ZpSCN
 YWimMgKYahul9CYOtTgvFYnoV56jUVTg4Bh9pNabbOhsatzs7O9dReNpA0t8pkqs/kyw
 dUJNknFvWk33ErAtGqN/GqWZUdDVqSXSLu5dlzLiEqa+KOI3mEAMQry5uEEiCIRqnD1q
 3Wrg==
X-Gm-Message-State: APjAAAXMWYFBT5BMSlTpbOglJHzg2k58FPZneREazCGW5vt7pWrKQG8m
 fg5RM263F8ZV0G6dQdtL80++FmmOK7qd5WjZNSjwiwJIw8M=
X-Google-Smtp-Source: APXvYqzwM+Tou0Qe62jc9AIyu0fV7xA9DuiqUEN/2h086BZbEvz7L86V50iGJtzofQ8mBRFwFvgO5aFchiyiBC19ATU=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr7351402oto.97.1574956817474; 
 Thu, 28 Nov 2019 08:00:17 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Nov 2019 16:00:06 +0000
Message-ID: <CAFEAcA9E-Z-RPwFsAiz9Pi3_MtBUFEU7enJFVrpOQ7UKW8e1DQ@mail.gmail.com>
Subject: qom device lifecycle interaction with hotplug/hotunplug ?
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi; this is a question which came up in Damien's reset series
which I don't know the answer to:

What is the interaction of the QOM device lifecycle (instance_init/realize/
unrealize/instance_finalize) with hotplug and hot-unplug ? I couldn't
find any documentation of this but maybe I was looking in the wrong
place...

Looking at device_set_realized() it seems like we treat "realize"
as meaning "and also do the hot-plug if this is a device we're
trying to hotplug". On the other hand hot-unplug is I think the
other way around: when we get a hot-unplug event we assume that
it should also imply an "unrealize" (but just unrealizing doesn't
auto-hot-unplug) ?

Once a device is hot-unplugged (and thus unrealized) is it valid
for it to be re-hot-plugged, or is the assumption that it's then
destroyed and a fresh device is created if the user wants to plug
something in again later ? Put another way, is it valid for a qdev
device to see state transitions realize -> unrealize -> realize ?

thanks
-- PMM

