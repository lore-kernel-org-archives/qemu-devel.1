Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E49C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:43:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F3420760
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UldtFR9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F3420760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw4AI-0005FS-Mk
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 09:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jw49j-0004p9-1z
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 09:42:35 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jw49h-0006CT-2i
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 09:42:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id z13so7119919wrw.5
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 06:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=evWRxzCsBS6rugw++k5qjyYFRBbto4of/HvSlbDac1M=;
 b=UldtFR9vh/G/SYAy4g2raekzDwsmu6c4IQHnt2gPJUOolCDb9mF1VeWGZio8DR7Ixg
 8ATYsv07FvYthoTA8zMTIhm/16agyH57k6Fjj8G7wC8zrsducyfEl6LU07BWWvx5a4kC
 nShX0020poWr7qZipAOCdPTPAGHBRp2T6T+9/8PqQYUUGND7vN63z84W005iWfySfF/D
 NyA896q7dkSBMzZVEx9l2XFwn71k83/QZL2rW8EgosC1i5gYyWzNR6N2Pst22EDs7W7u
 3AM7LQkob1Y1o/BuT8x88uMBRVgfA30M9o4Y0v7VK5mRQV27u4hRqkBCT9DTDq+wKvxw
 wOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=evWRxzCsBS6rugw++k5qjyYFRBbto4of/HvSlbDac1M=;
 b=kd2RQVY2dm7/n3bRvMGPeuVx24F6JypuoU8VmKCRw9oMbpZdrj7K+31430+WIFLmNT
 lfJvCd5v8s5fMA7L1WrS/p/KPfrgZqEbEznxRq96KwC2Hcrm1tgmYIFyW6ctWTMR1rdf
 0XICm7gADUwQBA/Xdlm38A4z78zAsd/crd0rRTQHfI3l2sB+khsLdxjmwXQO/AXYwxsv
 hl6xkZv4cn/G0irps58Buarm3QPkvpPkuV0jyBMDl8I2F+w6oPIJUHL4g7r/OunQHxCX
 ptgJKFtuiqqRRYHPO+vWxSDuwvbNh0wdi2PYyiP/0zMrXxyOuEM9RS1t+KxjUjB05GzV
 qUzA==
X-Gm-Message-State: AOAM531f4mNCaq57EzJsurWS8tEt8JRzczx+jC+cheLi8ukjjJeJDo9l
 MxP7TiBUgju/NBybWbF4/S2YgA==
X-Google-Smtp-Source: ABdhPJyC6QBPO5enBnoW0vRfpcKpMOEBkqCFLQLJPnrNMI2K3Ra9RYjDLH6L5bIXBuPz3JudybSwyQ==
X-Received: by 2002:adf:fac8:: with SMTP id a8mr5146535wrs.368.1594906951373; 
 Thu, 16 Jul 2020 06:42:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f15sm8798589wrx.91.2020.07.16.06.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 06:42:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 733CE1FF7E;
 Thu, 16 Jul 2020 14:42:29 +0100 (BST)
References: <20200715204814.2630-1-robert.foley@linaro.org>
 <20200715204814.2630-3-robert.foley@linaro.org>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 2/2] python/qemu: Change ConsoleSocket to optionally
 drain socket.
In-reply-to: <20200715204814.2630-3-robert.foley@linaro.org>
Date: Thu, 16 Jul 2020 14:42:29 +0100
Message-ID: <875zanwp8a.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: peter.puhov@linaro.org, Cleber Rosa <crosa@redhat.com>, jsnow@redhat.com,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> The primary purpose of this change is to clean up
> machine.py's console_socket property to return a single type,
> a ConsoleSocket.
>
> ConsoleSocket now derives from a socket, which means that
> in the default case (of not draining), machine.py
> will see the same behavior as it did prior to ConsoleSocket.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  python/qemu/console_socket.py | 81 +++++++++++++++++++++--------------
>  python/qemu/machine.py        | 13 ++----
>  2 files changed, 54 insertions(+), 40 deletions(-)
>
> diff --git a/python/qemu/console_socket.py b/python/qemu/console_socket.py
> index 6a746c1dbf..475de5b101 100644
> --- a/python/qemu/console_socket.py
> +++ b/python/qemu/console_socket.py
> @@ -13,68 +13,76 @@ which can drain a socket and optionally dump the byte=
s to file.
>  # the COPYING file in the top-level directory.
>  #
>=20=20
> -import asyncore
>  import socket
>  import threading
>  from collections import deque
>  import time
>=20=20
>=20=20
> -class ConsoleSocket(asyncore.dispatcher):
> +class ConsoleSocket(socket.socket):
>      """
>      ConsoleSocket represents a socket attached to a char device.
>=20=20
> -    Drains the socket and places the bytes into an in memory buffer
> -    for later processing.
> +    Optionally (if drain=3D=3DTrue), drains the socket and places the by=
tes
> +    into an in memory buffer for later processing.
>=20=20
>      Optionally a file path can be passed in and we will also
>      dump the characters to this file for debugging purposes.
>      """
> -    def __init__(self, address, file=3DNone):
> +    def __init__(self, address, file=3DNone, drain=3DFalse):
>          self._recv_timeout_sec =3D 300
>          self._sleep_time =3D 0.5
>          self._buffer =3D deque()
> -        self._asyncore_thread =3D None
> -        self._sock =3D socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
> -        self._sock.connect(address)
> +        self._drain_thread =3D None
> +        socket.socket.__init__(self, socket.AF_UNIX, socket.SOCK_STREAM)
> +        self.connect(address)
> +        self._drain =3D drain

We end up with two variables that represent the fact we have draining
happening. Could we rationalise it into:

  if drain:
     self._drain_thread =3D self._thread_start()
  else
     self._drain_thread =3D None # if this is needed

And then tests for:

  if not self._drain:

become

  if self._drain_thread is None:

>          self._logfile =3D None
>          if file:
>              self._logfile =3D open(file, "w")
> -        asyncore.dispatcher.__init__(self, sock=3Dself._sock)
>          self._open =3D True
> -        self._thread_start()
> +        if drain:
> +            self._thread_start()
> +
> +    def _drain_fn(self):
> +        """Drains the socket and runs while the socket is open."""
> +        while self._open:
> +            try:
> +                self._drain_socket()
> +            except socket.timeout:
> +                # The socket is expected to timeout since we set a
> +                # short timeout to allow the thread to exit when
> +                # self._open is set to False.
> +                time.sleep(self._sleep_time)
>=20=20
>      def _thread_start(self):
> -        """Kick off a thread to wait on the asyncore.loop"""
> -        if self._asyncore_thread is not None:
> +        """Kick off a thread to drain the socket."""
> +        if self._drain_thread is not None:
>              return
> -        self._asyncore_thread =3D threading.Thread(target=3Dasyncore.loo=
p,
> -                                                 kwargs=3D{'timeout':1})
> -        self._asyncore_thread.daemon =3D True
> -        self._asyncore_thread.start()
> -
> -    def handle_close(self):
> -        """redirect close to base class"""
> -        # Call the base class close, but not self.close() since
> -        # handle_close() occurs in the context of the thread which
> -        # self.close() attempts to join.
> -        asyncore.dispatcher.close(self)
> +        # Configure socket to not block and timeout.
> +        # This allows our drain thread to not block
> +        # on recieve and exit smoothly.
> +        socket.socket.setblocking(self, 0)
> +        socket.socket.settimeout(self, 1)
> +        self._drain_thread =3D threading.Thread(target=3Dself._drain_fn)
> +        self._drain_thread.daemon =3D True
> +        self._drain_thread.start()
>=20=20
>      def close(self):
>          """Close the base object and wait for the thread to terminate"""
>          if self._open:
>              self._open =3D False
> -            asyncore.dispatcher.close(self)
> -            if self._asyncore_thread is not None:
> -                thread, self._asyncore_thread =3D self._asyncore_thread,=
 None
> +            if self._drain and self._drain_thread is not None:
> +                thread, self._drain_thread =3D self._drain_thread, None

Would self._drain ever not have self._drain_thread set?

>                  thread.join()
> +            socket.socket.close(self)
<snip>
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index 6769359766..62709d86e4 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -22,7 +22,6 @@ import logging
>  import os
>  import subprocess
>  import shutil
> -import socket

FYI minor patch conflict here with master

>  import tempfile
>  from typing import Optional, Type
>  from types import TracebackType
> @@ -591,12 +590,8 @@ class QEMUMachine:
>          Returns a socket connected to the console
>          """
>          if self._console_socket is None:
> -            if self._drain_console:
> -                self._console_socket =3D console_socket.ConsoleSocket(
> -                    self._console_address,
> -                    file=3Dself._console_log_path)
> -            else:
> -                self._console_socket =3D socket.socket(socket.AF_UNIX,
> -                                                     socket.SOCK_STREAM)
> -                self._console_socket.connect(self._console_address)
> +            self._console_socket =3D console_socket.ConsoleSocket(
> +                self._console_address,
> +                file=3Dself._console_log_path,
> +                drain=3Dself._drain_console)
>          return self._console_socket


--=20
Alex Benn=C3=A9e

