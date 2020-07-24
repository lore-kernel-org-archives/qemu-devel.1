Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E949C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 07:26:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374182065E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 07:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rn7DNDdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374182065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jys5k-0003Y0-I1
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 03:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jys4y-0002Xs-7G
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 03:25:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38587)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jys4w-00068F-6E
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 03:25:15 -0400
Received: by mail-wr1-x442.google.com with SMTP id a14so7353066wra.5
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 00:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Op4PVcs257hXsYqi7kmVCXY+lq0f8+sXcC2mrfJOq/s=;
 b=rn7DNDdCZVvEDaBd+Tef/1KXqLq665DW1YKd6ucaxDLu5voAsIv923RAms1kLduETl
 t8l0RMnP1/8a9Ah3VnsGwdQb20H9weYyqBdsQEGTivtCz/9pNbADGcKD/obJbmVuocYM
 NLL4qGPTfAXpg77T/kb8JG7mpNVdCsX3uvzib1UrgUCIydxPpdhPLVpnRCv0OD/nJDLr
 Sh7TN53UwBxPO6QnNAwTh/6sr7TLbNC81M9MgpSAJwlQlTSXuoD77sn9bD12YioAXuYu
 W8RaXwhJOw/VGjoi+285ey0rxKnZOQI9M5AHRa0g/mOA/rnZVh0R3HwJ1eVIPsK2S4le
 ANeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Op4PVcs257hXsYqi7kmVCXY+lq0f8+sXcC2mrfJOq/s=;
 b=F9lEv0nVM/OdfQrRQtIXE5bfqtAgaET0+UvObfR+F9FgOs/cgQXSHTD5mMpEG2UISH
 lAKH9+Ub+1EA4bgLVRana4w9Qk6HWaTpVE5gIu1ub0DuD3hh740P/qmtLag7oqa2lcAn
 3CaPrT9BsjpcaF9+SJkLshnbx/nx8Ym5jwr/P4FcCpbTNA7mwLCK25zcak0sBdLal6af
 YOoONtpyyhVbemcI/rUJG0hE+RTiN7YgtxlTeMtcrM/VCXZC8hhISk2g4b0DIW5So/4X
 Js33VIJaUHSmT126myRsIKm6ViTNP+1ni2HUNmjopwiamcih4IS/jtbL0vzwRAvm2KZy
 JBCg==
X-Gm-Message-State: AOAM530f+rvxPNg4d4KQkOPQDC0/9wb/CvdRWYZhMepOgOfFzjl+fso6
 IxoJm+iugKyz5flb0ovoenE=
X-Google-Smtp-Source: ABdhPJyY+we5O721yh2pxIz6QGJSpFnfekaDunEXX5CUimCcIGFo6LQUmYPe9bbN3zvWKvX3Lktv9Q==
X-Received: by 2002:a5d:4d87:: with SMTP id b7mr1858199wru.170.1595575512197; 
 Fri, 24 Jul 2020 00:25:12 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id p15sm255934wrj.61.2020.07.24.00.25.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 00:25:11 -0700 (PDT)
Subject: Re: [PATCH v3 14/16] python/qemu: Cleanup changes to ConsoleSocket
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200724064509.331-1-alex.bennee@linaro.org>
 <20200724064509.331-15-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f92eef51-ba19-1be1-c70a-3715587ff44a@amsat.org>
Date: Fri, 24 Jul 2020 09:25:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200724064509.331-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com, Robert Foley <robert.foley@linaro.org>,
 richard.henderson@linaro.org, cota@braap.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, aurelien@aurel32.net,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+John who requested the changes.

On 7/24/20 8:45 AM, Alex Bennée wrote:
> From: Robert Foley <robert.foley@linaro.org>
> 
> The changes to console_socket.py and machine.py are to
> cleanup for pylint and flake8.
> 
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20200717203041.9867-2-robert.foley@linaro.org>
> ---
>  python/qemu/console_socket.py | 57 ++++++++++++++++++-----------------
>  python/qemu/machine.py        |  7 +++--
>  python/qemu/pylintrc          |  2 +-
>  3 files changed, 34 insertions(+), 32 deletions(-)
> 
> diff --git a/python/qemu/console_socket.py b/python/qemu/console_socket.py
> index 830cb7c6282..09986bc2152 100644
> --- a/python/qemu/console_socket.py
> +++ b/python/qemu/console_socket.py
> @@ -1,12 +1,9 @@
> -#!/usr/bin/env python3
> -#
> -# This python module implements a ConsoleSocket object which is
> -# designed always drain the socket itself, and place
> -# the bytes into a in memory buffer for later processing.
> -#
> -# Optionally a file path can be passed in and we will also
> -# dump the characters to this file for debug.
> -#
> +"""
> +QEMU Console Socket Module:
> +
> +This python module implements a ConsoleSocket object,
> +which can drain a socket and optionally dump the bytes to file.
> +"""
>  # Copyright 2020 Linaro
>  #
>  # Authors:
> @@ -15,20 +12,27 @@
>  # This code is licensed under the GPL version 2 or later.  See
>  # the COPYING file in the top-level directory.
>  #
> +
>  import asyncore
>  import socket
>  import threading
> -import io
> -import os
> -import sys
>  from collections import deque
>  import time
> -import traceback
> +
>  
>  class ConsoleSocket(asyncore.dispatcher):
> +    """
> +    ConsoleSocket represents a socket attached to a char device.
>  
> +    Drains the socket and places the bytes into an in memory buffer
> +    for later processing.
> +
> +    Optionally a file path can be passed in and we will also
> +    dump the characters to this file for debugging purposes.
> +    """
>      def __init__(self, address, file=None):
>          self._recv_timeout_sec = 300
> +        self._sleep_time = 0.5
>          self._buffer = deque()
>          self._asyncore_thread = None
>          self._sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
> @@ -70,31 +74,28 @@ class ConsoleSocket(asyncore.dispatcher):
>  
>      def handle_read(self):
>          """process arriving characters into in memory _buffer"""
> -        try:
> -            data = asyncore.dispatcher.recv(self, 1)
> -            # latin1 is needed since there are some chars
> -            # we are receiving that cannot be encoded to utf-8
> -            # such as 0xe2, 0x80, 0xA6.
> -            string = data.decode("latin1")
> -        except:
> -            print("Exception seen.")
> -            traceback.print_exc()
> -            return
> +        data = asyncore.dispatcher.recv(self, 1)

A bit more than the commit description, but I don't mind.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +        # latin1 is needed since there are some chars
> +        # we are receiving that cannot be encoded to utf-8
> +        # such as 0xe2, 0x80, 0xA6.
> +        string = data.decode("latin1")
>          if self._logfile:
>              self._logfile.write("{}".format(string))
>              self._logfile.flush()
>          for c in string:
>              self._buffer.extend(c)
>  
> -    def recv(self, n=1, sleep_delay_s=0.1):
> -        """Return chars from in memory buffer"""
> +    def recv(self, buffer_size=1):
> +        """Return chars from in memory buffer.
> +           Maintains the same API as socket.socket.recv.
> +        """
>          start_time = time.time()
> -        while len(self._buffer) < n:
> -            time.sleep(sleep_delay_s)
> +        while len(self._buffer) < buffer_size:
> +            time.sleep(self._sleep_time)
>              elapsed_sec = time.time() - start_time
>              if elapsed_sec > self._recv_timeout_sec:
>                  raise socket.timeout
> -        chars = ''.join([self._buffer.popleft() for i in range(n)])
> +        chars = ''.join([self._buffer.popleft() for i in range(buffer_size)])
>          # We choose to use latin1 to remain consistent with
>          # handle_read() and give back the same data as the user would
>          # receive if they were reading directly from the
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index 80c4d4a8b6e..9956360a792 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -27,7 +27,7 @@ import socket
>  import tempfile
>  from typing import Optional, Type
>  from types import TracebackType
> -from qemu.console_socket import ConsoleSocket
> +from . import console_socket
>  
>  from . import qmp
>  
> @@ -674,8 +674,9 @@ class QEMUMachine:
>          """
>          if self._console_socket is None:
>              if self._drain_console:
> -                self._console_socket = ConsoleSocket(self._console_address,
> -                                                    file=self._console_log_path)
> +                self._console_socket = console_socket.ConsoleSocket(
> +                    self._console_address,
> +                    file=self._console_log_path)
>              else:
>                  self._console_socket = socket.socket(socket.AF_UNIX,
>                                                       socket.SOCK_STREAM)
> diff --git a/python/qemu/pylintrc b/python/qemu/pylintrc
> index 5d6ae7367d8..3f69205000d 100644
> --- a/python/qemu/pylintrc
> +++ b/python/qemu/pylintrc
> @@ -33,7 +33,7 @@ good-names=i,
>             Run,
>             _,
>             fd,
> -
> +           c,
>  [VARIABLES]
>  
>  [STRING]
> 

