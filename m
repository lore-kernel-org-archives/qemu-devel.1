Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FA5CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 19:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6EC2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 19:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6EC2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLXc6-0005Xb-2B
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 15:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLXZw-0002jj-De
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 15:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLXZu-0001ne-6A
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 15:06:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54496)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLXZt-0001nF-UA
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 15:06:22 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0B17A51EE9
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 19:06:21 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id f4so3119965wrj.12
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 12:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ObPZgmXRYrpC1K1VYu4wZbCD9OquUZ3D1JIuw4fuMh0=;
 b=UbjUJ3FJbbM8lXAxpWKbdVE0xQPIEf5rllKVTC+mafXJBSiyZuO4NTwh+hA3mVYg2g
 ZUN1sb8azIcBMUjsR37btBazAGprRwqVmPnzyVODdMriXZoD3RfbW9MO6kkrgQYHw9ih
 upYuELolOO0SXoAYvOz/DLSm6yeH2pQ7HYv8StbN4m4j/UuPNWzsLCXc/KjP55+1PiWA
 NQCy/fzwSefqXYTRx2PWHvy0zm9xwP00amTIO90Gr4Vk+ZnR7EvpcDIjT9CdAc9MoYxI
 2JiEt5Qyef91xgTuLYSi7qcijF6StPpBN7LswCjARa/FlawGUs4hB7sYoDDnygd+bVy0
 sYRA==
X-Gm-Message-State: APjAAAU+0QgJ1CtOOMfOjKYlc4qpF21yUnyGjfqAtNJXvzh7moOsYHTA
 4tbnspTkWRI7GWSqNPGdi5F+Q+nc8idR2RoP4Qzv9RDTL3XNhF2AiJ8fAsZMgSUM/h2ineGiest
 RfvlkHacoBEfiiMM=
X-Received: by 2002:a5d:4ace:: with SMTP id y14mr3348107wrs.131.1571425579806; 
 Fri, 18 Oct 2019 12:06:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxSRkpHEsMhqqjY91ZOruUcyEPKRpgVfJjSwtyTc1+rmOWAWW5vQ48Bx8g+MmwNt2fvgacCtg==
X-Received: by 2002:a5d:4ace:: with SMTP id y14mr3348096wrs.131.1571425579576; 
 Fri, 18 Oct 2019 12:06:19 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id u1sm5760080wmc.38.2019.10.18.12.06.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2019 12:06:18 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] tests/vm: Let subclasses disable IPv6
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20191018181705.17957-1-ehabkost@redhat.com>
 <20191018181705.17957-3-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c340e3bd-4ddf-dd21-e36d-5f724fd6f355@redhat.com>
Date: Fri, 18 Oct 2019 21:06:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191018181705.17957-3-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 8:17 PM, Eduardo Habkost wrote:
> The mechanism will be used to work around issues related to IPv6
> on the netbsd image builder.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>   tests/vm/basevm.py | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index b5d1479bee..2929de23aa 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -57,6 +57,8 @@ class BaseVM(object):
>       arch =3D "#arch"
>       # command to halt the guest, can be overridden by subclasses
>       poweroff =3D "poweroff"
> +    # enable IPv6 networking
> +    ipv6 =3D True
>       def __init__(self, debug=3DFalse, vcpus=3DNone):
>           self._guest =3D None
>           self._tmpdir =3D os.path.realpath(tempfile.mkdtemp(prefix=3D"=
vm-test-",
> @@ -81,7 +83,8 @@ class BaseVM(object):
>           self._args =3D [ \
>               "-nodefaults", "-m", "4G",
>               "-cpu", "max",
> -            "-netdev", "user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22",
> +            "-netdev", "user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22" +
> +                       (",ipv6=3Dno" if not self.ipv6 else ""),
>               "-device", "virtio-net-pci,netdev=3Dvnet",
>               "-vnc", "127.0.0.1:0,to=3D20"]
>           if vcpus and vcpus > 1:
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

