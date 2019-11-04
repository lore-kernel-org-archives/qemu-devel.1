Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09B6CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96FF02084D
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FF02084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRhMu-00058M-GZ
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 13:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iRhLC-0003YG-5l
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:44:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iRhLA-0005ea-0Z
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:44:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39048)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iRhL9-0005eH-GX
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:44:35 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 08B03C057EC6
 for <qemu-devel@nongnu.org>; Mon,  4 Nov 2019 18:44:32 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id j17so10625734wru.13
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 10:44:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j5kgJQpQtGyLUNL4icI34/hxH/c6LwMPQapgT9J3q9o=;
 b=X/8T98TSWD06m/iLjXyk8fEM4b67mqaGTGCDSC+AOA4EeOnNKCVf1WcQl4ST8o8Ve1
 qJeEYZQzX17S7uxznRoPtWJlfv97wDXTpZUEDeZQb141qsUe18Yd6HVaD3EmTCHYfg6i
 SzZ8wKWmVM7l/dVxcM74jhVhGdgbV+kVC+9IbWHfTCOs8AWq38YnjQ9s660qWmfOIqx8
 WUzfyWoUuMqCVqMvsH09rzpIul2dnZMBNgnz7wrwO33VVN6kifmTVR4qp5lVtn8Ua0t/
 eX9/0OQkbpjJNXX+cMqgnKhJloitTYn5/p2uhsqRuCTf7JPo9dtNK6Y1OTe33Gc2MuLU
 7Uew==
X-Gm-Message-State: APjAAAVOtG/ziJrHio/wRzVt+ipq1Uvxp2rgcAYg9I06fVKxEqX/3roB
 hq3JOvAgsycmaSZLnrCP46zJkcAH4F2HEyOme78FZO2XCvQIsPV09KaSO+3pm/wIViwl3Fj9MW4
 9R8hbP3ioB0jPF70=
X-Received: by 2002:adf:e2cc:: with SMTP id d12mr3410956wrj.168.1572893070823; 
 Mon, 04 Nov 2019 10:44:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqwKYHtvi14uU/z+tNRCBHt+mTZGsN5DRL5NwGryziyiT+vE/LTue128OgR3nPU990PNR/b0Ng==
X-Received: by 2002:adf:e2cc:: with SMTP id d12mr3410944wrj.168.1572893070571; 
 Mon, 04 Nov 2019 10:44:30 -0800 (PST)
Received: from [192.168.1.24] (lfbn-1-7864-228.w92-167.abo.wanadoo.fr.
 [92.167.33.228])
 by smtp.gmail.com with ESMTPSA id 189sm23059369wmc.7.2019.11.04.10.44.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2019 10:44:30 -0800 (PST)
Subject: Re: [PATCH v1 2/6] tests/vm: add console_consume helper
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191104173654.30125-1-alex.bennee@linaro.org>
 <20191104173654.30125-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <23f2543d-f329-cc64-1bd5-78bfa9ee11c1@redhat.com>
Date: Mon, 4 Nov 2019 19:44:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191104173654.30125-3-alex.bennee@linaro.org>
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 Gerd Hoffmann <kraxel@redhat.com>, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/19 6:36 PM, Alex Benn=C3=A9e wrote:
> From: Gerd Hoffmann <kraxel@redhat.com>
>=20
> Helper function to read all console output.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Message-Id: <20191031085306.28888-3-kraxel@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   tests/vm/basevm.py | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>=20
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 2929de23aa7..086bfb2c66d 100755
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

