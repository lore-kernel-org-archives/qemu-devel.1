Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399D0C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 17:10:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0571E2070E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 17:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hHnFtnxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0571E2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw7PE-00039L-82
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 13:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jw7Od-0002gO-Bb
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 13:10:11 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:35451)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jw7Ob-0006vS-9b
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 13:10:10 -0400
Received: by mail-lf1-x143.google.com with SMTP id u12so4096236lff.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 10:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YqcsYynJBfMHZD5+yJDGwgPi48fPOpvnZ5f13VNmHIE=;
 b=hHnFtnxKCYT+3Mpgf/bW7115RUSr0lQx606S4ld0y8FZZyQ/o5b4T0F9Dh5ceMS30L
 W7/09rEizGPiCjqZLlSsT5jbA1uWaqEbXv76cStEgjKfEgrbnw8XsLho3Xb7vEQNcfaf
 eGLv7l64fPUyPBpoGPbe/+qm1X2D00aTOECHsAIUEVrjQX6cf7SPhpMuqlSvUPaoBxpo
 MpRO4V6mYOjyXsPOGq+tQVmTkX6Z6tmiaKJvvdLUwoycv8E217RPIcfdtwX+S+FVBkZa
 5xB2G0EVdcBDYq4feYmxKFpXFmPY7BcgA4n9+4i5fkDMxBy9BUYmQcad2qX7uC3KubGa
 HZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YqcsYynJBfMHZD5+yJDGwgPi48fPOpvnZ5f13VNmHIE=;
 b=tT5Ffa31WXVFtKZCAkTIlkTS3Us0Ec32nc54a66RyIvBCp0vt/mPtDOl6F6a4cgETW
 XbGX1MG7d7R1u5AKV6Dg0PbdFuzx0oXhRfbroNzrxErA13Mszjz86f+Ua8GhmznRkzt+
 plwXiNfPqeO1yC3/sj6ywb/97ob9FGtcfT14+p0bdhpB0WS2dh5Qpre/nhewUTbMgm8M
 2Wwum1Lk3Qy26cisYKLQq/SAFVbGr+EwxPOA2xzS0bXBlI7Xtu10l67HRq5ZcTh1DfSW
 wcu1Qzqtf0FIZK6Qz7cgJgExiFUwXWxa1sc7J+HkxK8QIX7T3TgfERk8+fPwrUDIMc8i
 W0Gg==
X-Gm-Message-State: AOAM533TxRLZNGY3JfxyqyH28ablYCd6ZEDTBz5/vUZ6zY2dgiHGjqrc
 4Kon0cub7QNc7wOg4MWAK+1ZZYq3D7RsjlK0WNpledCaH8Ib8A==
X-Google-Smtp-Source: ABdhPJzxcOb8x0Eh6cCw8DN3AXmkg/FWYSBE1dmN+rDNux1c674uOm9TyKqnFZ3RWaXXb6H0asNlcqWDs4YHvgR/BR0=
X-Received: by 2002:a2e:974f:: with SMTP id f15mr2487615ljj.193.1594919100531; 
 Thu, 16 Jul 2020 10:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200715204814.2630-1-robert.foley@linaro.org>
 <20200715204814.2630-3-robert.foley@linaro.org> <875zanwp8a.fsf@linaro.org>
In-Reply-To: <875zanwp8a.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Thu, 16 Jul 2020 13:05:13 -0400
Message-ID: <CAEyhzFvmBqQUPoXu=1sYopBQ2JC9YaS8bqsztRVtrwn6M6MLfw@mail.gmail.com>
Subject: Re: [PATCH 2/2] python/qemu: Change ConsoleSocket to optionally drain
 socket.
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=robert.foley@linaro.org; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Puhov <peter.puhov@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jul 2020 at 09:42, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
<snip>
> > +        self._drain_thread =3D None
> > +        socket.socket.__init__(self, socket.AF_UNIX, socket.SOCK_STREA=
M)
> > +        self.connect(address)
> > +        self._drain =3D drain
>
> We end up with two variables that represent the fact we have draining
> happening. Could we rationalise it into:
>
>   if drain:
>      self._drain_thread =3D self._thread_start()
>   else
>      self._drain_thread =3D None # if this is needed
>
> And then tests for:
>
>   if not self._drain:
>
> become
>
>   if self._drain_thread is None:

Good point, this is simpler.  Will update.

<snip>
> > +            if self._drain and self._drain_thread is not None:
> > +                thread, self._drain_thread =3D self._drain_thread, Non=
e
> Would self._drain ever not have self._drain_thread set?

No, I believe that if drain is set, it results in _drain_thread also being =
set.
This will be cleaned up once we drop the _drain.

>
> >                  thread.join()
> > +            socket.socket.close(self)
> <snip>
> > diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> > index 6769359766..62709d86e4 100644
> > --- a/python/qemu/machine.py
> > +++ b/python/qemu/machine.py
> > @@ -22,7 +22,6 @@ import logging
> >  import os
> >  import subprocess
> >  import shutil
> > -import socket
>
> FYI minor patch conflict here with master

OK, will rebase and fix this conflict.

Thanks & Regards,
-Rob
>
> >  import tempfile
> >  from typing import Optional, Type
> >  from types import TracebackType
> > @@ -591,12 +590,8 @@ class QEMUMachine:
> >          Returns a socket connected to the console
> >          """
> >          if self._console_socket is None:
> > -            if self._drain_console:
> > -                self._console_socket =3D console_socket.ConsoleSocket(
> > -                    self._console_address,
> > -                    file=3Dself._console_log_path)
> > -            else:
> > -                self._console_socket =3D socket.socket(socket.AF_UNIX,
> > -                                                     socket.SOCK_STREA=
M)
> > -                self._console_socket.connect(self._console_address)
> > +            self._console_socket =3D console_socket.ConsoleSocket(
> > +                self._console_address,
> > +                file=3Dself._console_log_path,
> > +                drain=3Dself._drain_console)
> >          return self._console_socket
>
>
> --
> Alex Benn=C3=A9e

