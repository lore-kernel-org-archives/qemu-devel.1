Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCB4C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 18:04:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E94620863
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 18:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E94620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39863 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSmec-0007db-8M
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 14:04:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSmcy-0006pX-K7
	for qemu-devel@nongnu.org; Mon, 20 May 2019 14:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSmcx-0007k1-4k
	for qemu-devel@nongnu.org; Mon, 20 May 2019 14:03:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hSmcw-0007jf-Ul
	for qemu-devel@nongnu.org; Mon, 20 May 2019 14:03:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id q15so272664wmj.0
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 11:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=eNJJcMQo6ndzqZiH5DPLKIJCz1165S6P25dcqq9dkyo=;
	b=UXD+qL9ZGvIuKHg/jNvdLqkWg//nI/Jx5Hqe/BN1FUKc7eGdejSkFLe3a3cDUH6zSG
	zecMkJy1ydg/ywP08ffM2BQhzt9jEUlG6KW2TzZQ8VB38Oo0vuFLKhFWfHDc3z4/1enS
	HME/PRfe+Y23NsZ3wySljkRXf8rEe8jSWsA6AfUOabvICo3VVkYv66BPaMFFB2GM7wVd
	mBd+6clac3X1/fi0rbTIJLht3HefxWuUg5mA1AF2eZQHjHudDST03DSMXvpaIKD2Se9M
	+cd9aZvAn1YmqtG6McZElfU+53l0dKm1zTmRJ9jbYGftQrOhdUYlretgLIV+o6AdfBJz
	wz1A==
X-Gm-Message-State: APjAAAU6MjxeCKJHsfFg5WeS7sMNkTdlBwJt03i3aCEaCyAG7WI1VTQa
	I6LbYD5Zpjo45JVL6xE5H+kmEQ==
X-Google-Smtp-Source: APXvYqyDU2ov9GTE/5R0DgPChvoZXR3aOJ7PxD5OimnLBfpFNKeVWuD8wQ3HMXFqP14VYWF2MhWJQA==
X-Received: by 2002:a05:600c:23ce:: with SMTP id
	p14mr292098wmb.36.1558375389047; 
	Mon, 20 May 2019 11:03:09 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id y2sm525230wmg.9.2019.05.20.11.03.08
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 11:03:08 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190520124716.30472-1-kraxel@redhat.com>
	<20190520124716.30472-5-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6eebf1ed-11f6-93ca-995c-1dd24dd687ce@redhat.com>
Date: Mon, 20 May 2019 20:03:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520124716.30472-5-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v3 04/14] tests/vm: use ssh with pty
 unconditionally
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
> Allways ask ssh to run with a pseudo terminal.
> Not having a terminal causes problems now and then.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/vm/basevm.py | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 640f3226929d..878f1a7a32b8 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -106,16 +106,14 @@ class BaseVM(object):
>          os.rename(fname + ".download", fname)
>          return fname
>  
> -    def _ssh_do(self, user, cmd, check, interactive=False):
> -        ssh_cmd = ["ssh", "-q",
> +    def _ssh_do(self, user, cmd, check):
> +        ssh_cmd = ["ssh", "-q", "-t",
>                     "-o", "StrictHostKeyChecking=no",
>                     "-o", "UserKnownHostsFile=" + os.devnull,
>                     "-o", "ConnectTimeout=1",
>                     "-p", self.ssh_port, "-i", self._ssh_key_file]
>          for var in self.envvars:
>              ssh_cmd += ['-o', "SendEnv=%s" % var ]
> -        if interactive:
> -            ssh_cmd += ['-t']
>          assert not isinstance(cmd, str)
>          ssh_cmd += ["%s@127.0.0.1" % user] + list(cmd)
>          logging.debug("ssh_cmd: %s", " ".join(ssh_cmd))
> @@ -127,9 +125,6 @@ class BaseVM(object):
>      def ssh(self, *cmd):
>          return self._ssh_do(self.GUEST_USER, cmd, False)
>  
> -    def ssh_interactive(self, *cmd):
> -        return self._ssh_do(self.GUEST_USER, cmd, False, True)
> -
>      def ssh_root(self, *cmd):
>          return self._ssh_do("root", cmd, False)
>  
> @@ -283,9 +278,9 @@ def main(vmcls):
>          return 2
>  
>      if args.interactive:
> -        if vm.ssh_interactive(*cmd) == 0:
> +        if vm.ssh(*cmd) == 0:
>              return 0
> -        vm.ssh_interactive()
> +        vm.ssh()
>          return 3
>      else:
>          if vm.ssh(*cmd) != 0:
> 

