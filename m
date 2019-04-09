Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B94C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 11:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692F920880
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 11:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmywDLys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692F920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39377 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDotv-0008Pd-HX
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 07:26:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hDot6-00086w-36
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hDot3-0001oR-LX
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:26:00 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hDot3-0001o1-3t
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:25:57 -0400
Received: by mail-wr1-x442.google.com with SMTP id g3so20359018wrx.9
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 04:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=xk/X+u3iWw04cO5PirjGmDBeEvRBdL6krFI1zPTIcms=;
	b=NmywDLysnfeEs6lt8mcnjL4p0nccdYhGyl7CGAhhuGBF0i4DDZvd7Uc1AP7ECTm0f0
	9lLg1w6WsdrMJEqBOX0dNeH1Gj/1hdLL83hlbOXCLZRHnU6szgY0XG6LxNbTTgcpIeQt
	qR3dNaaMC8oi8NHzVHlsgIZM8LeuMU/vVixJO33Tpi/8+VMuY6hyzVIDJlYoejX9/S/s
	WAJhtcNjsOTeI+akAvAXZrTDBn/S1P90rWssEd5frCR/oyAf0gavy8Xm9yPA5xfT+cwN
	iVrVHXd2XF0T1RbXOCAyKch5HiNwzRyDwZDB2Pm6PP2cFXikDh5wGHuQKySNueSnHzYe
	ErCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=xk/X+u3iWw04cO5PirjGmDBeEvRBdL6krFI1zPTIcms=;
	b=ViFh/cGmMPOWqHqJxrQNlZfwQ0c07ajmKB5w5+awScmCWFxCo1nRkLOt4KPzWfFsXe
	Iysf4H/yMni3R+GyPnQhI4Q1DiB/sGO5JTZ4x/bpYBF0uLJufDBqq6OjFxlbqNZjGN1W
	PYIQrxQL5Ukf6MxKe6Jwq39N3X0DeH2YsLvaNHlSX7AfzMlEtd6C7x6GrrpAIUo590I5
	AkyjY8ipqlHN41EJ4sranRZaeMmiCnI6mOTUhJ/FNDafxf9TEZ6cSqRCs3SFsL5icUSH
	XoNPwKU9J6nzG4WnkVlybdriY+hO6nIEwbZTVlSDNR3cSeZtvoIBSoqsqDH4c73gFaUU
	+l4w==
X-Gm-Message-State: APjAAAUrww2objzVuUynU5DcqEyHjNqzyV/67wIDsNX6ciVwEEkV6hA1
	KR7pW8Y1ZMzrSrz49aRgVUika8v83HWV2WsSOR4=
X-Google-Smtp-Source: APXvYqzcvZMLPykur7yJcYR4/XKG0m1xy8hZ+qME5ZPaAU+0yqc0aGB59oszyYF/YvnjE5SzZ5zh2HSnsclkc77leB0=
X-Received: by 2002:adf:ed8f:: with SMTP id c15mr23595126wro.144.1554809155585;
	Tue, 09 Apr 2019 04:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-4-armbru@redhat.com>
	<CAMxuvayc+RnpmFpUVFaLW2Uh8y6bZo2N4o6wu6YVyE1XRHtdWg@mail.gmail.com>
	<87bm1gr83k.fsf@dusky.pond.sub.org>
	<1f1ab942-49e9-0714-c6bc-65c7a0c4fa27@redhat.com>
In-Reply-To: <1f1ab942-49e9-0714-c6bc-65c7a0c4fa27@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Apr 2019 13:25:43 +0200
Message-ID:
 <CAJ+F1C+7gBUPFY5hJ8aCg4_KWJHiNMNx_6CjAQExOVKqmG7FOA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 03/15] char-pty: Drop "char device
 redirected to" message
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409112543.OmhqUEiI0hyeJXQqJCCUXm_rtXzqGkbE1jshLuK1QDQ@z>

Hi

On Tue, Apr 9, 2019 at 12:40 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 4/8/19 2:31 PM, Markus Armbruster wrote:
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >
> >> Hi
> >>
> >> On Mon, Apr 8, 2019 at 10:36 AM Markus Armbruster <armbru@redhat.com> =
wrote:
> >>>
> >>> char_pty_open() prints a "char device redirected to PTY_NAME (label
> >>> LABEL)" message to the current monitor or else to stderr.  No other
> >>> ChardevClass::open() prints anything on success.  Drop the message.
> >>>
> >>> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> >>> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >>> ---
> >>>  chardev/char-pty.c | 2 --
> >>>  1 file changed, 2 deletions(-)
> >>>
> >>
> >> I guess that was printed for convenience.
> >>
> >> Allocated pty can be read from "info chardev", so I suppose we can
> >> make qemu more silent. Fine with me:
> >>
> >> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Thanks!
> >
> > If we should decide the message is still useful enough to be worth
> > keeping, I could direct it to stdout instead of dropping it.
>
> I prefer this, if Marc-Andr=C3=A9 is still OK.

I don't mind, but I wonder if we really have users that care. Power
users can easily get the associated pty from a monitor query.


--=20
Marc-Andr=C3=A9 Lureau

