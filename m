Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9566C4646B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:05:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 966122083B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 11:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966122083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46138 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdusm-0003ib-D5
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 07:05:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45442)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hdufI-0002G7-7s
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hduSu-00032N-JT
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:40:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55642)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hduSu-00031Z-E1
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 06:38:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so2531405wmj.5
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 03:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IsljRLYWTjIQPmEFwNCyB8dqzHMxJyFO3IW64lGhZck=;
 b=a1yBZX4Bc6NPW3q321WcNGrIGdrZ9ojGOZJ06AXouXJXncL0x4fDRv4VVCH/yTTXEG
 pQPi58DwV5z1VDTe1j2c/GBm8RbAUBONTBJXfq3RUGEjoXgt5cmesoKXM+XSLyP2y0ey
 a4hSCWB4K5OIQhNHXqa/jLA0ewBmMDo/qolxVXdsk1WSTQv5T/LLbMLttxhPObmkfmSq
 tPyyyQIc5J+/tdnoNgG2xOHBNWm/Dn9qR9AhkH+acicibCu08yBRpZ8YFRPz0/eOl+lR
 v1kN75lrzKni7xwJBWyx/8/mGf/7IyfEd6C2LnICc+/T/0cjIVh0twv7FkU/44WE0QwK
 ZpAw==
X-Gm-Message-State: APjAAAXwJQC7sz3tth/WQd4atf5TTVA2B+ymcVl5/3nS11OkEhQ0hxbV
 6RTdtm390ePeJhl29oLj7gNlNA==
X-Google-Smtp-Source: APXvYqwnfGrvhQWfd89DYdqm8wm6Hmf74q8evRxnVEpYeY4s/2XBMUybAV3apzmU7EBcjBdcpJJfkg==
X-Received: by 2002:a1c:544d:: with SMTP id p13mr2440380wmi.78.1561027127083; 
 Thu, 20 Jun 2019 03:38:47 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id 11sm4995682wmd.23.2019.06.20.03.38.46
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 03:38:46 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190619194021.8240-1-alex.bennee@linaro.org>
 <20190619194021.8240-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <711ca291-a349-64f4-d3d4-1017e95b737d@redhat.com>
Date: Thu, 20 Jun 2019 12:38:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190619194021.8240-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v1 05/17] tests/vm: send proxy environment
 variables over ssh
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/19 9:40 PM, Alex Bennée wrote:
> From: Gerd Hoffmann <kraxel@redhat.com>
> 
> Packages are fetched via proxy that way, if configured on the host.
> That might be required to pass firewalls, and it allows to route
> package downloads through a caching proxy server.
> 
> Needs AcceptEnv setup in sshd_config on the guest side to work.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Message-Id: <20190617043858.8290-2-kraxel@redhat.com>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tests/vm/basevm.py | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 4847549592..5e30bac661 100755
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
> @@ -106,6 +113,8 @@ class BaseVM(object):
>                     "-o", "UserKnownHostsFile=" + os.devnull,
>                     "-o", "ConnectTimeout=1",
>                     "-p", self.ssh_port, "-i", self._ssh_key_file]
> +        for var in self.envvars:
> +            ssh_cmd += ['-o', "SendEnv=%s" % var ]
>          if interactive:
>              ssh_cmd += ['-t']
>          assert not isinstance(cmd, str)
> 

