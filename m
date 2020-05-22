Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3639BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA95F20723
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tiOPHOWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA95F20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcAai-0004DY-4K
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jcAa9-0003ne-8y
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:31:37 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:45822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jcAa7-0000jL-Do
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:31:36 -0400
Received: by mail-ej1-x641.google.com with SMTP id yc10so13647159ejb.12
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=QsSeKihwMe4diNyC+ByvdRSk1O1Gu6Hbw1XIX7lPDw8=;
 b=tiOPHOWxk0cwWMaHZ0vQiqnf/78WqkKFJiTT+gec6ZAS6pE78a43ArIQ7Mm+81EZDf
 zdXQ4zOtW6wwidwW4nC0Jv0smLy7A8+AN+5OwGvq0fI+RJ5jfiHZrKNasnwQHHL73V15
 2c1bAzyU6qt090xqaOqmgc3lCvmTrWhGJQm0IQfue+m1cxlpShYwpN8FBB47NI9eDW6x
 aHbmyEO7tb+x4LipxtS0kVnf1oHJLZXhOuTaLpq5Bfx6idNLaJFwtogvrhgkOe9zu+ws
 AzMINIgUhdRYA7DkAF3vwvfalJNru4lUIZC8FnRMhBQxK2wvFOHkG6Da4s1mIY4nONKr
 kh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=QsSeKihwMe4diNyC+ByvdRSk1O1Gu6Hbw1XIX7lPDw8=;
 b=tISAob9g15u6z1vavkha/dIiOZ77tuXWi26X4KOgGYo55RzHXGLiWo1VPjrvEOYk/C
 xAULRYwFy+BQFQLRmF4HUt0f8YCHrpBcOKIco1vZv0ZOu3brXOshm1fYqmOnGYJdpO39
 uZduuFKcG0DizTQFcjIDNpf90iOz1a6C+ZnKGFUAKVrG+bmkW/mywDSH3IzS/yjCL121
 RhhllRhTsA/As8NANlkFlPjsXrrRmRm2npCC8f4RWwnaAbqYIikJscRoiDmgQrC54Mf9
 78yIfd5qrcfOfY81pR9oUKu/R13wzYmr1jSNUNK/VpLeyyO1U2EtJRWfUZmieA2lA2RA
 ozTg==
X-Gm-Message-State: AOAM532T3QTw923VSMaKHHm2i676fTX7XmjF5I8A0ZHa+MpR9VAySpse
 ZRlMVGy1fm5JDs+D5HnhGy/UTg==
X-Google-Smtp-Source: ABdhPJzZsiraxQE1uECfAhdufsEwaR3m71Np4vky+YIUMu3ooGJcUZyHHflBF019JXkQS7pI91Eqdw==
X-Received: by 2002:a17:906:3943:: with SMTP id
 g3mr8607927eje.489.1590165093367; 
 Fri, 22 May 2020 09:31:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a18sm7584038edb.44.2020.05.22.09.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 09:31:32 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4552E1FF7E;
 Fri, 22 May 2020 17:31:31 +0100 (BST)
References: <20200519132259.405-1-robert.foley@linaro.org>
 <20200519132259.405-13-robert.foley@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v7 12/12] tests/vm: Add workaround to consume console
In-reply-to: <20200519132259.405-13-robert.foley@linaro.org>
Date: Fri, 22 May 2020 17:31:31 +0100
Message-ID: <87zha0c4nw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x641.google.com
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
Cc: peter.puhov@linaro.org, Cleber Rosa <crosa@redhat.com>, philmd@redhat.com,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

I think you need to look at adding:

[sendemail]
	cccmd =3D scripts/get_maintainer.pl --nogit-fallback

to your .git/config to ensure maintainers get pinged when you touch
their subsystems. Eduardo and Cleber CC'd=20

> The ConsoleSocket object provides a socket interface
> which will consume all arriving characters on the
> socket, but will provide those chars via recv() as
> would a regular socket.
> This is a workaround we found was needed since
> there is a known issue where QEMU will hang waiting
> for console characters to be consumed.
> We also add the option of logging the console to a file.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> ---
>  python/qemu/console_socket.py | 162 ++++++++++++++++++++++++++++++++++
>  python/qemu/machine.py        |  23 ++++-
>  tests/vm/Makefile.include     |   4 +
>  tests/vm/basevm.py            |  19 +++-
>  4 files changed, 202 insertions(+), 6 deletions(-)
>  create mode 100644 python/qemu/console_socket.py
>
> diff --git a/python/qemu/console_socket.py b/python/qemu/console_socket.py
> new file mode 100644
> index 0000000000..a1f74e60ac
> --- /dev/null
> +++ b/python/qemu/console_socket.py
> @@ -0,0 +1,162 @@
> +#!/usr/bin/env python3
> +#
> +# This python module implements a ConsoleSocket object which is
> +# designed always drain the socket itself, and place
> +# the bytes into a in memory buffer for later processing.
> +#
> +# Optionally a file path can be passed in and we will also
> +# dump the characters to this file for debug.
> +#
> +# Copyright 2020 Linaro
> +#
> +# Authors:
> +#  Robert Foley <robert.foley@linaro.org>
> +#
> +# This code is licensed under the GPL version 2 or later.  See
> +# the COPYING file in the top-level directory.
> +#
> +import asyncore
> +import socket
> +import threading
> +import io
> +import os
> +import sys
> +from collections import deque
> +import time
> +import traceback

Left over debug?

> +
> +class ConsoleSocket(asyncore.dispatcher):
> +
> +    def __init__(self, address, file=3DNone):
> +        self._recv_timeout_sec =3D 300
> +        self._buffer =3D deque()
> +        self._asyncore_thread =3D None
> +        self._sock =3D socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
> +        self._sock.connect(address)
> +        self._logfile =3D None
> +        if file:
> +            self._logfile =3D open(file, "w")
> +        asyncore.dispatcher.__init__(self, sock=3Dself._sock)
> +        self._thread_start()
> +        self._open =3D True
> +
> +    def _thread_start(self):
> +        """Kick off a thread to wait on the asyncore.loop"""
> +        if self._asyncore_thread is not None:
> +            return
> +        self._asyncore_thread =3D threading.Thread(target=3Dasyncore.loo=
p,
> +                                                 kwargs=3D{'timeout':1})
> +        self._asyncore_thread.daemon =3D True
> +        self._asyncore_thread.start()
> +
> +    def handle_close(self):
> +        """redirect close to base class"""
> +        # Call the base class close, but not self.close() since
> +        # handle_close() occurs in the context of the thread which
> +        # self.close() attempts to join.
> +        asyncore.dispatcher.close(self)
> +
> +    def close(self):
> +        """Close the base object and wait for the thread to terminate"""
> +        if self._open:
> +            self._open =3D False
> +            asyncore.dispatcher.close(self)
> +            if self._asyncore_thread is not None:
> +                thread, self._asyncore_thread =3D self._asyncore_thread,=
 None
> +                thread.join()
> +            if self._logfile:
> +                self._logfile.close()
> +                self._logfile =3D None
> +
> +    def handle_read(self):
> +        """process arriving characters into in memory _buffer"""
> +        try:
> +            data =3D asyncore.dispatcher.recv(self, 1)
> +            # latin1 is needed since there are some chars
> +            # we are receiving that cannot be encoded to utf-8
> +            # such as 0xe2, 0x80, 0xA6.
> +            string =3D data.decode("latin1")
> +        except:
> +            print("Exception seen.")
> +            traceback.print_exc()
> +            return
> +        if self._logfile:
> +            self._logfile.write("{}".format(string))
> +            self._logfile.flush()
> +        for c in string:
> +            self._buffer.append(c)
> +
> +    def recv(self, n=3D1):
> +        """Return chars from in memory buffer"""
> +        start_time =3D time.time()
> +        while len(self._buffer) < n:
> +            time.sleep(0.1)
> +            elapsed_sec =3D time.time() - start_time
> +            if elapsed_sec > self._recv_timeout_sec:
> +                raise socket.timeout
> +        chars =3D ''.join([self._buffer.popleft() for i in range(n)])
> +        # We choose to use latin1 to remain consistent with
> +        # handle_read() and give back the same data as the user would
> +        # receive if they were reading directly from the
> +        # socket w/o our intervention.
> +        return chars.encode("latin1")
> +
> +    def set_blocking(self):
> +        """Maintain compatibility with socket API"""
> +        pass
> +
> +    def settimeout(self, seconds):
> +        """Set current timeout on recv"""
> +        self._recv_timeout_sec =3D seconds
> +
> +class ByteBuffer(deque):
> +    """Simple in memory buffer with read/write interface"""
> +    def write(self, bytes):
> +        for i in bytes:
> +            self.append(i)
> +    def read(self, n):
> +        return ''.join([self.popleft() for i in range(n)])
> +
> +if __name__ =3D=3D '__main__':

If the module is meant to be executable then you need to +x the file.
However since 8f8fd9edba I think everything is meant to be doing things
the pythonic way as a proper module. I'm not sure where unit tests for
the modules are meant to sit in this case.

> +    # Brief test to exercise the above code.
> +    # The ConsoleSocket will ship some data to the server,
> +    # the server will echo it back and the client will echo what it rece=
ived.
> +
> +    # First remove the socket.
> +    address =3D "./test_console_socket"
> +    if os.path.exists(address):
> +        os.unlink(address)
> +
> +    # Create the server side.
> +    server_socket =3D socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
> +    server_socket.bind(address)
> +    server_socket.listen(1)
> +
> +    # Create the object we are trying to test.
> +    console_socket =3D ConsoleSocket(address, file=3D"./logfile.txt")
> +
> +    # Generate some data and ship it over the socket.
> +    send_data =3D ""
> +    for i in range(10):
> +        send_data +=3D "this is a test message {}\n".format(i)
> +    console_socket.send(send_data.encode('latin1'))
> +    connection, client_address =3D server_socket.accept()
> +
> +    # Process the data on the server and ship it back.
> +    data =3D connection.recv(len(send_data))
> +    print("server received: {}".format(data))
> +    print("server: sending data back to the client")
> +    connection.sendall(data)
> +
> +    # Client receives teh bytes and displays them.

s/teh/the/

> +    print("client: receiving bytes")
> +    bytes =3D console_socket.recv(len(data))
> +    recv_data =3D bytes.decode('latin1')
> +    print("client received: {}".format(recv_data))
> +    assert(recv_data =3D=3D send_data)
> +    # Close console connection first, then close server.
> +    console_socket.close()
> +    connection.close()
> +    server_socket.close()
> +    print("test successful.")
> +

I think in this case it might be worth splitting introducing the
functionally into the python library from the actual usage of it in the
wider machines.

Otherwise it seems to work well enough for me. I'd like the proper
python gurus to have a look over it though.

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

