Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6B1C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 16:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5174E20882
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 16:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5174E20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAzV7-0005hy-4X
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 12:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAzTK-0004M2-4b
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAzTI-0002wI-US
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:39:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47918)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAzTI-0002vY-JH
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:39:56 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B8AB181129
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 16:39:55 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id j2so1296750wre.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 09:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GSzZHlp6ZMaEzC9Pf/mjx2k28ZCbx1aWVvcuojidkGk=;
 b=cE/J0TnpmxcGxFchv65MWUber6EeqIE42Nqnhg5rS0fmT8jD3AGBEFyVHzSUbevy/F
 yqEbV6g5mL/A/AfezqSxeX8eZYVtt0O5sJAl+8x0iQT8sQQFq3R8LICjN4gULMw3vxgM
 p3URQdTZ5FGsxaksMCu5KGJYzAdsGj/fHXF1PgsSGM0rY++DU0Dywbqi/qUaDDBxIVY9
 dLhKhNXu03DkMvBLzp0M3vYdp0tjJaK3HfQMOgvNgJP2zIuP0TwX/x167mR90duC2CRa
 6ncr2z9gDlrlAIQITSK5qVhUqXeZEV8p5e5+z+kipPf7HbUMwGf/0CXWsOyf2LdGqXdT
 AgtA==
X-Gm-Message-State: APjAAAVEO+qAj391562sOnsfGzSN7wGZHmHO393wuLMAFl7Lwsfd6xIF
 DZOMOHDZ1KtxlnZZJSLeFFI6/PUlt3zOIzYa5E9Mf2UZ3/QGf4rJdyH6Z92qQoMEKkAwnhuCeLa
 tJfl086BiJU7w7P4=
X-Received: by 2002:a5d:6ac8:: with SMTP id u8mr7904729wrw.104.1568911194465; 
 Thu, 19 Sep 2019 09:39:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzFXhZI5zOm9Fd5PnvKSWJ2CNuIXhMwWNTYr/MOuzQsMkYaaysux0sjQzi5oB4UpqtKbEfV6A==
X-Received: by 2002:a5d:6ac8:: with SMTP id u8mr7904710wrw.104.1568911194220; 
 Thu, 19 Sep 2019 09:39:54 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id v2sm11544492wmf.18.2019.09.19.09.39.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 09:39:53 -0700 (PDT)
Subject: Re: [PATCH] edk2 build scripts: work around TianoCore#1607 without
 forcing Python 2
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
References: <20190918171141.15957-1-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2d02cb02-27ce-081b-c9ec-4c4430503749@redhat.com>
Date: Thu, 19 Sep 2019 18:39:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190918171141.15957-1-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/18/19 7:11 PM, Laszlo Ersek wrote:
> It turns out that forcing python2 for running the edk2 "build" utility is
> neither necessary nor sufficient.
> 
> Forcing python2 is not sufficient for two reasons:
> 
> - QEMU is moving away from python2, with python2 nearing EOL,
> 
> - according to my most recent testing, the lacking dependency information
>   in the makefiles that are generated by edk2's "build" utility can cause
>   parallel build failures even when "build" is executed by python2.
> 
> And forcing python2 is not necessary because we can still return to the
> original idea of filtering out jobserver-related options from MAKEFLAGS.
> So do that.

FYI I tried uninstalling python2 on Fedora 29,

$ make -C roms efi -j8
make: Entering directory '/home/phil/source/qemu/roms'
make -C edk2/BaseTools \
        EXTRA_OPTFLAGS='' \
        EXTRA_LDFLAGS=''
make[1]: Entering directory '/home/phil/source/qemu/roms/edk2/BaseTools'
[...]
make -C Tests
make[2]: Entering directory
'/home/phil/source/qemu/roms/edk2/BaseTools/Tests'
/bin/sh: python: command not found
make[2]: *** [GNUmakefile:11: test] Error 127

'python' seems to be provided by python-unversioned-command which is
wired to Python2:

$ dnf info python-unversioned-command
Last metadata expiration check: 0:03:08 ago on Thu 19 Sep 2019 04:21:21
PM UTC.
Available Packages
Name         : python-unversioned-command
Version      : 2.7.16
Release      : 2.fc29
Arch         : noarch
Size         : 13 k
Source       : python2-2.7.16-2.fc29.src.rpm
Repo         : updates
Summary      : The "python" command that runs Python 2
URL          : https://www.python.org/
License      : Python
Description  : This package contains /usr/bin/python - the "python"
command that runs Python 2.

I had to manually run update-alternatives to continue:

$ sudo update-alternatives --install /usr/bin/python python
/usr/bin/python3 69

Not sure this is the expected behavior, it is confusing.

