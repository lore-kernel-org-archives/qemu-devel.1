Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D69EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 19:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D0C2076A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 19:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQ7lHF3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D0C2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtyb1-0005tg-Ip
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 15:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtyZq-0004Qz-Sa
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 15:20:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34969
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtyZm-000499-5e
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 15:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594408848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JBXzWfzDLMe7osIi1a2VXwF3yrsfeeZKJVfMKHj+ieM=;
 b=MQ7lHF3lScc0YSTI1CDoHLi1rJXlqQDJ1HMkibLWUCQ1+9m8JDFzRRK8BPgI6ikqD4l75C
 EUhmLlyjl+5i+vPZZ8GcnK2rOI/iitoZJzzCPegfTWoU8e0kFUyTotC30nJ0YCJDZyIpJJ
 i3NnZ7YvYt+vcHcLby2+gyPcm0hXALQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-p5w8n2CvNz-vwB7PyOpEzQ-1; Fri, 10 Jul 2020 15:20:32 -0400
X-MC-Unique: p5w8n2CvNz-vwB7PyOpEzQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7735100A614;
 Fri, 10 Jul 2020 19:20:30 +0000 (UTC)
Received: from [10.10.118.196] (ovpn-118-196.rdu2.redhat.com [10.10.118.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90AD278A3E;
 Fri, 10 Jul 2020 19:20:29 +0000 (UTC)
Subject: Re: [PULL 10/41] python/qemu: Add ConsoleSocket for optional use in
 QEMUMachine
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org
References: <20200707070858.6622-1-alex.bennee@linaro.org>
 <20200707070858.6622-11-alex.bennee@linaro.org>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <fa8ee177-3a53-cde0-a8f1-8b0e8eba678f@redhat.com>
Date: Fri, 10 Jul 2020 15:20:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200707070858.6622-11-alex.bennee@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 15:06:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/7/20 3:08 AM, Alex Bennée wrote:
> From: Robert Foley <robert.foley@linaro.org>
> 

Hi, this creates some pylint regressions, can they please be addressed
first?

> We add the ConsoleSocket object, which has a socket interface
> and which will consume all arriving characters on the
> socket, placing them into an in memory buffer.
> This will also provide those chars via recv() as
> would a regular socket.
> ConsoleSocket also has the option of dumping
> the console bytes to a log file.
> 
> We also give QEMUMachine the option of using ConsoleSocket
> to drain and to use for logging console to a file.
> By default QEMUMachine does not use ConsoleSocket.
> 
> This is added in preparation for use by basevm.py in a later commit.
> This is a workaround we found was needed for basevm.py since
> there is a known issue where QEMU will hang waiting
> for console characters to be consumed.
> 
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> Acked-by: Alex Bennée <alex.bennee@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20200601211421.1277-9-robert.foley@linaro.org>
> Message-Id: <20200701135652.1366-13-alex.bennee@linaro.org>
> 
> diff --git a/python/qemu/console_socket.py b/python/qemu/console_socket.py
> new file mode 100644
> index 000000000000..830cb7c62825
> --- /dev/null
> +++ b/python/qemu/console_socket.py
> @@ -0,0 +1,110 @@
> +#!/usr/bin/env python3

> +#
> +# This python module implements a ConsoleSocket object which is
> +# designed always drain the socket itself, and place
> +# the bytes into a in memory buffer for later processing.
> +#
> +# Optionally a file path can be passed in and we will also
> +# dump the characters to this file for debug.
> +#

Convert to a module docstring, please.

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

vvv

> +import io
> +import os
> +import sys

^^^ unused, remove

> +from collections import deque
> +import time
> +import traceback
> +

Add one more blank line here, for flake8.

> +class ConsoleSocket(asyncore.dispatcher):
> +
> +    def __init__(self, address, file=None):
> +        self._recv_timeout_sec = 300
> +        self._buffer = deque()
> +        self._asyncore_thread = None
> +        self._sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
> +        self._sock.connect(address)
> +        self._logfile = None
> +        if file:
> +            self._logfile = open(file, "w")
> +        asyncore.dispatcher.__init__(self, sock=self._sock)
> +        self._open = True
> +        self._thread_start()
> +
> +    def _thread_start(self):
> +        """Kick off a thread to wait on the asyncore.loop"""
> +        if self._asyncore_thread is not None:
> +            return
> +        self._asyncore_thread = threading.Thread(target=asyncore.loop,
> +                                                 kwargs={'timeout':1})

Add a space after the colon here.

> +        self._asyncore_thread.daemon = True
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
> +            self._open = False
> +            asyncore.dispatcher.close(self)
> +            if self._asyncore_thread is not None:
> +                thread, self._asyncore_thread = self._asyncore_thread, None
> +                thread.join()
> +            if self._logfile:
> +                self._logfile.close()
> +                self._logfile = None
> +
> +    def handle_read(self):
> +        """process arriving characters into in memory _buffer"""
> +        try:
> +            data = asyncore.dispatcher.recv(self, 1)
> +            # latin1 is needed since there are some chars
> +            # we are receiving that cannot be encoded to utf-8
> +            # such as 0xe2, 0x80, 0xA6.
> +            string = data.decode("latin1")
> +        except:
> +            print("Exception seen.")
> +            traceback.print_exc()
> +            return

Please, no bare exceptions unless you re-raise the error.
If you want to handle the error, please handle the error in the caller
and not the shared library code.

As it is, I have no idea what errors you saw that might have warranted
this exclusion.

> +        if self._logfile:
> +            self._logfile.write("{}".format(string))
> +            self._logfile.flush()
> +        for c in string:
> +            self._buffer.extend(c)
> +

Pylint complains about the usage of 'c' here, but that's okay. Please
amend pylintrc to allow this usage by amending the "good-names" section.

> +    def recv(self, n=1, sleep_delay_s=0.1):
> +        """Return chars from in memory buffer"""
> +        start_time = time.time()
> +        while len(self._buffer) < n:
> +            time.sleep(sleep_delay_s)
> +            elapsed_sec = time.time() - start_time
> +            if elapsed_sec > self._recv_timeout_sec:
> +                raise socket.timeout
> +        chars = ''.join([self._buffer.popleft() for i in range(n)])
> +        # We choose to use latin1 to remain consistent with
> +        # handle_read() and give back the same data as the user would
> +        # receive if they were reading directly from the
> +        # socket w/o our intervention.
> +        return chars.encode("latin1")
> +

console_socket.py:89:4: W0221: Parameters differ from overridden 'recv'
method (arguments-differ)

Seems pretty different from the asyncore.dispatcher recv method, is that
intentional?

https://github.com/python/cpython/blob/master/Lib/asyncore.py

Does overriding this way break any other methods that we expect to work?

> +    def set_blocking(self):
> +        """Maintain compatibility with socket API"""
> +        pass
> +

You can remove the pass statement here because the docstring fulfills
the role of providing a function body.

> +    def settimeout(self, seconds):
> +        """Set current timeout on recv"""
> +        self._recv_timeout_sec = seconds
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index 041c615052e4..c25f0b42cf60 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -26,6 +26,7 @@ import socket
>  import tempfile
>  from typing import Optional, Type
>  from types import TracebackType
> +from qemu.console_socket import ConsoleSocket
>  

Match the import style for other relative imports in the module, as below.

>  from . import qmp
>  
> @@ -75,7 +76,8 @@ class QEMUMachine:
>  
>      def __init__(self, binary, args=None, wrapper=None, name=None,
>                   test_dir="/var/tmp", monitor_address=None,
> -                 socket_scm_helper=None, sock_dir=None):
> +                 socket_scm_helper=None, sock_dir=None,
> +                 drain_console=False, console_log=None):
>          '''
>          Initialize a QEMUMachine
>  
> @@ -86,6 +88,9 @@ class QEMUMachine:
>          @param test_dir: where to create socket and log file
>          @param monitor_address: address for QMP monitor
>          @param socket_scm_helper: helper program, required for send_fd_scm()
> +        @param sock_dir: where to create socket (overrides test_dir for sock)
> +        @param console_log: (optional) path to console log file
> +        @param drain_console: (optional) True to drain console socket to buffer
>          @note: Qemu process is not started until launch() is used.
>          '''
>          if args is None:
> @@ -122,6 +127,12 @@ class QEMUMachine:
>          self._console_address = None
>          self._console_socket = None
>          self._remove_files = []
> +        self._console_log_path = console_log
> +        if self._console_log_path:
> +            # In order to log the console, buffering needs to be enabled.
> +            self._drain_console = True
> +        else:
> +            self._drain_console = drain_console
>  
>      def __enter__(self):
>          return self
> @@ -580,7 +591,11 @@ class QEMUMachine:
>          Returns a socket connected to the console
>          """
>          if self._console_socket is None:
> -            self._console_socket = socket.socket(socket.AF_UNIX,
> -                                                 socket.SOCK_STREAM)
> -            self._console_socket.connect(self._console_address)
> +            if self._drain_console:
> +                self._console_socket = ConsoleSocket(self._console_address,
> +                                                    file=self._console_log_path)

Needs one more space, but the line is already too long as-is.

> +            else:
> +                self._console_socket = socket.socket(socket.AF_UNIX,
> +                                                     socket.SOCK_STREAM)
> +                self._console_socket.connect(self._console_address)
>          return self._console_socket
> 

This makes the typing for _console_socket really tough ... but
technically not a regression as the mypy code isn't merged yet.

--js


