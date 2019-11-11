Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49848C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D8420656
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kr3WZLr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D8420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCdM-00010O-JG
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iUCOd-0001yi-RS
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:18:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iUCOc-0001BC-Cb
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:18:31 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46212)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iUCOc-0001AC-6s
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:18:30 -0500
Received: by mail-ot1-x341.google.com with SMTP id n23so11675134otr.13
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 08:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GDBpaziJfd1ljGg5IEBQKD7sqmydzh1TW8chDqLMn7A=;
 b=kr3WZLr9lafU+hR0RzadBExrDWDcMIpI7oY3IDsGjlvKTJLAO/VrwVOdCcc+7hDqcz
 y4bhJRXhCo4hvv3X0LBzmpPjQZhJ1oHfPhLi94moy2o48pOF2pW69oG8pNMnJYkbhLSc
 MVIAjeOfupT6BXMemrVrBM3B9FrD3BET/0KsYhNDT+QtTv7rMLpO6IzpEkrwO5WBhnB4
 dqI+TKaVUNO5v8S+Yspa1wQu5MEdIDicKti0x6fF3HvBJWisJ/v8s62BRFbIQI+YQr+b
 2yCIWlrQN7xwl4fReHWM/s/+ddXFhuqUP2IUsWKqGT1wkHCbkkPQvk1mwarmpQur+PZr
 WkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GDBpaziJfd1ljGg5IEBQKD7sqmydzh1TW8chDqLMn7A=;
 b=oScMmzEQULZAYBfuC3Eq1hSdLtcSdBSBJvS6M6wJfZEhERYTBekqN1h6QmSx8SaS0O
 D4aDUS/cYPNLjkoXIqhcAaRXUKgBAEduSfHgpSPv3AcEhqoNrKWIDMkXh8eFJ+8+XkHG
 mzeNqRerLhxvp/SeXJUOULN6hO996HTCC6g2WNpxdXmityr/PkN4UOG2P9c9dIpiwTF3
 lIMu9u+gyHn3vnQf1V//TK50PZ2tN9Dlbqew7Ut/imqaYaFdSt8iLD5GQrpLAxWpdLXZ
 3C1Xh5h9wLMbfg5Ap8XSKDQ7mwHJRx8NWklzkfBb8bZWKUNDpWSCaNCr5m58qr8PKK78
 yEOA==
X-Gm-Message-State: APjAAAWf3mujVBVuEXh8GDq6+mcs4vu58En04jhFOW7XNBqXaRopNC+4
 MnqRSZHGPzsouq03qEsoBQgxcrL8jqGeZj1zBKBJDw==
X-Google-Smtp-Source: APXvYqyWS1Q9XJmC0cN6Fr7ebGcwh9N6FJCRlEb7tUggwY2zfP/tTsK6PnoM6vTmMw3dgWMxCwCC3KTjVvQ0pwYzerk=
X-Received: by 2002:a9d:7f12:: with SMTP id j18mr20511953otq.221.1573489109237; 
 Mon, 11 Nov 2019 08:18:29 -0800 (PST)
MIME-Version: 1.0
References: <20191111125530.26579-1-alex.bennee@linaro.org>
 <cd4917d6-75b7-2c47-0c6b-07dda077c52e@redhat.com> <878soma4ev.fsf@linaro.org>
 <97fd0943-586c-035f-b33b-eb6b2eb3dde6@redhat.com>
In-Reply-To: <97fd0943-586c-035f-b33b-eb6b2eb3dde6@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Nov 2019 16:18:17 +0000
Message-ID: <CAFEAcA_F1gUOhTyVkd185ie=tgoFS08n62Nk425RnAW+w6o0XA@mail.gmail.com>
Subject: Re: [PATCH] tests/migration: use the common library function
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 Nov 2019 at 14:41, Thomas Huth <thuth@redhat.com> wrote:
>
> On 11/11/2019 15.11, Alex Benn=C3=A9e wrote:
> >
> > Thomas Huth <thuth@redhat.com> writes:
> >
> >> On 11/11/2019 13.55, Alex Benn=C3=A9e wrote:
> >>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >>
> >> Could you please add at least a short patch description? (Why is this
> >> change necessary / a good idea?)
> >
> > It's just a minor clean-up Dave happened to comment on last week. Using
> > the helper function is preferable given it abstracts away any system
> > differences for the same information.
>
> But this also changes the behavior on non-Linux systems (i.e. the *BSDs
> and macOS), since they will now use getpid() instead of gettid ... is
> that the intended change here?

Does the 'stress' program work on those OSes? For that matter,
does it work on Linux?

As far as I can tell we don't compile stress.c on any host,
since the only thing that depends on tests/migration/stress$(EXESUF)
is tests/migration/initrd-stress.img, and nothing depends on that.

Nothing creates tests/migration/ in the build dir so trying
to build tests/migration/stress in an out-of-tree config fails:

  CC      tests/migration/stress.o
/home/petmay01/linaro/qemu-from-laptop/qemu/tests/migration/stress.c:359:1:
fatal error: opening dependency file tests/migration/stress.d: No such
file or directory
 }
 ^
compilation terminated.

...and if I fix that by manually creating the directory then
it fails to link:

  CC      tests/migration/stress.o
  LINK    tests/migration/stress
tests/migration/stress.o: In function `get_command_arg_str':
/home/petmay01/linaro/qemu-from-laptop/qemu/tests/migration/stress.c:107:
undefined reference to `g_strndup'
/home/petmay01/linaro/qemu-from-laptop/qemu/tests/migration/stress.c:109:
undefined reference to `g_strdup'
tests/migration/stress.o: In function `get_command_arg_ull':
/home/petmay01/linaro/qemu-from-laptop/qemu/tests/migration/stress.c:129:
undefined reference to `g_free'
/home/petmay01/linaro/qemu-from-laptop/qemu/tests/migration/stress.c:132:
undefined reference to `g_free'
tests/migration/stress.o: In function `stress':
/home/petmay01/linaro/qemu-from-laptop/qemu/tests/migration/stress.c:253:
undefined reference to `pthread_create'
collect2: error: ld returned 1 exit status
/home/petmay01/linaro/qemu-from-laptop/qemu/tests/Makefile.include:849:
recipe for target 'tests/migration/stress' failed

Is this dead code ?

thanks
-- PMM

