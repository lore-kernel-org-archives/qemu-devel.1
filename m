Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEF1C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 14:15:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A812083B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 14:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lauvP1x7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A812083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48090 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdxqv-0002yj-HY
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 10:15:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33127)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pranith.foss@gmail.com>) id 1hdxgn-0003Nv-DG
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 10:05:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pranith.foss@gmail.com>) id 1hdxVe-0007bY-GB
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:55:39 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:40327)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pranith.foss@gmail.com>)
 id 1hdxVb-0007X5-Fs
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:53:48 -0400
Received: by mail-yb1-xb43.google.com with SMTP id i14so1258130ybp.7
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 06:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Flb6jxOPCU7jr8xaxPeezkHCJjR+kusDgoDhgZjK42E=;
 b=lauvP1x7SmH31WEt+RXIeCW5W01btedli5EZ57QT02agvP53cPpHzED3+iQOyNVNMG
 5rkDX5yICcCHAw0d/FvzvVl8N28c27BLnlWgCAf6lSU/p1/es5G2C0pDRd+0OSTx9qTW
 Xd7O/q+FIj9mchkBPlVjtYbeuWGs30gnPLU8yZt++9BzljKf2waTz626GitHlaihIcb5
 MWH2D8SZ/sRaqiRYMSdyU3bIrzC2FVuLBKzHvtivImdPYoFTH7uWOqYwL0J/VBnWIau6
 yZaSnAQ1MV4yLGYKbtDCEaRRZ3ot5zv/H3UAV9h5pxlG2fnj5hUlcfOxasmcXAmjKmBk
 vRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Flb6jxOPCU7jr8xaxPeezkHCJjR+kusDgoDhgZjK42E=;
 b=l6N/Q+37814nrJqTVe+ALgQRcq0nB76q4BA4bF483YoS+MpDjGbmdYZCb9O2eB8muR
 DTt0pM6W+t5iUPJFMmhhiYa2iBbhTEvRawzY+eyOj1fS+/d+7Xoi6CW/MOOa53Y29ZXf
 oMB2YmHCKCvfqX8H1zA04ANPTfOfQfo5cIuzqND6NrQz0DGvYmnCxT1d0+5ghKW66Hpo
 ylpP58QLu9fQrPeVpY4ET4fMO4eQ2FTuLEkCXAugk6IZR11qhUZQUZMIHOkjwKrGr02Y
 ktIpygBe8KcG7lh4U2CRGEbsxNrs+K+7PnyRVmM220dDXRGQznVKKyHhAYwpNf05mGSR
 1e/A==
X-Gm-Message-State: APjAAAWAl58P0XkrDw0I7TlsqQh2QmyLEOhpex3Z02XXs8Drds+QlINI
 2DHEWIO4WAc3xmSlRjspiYWZZLZ7I2k2s1tMgiI=
X-Google-Smtp-Source: APXvYqzaA0jrzZQ6vrGX2doUraWSBwdpRL2Nl/YcdzypInJ0nsMfNvN/WBHm84ZmkPi7IGY3O05FZNH9Ga/WFOxKZvE=
X-Received: by 2002:a5b:706:: with SMTP id g6mr64101213ybq.316.1561038822420; 
 Thu, 20 Jun 2019 06:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190614171200.21078-1-alex.bennee@linaro.org>
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu, 20 Jun 2019 06:53:30 -0700
Message-ID: <CADYwmhFw8ujwz+NN9prKc+Za6=dD1aN==JnKmC0gnr4V7LPU4w@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: Re: [Qemu-devel] [PATCH v3 00/50] tcg plugin support
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
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex/Emilio,

I am really happy to see the progress you made on the plugin feature. Looki=
ng
forward to seeing it merged soon! Please CC me on future versions of the
patchset. I am happy to help review and contribute to this effort.

I have a few general comments from experience writing a very similar system
(qsim) below.

On Fri, Jun 14, 2019 at 10:23 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
> Hi,
>
> This is v3 of the proposed plugins API for QEMU. As Emilio is busy
> having finished his time at Columbia I have volunteered to take the
> patch series forward. Emilio's RFC v2 was posted last year:
>
>   Subject: [RFC v2 00/38] Plugin support
>   Date: Sun,  9 Dec 2018 14:37:11 -0500
>   Message-Id: <20181209193749.12277-1-cota@braap.org>
>

* Register and memory read/write API

  It would be great to have register and memory read/write API i.e., abilit=
y
  to read/write to registers/memory from within the callback. This gives th=
e
  plugin ability to do system introspection. (Not sure if the current patch=
set
  implements this already).

* Register callbacks

  A callback needs to be invoked whenever a specified registers is read or
  written to.

* Where do new plugins live in the tree?

  The current source files in plugins (api, core etc.,) I think are better =
if
  moved to tcg/plugins/.  The various plugins we write would then live in t=
he
  plugins/ folder instead of the current tests/plugin/ folder.

* Timer interrupts

  What I observed is that the system execution is affected by what you do i=
n
  the callbacks because of timer interrupts. For example, if you spend time=
 in
  the memory callback doing a bit of processing and writing to a file, you
  will see more timer interrupt instructions. One solution to this would be=
 to
  use 'icount', but it does not work that well. I think we need to do
  something similar to what gdb does in debug mode. How would you handle MT=
TCG
  guests in that case?

  Another approach would be to offload callback generation to a separate
  plugin thread. The main thread will copy data required by a callback and
  invoke the callback asynchronously (std::async in C++ if you are familiar=
).

* Starting and stopping callback generation

  It would be great if we have a mechanism to dynamically start/stop callba=
cks
  when a sequence of code (magic instruction) is executed. This would be
  useful to annotate region-of-interest (ROI) in benchmarks to
generate callbacks.

  Also, the return value from a callback can be used to decide further cour=
se
  of action. For example, if our plugin needs 10000 callbacks, it can indic=
ate
  to stop generating further callbacks in the return value of the callback
  once it got the necessary callbacks.

* State saving API

  An API to save the state of the VM from the plugin code.

Let me know your thoughts and any other ideas you might have.

Thanks,
--
Pranith

