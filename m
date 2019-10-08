Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC81ECE58E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 832402070B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8LUXyK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 832402070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHp28-0006tS-If
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 08:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1iHp1G-0006Ha-BA
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:55:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1iHp1F-0003bH-0P
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:55:14 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b]:36539)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lucienmp.qemu@gmail.com>)
 id 1iHp1E-0003Z0-Sa
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:55:12 -0400
Received: by mail-qt1-x82b.google.com with SMTP id o12so25119810qtf.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 05:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+75ozcsMUPNQrJPXtCB4eC0RRh0TKhXhDCufF8BWhIA=;
 b=E8LUXyK9LCLFqWndcgRZf+cRHdNJXRf5S5omFAuQw3IaBsS4WI8qILxosaHFTSlC/c
 4zP6V2myXz3qAQvAeYg5Rps1rYjHt5/yR3QG0d8RcyBUX+XTXjLqhh8+fN44QLeAkmL8
 rf0YyOzmVL4NAzGDo1t0lzKwNxHfUXsaP+cNX/+1om1Il7Od2a3Tr6e/OoZdGxXYLL59
 AJYSYEKyKJoT0kVycu29XFplI87tfazuYoimDK4CHAeDo4ORZnfoUmtCMnM6y4tyo6sl
 VQt1HAwFb/c2bAwPKN4TmygUPPOZEw0Yx60m5yUbei4cVU1xu6S4ShQ9fW8hOHF0T4zo
 c++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+75ozcsMUPNQrJPXtCB4eC0RRh0TKhXhDCufF8BWhIA=;
 b=bhrcnfwsLjvWAbUt+of6K/YErCvSOwjKrv9prNyl2xtmBjembDL0roQWFdHwWt0B6i
 ycVxmlvvWzvRWH3zT/A8iRZN4UN/vuh0k74D9tOjImJMRZjSp+TZo0XUiP9aAQpobzPj
 mTbwHNtbBlbNF8rWBr/nPs/ZZVrIqrkbc/fXxnLaWYupmUiXBfZQuxhxkx7JwybHQpCJ
 EPaPvuLgwInpzD2Pia/AyfY26ct7+jxXKEJSt9uKiIlS9M0PA+BTqWRimAsyKlrB1tkM
 yTwJ3VIMb9CpyQ6Fu40dBScuyD20axivXpUHH0/8ZJpQAXrBvJYeY5hO+uonFojyl8FE
 xFTw==
X-Gm-Message-State: APjAAAXvf0DsxlMIF/GvW6vHNA8BED4ZrgPgrmNHxX20BbDhy2jrzC5w
 pt4pwD0o2TidgSI8ZCA0QiYPl9My1tGZLpKNn+E=
X-Google-Smtp-Source: APXvYqyK58alnT+Z8Xl7iiP/B4dCrl5uxqEBBJGCHauGfHRofBVx/hmssFrhh+iRjlUjtjkyAyahrRMLOFGcbAibq0A=
X-Received: by 2002:ac8:fbd:: with SMTP id b58mr11336978qtk.210.1570539311415; 
 Tue, 08 Oct 2019 05:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <CALvKS=EoaNnNQCmdp3rjjbaAYOoow8txsn1KX=Mb37Vk3he5Kw@mail.gmail.com>
 <5ef2c575-0bae-9f0b-cf2b-437280914cec@redhat.com>
 <CAFEAcA8bs-DZPsxzE=kJ-gRT-1i6wZ4FvkK+-MaygE0Zg3A4Yw@mail.gmail.com>
 <e01f0c12-cd2f-d2f0-aac3-b8145239c45b@redhat.com>
In-Reply-To: <e01f0c12-cd2f-d2f0-aac3-b8145239c45b@redhat.com>
From: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Date: Tue, 8 Oct 2019 21:54:58 +0900
Message-ID: <CALvKS=Ht-2zkdM8LxwyTYcVrg6ALoG099GZgkZcOzPW+P7rV0g@mail.gmail.com>
Subject: Re: Peculiar reply from mail list handler???
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::82b
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
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 8, 2019 at 8:29 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> On 10/5/19 9:09 PM, Peter Maydell wrote:
> > On Sat, 5 Oct 2019 at 18:13, John Snow <jsnow@redhat.com> wrote:
> >> I'm not clear on the particulars of mail delivery protocols or what
> >> lists.sr.ht is, but we indeed do not like HTML mail sent to this list.
> >
> > I suspect the lists.sr.ht address is just some subscriber to the
> > QEMU mailing list -- the list server sent your mail to all
> > the subscribers, including that one, which then complained
> > to you. But the QEMU list itself is OK with HTML email
> > (we prefer plain text, but we don't reject HTML).
>
> I subscribed to sr.ht some time ago to test the service because they
> provide a CI, git hosting, mailing list, so this might come from my
> account. If so, I'm surprise it send email on the subscriber behalf.
>
> Per https://man.sr.ht/lists.sr.ht/etiquette.md#plain-text:
>
>    Rich text is not desirable for development-oriented email
>    conversations, so you should disable this feature and send
>    your email as "plain text". Every email client is different,
>    you should research the options for your specific client.
>    HTML emails are rejected by all sr.ht services.
>
> Surprisingly there is no option to allow HTML... (plain text is a design
> feature).

Yep, I forgot to change it and was intending to just write a quick message
without having to fire up my Linux box.  Had a "damn it" moment the
second the reply bounced back.

But was a little more concerned the list had its own issues as the
domain looked a little suspect at first glance (I hadnt seen it before,
and the style looks unusual / lazy )

Anyway, something directly mailed back.  And yes I will see where the
gmail "plain text first" options are so I dont mess it up again

Cheers,
Luc

