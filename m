Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25774C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:17:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B87208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B87208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54211 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVyRw-0006uF-7g
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 09:17:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVyQv-0006YI-OG
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVyQt-0003O3-S0
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:15:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hVyQr-0003LG-Ui
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:15:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id i3so1661739wml.4
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 06:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=7RbSj0KIuAO1mDYxrD6s5eFi3g8XUdCIoOomtT5VyQk=;
	b=bVwIIDfzYT0nBuG+3hZusPVEumyTmWftvv1YyumT0ulrVWBXExjoVLOtfIi+cS/SoS
	6Vmy4SxF/SuPd1RTqS3PGASJVo788qK1JoT+tR/1j8+8+YgjWWz51L9RES0Tilwwh2sv
	2CBlyGEqhEhpvHkNy2QMczTgpv8CLtCXbMCB9/ENgtw6pmmmzUbIs9V8Rclnvvc2zK55
	8treGHHRaVfm05L/5C3meSzuZmVQeoaeN+ufFdT7plNJF0Od4G8OhGVjkHrH8l06Fl53
	+W4uoLLxrzt7xzzSGqnoRb+pKC9Hkc9CzZLDCjW+LgO5vDxwBqRfmTrJp5cxFAfK9gG9
	uaqQ==
X-Gm-Message-State: APjAAAVLBfcw/34sSQWhaTxe8UXDeroORnBSQzi6gp1ctCOEq7sr8l0M
	92TCTZ1amYLZA8AOBb9mb1pKbA==
X-Google-Smtp-Source: APXvYqzRpecZ1u26Uns4JePhGk4xnbX6HaiClkzFqEqVYND/ANwNoVQZYfP0uNoJKiBEu3SFjEks2w==
X-Received: by 2002:a1c:f105:: with SMTP id p5mr6240541wmh.87.1559135750212;
	Wed, 29 May 2019 06:15:50 -0700 (PDT)
Received: from [10.32.224.40] (red-hat-inc.vlan560.asr1.mad1.gblx.net.
	[159.63.51.90]) by smtp.gmail.com with ESMTPSA id
	v11sm13557450wrr.87.2019.05.29.06.15.48
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 06:15:49 -0700 (PDT)
To: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20190528204220.9615-1-jsnow@redhat.com>
	<20190528204220.9615-3-jsnow@redhat.com>
	<87d0k1j0sx.fsf@dusky.pond.sub.org>
	<2162219b-1df1-97d1-bcf8-01556af09393@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <5ca0761e-ad51-1226-e968-a39ff74a7c8b@redhat.com>
Date: Wed, 29 May 2019 15:15:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2162219b-1df1-97d1-bcf8-01556af09393@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] machine.py: minor delinting
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/19 2:54 PM, John Snow wrote:
> On 5/29/19 1:18 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>>
>>> Since we're out in a new module, do a quick cursory pass of some of the
>>> more obvious style issues.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  python/qemu/machine.py | 23 +++++++++++++++--------
>>>  1 file changed, 15 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
>>> index a8a311b035..925046fc20 100644
>>> --- a/python/qemu/machine.py
>>> +++ b/python/qemu/machine.py
>>> @@ -16,7 +16,6 @@ import errno
>>>  import logging
>>>  import os
>>>  import subprocess
>>> -import re
>>>  import shutil
>>>  import socket
>>>  import tempfile
>>> @@ -54,7 +53,7 @@ class MonitorResponseError(qmp.QMPError):
>>>          self.reply = reply
>>>  
>>>  
>>> -class QEMUMachine(object):
>>> +class QEMUMachine:
>>
>> Premature.  Makes it a "classic class" in Python 2.  See
>>
>> https://docs.python.org/2.7/reference/datamodel.html#new-style-and-classic-classes
>> https://pythonclock.org/
>>
> 
> I thought we had dropped support for 2? No? I need to double-check this
> patch then. I have not been testing with 2.

Deprecated doesn't mean dropped :(

> 
>>>      """
>>>      A QEMU VM
>>>  
>>> @@ -119,8 +118,10 @@ class QEMUMachine(object):
>>>          self.shutdown()
>>>          return False
>>>  
>>> -    # This can be used to add an unused monitor instance.
>>>      def add_monitor_null(self):
>>> +        """
>>> +        This can be used to add an unused monitor instance.
>>> +        """
>>>          self._args.append('-monitor')
>>>          self._args.append('null')
>>>  
>>> @@ -143,10 +144,13 @@ class QEMUMachine(object):
>>>          self._args.append(','.join(options))
>>>          return self
>>>  
>>> -    # Exactly one of fd and file_path must be given.
>>> -    # (If it is file_path, the helper will open that file and pass its
>>> -    # own fd)
>>>      def send_fd_scm(self, fd=None, file_path=None):
>>> +        """
>>> +        Send an fd or file_path to socket_scm_helper.
>>> +
>>> +        Exactly one of fd and file_path must be given.
>>> +        If it is file_path, the helper will open that file and pass its own fd.
>>> +        """
>>>          # In iotest.py, the qmp should always use unix socket.
>>>          assert self._qmp.is_scm_available()
>>>          if self._socket_scm_helper is None:
>>> @@ -194,14 +198,17 @@ class QEMUMachine(object):
>>>              raise
>>>  
>>>      def is_running(self):
>>> +        """Returns true if the VM is running."""
>>>          return self._popen is not None and self._popen.poll() is None
>>>  
>>>      def exitcode(self):
>>> +        """Returns the exit code if possible, or None."""
>>>          if self._popen is None:
>>>              return None
>>>          return self._popen.poll()
>>>  
>>>      def get_pid(self):
>>> +        """Returns the PID of the running process, or None."""
>>>          if not self.is_running():
>>>              return None
>>>          return self._popen.pid
>>> @@ -339,7 +346,7 @@ class QEMUMachine(object):
>>>                  command = ' '.join(self._qemu_full_args)
>>>              else:
>>>                  command = ''
>>> -            LOG.warn(msg, -exitcode, command)
>>> +            LOG.warning(msg, -exitcode, command)
>>
>> Is this a bug fix?
>>
> 
> No, "warn" is just deprecated.
> 
>>>  
>>>          self._launched = False
>>>  
>>> @@ -373,7 +380,7 @@ class QEMUMachine(object):
>>>          """
>>>          Poll for one queued QMP events and return it
>>>          """
>>> -        if len(self._events) > 0:
>>> +        if self._events:
>>>              return self._events.pop(0)
>>>          return self._qmp.pull_event(wait=wait)
> 
> 

