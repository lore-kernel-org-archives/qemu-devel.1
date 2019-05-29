Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00BEC04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 05:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC31820883
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 05:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC31820883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47364 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVqzs-0002qa-VD
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 01:19:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVqz6-0002ZZ-TB
	for qemu-devel@nongnu.org; Wed, 29 May 2019 01:18:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVqz5-0005R3-I1
	for qemu-devel@nongnu.org; Wed, 29 May 2019 01:18:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hVqz5-0005QT-BE
	for qemu-devel@nongnu.org; Wed, 29 May 2019 01:18:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 511903001835
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 05:18:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CB6757D910;
	Wed, 29 May 2019 05:18:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 4A66C1138648; Wed, 29 May 2019 07:18:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
References: <20190528204220.9615-1-jsnow@redhat.com>
	<20190528204220.9615-3-jsnow@redhat.com>
Date: Wed, 29 May 2019 07:18:38 +0200
In-Reply-To: <20190528204220.9615-3-jsnow@redhat.com> (John Snow's message of
	"Tue, 28 May 2019 16:42:20 -0400")
Message-ID: <87d0k1j0sx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Wed, 29 May 2019 05:18:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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

John Snow <jsnow@redhat.com> writes:

> Since we're out in a new module, do a quick cursory pass of some of the
> more obvious style issues.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/machine.py | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index a8a311b035..925046fc20 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -16,7 +16,6 @@ import errno
>  import logging
>  import os
>  import subprocess
> -import re
>  import shutil
>  import socket
>  import tempfile
> @@ -54,7 +53,7 @@ class MonitorResponseError(qmp.QMPError):
>          self.reply = reply
>  
>  
> -class QEMUMachine(object):
> +class QEMUMachine:

Premature.  Makes it a "classic class" in Python 2.  See

https://docs.python.org/2.7/reference/datamodel.html#new-style-and-classic-classes
https://pythonclock.org/

>      """
>      A QEMU VM
>  
> @@ -119,8 +118,10 @@ class QEMUMachine(object):
>          self.shutdown()
>          return False
>  
> -    # This can be used to add an unused monitor instance.
>      def add_monitor_null(self):
> +        """
> +        This can be used to add an unused monitor instance.
> +        """
>          self._args.append('-monitor')
>          self._args.append('null')
>  
> @@ -143,10 +144,13 @@ class QEMUMachine(object):
>          self._args.append(','.join(options))
>          return self
>  
> -    # Exactly one of fd and file_path must be given.
> -    # (If it is file_path, the helper will open that file and pass its
> -    # own fd)
>      def send_fd_scm(self, fd=None, file_path=None):
> +        """
> +        Send an fd or file_path to socket_scm_helper.
> +
> +        Exactly one of fd and file_path must be given.
> +        If it is file_path, the helper will open that file and pass its own fd.
> +        """
>          # In iotest.py, the qmp should always use unix socket.
>          assert self._qmp.is_scm_available()
>          if self._socket_scm_helper is None:
> @@ -194,14 +198,17 @@ class QEMUMachine(object):
>              raise
>  
>      def is_running(self):
> +        """Returns true if the VM is running."""
>          return self._popen is not None and self._popen.poll() is None
>  
>      def exitcode(self):
> +        """Returns the exit code if possible, or None."""
>          if self._popen is None:
>              return None
>          return self._popen.poll()
>  
>      def get_pid(self):
> +        """Returns the PID of the running process, or None."""
>          if not self.is_running():
>              return None
>          return self._popen.pid
> @@ -339,7 +346,7 @@ class QEMUMachine(object):
>                  command = ' '.join(self._qemu_full_args)
>              else:
>                  command = ''
> -            LOG.warn(msg, -exitcode, command)
> +            LOG.warning(msg, -exitcode, command)

Is this a bug fix?

>  
>          self._launched = False
>  
> @@ -373,7 +380,7 @@ class QEMUMachine(object):
>          """
>          Poll for one queued QMP events and return it
>          """
> -        if len(self._events) > 0:
> +        if self._events:
>              return self._events.pop(0)
>          return self._qmp.pull_event(wait=wait)

