Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7431C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 22:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B41B20720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 22:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qb0iIGNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B41B20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0C0w-00023G-PJ
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 17:22:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1j0BzM-00019M-Sn
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 17:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1j0BzL-0000Gt-Ah
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 17:20:40 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:45613)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1j0BzL-0000B8-1H
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 17:20:39 -0500
Received: by mail-lj1-x244.google.com with SMTP id f25so904791ljg.12
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 14:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=eI8qM9AM5BA2CQDWBWStTW/GjA81uhrYL6kf/5O2hWY=;
 b=qb0iIGNWNoSXaGOyDm0ErXYuOnHxG9ZFZMduRRn/2Eb+K6GnkHWovW3waeeSVAsMQc
 G/gGsKjUKYnMqsdwlAAFWZOXy4mgv8f20x7cj9iZsK8EeHUoRJGFxGIPQW0qCS7aemDJ
 4IPMMhlpq7FZko9yZw0Hy8Dz9wkwXvt4rv9vNyzUFytJJX+BTBWfMhDTgyYqIOMrJgA5
 EYuqFhvWwayy4lM93I5fHyn8bxRdvp/54/PxsGgqEGXgqZvUyogF/hF6Mt7ediQpDdy3
 SWVnFdDt2DoZ218QONsMgNliNE41aXED5lemhKvvBrkCFzmlR84R6vXFcF8ZBL5leSAT
 WoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eI8qM9AM5BA2CQDWBWStTW/GjA81uhrYL6kf/5O2hWY=;
 b=DVDN61i2x0hJ0IJ6onyiur6DhTTPoB6KViv3rzQphYLV2Y8o6mgItIdM4WNLWjoxy+
 W0LlQj8HPekE9+ttPJ5kCY/CVVYWhsMxBA+crPGkiLONQrCtxQJF+rLpsNxcunKaIbBM
 k463u/+rECJa4E2GSHFf7QoflvXXOix62GOy3FHVgXkdR+g8yge2sCU8YKVwDM3i7Ga6
 R7UtS0d07JGJVPcb9Lh+20xy+CZOT0NRx/4UsB02FMhsYnLUHxkaZFjCFmYL7Vk2rasB
 JqW4e+iQ6Fm6zCBSWBBtPGnrOrjuMzTuZrleWcyx9THqTkXooNu/+GPpK9c3ho9IRrRU
 iiCA==
X-Gm-Message-State: APjAAAULM/VadEaKgSLzqf7w1m5W5vWw06qTnJLDJ6xuYaN5/2bj3kKn
 OmYVnLlWgCAXD1k3UR/jAmwKiqWbmW6PaSqiF/ahXw==
X-Google-Smtp-Source: APXvYqwj1psIQYeOkTqRcfR7y4ZdKYCIDU2rGpLctCk/YLGb1J7QVySzLdHHmlYUIyGpY6nw301VLdB1LqvbPmbMa1M=
X-Received: by 2002:a05:651c:120d:: with SMTP id
 i13mr785984lja.173.1581114036899; 
 Fri, 07 Feb 2020 14:20:36 -0800 (PST)
MIME-Version: 1.0
References: <20200205212920.467-1-robert.foley@linaro.org>
 <20200205212920.467-7-robert.foley@linaro.org>
 <874kw27248.fsf@linaro.org>
In-Reply-To: <874kw27248.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Fri, 7 Feb 2020 17:20:00 -0500
Message-ID: <CAEyhzFs6+Lssj8a5QckmDaqi41E8_WemueSYuZrqtr=tVbYOjA@mail.gmail.com>
Subject: Re: [PATCH v1 06/14] tests/vm: Add logging of console to file.
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: fam@euphon.net, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 at 12:12, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Robert Foley <robert.foley@linaro.org> writes:
>
> > This adds logging of the char device used by the console
> > to a file.  The basevm.py then uses this file to read
> > chars from the console.
> > One reason to add this is to aid with debugging.
>
> I can certainly see an argument for saving the install log.
>
> > But another is because there is an issue where the QEMU
> > might hang if the characters from the character device
> > are not consumed by the script.
>
> I'm a little confused by this. Outputting to a file and then parsing the
> file seems a bit more janky than injesting the output in the script and
> then logging it.
>
> Is this to work around the hang because the socket buffers fill up and
> aren't drained?

Yes, exactly.  This is to work around the hang we are seeing when we
try to use these new VMs.

> > +    console_logfile =3D "console.log"
>
> We should probably dump the log somewhere other than cwd. Given we cache
> stuff in ~/.cache/qemu-vm maybe something of the form:
>
>   ~/.cache/qemu-vm/ubuntu.aarch64.install.log
>
> ?

Good point, we will locate the log file there.

> > +            elapsed_sec =3D time.time() - start_time
> > +            if elapsed_sec > self._console_timeout_sec:
> > +                raise ConsoleTimeoutException
> > +        return data.encode('latin1')
> > +
>
> Is latin1 really the best choice here? I would expect things to be utf-8 =
clean.

We were trying to follow the existing code, which is using latin1.
For example, console_wait() or console_consume() are using latin1.
However on further inspection we see that console_send() is using utf-8.
We will look at changing these latin1 cases to be utf-8.
I also found a case in get_qemu_version() we will change to utf-8 also.

> > +
> > +    def join(self, timeout=3DNone):
> > +        """Time to destroy the thread.
> > +           Clear the event to stop the thread, and wait for
> > +           it to complete."""
> > +        self.alive.clear()
> > +        threading.Thread.join(self, timeout)
> > +        self.log_file.close()
>
> I'm note sure about this - introducing threading into Python seems very
> un-pythonic. I wonder if the python experts have any view on a better
> way to achieve what we want which I think is:
>
>   - a buffer that properly drains output from QEMU
>   - which can optionally be serialised onto disk for logging
>
> What else are we trying to achieve here?

I think that covers what we are trying to achieve here.
The logging to file is a nice to have, but
the draining of the output from QEMU is the main objective here.
We will do a bit more research here to seek out a cleaner way to achieve th=
is,
but certainly we would also be interested if any python experts have a
view on a cleaner approach.

Thanks & Regards,
-Rob
>
> --
> Alex Benn=C3=A9e

