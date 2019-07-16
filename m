Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A23DC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 11:17:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC2A92173B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 11:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE/CwZ2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2A92173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnLSe-0006Vp-Th
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 07:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34834)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hnLST-000676-2g
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 07:17:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hnLSQ-0001HG-U2
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 07:17:20 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:35723)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hnLSO-0001Dv-Tz
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 07:17:17 -0400
Received: by mail-oi1-x232.google.com with SMTP id a127so15242903oii.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 04:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=fdkdThK7Ey22EbKOVP7TGOS8OaYcez9y2ZyYKR9N8R8=;
 b=bE/CwZ2jzvhzIprBjt/jbN/si+K3ax3f1/1c/+NidqVcNphoimU37og9l4sTC58T/G
 +b3EAh8zVgEq49AMvWM/jDkTysnk0KjDXa21I9vf8WD7M6eSaiY4Q4bHrx0yGiHMOrQK
 hAJDTR6tpoIqQ4K177Xch9JjoKTXwLP8856BJ3HS56MeGWITJfND6EI0xYOq6WVrspKW
 Luo6B5iza3WtXrZ9rqWyfWfvWRSrN9Gjp7BUAwcxbBUVrPL2OL/i7NlnZ0iejo04SRMu
 VvlyE660R8DqdXjMixQN2WKRUgomoF8kDOhYMiJZjFUCPIkI7NlkhYc6LSE/3KsOHcrs
 diOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=fdkdThK7Ey22EbKOVP7TGOS8OaYcez9y2ZyYKR9N8R8=;
 b=XZEv77xixSLpeZu69oSpvDI/mdavrFPgU9l4+hQGEiF1mYJw/Z4pMteZ0IdseIiugm
 jw0/AlQMXQZ9jwKOLPbBm6clwSl+TYtApnwml1ydTlcgunRCEpcC0HMIgXk6J5foSdJj
 gdFaO7H2kjWYVUlskXNMt+fZGkUzZ+q39WJLufBkORRrh8um1djq9Doey2wi+RoESkjB
 5lSuU168GCQBsHnQZ+t4Q/2rAod7AREjGZmhE+yJl9xWRyRsX1NkkalaokuMGBRMRAET
 54U8TO78EFFEzeNJSeXCHlxrGuDg+wsohsGAFD042h7ZtcVnUSljDUmStCn+++xBYN1W
 YYbw==
X-Gm-Message-State: APjAAAUYmgFjBU33lKkPstYFvXMpeIZoizgt4dvwpAUbwscRhK0Y9N99
 jmAOgN3QlGlDFBO8//nRph48pSdkmWGtGJXc9Gc=
X-Google-Smtp-Source: APXvYqzeYVTFWRW+orcF1T05Bvu1AitYh7HTKUgMuapBNc6d2wTdgfuMdWT2mpRMAjl+wfUD/2yy165XAzWudOeNBv8=
X-Received: by 2002:aca:abd8:: with SMTP id
 u207mr15802436oie.136.1563275832428; 
 Tue, 16 Jul 2019 04:17:12 -0700 (PDT)
MIME-Version: 1.0
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 16 Jul 2019 13:17:01 +0200
Message-ID: <CAL1e-=jiySpoypabXMkUsO=2pqgUrRxUhac=JM_V=2sn2LPhWA@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, 
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
Subject: [Qemu-devel] [QUESTION] SDL 1.2 support
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

Hello, Gerd, Daniel, and others involved.

I have multiple reports from end users that say that transition from
SDL 1.2 to SDL 2.0 was difficult, or even impossible for their hosts.
In that light, they don't appreciate removing SDL 1.2 support from
QEMU. The most notable example is Ubutnu 16.04, where it looks there
is no way of installing SDL 2.0 that does not involve complete OS
upgrade, which, for various reasons, many are not willing to do.

It looks to me that depreciation of SDL 1.2 was a little premature. My
humble opinion is that we should not look at release dates of
libraries when we deprecate them, but release dates and end-of-support
dates of major Linux distribution that include them.

My question for you is: How difficult would be to reactivate SDL 1.2
support in QEMU, and postpone its depreciation for a couple of years?

I do not demand anything, this is just a question, meant to start a
conversation.

Yours,
Aleksandar

