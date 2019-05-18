Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897B1C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 22:16:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FFF220848
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 22:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFF220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39232 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS7cz-0003Xs-GU
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 18:16:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hS7c1-00036e-K9
	for qemu-devel@nongnu.org; Sat, 18 May 2019 18:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hS7bv-0004lN-Jr
	for qemu-devel@nongnu.org; Sat, 18 May 2019 18:15:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hS7bq-0004XO-BX
	for qemu-devel@nongnu.org; Sat, 18 May 2019 18:15:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so10406908wrv.2
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 15:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=fkO7m6V/9Rclq85ftKQ1/J0eJFDtCu1xwTz7ywy63Io=;
	b=rz0UqdQi9qBEaiLp0bcKgqOCm9F03uqLhVZjk1RG0ZbIOTkQUGKGFfofYFM6kzni6M
	2gYBarK48wy8uaLnhJ+ngNJrVI0tlLeony87mbNlHSWDwn2ZfMhPoFeXcre34dILwIC7
	Z2WqlEgvNJN2OGBvkqVhDwMXKTHA3mC/cGwmRioOQko5l9JHz7R7BLOm1/r02nFVRwrI
	7BG9n7qZnmOKMOUImEeyauIAMUdmH7TeRAhncquHByvhAF+ar2hUuk6bMMEZaui3M2F0
	9NJ9j5Bmjtd4oR9xq3LYoO0RSvHfTcu2PTTKKYsyNxRpjXGZT6gl0MC8J0mO+6hHnv6i
	e0/A==
X-Gm-Message-State: APjAAAWPWhrOTPNeneukIKpoCYa1DP3AzkGXQCDujiFslP/nbjCgzmkZ
	ElAV8P9qCO6IfDkesRz7i16dwg==
X-Google-Smtp-Source: APXvYqyayNQtHNF6V2cZpQfSogMURhWqtIDTDviLMiXDNT+rRPXtRAXV0t96uC0W4MEVLTs9ir9N0Q==
X-Received: by 2002:adf:9023:: with SMTP id h32mr28218645wrh.95.1558217711175; 
	Sat, 18 May 2019 15:15:11 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	h12sm8320479wre.14.2019.05.18.15.15.10
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 15:15:10 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190510104633.9428-1-kraxel@redhat.com>
	<20190510104633.9428-3-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f69be0ad-6428-cebb-80f5-19709a140c99@redhat.com>
Date: Sun, 19 May 2019 00:15:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510104633.9428-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v2 02/13] tests/vm: send proxy environment
 variables over ssh
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

On 5/10/19 12:46 PM, Gerd Hoffmann wrote:
> Packages are fetched via proxy that way, if configured on the host.
> That might be required to pass firewalls, and it allows to route
> package downloads through a caching proxy server.
> 
> Needs AcceptEnv setup in sshd_config on the guest side to work.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/vm/basevm.py | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 0556bdcf9e9f..6b46674f4497 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -38,6 +38,13 @@ class BaseVM(object):
>      GUEST_PASS = "qemupass"
>      ROOT_PASS = "qemupass"
>  
> +    envvars = [
> +        "https_proxy",
> +        "http_proxy",
> +        "ftp_proxy",
> +        "no_proxy",
> +    ]
> +
>      # The script to run in the guest that builds QEMU
>      BUILD_SCRIPT = ""
>      # The guest name, to be overridden by subclasses
> @@ -105,6 +112,8 @@ class BaseVM(object):
>                     "-o", "UserKnownHostsFile=" + os.devnull,
>                     "-o", "ConnectTimeout=1",
>                     "-p", self.ssh_port, "-i", self._ssh_key_file]
> +        for var in self.envvars:
> +            ssh_cmd += ['-o', "SendEnv=%s" % var ]
>          if interactive:
>              ssh_cmd += ['-t']
>          assert not isinstance(cmd, str)
> 

