Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD601C43141
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 09:32:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F4E4206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 09:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0g7Mpv/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F4E4206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVBUg-00034V-O6
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 04:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iVBTi-0002UT-Ea
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:31:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iVBTh-0005CG-I9
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:31:50 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37809)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iVBTh-0005AN-CD
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:31:49 -0500
Received: by mail-wr1-x443.google.com with SMTP id t1so5615915wrv.4
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 01:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=88L5zRsJrM3Y01ROq4JyPItU7KZg+cXae9DWnup5tjg=;
 b=R0g7Mpv/RCvhQyZwEB6bOpIheEg3rlyWp7qT4vw2hP9jyIci68Gf8t90PqWrIxabAM
 L9aUXZRIEKMPkgfnuiKxPqM/nLq97vRPXkv8BQyiBbIxdrrIUPjts4f7MY541MD+Dh7k
 SRCdzM7CVJKj1hC0zYh21BPDCJiELgHW6JSMbE8wAmtxU3LA4kOLtNIQcDtEbO0UNikP
 r3m+ri5M98ge7g0ewp6OKXUlPApAwN1hg4a0phgQU7G+sGIMdxDVdr39rbLlzQ8UTo/h
 V21GsreSYTEJaq1fXyKxwpT34+Oz1EKp290qhXzhMRHgr1hF7jPpw7pHay6qLQtren7x
 EagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=88L5zRsJrM3Y01ROq4JyPItU7KZg+cXae9DWnup5tjg=;
 b=NAJ99MsZCPWhmpClFox0vpDVN+e3mHjV2FdZMqbPkDmgoraWacThwSugAvTX4US06X
 oVq6fE8pqfHmzwZEtPolNByaKhzf95i3uwG5NnqHRNaaAechH29BDfSx0CLeuEeEgLPF
 I6ze2Gbn+hNm0fZszG+0gq1BLBSozImxY4UKYyf720kg2vGDYo2XiJ8ctUNZzObJ1TEg
 djdfkmyDOvLPc1Ri1t4WHAhMNUf5Ql46xo/MhUARQX0X8O+Wf6ONH7W3NzVj58myTfl4
 SJhM+hRPYWVVtYjD6s5qXtkcbSwFa9V3RwWw9oloko8GosdHSDJm8qzLDJQy7WuVG4X8
 4/CQ==
X-Gm-Message-State: APjAAAUpvJmRKF/WzjKmP3No9Q18nOEEis3ShCem5gEu5cQhMFatg8Ub
 CbRKxPNMCNbC8+etbQlgAeR+2B553t288a6vpoE=
X-Google-Smtp-Source: APXvYqwx1+d5o7dKz8+hRo7ovoDqVOov1ujcLC8xVXLtbx1OTncBtq8kF4s1oqh8k3Oiw/s2U0KSsgVydSapTFBPZiU=
X-Received: by 2002:adf:ed4e:: with SMTP id u14mr7457751wro.132.1573723908241; 
 Thu, 14 Nov 2019 01:31:48 -0800 (PST)
MIME-Version: 1.0
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-2-git-send-email-pbonzini@redhat.com>
 <CAJ+F1CKaxddkwtE6GGQMxhrUxbFaw8EaokU=Q4VLQH6Y66DqVw@mail.gmail.com>
 <a69fbac4-aec4-da6a-b6db-39d27785406e@redhat.com>
In-Reply-To: <a69fbac4-aec4-da6a-b6db-39d27785406e@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 14 Nov 2019 13:31:35 +0400
Message-ID: <CAJ+F1CJBsaGY6g4rfMrMhTO2Os7ji=804dRkLhNT2-g_Qr6MFQ@mail.gmail.com>
Subject: Re: [PATCH 01/16] memory: do not look at current_machine->accel
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 14, 2019 at 1:27 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 14/11/19 09:56, Marc-Andr=C3=A9 Lureau wrote:
> >> +                    qemu_printf(" %s", fvi->ac->name);
> >
> > There was a discussion on the original patch that this will have
> > -accel appended.
>
> This is not the class name, it's the name member of AccelClass.
>

right, thanks

--=20
Marc-Andr=C3=A9 Lureau

