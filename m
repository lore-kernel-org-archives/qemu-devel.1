Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC72CC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 18:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE4820863
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 18:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE4820863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39933 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSmgW-00012p-UA
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 14:06:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSmdy-0007UF-FS
	for qemu-devel@nongnu.org; Mon, 20 May 2019 14:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSmdx-0008I1-C7
	for qemu-devel@nongnu.org; Mon, 20 May 2019 14:04:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hSmdx-0008GV-6C
	for qemu-devel@nongnu.org; Mon, 20 May 2019 14:04:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id r7so15592484wrr.13
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 11:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=TvraPVo/i1I8O8uOVha3qg9Qi1oMNtvVlL4NOIRvn80=;
	b=huePtOF9KQiay3m8vCUaI2JTogd8LzBOZjwY1haqJEVdD2Ws1lY+NmuRxrB+7/GIVr
	XEAUsT4+HX7pJdJ5eTpTxADEcC78Vha2LBgqvEf9aMS/bRrmikhYcEiWyeMJu+GIktnP
	zYHHaHB4r6JTwt7IzkVSL5o2ef9BvmKrn753AZOGdTZkl2P4xZs/FKa1q9Bz0oNDAA/u
	zADuQFp6vXWa8UxI4w9lpABawMn7A2eqCx3Da7coXIIt9/I+2t50McLo3cX7iVZb6FXf
	yc38GU1G33XNNbcUZ/lqN5KLoTBbmuSxXW8kAoC0IdGWeoypisJh6kBUkWDBv/RRI7xZ
	YUJg==
X-Gm-Message-State: APjAAAViNZ01EtKBb7+0ifdfGpDd1/fvkEsli6BVyj8W117DI0V1f/Eq
	krNucNyp/Ru3l1HINOdU7qnoRg==
X-Google-Smtp-Source: APXvYqzMgNTTi14rIEzmRPsoHcnJq7i5UlfWJmVDsXHk9B/iAwGWUkbvW+Dj5+Q661OfHoU0CvkZGg==
X-Received: by 2002:a5d:640d:: with SMTP id z13mr22670706wru.299.1558375451631;
	Mon, 20 May 2019 11:04:11 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	z14sm13336113wrq.22.2019.05.20.11.04.10
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 11:04:11 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190520124716.30472-1-kraxel@redhat.com>
	<20190520124716.30472-7-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e0abaa90-b39a-f75b-14b9-335fac9a27d0@redhat.com>
Date: Mon, 20 May 2019 20:04:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520124716.30472-7-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v3 06/14] tests/vm: proper guest shutdown
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	Kamil Rytarowski <kamil@netbsd.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/19 2:47 PM, Gerd Hoffmann wrote:
> When not running in snapshot mode ask the guest to poweroff and wait for
> this to finish instead of simply quitting qemu, so the guest can flush
> pending updates to disk.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/vm/basevm.py | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 878f1a7a32b8..465c7b80d011 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -51,6 +51,8 @@ class BaseVM(object):
>      name = "#base"
>      # The guest architecture, to be overridden by subclasses
>      arch = "#arch"
> +    # command to halt the guest, can be overridden by subclasses
> +    poweroff = "poweroff"
>      def __init__(self, debug=False, vcpus=None):
>          self._guest = None
>          self._tmpdir = os.path.realpath(tempfile.mkdtemp(prefix="vm-test-",
> @@ -201,6 +203,10 @@ class BaseVM(object):
>      def wait(self):
>          self._guest.wait()
>  
> +    def graceful_shutdown(self):
> +        self.ssh_root(self.poweroff)
> +        self._guest.wait()
> +
>      def qmp(self, *args, **kwargs):
>          return self._guest.qmp(*args, **kwargs)
>  
> @@ -277,11 +283,13 @@ def main(vmcls):
>          traceback.print_exc()
>          return 2
>  
> -    if args.interactive:
> -        if vm.ssh(*cmd) == 0:
> -            return 0
> +    exitcode = 0
> +    if vm.ssh(*cmd) != 0:
> +        exitcode = 3
> +    if exitcode != 0 and args.interactive:
>          vm.ssh()
> -        return 3
> -    else:
> -        if vm.ssh(*cmd) != 0:
> -            return 3
> +
> +    if not args.snapshot:
> +        vm.graceful_shutdown()
> +
> +    return exitcode
> 

