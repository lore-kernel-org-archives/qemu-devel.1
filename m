Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A98DC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 16:16:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DEA02075F
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 16:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iN8wlGx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEA02075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juIAa-0006R8-8Q
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 12:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1juI9y-00061B-Rz
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 12:15:30 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233]:36077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1juI9w-00013K-U1
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 12:15:30 -0400
Received: by mail-lj1-x233.google.com with SMTP id d17so9909151ljl.3
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 09:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6rti03L29RLG/mXt0l72p1uDXHfD9d/yrkeOOVJRm2o=;
 b=iN8wlGx6J5hmYbtsb2xBEfDIgtm28ivQmnzKqw1t3EXANKthiusiASM7AdmnWxSFWj
 91Y6iCmekLwG4ifOU0lCxZMPziCheQNvoiB1ah6/4yz6AXe/1qCLezcOMTULqO9O8HCz
 5OaZBlIQId24pK6QrlWlmWeq/wF7M86rSvNpRKIDy2lGitd3uHSKnSZzUB95stCuVZlm
 gL1ghtq8eDi51yeQBel3p/1fN1E0LuoKW7StRstfpbSAobkiW8+HJFolxQqu2AdYegEr
 HWQyEzArYtdPk+UaFtj0gD7XqyrXODuQomjpc1u+XlH5nDhDrxHmJ4WL0QPac3mLhety
 HU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6rti03L29RLG/mXt0l72p1uDXHfD9d/yrkeOOVJRm2o=;
 b=F+OvgUFiTshmlKjMUQ/ipIrjFh06OAuQ+rQUjbXDAI3/WJNu46GtlXx4QCHIpOq0fy
 QGMRQ/vmSRMsMjBBqXzYyXdl+BRcPWMKMZ8iHiCc35mvV5ejaG+KQ9e7iD9ktdxuaJxT
 2ctNosqJFCukdLqMOy96fDJtqQ0/dhj+hGiIt4PNUAse+lMkvZ3tKnhavWzB/1VkmkXA
 fiG6gWj8LZuJfQd14H8G4hQReNNP02+PZLYbhj0srREs9VZfLvwFNWIbyGd46+UY5Noy
 fPO7V6TxUthX39sKR2tOoQGEtqBZ3G6ieLASoxlSl2cBZvF4en/rE1TT5Prdn8kklpxo
 QibQ==
X-Gm-Message-State: AOAM533DPT4ToSeLc0ph+O9MgQNEEE9hWBxVE1VG93v011e1Y439kwCh
 2/QSPNyEvC9MwMZQJqVd9a1BFX43j0e2Uf1ourA0pQ==
X-Google-Smtp-Source: ABdhPJzmY85eOizwnLvxEajWY0C967vaEt4RX95A8Vz6NHLyqApCLiwTqDs2huDnhb2VZNiw3hb3mFmozOAdCi+zSEA=
X-Received: by 2002:a2e:9855:: with SMTP id e21mr40742115ljj.424.1594484126445; 
 Sat, 11 Jul 2020 09:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200707070858.6622-1-alex.bennee@linaro.org>
 <20200707070858.6622-11-alex.bennee@linaro.org>
 <fa8ee177-3a53-cde0-a8f1-8b0e8eba678f@redhat.com>
In-Reply-To: <fa8ee177-3a53-cde0-a8f1-8b0e8eba678f@redhat.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Sat, 11 Jul 2020 12:15:38 -0400
Message-ID: <CAEyhzFsYb4KvDaeMGwjocSjU0QO957Eg_TQbi0oEr1c=rE5vwQ@mail.gmail.com>
Subject: Re: [PULL 10/41] python/qemu: Add ConsoleSocket for optional use in
 QEMUMachine
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x233.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,
Thanks for the detailed feedback!  I will look at making these changes.

On Fri, 10 Jul 2020 at 15:20, John Snow <jsnow@redhat.com> wrote:
>
>
>
> On 7/7/20 3:08 AM, Alex Benn=C3=A9e wrote:
> > From: Robert Foley <robert.foley@linaro.org>
> >
>
<snip>
> > +    def recv(self, n=3D1, sleep_delay_s=3D0.1):
> > +        """Return chars from in memory buffer"""
> > +        start_time =3D time.time()
> > +        while len(self._buffer) < n:
> > +            time.sleep(sleep_delay_s)
> > +            elapsed_sec =3D time.time() - start_time
> > +            if elapsed_sec > self._recv_timeout_sec:
> > +                raise socket.timeout
> > +        chars =3D ''.join([self._buffer.popleft() for i in range(n)])
> > +        # We choose to use latin1 to remain consistent with
> > +        # handle_read() and give back the same data as the user would
> > +        # receive if they were reading directly from the
> > +        # socket w/o our intervention.
> > +        return chars.encode("latin1")
> > +
>
> console_socket.py:89:4: W0221: Parameters differ from overridden 'recv'
> method (arguments-differ)
>
> Seems pretty different from the asyncore.dispatcher recv method, is that
> intentional?

The intention is that the API be the same as asyncore.dispatcher recv.
The sleep_delay_s can be removed, and n is the same as buffer_size in
asyncore.dispatcher recv.  Will plan to rename n -> buffer_size.

> https://github.com/python/cpython/blob/master/Lib/asyncore.py
>
<snip>
> >      def __enter__(self):
> >          return self
> > @@ -580,7 +591,11 @@ class QEMUMachine:
> >          Returns a socket connected to the console
> >          """
> >          if self._console_socket is None:
> > -            self._console_socket =3D socket.socket(socket.AF_UNIX,
> > -                                                 socket.SOCK_STREAM)
> > -            self._console_socket.connect(self._console_address)
> > +            if self._drain_console:
> > +                self._console_socket =3D ConsoleSocket(self._console_a=
ddress,
> > +                                                    file=3Dself._conso=
le_log_path)
>
> Needs one more space, but the line is already too long as-is.
>
> > +            else:
> > +                self._console_socket =3D socket.socket(socket.AF_UNIX,
> > +                                                     socket.SOCK_STREA=
M)
> > +                self._console_socket.connect(self._console_address)
> >          return self._console_socket
> >
>
> This makes the typing for _console_socket really tough ... but
> technically not a regression as the mypy code isn't merged yet.

From the comment on mypy, I understand that we need to return a
constant type?

One option to provide a constant type is to simply always return
ConsoleSocket here.

A few changes would be needed inside of ConsoleSocket,
but essentially ConsoleSocket would handle the detail
of draining the console (or not), and thus eliminate this
if/else above reducing it to something like this:

self._console_socket =3D ConsoleSocket(self._console_address,
                                     file=3Dself._console_log_path,
                                     drain=3Dself._drain_console)

How does this sound?

Thanks & Regards,
-Rob

>
> --js
>

