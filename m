Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF72C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B57120838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xe8Jaqc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B57120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j072j-0002sT-Az
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 12:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j06zN-0004cP-Qx
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:00:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j06zM-0003IZ-Fb
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:00:21 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44870)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j06zM-0003FZ-7y
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:00:20 -0500
Received: by mail-ot1-x343.google.com with SMTP id h9so2760753otj.11
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 09:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=F5+d8AqKgWKJUkNZjeJml+KURblA5gJfBPv4qC+u0Mk=;
 b=xe8Jaqc+7nRii9xTrbGGMfZ5+pgsC6Wp0COB7RuEP3pLbnUjvYuVI/oEK1zfcfX82A
 0y+hH5+/lodU5q3w/BcozaWzVs5KqCLey4xHM6ueVkXzChq4uQTJ6N8T2FuTUbWgX8SF
 WHsM/qBE1J1uC8YVhv1CarU7lb9tp6xP3mnAhkCpWxHmSNZoHkaFEuEcSUHmt9uCuhXK
 0myWp9gdTx1AjQBdYLueX9jpGiV2XH3r+S6xFOeYqseyfcla8hy6taaKxsHZXLb+mtO/
 A7B42eTN3++6MYwUGVSBQ69FankoBB6ZLNCS9sduiDmvnKOAkBQbtpkQ7D2bFSkcoOMO
 7QYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F5+d8AqKgWKJUkNZjeJml+KURblA5gJfBPv4qC+u0Mk=;
 b=VHkIkFPp2nxkyPNV28GMhyc1W3AwJ9CJ3EWANfEpp6tXRF23vaRgbH0y3+AYPE1JKH
 lR5Q1bsOpCXHP9wPqKwozEzOXfeU8Dw7neK4QkNZX+ToxeRogIWW+KOewTVlx3ai3gkB
 NKRLHSwotXRcMjG0UU/VHhuSfrf4ymEyLLT07FGcJ0MAeNdFRn5CWrx24Pyizj7eQTkv
 9Mw4UFUwVBnU3DQlD6LIKHYD+8x34uj601QDwSpUPnoF2PzKbJUrIMLiJIIUySbx5RgY
 khbBcaMme6sb2+500lHg6gVnVnvE+HzLZtAwaFrafm1A5D/ar0xs2K9Aybzx3FVTRp/k
 dHxg==
X-Gm-Message-State: APjAAAVAcszcqybnMR4vfn7wslkmyi2p/7IHj9HrREgFbAKCpQmahYvW
 G588ZuMjgM+RIifQsnMK4hS6OmRcHrP/tMSQeD4Sjg==
X-Google-Smtp-Source: APXvYqxl6Wbyk+TigT7Zwm8VLi/H5gcIIvwW9HZUDY3XLcxvToiNEBWi+hw1bMTtMuAZIDbYK5PklceAGjY6qw0WBug=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr214504otq.221.1581094818843; 
 Fri, 07 Feb 2020 09:00:18 -0800 (PST)
MIME-Version: 1.0
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-19-peter.maydell@linaro.org>
 <87a75unxrm.fsf@dusky.pond.sub.org>
In-Reply-To: <87a75unxrm.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 17:00:07 +0000
Message-ID: <CAFEAcA_ncWPsFyywKCM9sWt+ZP+hYqYbMOL07EinQbkVHgBfbA@mail.gmail.com>
Subject: Re: [PATCH 18/29] qapi/migration.json: Replace _this_ with *this*
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 at 16:54, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > The MigrationInfo::setup-time documentation is the only place where
> > we use _this_ inline markup to mean italics.
>
> Nitpick: _this_ does not mean italics, it means emphasis.  See
> qapi-code-gen.txt section "Documentation markup".  doc.py maps it to
> @emph{this}, which Texinfo commonly renders in italics when the output
> format supports that.

Yeah, I know. But to my mind nobody actually cares about "is this
'emphasis' or 'strong'", because those are pretty meaningless
and are not very easy to distinguish semantically. What people
actually care about is "how does this render", because bold and
italics look noticeably different and if you're writing you
might care about which you get. At that point 'strong' is just
a confusing synonym for 'bold' and 'emphasis' is a confusing
synonym for 'italics'. But maybe I'm out on a limb here.

Anyway, I'm happy to tweak the commit message.

thanks
-- PMM

