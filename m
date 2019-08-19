Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE74C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 06:46:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E10C2086C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 06:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VR6Ka+ua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E10C2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzbQk-0006Lk-Qh
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 02:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hzbPd-0005W7-94
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 02:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hzbPb-0000Fk-AB
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 02:45:05 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45485)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hzbPY-0000Bl-7i; Mon, 19 Aug 2019 02:45:00 -0400
Received: by mail-ot1-x344.google.com with SMTP id m24so681298otp.12;
 Sun, 18 Aug 2019 23:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=/aTP8g+19vLIwV8ybJBObPx+sZ/gn9UWAOsVgyiAfEQ=;
 b=VR6Ka+uaKYhh16qQODx9p9AwmGc91mFUhftrNVTFV/QjJe8CznKpdsQc1iATSMgCKc
 jVvQ0cQe8a2NmvmT8plxyrV+pqaLUsGD1AS9yQDlW3jQBWLSDfuyCnWPo8yMtYrCwxgQ
 yVr8Bcq9qz1CFHsMnOIgsm4d4JzOyGhBYMPRt8TdgZuJf58HmU3Z2PpPBb44fJrBdr60
 NzOSggUApM9/sHgyk5QHLlAlp1lbh0mAogY7O+Gb0qr65EJUUmwTbdgZsM96awtCCuI2
 +1eWRMbaimcW3T8d0IKgNb3afNUc/DH2c73MUyQB7JIo7asr9MRGfGl7NTJ50QiDWlHY
 LSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=/aTP8g+19vLIwV8ybJBObPx+sZ/gn9UWAOsVgyiAfEQ=;
 b=bP/boyIuOD+zZwq8/zo28IjvveG7kH6tVe/0oh29BGHZrEcpeJPAo88WTw9hezu+WH
 RzI/tjvdbultKzO3xcr+X2rmpofUxgUdAPwSZAt5DXFQ5L7Qyu0xi6tAUILCcX7lW2ed
 bjwygEPFt9vWHhIN79T303//dEr96scD/ugWO5LmuC6f1pMKvKkDzelN+VNwjLASc3Ha
 a/U/A/ebHjAIx7W0iGDnFIEo9dRVZzdjKbpZ/WdKkVxaOczS1sPD9ES3Nme2eAQnmUFT
 vFUbjWbUam6VKeWDKzmi3ynDw8N5XyAc8gc3xgD6k3MeCktgrZgf2+9LHd52oOMZFz3L
 fHvw==
X-Gm-Message-State: APjAAAWwmjrm6pFAvNKgCPt/uilS3bUs2wGr3V9YLZIHaviQ253shnIT
 SggoM6tEFVyIBTEth+ghqXSEjyV/PbGIWbnaRms=
X-Google-Smtp-Source: APXvYqyZoIjxLBJUJ2CxN0g76Gq6hVkd4xW/Lucz5HLrDYQJqSPEHnruib9YtjDxJm7YTwkaHuXLQhAYu3Otn/P6/Xc=
X-Received: by 2002:a05:6830:1d75:: with SMTP id
 l21mr15952680oti.121.1566197099390; 
 Sun, 18 Aug 2019 23:44:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Sun, 18 Aug 2019 23:44:58
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Sun, 18 Aug 2019 23:44:58
 -0700 (PDT)
In-Reply-To: <20190819062817.GA24503@umbus.fritz.box>
References: <1565983669-6886-1-git-send-email-pc@us.ibm.com>
 <CAL1e-=jy6vggskJ26rTc8dnaqtqCB0SdfpV9p-NvKdjoBk+Vkw@mail.gmail.com>
 <0cfddc22-92ef-3067-9275-8f4f22ca9805@linaro.org>
 <CAL1e-=h=Hzfm8KZ4ebwaBsS6U=KVcReXpOPT2-vy4OeBktjWkQ@mail.gmail.com>
 <20190819062817.GA24503@umbus.fritz.box>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 19 Aug 2019 08:44:58 +0200
Message-ID: <CAL1e-=j0w=OasHidP4W4ND-R3p6Ui7MS0iaj7Wk+c1tVyR09+A@mail.gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] ppc: Three floating point fixes
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
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 "Paul A. Clarke" <pc@us.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.08.2019. 08.30, "David Gibson" <david@gibson.dropbear.id.au> =D1=98=D0=
=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On Sun, Aug 18, 2019 at 10:59:01PM +0200, Aleksandar Markovic wrote:
> > 18.08.2019. 10.10, "Richard Henderson" <richard.henderson@linaro.org> =
=D1=98=D0=B5
> > =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > >
> > > On 8/16/19 11:59 PM, Aleksandar Markovic wrote:
> > > >> From: "Paul A. Clarke" <pc@us.ibm.com>
> > > ...
> > > >>   ISA 3.0B has xscvdpspn leaving its result in word 1 of the targe=
t
> > > > register,
> > > >>   and mffprwz expecting its input to come from word 0 of the sourc=
e
> > > > register.
> > > >>   This sequence fails with QEMU, as a shift is required between
those
> > two
> > > >>   instructions.  However, the hardware splats the result to both
word 0
> > > > and
> > > >>   word 1 of its output register, so the shift is not necessary.
> > > >>   Expect a future revision of the ISA to specify this behavior.
> > > >>
> > > >
> > > > Hmmm... Isn't this a gcc bug (using undocumented hardware feature),
> > given
> > > > everything you said here?
> > >
> > > The key here is "expect a future revision of the ISA to specify this
> > behavior".
> > >
> > > It's clearly within IBM's purview to adjust the specification to
document
> > a
> > > previously undocumented hardware feature.
> > >
> >
> > By no means, yes, the key is in ISA documentation. But, the impression
that
> > full original commit message conveys is that the main reason for change
is
> > gcc behavior. If we accepted in general that gcc behavior determines
QEMU
> > behavior, I am afraid we would be on a very slippery slope - therefore =
I
> > think the commit message (and possible code comment) should, in my
opinion,
> > mention ISA docs as the central reason for change. Paul, is there any
> > tentative release date of the new ISA specification?
>
> It's not really a question of gcc behaviour, it's a question of actual
> cpu behaviour versus ISA document.  Which one qemu should follow is
> somewhat debatable, but it sounds here like the ISA will be updated to
> match the cpu, which weights it heavily in favour of mimicing the
> actual cpu.
>

This sounds right to me.

Aleksandar

> --
> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_
_other_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson
