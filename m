Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A5EC3F34A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:14:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 938E524697
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHzXPlpi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938E524697
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Jvb-0005y9-Ph
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:14:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7Jte-0003N0-M0
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7Jtd-00073D-HK
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:12:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31973
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7Jtd-00072t-E9
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582812732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OylcwCOIaEADfsTv++s8v9C1Mw/87Zv4lUQEip8/nH4=;
 b=IHzXPlpicM9irwNuMEoELDdZxX/g7WERh/DAhfNFxECborGwBMwoSQYcNP0bqI2bbb0a12
 0KIj7mylZlmld43ZC3RxhBWjdejU5jf8QUr4ifAG42FM8DseSvz5FCRhLXCvQ7qGnPz/wv
 hChfGqwQT0O3jjnpzEzqhvnq2zpSH5I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-xpQ5Izv6PNe4jWqYek8x-A-1; Thu, 27 Feb 2020 09:12:08 -0500
X-MC-Unique: xpQ5Izv6PNe4jWqYek8x-A-1
Received: by mail-wm1-f69.google.com with SMTP id o24so744303wmh.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 06:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MexhEM97y8Y0OyJ1bcDYC6caefvAfrBGTzhdZHdLINo=;
 b=alb4CnrAGg43U+X1bUQslkci2Z8Sb0WS7UDCiai1YFKsR/iqJ9NmDiAMOb/Xh6s7ZT
 ZJ9xT64umP2dRxY0fjqw6mAnx6rS+K76ZUbCzx0LoZIdHQGDgZg4z3TOzrE2GS5c3vbR
 KJFShA2NlgVa7bJK4YtZ+eual9eMtC0n3WjUd1qVC5YbLi2KAPpV0v4s2aI0GFT/hdAV
 HAFm+AaDbE/VPhVPRsJXcGb+uFqt9VK0o/FIZgceM8NqokGh0MS4xXlmHvkwcYvg0NZS
 GpLSkJbuWiOekd/kJk9yt+oLvfC0vArkNrvWovadqSSlt+Zzx8zUl1iwSc6oNvgSr38p
 r81Q==
X-Gm-Message-State: APjAAAWk4KrHCG/JPTr8DnyeLYTCnkG5E/TyQRMiCboSFydlk8Qbet1o
 jZz636qp5t1jNlITsOwjy89/NsNlUkKN4rebZXBO7lywt7us0EHzyXHulXHbJfO2neq8B+jJm/E
 nwx2GlzmafUUUoX8=
X-Received: by 2002:adf:fc85:: with SMTP id g5mr5058089wrr.52.1582812727389;
 Thu, 27 Feb 2020 06:12:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqxUTPc47c931H4KkfAdi5Vu9HyIJBPEraPcdvzhh3NMQ7uJIAW7Ke06y4QwCzi/uCVvbq1dSQ==
X-Received: by 2002:adf:fc85:: with SMTP id g5mr5058067wrr.52.1582812727135;
 Thu, 27 Feb 2020 06:12:07 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id w1sm7852555wmc.11.2020.02.27.06.12.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 06:12:06 -0800 (PST)
Subject: Re: [PATCH v6 8/9] iotests: don't use 'format' for drive_add
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200227000639.9644-1-jsnow@redhat.com>
 <20200227000639.9644-9-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a9c948e0-16cd-4c4d-bbc4-48c35a37054e@redhat.com>
Date: Thu, 27 Feb 2020 15:12:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227000639.9644-9-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 1:06 AM, John Snow wrote:
> It shadows (with a different type) the built-in format.
> Use something else.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/055        | 3 ++-
>   tests/qemu-iotests/iotests.py | 6 +++---
>   2 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
> index 82b9f5f47d..4175fff5e4 100755
> --- a/tests/qemu-iotests/055
> +++ b/tests/qemu-iotests/055
> @@ -469,7 +469,8 @@ class TestDriveCompression(iotests.QMPTestCase):
>           qemu_img('create', '-f', fmt, blockdev_target_img,
>                    str(TestDriveCompression.image_len), *args)
>           if attach_target:
> -            self.vm.add_drive(blockdev_target_img, format=3Dfmt, interfa=
ce=3D"none")
> +            self.vm.add_drive(blockdev_target_img,
> +                              img_format=3Dfmt, interface=3D"none")
>  =20
>           self.vm.launch()
>  =20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index 214f59995e..8bf640c632 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -492,21 +492,21 @@ def add_drive_raw(self, opts):
>           self._args.append(opts)
>           return self
>  =20
> -    def add_drive(self, path, opts=3D'', interface=3D'virtio', format=3D=
imgfmt):
> +    def add_drive(self, path, opts=3D'', interface=3D'virtio', img_forma=
t=3Dimgfmt):
>           '''Add a virtio-blk drive to the VM'''
>           options =3D ['if=3D%s' % interface,
>                      'id=3Ddrive%d' % self._num_drives]
>  =20
>           if path is not None:
>               options.append('file=3D%s' % path)
> -            options.append('format=3D%s' % format)
> +            options.append('format=3D%s' % img_format)
>               options.append('cache=3D%s' % cachemode)
>               options.append('aio=3D%s' % aiomode)
>  =20
>           if opts:
>               options.append(opts)
>  =20
> -        if format =3D=3D 'luks' and 'key-secret' not in opts:
> +        if img_format =3D=3D 'luks' and 'key-secret' not in opts:
>               # default luks support
>               if luks_default_secret_object not in self._args:
>                   self.add_object(luks_default_secret_object)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


