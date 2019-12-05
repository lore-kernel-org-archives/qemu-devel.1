Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B77C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 13:42:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D17B22525
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 13:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mwt/vouy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D17B22525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icrOT-0001SU-35
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 08:42:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1icrGe-0003wd-Hw
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:34:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1icrGd-0004r8-JD
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:34:04 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:37335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1icrGd-0004oh-Bb
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:34:03 -0500
Received: by mail-ot1-x336.google.com with SMTP id k14so2588910otn.4
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 05:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=zUb5hjdjFuEycyokBACyakxicbn/nLtIcYYyDH+r37Y=;
 b=Mwt/vouyVWWKMYoylNKMGSvmL0RR1jwUMOIJ585ay1ysqozT1zs4ACbgq0A3IFhyp8
 Mc4o1X9J7sViWTKZLozGhq0emeAxyL83r5Dstd1a9nf0dbbm5PSLaWIjPox28nm0SsY4
 p5QDntAKWCi2gPPdSmU/y2ymBMe7VAUoaH0Fd23xDOVcwTnWro9bgSCvsyHlwsDfnQ/T
 zyT8dnOecgckgnDcc5Wydo85W20ooEq1n8vYEWWbuWcT9XxTEIruPbIV5okMHvUQHVwb
 1AyKXWSGnQBQlRmWnjP2IAw5eMEgdgHcje3v+QOEq5VWoNJWemJXRUHHugt9hnYZ1b92
 P4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=zUb5hjdjFuEycyokBACyakxicbn/nLtIcYYyDH+r37Y=;
 b=jZt+h4QbZFc9RoGpqHRz6l5YDCxWdOuStvWbwqs8PlO0muQlc0lkPQS1I3rpg6XTmx
 5FXRIAD3fgVbK6OzkMf2Na1PDCrYR1aV25YyvKJ832EQrEQKuydCiMo/oHezkKo4YaCS
 b3wWYqD6WoteiUoWva41aw9XPGF2/A6FKcvggAn8t7tJcZe4U9/OwAT2582FXUPpavWl
 z2mfSek6GMB7Rp8eAuqVDaJKrz6ZZ/P+ErcOeU7CzYFKwaWQt+6MWOrIYRUQVGVbc2/P
 JQdoFkZWDMNokfIpF3AK5JH57TjJ2ca6VqdMN5TQ4MKMAom6hgGTWesN8J9kqrb5KhDp
 kSjg==
X-Gm-Message-State: APjAAAWD0NXI+5ahoidv5n8VGCy9xsj1lsjMeb1JGxeFk1mompTKnBmb
 0MeJq1CJz6vGEFa7751qfazikx2hdMW2ZkTd+LC2Lg==
X-Google-Smtp-Source: APXvYqz5LfejNzdvEl+h6nHodC+shaVe1AnP5S8JclmnlJTfuufMuhpHKxhRcWctu+wUdi0yPet+KdNEbdINjGjqwL4=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr6636504otc.295.1575551514267; 
 Thu, 05 Dec 2019 05:11:54 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Thu, 5 Dec 2019 05:11:53 -0800 (PST)
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 5 Dec 2019 14:11:53 +0100
Message-ID: <CAL1e-=hzSLWQ2_qTOXc30FpaMO65uKGqUP9agE+Ti1cfEU9j=A@mail.gmail.com>
Subject: [QUESTION] "cpu" vs "core"
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000005554f60598f4ac34"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
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

--0000000000005554f60598f4ac34
Content-Type: text/plain; charset="UTF-8"

Hi, all.

Times are changing, and perhaps some words change their significance or are
less in use.

What do you think of introducing a new option in our command line "-core",
that would be (code-wise) a sinomym to "-cpu" (that becomes almost archaic)?

Yours,
Aleksandar

--0000000000005554f60598f4ac34
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, all.<div><br></div><div>Times are changing, and perhaps some words chan=
ge their significance or are less in use.</div><div><br></div><div>What do =
you think of introducing a new option in our command line &quot;-core&quot;=
, that would be (code-wise) a sinomym to &quot;-cpu&quot; (that becomes alm=
ost archaic)?</div><div><br></div><div>Yours,</div><div>Aleksandar</div>

--0000000000005554f60598f4ac34--

