Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBB4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 13:01:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 969452068D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 13:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gzIp5iRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969452068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfk4D-0003Uj-TM
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 09:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jfk3H-0002z2-MA
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 09:00:27 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:39092)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jfk3G-0000Sr-ES
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 09:00:27 -0400
Received: by mail-lj1-x243.google.com with SMTP id o9so7999605ljj.6
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 06:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=M3MfbsXYtiGzjDMY/poZ7/sxpw3ghsTj+NaqVdVnc60=;
 b=gzIp5iRojtouJQqveBTM8gTkgG+wNXZcYwxN8x3ECNKj5ZPUM2Lx3wQx4S2xQFJc/W
 truMdC+j5+UhA0X6w7Q5KkdUpIE3sKfxu2u4Qlo1BRdyQ2g4PHHGs2C5/9KZCePK0c6k
 bA/P03Z3j0RvisdapoUO0RSwhOewmYvNGBE+NMKilvdYcpYrgYdXvOcHWKeT7C5EogzZ
 6Ss1sUp0rmLTBw/TDvrkk/mUzajgpzjlI+BwRNNuFJ9V+1+8mSZWHYz4jm6uq5La20xZ
 7gtDNiiFHq6QVy3Bbu+baAmmPiTlDTr6sIAX44jVKQQHdWnK3ZA5vgxuGIKH12nduXkE
 ScIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=M3MfbsXYtiGzjDMY/poZ7/sxpw3ghsTj+NaqVdVnc60=;
 b=k/4hlo0F66oyXxRwCQ4gTDRpLrXATFJEna/quxokZDPjgBYGcf8fwmRlsib/6rcjEX
 INkjS//FVQ/myPjtU2yGWI0V1dua6PeONUBe2lI5Q16Vwyl0SsnRE/+HBPwPaMPRfkur
 3F24hP2fwotRQqH8I0JKFgO9WN0/TKJVzBklw/vl2nwgD0q0sPWe6JIihI7kLFSCJrNx
 q7X+I8AwltLMJ/7L4z7jNpBXHiv2NPXLfVSYFhVHq/NPCCQ6DGV7pg4B7yYWza8Wu+j8
 LI1azncsi2Wsmgi78Uha2eKAUDJmi+5UqqKwWnK97F45fKyLk/cfUYqWpcu+hPoLoVDl
 SsTg==
X-Gm-Message-State: AOAM530vYp+x0/y7Hdu12uVuXrXs5Fp0+sBGFopbcXmAATJgSq0UM5pN
 Nyzun1cZmOEOBVJn6LBiVjXHnXOnYdMBiU9A1z8f8g==
X-Google-Smtp-Source: ABdhPJyB+I2rZhb0UAc2hJaYAjn61L08HBYDgxC++invjnAHFMrMsgVP14kS9nCuqu6tdGqkvtKUdmDb35bXrcKzkeM=
X-Received: by 2002:a2e:150f:: with SMTP id s15mr10267873ljd.102.1591016424167; 
 Mon, 01 Jun 2020 06:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200529203458.1038-1-robert.foley@linaro.org>
 <20200529203458.1038-12-robert.foley@linaro.org>
 <ac472970-1258-a82c-77da-edb8393c9a99@redhat.com>
In-Reply-To: <ac472970-1258-a82c-77da-edb8393c9a99@redhat.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 1 Jun 2020 09:00:22 -0400
Message-ID: <CAEyhzFue2fVExHJkR7D3E6OGCQ99HRDjGb29PWnOo3218LxQ-Q@mail.gmail.com>
Subject: Re: [PATCH v8 11/12] python/qemu: Add ConsoleSocket for optional use
 in QEMUMachine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Sun, 31 May 2020 at 07:22, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 5/29/20 10:34 PM, Robert Foley wrote:
> > We add the ConsoleSocket object, which has a socket interface
> > and which will consume all arriving characters on the
> > socket, placing them into an in memory buffer.
> > This will also provide those chars via recv() as
> > would a regular socket.
> > ConsoleSocket also has the option of dumping
> > the console bytes to a log file.
> >
> > We also give QEMUMachine the option of using ConsoleSocket
> > to drain and to use for logging console to a file.
> > By default QEMUMachine does not use ConsoleSocket.
> >
> > This is added in preparation for use by basevm.py in a later commit.
> > This is a workaround we found was needed for basevm.py since
> > there is a known issue where QEMU will hang waiting
> > for console characters to be consumed.
> >
> > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > Cc: Cleber Rosa <crosa@redhat.com>
> > Signed-off-by: Robert Foley <robert.foley@linaro.org>
> > Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> > Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > ---
> >  python/qemu/console_socket.py | 118 ++++++++++++++++++++++++++++++++++
> >  python/qemu/machine.py        |  23 +++++--
> >  2 files changed, 137 insertions(+), 4 deletions(-)
> >  create mode 100644 python/qemu/console_socket.py
> >
> > diff --git a/python/qemu/console_socket.py b/python/qemu/console_socket=
.py
> > new file mode 100644
> > index 0000000000..2fe1c20d64
> > --- /dev/null
> > +++ b/python/qemu/console_socket.py
> > @@ -0,0 +1,118 @@
> > +#!/usr/bin/env python3
> > +#
> > +# This python module implements a ConsoleSocket object which is
> > +# designed always drain the socket itself, and place
> > +# the bytes into a in memory buffer for later processing.
> > +#
> > +# Optionally a file path can be passed in and we will also
> > +# dump the characters to this file for debug.
> > +#
> > +# Copyright 2020 Linaro
> > +#
> > +# Authors:
> > +#  Robert Foley <robert.foley@linaro.org>
> > +#
> > +# This code is licensed under the GPL version 2 or later.  See
> > +# the COPYING file in the top-level directory.
> > +#
> > +import asyncore
> > +import socket
> > +import threading
> > +import io
> > +import os
> > +import sys
> > +from collections import deque
> > +import time
> > +import traceback
> > +
> > +class ConsoleSocket(asyncore.dispatcher):
> > +
> > +    def __init__(self, address, file=3DNone):
> > +        self._recv_timeout_sec =3D 300
> > +        self._buffer =3D deque()
> > +        self._asyncore_thread =3D None
> > +        self._sock =3D socket.socket(socket.AF_UNIX, socket.SOCK_STREA=
M)
> > +        self._sock.connect(address)
> > +        self._logfile =3D None
> > +        if file:
> > +            self._logfile =3D open(file, "w")
> > +        asyncore.dispatcher.__init__(self, sock=3Dself._sock)
> > +        self._thread_start()
> > +        self._open =3D True
>
> Please set _open before starting the thread (invert last 2 lines).
>
> > +
> > +    def _thread_start(self):
> > +        """Kick off a thread to wait on the asyncore.loop"""
> > +        if self._asyncore_thread is not None:
> > +            return
> > +        self._asyncore_thread =3D threading.Thread(target=3Dasyncore.l=
oop,
> > +                                                 kwargs=3D{'timeout':1=
})
> > +        self._asyncore_thread.daemon =3D True
> > +        self._asyncore_thread.start()
> > +
> > +    def handle_close(self):
> > +        """redirect close to base class"""
> > +        # Call the base class close, but not self.close() since
> > +        # handle_close() occurs in the context of the thread which
> > +        # self.close() attempts to join.
> > +        asyncore.dispatcher.close(self)
> > +
> > +    def close(self):
> > +        """Close the base object and wait for the thread to terminate"=
""
> > +        if self._open:
> > +            self._open =3D False
> > +            asyncore.dispatcher.close(self)
> > +            if self._asyncore_thread is not None:
> > +                thread, self._asyncore_thread =3D self._asyncore_threa=
d, None
> > +                thread.join()
> > +            if self._logfile:
> > +                self._logfile.close()
> > +                self._logfile =3D None
> > +
> > +    def handle_read(self):
> > +        """process arriving characters into in memory _buffer"""
> > +        try:
> > +            data =3D asyncore.dispatcher.recv(self, 1)
> > +            # latin1 is needed since there are some chars
> > +            # we are receiving that cannot be encoded to utf-8
> > +            # such as 0xe2, 0x80, 0xA6.
> > +            string =3D data.decode("latin1")
> > +        except:
> > +            print("Exception seen.")
> > +            traceback.print_exc()
> > +            return
> > +        if self._logfile:
> > +            self._logfile.write("{}".format(string))
> > +            self._logfile.flush()
> > +        for c in string:
> > +            self._buffer.append(c)
>
>            self._buffer.extend(string) ?
>
> > +
> > +    def recv(self, n=3D1):
>
> Please make a sleep_delay_s argument:
>
>        def recv(self, n=3D1, sleep_delay_s=3D0.1):
>
> > +        """Return chars from in memory buffer"""
> > +        start_time =3D time.time()
> > +        while len(self._buffer) < n:
> > +            time.sleep(0.1)
>
>                time.sleep(sleep_delay_s)
>
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
> > +    def set_blocking(self):
> > +        """Maintain compatibility with socket API"""
> > +        pass
> > +
> > +    def settimeout(self, seconds):
> > +        """Set current timeout on recv"""
> > +        self._recv_timeout_sec =3D seconds
> > +
> > +class ByteBuffer(deque):
> > +    """Simple in memory buffer with read/write interface"""
> > +    def write(self, bytes):
> > +        for i in bytes:
> > +            self.append(i)
>
>            self.extend(bytes) ?
>
> However 'bytes' seems a reserved keyword.

These are all good points.  However, I noticed that this class is
no longer used in this patch, so I will plan to remove it.

I will apply these and the other suggestions above too in the next version.

Thanks,
-Rob


>
> > +    def read(self, n):
> > +        return ''.join([self.popleft() for i in range(n)])
> > diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> > index b9a98e2c86..ee9c337f55 100644
> > --- a/python/qemu/machine.py
> > +++ b/python/qemu/machine.py
> > @@ -24,6 +24,7 @@ import subprocess
> >  import shutil
> >  import socket
> >  import tempfile
> > +from qemu.console_socket import ConsoleSocket
> >
> >  from . import qmp
> >
> > @@ -71,7 +72,8 @@ class QEMUMachine(object):
> >
> >      def __init__(self, binary, args=3DNone, wrapper=3DNone, name=3DNon=
e,
> >                   test_dir=3D"/var/tmp", monitor_address=3DNone,
> > -                 socket_scm_helper=3DNone, sock_dir=3DNone):
> > +                 socket_scm_helper=3DNone, sock_dir=3DNone,
> > +                 drain_console=3DFalse, console_log=3DNone):
> >          '''
> >          Initialize a QEMUMachine
> >
> > @@ -82,6 +84,9 @@ class QEMUMachine(object):
> >          @param test_dir: where to create socket and log file
> >          @param monitor_address: address for QMP monitor
> >          @param socket_scm_helper: helper program, required for send_fd=
_scm()
> > +        @param sock_dir: where to create socket (overrides test_dir fo=
r sock)
> > +        @param console_log: (optional) path to console log file
> > +        @param drain_console: (optional) True to drain console socket =
to buffer
> >          @note: Qemu process is not started until launch() is used.
> >          '''
> >          if args is None:
> > @@ -118,6 +123,12 @@ class QEMUMachine(object):
> >          self._console_address =3D None
> >          self._console_socket =3D None
> >          self._remove_files =3D []
> > +        self._console_log_path =3D console_log
> > +        if self._console_log_path:
> > +            # In order to log the console, buffering needs to be enabl=
ed.
> > +            self._drain_console =3D True
> > +        else:
> > +            self._drain_console =3D drain_console
> >
> >          # just in case logging wasn't configured by the main script:
> >          logging.basicConfig()
> > @@ -568,7 +579,11 @@ class QEMUMachine(object):
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
> > +            else:
> > +                self._console_socket =3D socket.socket(socket.AF_UNIX,
> > +                                                     socket.SOCK_STREA=
M)
> > +                self._console_socket.connect(self._console_address)
> >          return self._console_socket
> >
>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>

