Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30935CA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 14:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 061372080F
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 14:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061372080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQB8V-0006JQ-9r
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 10:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iQB4m-0001wg-4l
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iQB4i-0004kz-RK
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:05:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39974)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iQB4i-0004Zz-HD
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:05:20 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 21E5A5945C
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 14:05:19 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id t2so3353415wri.18
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 07:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L+WvcYkBwACKV4+sITUmfgR424M57XEtVLW3iW4rt6o=;
 b=H2hcIX6q2so33GD5NXiCHglGAMAK9xuB9+cw617AN5XuKADcPanZLkJkxhT0rxUiwy
 UZ0piDPMe2xcVVZPlF+wv3ehCyNX8pnLW7RQP/dnjN+PSjE4Wc12iSQwpjdFUnC+Az6P
 kdxlAuRb2pE9GhT7RLpDVNoNQ1v8Lv85egisRX/qODEQSSxcz3EGi/AGOZ164VeqbFXQ
 o+AXjcxgJDBrrwqZXa6SJj6lqVdaoXbvNoST4wb12irK33QchDYE8YXYmYQUgqulT96W
 APRM8MLHSA1muVTcmkr779kVcBHqJ2HobZ1KvK0K1t1KttslsoUytnjmvrsnAE5qfp34
 sIZA==
X-Gm-Message-State: APjAAAWOmv3Y1jayjFH3WwUEXgCy2DAlS/fRDZ+ASwECTyytVKpHOxNm
 NPbakCAiHvK+OCgts9tNksFKvGHIJH/eQ3pbdpwCRm0laPdrXgGtL6gg4oeCc3EwWkeDpsninby
 PXF5uVkHf/ErOHvk=
X-Received: by 2002:a7b:c208:: with SMTP id x8mr4839599wmi.87.1572530717746;
 Thu, 31 Oct 2019 07:05:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwnF6Zjr0Kl01rJWsRmhVUD58wFD7Is29jZyVLjX2umoNtEleF0Y+fOnwPNcogeoJ0nrGUE/w==
X-Received: by 2002:a7b:c208:: with SMTP id x8mr4839574wmi.87.1572530717535;
 Thu, 31 Oct 2019 07:05:17 -0700 (PDT)
Received: from [172.20.51.145] ([91.217.168.176])
 by smtp.gmail.com with ESMTPSA id s12sm4321056wme.20.2019.10.31.07.05.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2019 07:05:16 -0700 (PDT)
Subject: Re: [PATCH v6 2/4] tests/vm: add console_consume helper
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20191031085306.28888-1-kraxel@redhat.com>
 <20191031085306.28888-3-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <467684e8-9e69-e0e3-2e1e-a8db55e8f653@redhat.com>
Date: Thu, 31 Oct 2019 15:05:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191031085306.28888-3-kraxel@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/31/19 9:53 AM, Gerd Hoffmann wrote:
> Helper function to read all console output.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   tests/vm/basevm.py | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>=20
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 2929de23aa..086bfb2c66 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -242,6 +242,25 @@ class BaseVM(object):
>               return False
>           return True
>  =20
> +    def console_consume(self):
> +        vm =3D self._guest
> +        output =3D ""
> +        vm.console_socket.setblocking(0)
> +        while True:
> +            try:
> +                chars =3D vm.console_socket.recv(1)
> +            except:
> +                break
> +            output +=3D chars.decode("latin1")

I don't know enough decode(), but I'm very happy with the rest of
the patch, thanks a lot for fixing this long standing issue Gerd!

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> +            if "\r" in output or "\n" in output:
> +                lines =3D re.split("[\r\n]", output)
> +                output =3D lines.pop()
> +                if self.debug:
> +                    self.console_log("\n".join(lines))
> +        if self.debug:
> +            self.console_log(output)
> +        vm.console_socket.setblocking(1)
> +
>       def console_send(self, command):
>           vm =3D self._guest
>           if self.debug:
>=20

