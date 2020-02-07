Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E48C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45105214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a1tVXaro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45105214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j07C2-000118-F4
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 12:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j07BN-0000IL-H2
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:12:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j07BL-0001N5-Sp
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:12:45 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34115)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j07BL-0001Lr-L0
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:12:43 -0500
Received: by mail-wm1-x341.google.com with SMTP id s144so3590804wme.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 09:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=JG8ScU+qIaNs6EifqhSzYi39o+XePyR5mVHqWQCwc+w=;
 b=a1tVXaroRlaJsxy6GCdif3xkHIIz/Nrtxn/MsoRFv9/WCnS/4y5L1HWv71b80mj/Ad
 i2KZ8Ig7WR5eZh6QpC0308gdFd/MfsjjvY6wolVl0yW27vJWGQzeGsDmkPeNOUm7dQoV
 UMrDKcizSw78gHDLOpp0E6bJ7D6L3a/eYEcxowYRpxjQHMUnENDD+MskWBGeGMyIm1Yn
 LiOz1mE+7smKMEQYHHxaJiLXsWEXTElH5qOyip2IhZC0Hd9/660+rhz7/Q544Mw+xOaf
 W+xW3SROdBu8KyxXVPt0/T/8YHxn4/tSyUNLhOaUy8Tz4n7XqtAKw4r0D0dtHr0ai8iL
 rvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=JG8ScU+qIaNs6EifqhSzYi39o+XePyR5mVHqWQCwc+w=;
 b=ZxNrR8Xdi9yzg6kxJW8/G04Z4Mw80maEuMA7uqTiqzc+vUuiaXOkadMW71PRvZHXwU
 VOA3BBUNmsr0WJAjfJpudboUrlulKWsJvugeq2KEUdmtZkFpudFylt/hnP/6VustOBf1
 yYReRugAUgVFlbqbPMErRQYBba0sxu79x3R3niUNbjrA8ohRLZcpi2uMChfUuwxcEYu6
 gJQiR8o2FP47NTnnUHUOMBNwE9X6FSFwXMdBFYdEbWIIVE/OO4vzvzcREMFtzb8byDFy
 isQCdLH0iynUBI+exgwAP/VcGkgl0wPI7hRPyek27X/iaHOvXAvA0ukpaSFiJ6m+V6Em
 lNHA==
X-Gm-Message-State: APjAAAUrVR4XfVxqw77wG8CH20QFtX1GyqAJlC5zzd54ybMNoRjdl6kI
 brWOgG/8PM2phSesjpZTqX3CwA==
X-Google-Smtp-Source: APXvYqz+FXMrg8fk2HJoEH79dQ9xBLFLoNVknoz9rRR+iiQiZP2DPOKplmNGrWpYqT1j/iIX4EIvSA==
X-Received: by 2002:a1c:7718:: with SMTP id t24mr5281709wmi.119.1581095562284; 
 Fri, 07 Feb 2020 09:12:42 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u4sm4072323wrt.37.2020.02.07.09.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 09:12:40 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DC5A91FF87;
 Fri,  7 Feb 2020 17:12:39 +0000 (GMT)
References: <20200205212920.467-1-robert.foley@linaro.org>
 <20200205212920.467-7-robert.foley@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v1 06/14] tests/vm: Add logging of console to file.
In-reply-to: <20200205212920.467-7-robert.foley@linaro.org>
Date: Fri, 07 Feb 2020 17:12:39 +0000
Message-ID: <874kw27248.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: fam@euphon.net, peter.puhov@linaro.org, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> This adds logging of the char device used by the console
> to a file.  The basevm.py then uses this file to read
> chars from the console.
> One reason to add this is to aid with debugging.

I can certainly see an argument for saving the install log.

> But another is because there is an issue where the QEMU
> might hang if the characters from the character device
> are not consumed by the script.

I'm a little confused by this. Outputting to a file and then parsing the
file seems a bit more janky than injesting the output in the script and
then logging it.

Is this to work around the hang because the socket buffers fill up and
aren't drained?

>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  tests/vm/basevm.py        | 48 ++++++++++++++++++++++---
>  tests/vm/socket_thread.py | 73 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 116 insertions(+), 5 deletions(-)
>  create mode 100644 tests/vm/socket_thread.py
>
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index a926211da8..87a484c55c 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -31,12 +31,17 @@ import tempfile
>  import shutil
>  import multiprocessing
>  import traceback
> +from socket_thread import SocketThread
>=20=20
>  SSH_KEY =3D open(os.path.join(os.path.dirname(__file__),
>                 "..", "keys", "id_rsa")).read()
>  SSH_PUB_KEY =3D open(os.path.join(os.path.dirname(__file__),
>                     "..", "keys", "id_rsa.pub")).read()
>=20=20
> +class ConsoleTimeoutException(Exception):
> +    """Raise this exception when read from console times out."""
> +    pass
> +
>  class BaseVM(object):
>      GUEST_USER =3D "qemu"
>      GUEST_PASS =3D "qemupass"
> @@ -59,12 +64,18 @@ class BaseVM(object):
>      poweroff =3D "poweroff"
>      # enable IPv6 networking
>      ipv6 =3D True
> +    # This is the timeout on the wait for console bytes.
> +    socket_timeout =3D 120
>      # Scale up some timeouts under TCG.
>      # 4 is arbitrary, but greater than 2,
>      # since we found we need to wait more than twice as long.
>      tcg_ssh_timeout_multiplier =3D 4
> +    console_logfile =3D "console.log"

We should probably dump the log somewhere other than cwd. Given we cache
stuff in ~/.cache/qemu-vm maybe something of the form:

  ~/.cache/qemu-vm/ubuntu.aarch64.install.log

?

>      def __init__(self, debug=3DFalse, vcpus=3DNone):
>          self._guest =3D None
> +        self._console_fd =3D None
> +        self._socket_thread =3D None
> +        self._console_timeout_sec =3D self.socket_timeout
>          self._tmpdir =3D os.path.realpath(tempfile.mkdtemp(prefix=3D"vm-=
test-",
>                                                           suffix=3D".tmp",
>                                                           dir=3D"."))
> @@ -179,6 +190,15 @@ class BaseVM(object):
>                              "-device",
>                              "virtio-blk,drive=3D%s,serial=3D%s,bootindex=
=3D1" % (name, name)]
>=20=20
> +    def init_console(self, socket):
> +        """Init the thread to dump console to a file.
> +           Also open the file descriptor we will use to
> +           read from the console."""
> +        self._socket_thread =3D SocketThread(socket, self.console_logfil=
e)
> +        self._console_fd =3D open(self.console_logfile, "r")
> +        self._socket_thread.start()
> +        print("console logfile is: {}".format(self.console_logfile))
> +
>      def boot(self, img, extra_args=3D[]):
>          args =3D self._args + [
>              "-device", "VGA",
> @@ -201,6 +221,7 @@ class BaseVM(object):
>              raise
>          atexit.register(self.shutdown)
>          self._guest =3D guest
> +        self.init_console(guest.console_socket)
>          usernet_info =3D guest.qmp("human-monitor-command",
>                                   command_line=3D"info usernet")
>          self.ssh_port =3D None
> @@ -212,9 +233,10 @@ class BaseVM(object):
>              raise Exception("Cannot find ssh port from 'info usernet':\n=
%s" % \
>                              usernet_info)
>=20=20
> -    def console_init(self, timeout =3D 120):
> -        vm =3D self._guest
> -        vm.console_socket.settimeout(timeout)
> +    def console_init(self, timeout =3D None):
> +        if timeout =3D=3D None:
> +            timeout =3D self.socket_timeout
> +        self._console_timeout_sec =3D timeout
>=20=20
>      def console_log(self, text):
>          for line in re.split("[\r\n]", text):
> @@ -230,13 +252,27 @@ class BaseVM(object):
>              # log console line
>              sys.stderr.write("con recv: %s\n" % line)
>=20=20
> +    def console_recv(self, n):
> +        """Read n chars from the console_logfile being dumped to
> +           by the socket thread we created earlier."""
> +        start_time =3D time.time()
> +        while True:
> +            data =3D self._console_fd.read(1)
> +            if data !=3D "":
> +                break
> +            time.sleep(0.1)
> +            elapsed_sec =3D time.time() - start_time
> +            if elapsed_sec > self._console_timeout_sec:
> +                raise ConsoleTimeoutException
> +        return data.encode('latin1')
> +

Is latin1 really the best choice here? I would expect things to be utf-8 cl=
ean.

>      def console_wait(self, expect, expectalt =3D None):
>          vm =3D self._guest
>          output =3D ""
>          while True:
>              try:
> -                chars =3D vm.console_socket.recv(1)
> -            except socket.timeout:
> +                chars =3D self.console_recv(1)
> +            except ConsoleTimeoutException:
>                  sys.stderr.write("console: *** read timeout ***\n")
>                  sys.stderr.write("console: waiting for: '%s'\n" % expect)
>                  if not expectalt is None:
> @@ -335,6 +371,8 @@ class BaseVM(object):
>              raise Exception("Timeout while waiting for guest ssh")
>=20=20
>      def shutdown(self):
> +        self._socket_thread.join()
> +        self._console_fd.close()
>          self._guest.shutdown()
>      def wait(self):
>          self._guest.wait()
> diff --git a/tests/vm/socket_thread.py b/tests/vm/socket_thread.py
> new file mode 100644
> index 0000000000..6160e9163d
> --- /dev/null
> +++ b/tests/vm/socket_thread.py
> @@ -0,0 +1,73 @@
> +#!/usr/bin/env python
> +#
> +# This python module defines a thread object which
> +# reads from a socket and dumps it to a file.
> +#
> +# The main use case is for reading QEMU console char dev and
> +# dumping them to a file either for debugging or for
> +# parsing by QEMU itself.
> +#
> +# Copyright 2020 Linaro
> +#
> +# Authors:
> +#  Robert Foley <robert.foley@linaro.org>
> +#
> +# This code is licensed under the GPL version 2 or later.  See
> +# the COPYING file in the top-level directory.
> +#
> +import sys
> +import re
> +import threading
> +import time
> +import traceback
> +import gettext
> +
> +class SocketThread(threading.Thread):
> +    """ Implements the standard threading.Thread API.(start, join, etc.).
> +        dumps all characters received on socket into a file.
> +    """
> +    def __init__(self, socket, filename):
> +        super(SocketThread, self).__init__()
> +        self.alive =3D threading.Event()
> +        self.alive.set()
> +        self.socket =3D socket
> +        self.log_file =3D open(filename, "w")
> +        self.debug =3D True
> +
> +    def receive(self):
> +        """Until the user calls join, we will read chars from
> +           the socket and dump them as is to the file."""
> +        self.socket.setblocking(0)
> +        self.socket.settimeout(1.0)
> +        while self.alive.isSet():
> +            try:
> +                chars =3D self.socket.recv(1)
> +            except:
> +                continue
> +            output =3D chars.decode("latin1")
> +            self.log_file.write("{}".format(output))
> +            # Flush the file since we need the characters to be
> +            # always up to date in case someone is reading the file
> +            # waiting for some characters to show up.
> +            self.log_file.flush()
> +        self.socket.setblocking(1)
> +
> +    def run(self):
> +        """This is the main loop of the socket thread.
> +           Simply receive from the file until the user
> +           calls join."""
> +        while self.alive.isSet():
> +            try:
> +                self.receive()
> +            except Exception as e:
> +                sys.stderr.write("Exception encountered\n")
> +                traceback.print_exc()
> +                continue
> +
> +    def join(self, timeout=3DNone):
> +        """Time to destroy the thread.
> +           Clear the event to stop the thread, and wait for
> +           it to complete."""
> +        self.alive.clear()
> +        threading.Thread.join(self, timeout)
> +        self.log_file.close()

I'm note sure about this - introducing threading into Python seems very
un-pythonic. I wonder if the python experts have any view on a better
way to achieve what we want which I think is:

  - a buffer that properly drains output from QEMU
  - which can optionally be serialised onto disk for logging

What else are we trying to achieve here?

--=20
Alex Benn=C3=A9e

