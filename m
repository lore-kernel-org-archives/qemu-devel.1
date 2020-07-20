Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CD2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 20:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B732922BF5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 20:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDQZiLGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B732922BF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxbzQ-0004WE-SL
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 16:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jxbyr-00045c-Cs
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 16:01:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38004
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jxbyo-0008SL-TD
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 16:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595275301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n9IgX4iCUUux059ntCNCrjJ+XLrdhWjSbAUEeAZJCp0=;
 b=gDQZiLGC3ssDQSjq5PacdQPCUr7Rve+pMzsnoP4cLliY17nUca9LHcu1PCtuX7+Z2Qu2ZK
 4KSceEQdkYv+CAESbDRC1LRka9l4D6bEolumTQ5OBl7o3F8iOZaKDVeDV3KeLCzQC5Cbl9
 +YdqhoZccP/6tf4oVPrDDnd+fjs5iKQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-zbxIrZTsNjCzqrIkDzjGEQ-1; Mon, 20 Jul 2020 16:01:39 -0400
X-MC-Unique: zbxIrZTsNjCzqrIkDzjGEQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C09F2100AA21;
 Mon, 20 Jul 2020 20:01:38 +0000 (UTC)
Received: from localhost (unknown [10.10.67.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63AED5D9DD;
 Mon, 20 Jul 2020 20:01:38 +0000 (UTC)
Date: Mon, 20 Jul 2020 16:01:37 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 1/1] python/machine: Change default timeout to 30 seconds
Message-ID: <20200720200137.GY1274972@habkost.net>
References: <20200720160252.104139-1-jsnow@redhat.com>
 <20200720160252.104139-2-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200720160252.104139-2-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 03:17:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, philmd@redhat.com,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 20, 2020 at 12:02:52PM -0400, John Snow wrote:
> 3 seconds is too short for some tests running inside busy VMs. Build it out to
> a rather generous 30 seconds to find out conclusively if there are more severe
> problems in the merge/CI tests.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

I would send my Reviewed-by to this patch without blinking if it
only changed the default value without touching anything else,
but this changes argument order and defaults in 4 different
methods.

I will still review this, though, and I will probably reply in a
few minutes with my Reviewed-by.

> ---
>  python/qemu/machine.py | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index 80c4d4a8b6..51aa255ef9 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -394,15 +394,15 @@ def _hard_shutdown(self) -> None:
>          self._popen.kill()
>          self._popen.wait(timeout=60)
>  
> -    def _soft_shutdown(self, has_quit: bool = False,
> -                       timeout: Optional[int] = 3) -> None:
> +    def _soft_shutdown(self, timeout: Optional[int],
> +                       has_quit: bool = False) -> None:
>          """
>          Perform early cleanup, attempt to gracefully shut down the VM, and wait
>          for it to terminate.
>  
> +        :param timeout: Timeout in seconds for graceful shutdown.
> +                        A value of None is an infinite wait.
>          :param has_quit: When True, don't attempt to issue 'quit' QMP command
> -        :param timeout: Optional timeout in seconds for graceful shutdown.
> -                        Default 3 seconds, A value of None is an infinite wait.
>  
>          :raise ConnectionReset: On QMP communication errors
>          :raise subprocess.TimeoutExpired: When timeout is exceeded waiting for
> @@ -418,14 +418,14 @@ def _soft_shutdown(self, has_quit: bool = False,
>          # May raise subprocess.TimeoutExpired
>          self._popen.wait(timeout=timeout)
>  
> -    def _do_shutdown(self, has_quit: bool = False,
> -                     timeout: Optional[int] = 3) -> None:
> +    def _do_shutdown(self, timeout: Optional[int],
> +                     has_quit: bool = False) -> None:
>          """
>          Attempt to shutdown the VM gracefully; fallback to a hard shutdown.
>  
> +        :param timeout: Timeout in seconds for graceful shutdown.
> +                        A value of None is an infinite wait.
>          :param has_quit: When True, don't attempt to issue 'quit' QMP command
> -        :param timeout: Optional timeout in seconds for graceful shutdown.
> -                        Default 3 seconds, A value of None is an infinite wait.
>  
>          :raise AbnormalShutdown: When the VM could not be shut down gracefully.
>              The inner exception will likely be ConnectionReset or
> @@ -433,7 +433,7 @@ def _do_shutdown(self, has_quit: bool = False,
>              may result in its own exceptions, likely subprocess.TimeoutExpired.
>          """
>          try:
> -            self._soft_shutdown(has_quit, timeout)
> +            self._soft_shutdown(timeout, has_quit)
>          except Exception as exc:
>              self._hard_shutdown()
>              raise AbnormalShutdown("Could not perform graceful shutdown") \
> @@ -441,7 +441,7 @@ def _do_shutdown(self, has_quit: bool = False,
>  
>      def shutdown(self, has_quit: bool = False,
>                   hard: bool = False,
> -                 timeout: Optional[int] = 3) -> None:
> +                 timeout: Optional[int] = 30) -> None:
>          """
>          Terminate the VM (gracefully if possible) and perform cleanup.
>          Cleanup will always be performed.
> @@ -453,7 +453,7 @@ def shutdown(self, has_quit: bool = False,
>          :param hard: When true, do not attempt graceful shutdown, and
>                       suppress the SIGKILL warning log message.
>          :param timeout: Optional timeout in seconds for graceful shutdown.
> -                        Default 3 seconds, A value of None is an infinite wait.
> +                        Default 30 seconds, A `None` value is an infinite wait.
>          """
>          if not self._launched:
>              return
> @@ -463,7 +463,7 @@ def shutdown(self, has_quit: bool = False,
>                  self._user_killed = True
>                  self._hard_shutdown()
>              else:
> -                self._do_shutdown(has_quit, timeout=timeout)
> +                self._do_shutdown(timeout, has_quit)
>          finally:
>              self._post_shutdown()
>  
> @@ -473,12 +473,12 @@ def kill(self):
>          """
>          self.shutdown(hard=True)
>  
> -    def wait(self, timeout: Optional[int] = 3) -> None:
> +    def wait(self, timeout: Optional[int] = 30) -> None:
>          """
>          Wait for the VM to power off and perform post-shutdown cleanup.
>  
> -        :param timeout: Optional timeout in seconds.
> -                        Default 3 seconds, A value of None is an infinite wait.
> +        :param timeout: Optional timeout in seconds. Default 30 seconds.
> +                        A value of `None` is an infinite wait.
>          """
>          self.shutdown(has_quit=True, timeout=timeout)
>  
> -- 
> 2.26.2
> 

-- 
Eduardo


