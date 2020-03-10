Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC15C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:49:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007C12051A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyDz/eT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007C12051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBaZx-0004V7-5l
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 04:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBaZB-00044d-H6
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBaZA-0000nY-Gw
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:48:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26078
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBaZA-0000mr-DR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583830124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LH3eDAHJLHzHFJvTcWo2PG+w8F0qATDDsUi9V7pyDkg=;
 b=SyDz/eT1xiv+WpcYORG/XTxsLp01JwhCwNjEb0NAyAmACTdt/cvzhX8mIN5yIbG/o6vbB6
 z8wsiKD3XPWmx22GaF5mMSafdYUG2yt1TmrizNIqHcnYvKDcr8NJY46VKwvMYg4KptTf10
 ibFwfnYEcyEt1Z2QFxjIX2wo/l2U6TQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-U8Yp4JHrNVeHtlk6JbTPJw-1; Tue, 10 Mar 2020 04:48:42 -0400
X-MC-Unique: U8Yp4JHrNVeHtlk6JbTPJw-1
Received: by mail-wr1-f72.google.com with SMTP id u18so6422577wrn.11
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 01:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xdoxmqgw6lgZ083x2Ybw81i6SW4P0r23IIK1cjF1Ge4=;
 b=H9KTKGAyie9pqsyfc6QFQh15zZOCRq0V3QKYNytqdQrE9elQQ5l1qcinhaxacH9zPw
 2hv313WfkH9rmq1/m7jGbgtRpdofBiJlQj9peegJeVAP7+yfirfjmCGIYeot7xP2sjKi
 X9gl4fLk/MG25o/Sz2UNRvQZeWNirhNrN5X7cFcC9IiEkZnBOLURjJxfaD9eWAj+cIq4
 JJnU9hnyL86K5m/4Dygu2Ym2wH2F5Wz3jV7c1b0eh9lbVMF7F1lnYCccSDT0M0PF6IVD
 eU0BNVw7t0bnW/LuXOBt/QkT0px8MU+jsYPaHQHA6rxNmB2sS7qkgAQUT/TlkNBIFxGP
 PD3w==
X-Gm-Message-State: ANhLgQ1kxglJmrq3sy/6h2X88IJi0LT7dwQOnsFK1etzuX7h5n/PiQsw
 z93Oi7XU1RPdRtPW+yjrIjfq1gAPN7EUP5+cQV6721kr1975xr1AuHpU9ViLi6sPvXA2V5dzJ6L
 ONyVJL8N+mfmAxOM=
X-Received: by 2002:adf:eb0a:: with SMTP id s10mr25929427wrn.405.1583830121117; 
 Tue, 10 Mar 2020 01:48:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtZ9zK46yeJCqxsjRdVhLwaKBx7hmbM1tQmHYymLYzMG5JBRUOrKtlFpeEh+mck8Q2e64Fr9w==
X-Received: by 2002:adf:eb0a:: with SMTP id s10mr25929411wrn.405.1583830120969; 
 Tue, 10 Mar 2020 01:48:40 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id c8sm56385228wru.7.2020.03.10.01.48.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 01:48:40 -0700 (PDT)
Subject: Re: [PATCH 1/4] tests/vm: write raw console log
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200310083218.26355-1-kraxel@redhat.com>
 <20200310083218.26355-2-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e968d21b-6982-61e9-c396-1b0773e9458e@redhat.com>
Date: Tue, 10 Mar 2020 09:48:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310083218.26355-2-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

On 3/10/20 9:32 AM, Gerd Hoffmann wrote:
> Run "tail -f /var/tmp/*/qemu*console.raw" in another terminal
> to watch the install console.

Better to document that in the code/documentation rather than this=20
commit description. Can you send a patch Alex can squash in?

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   tests/vm/basevm.py | 6 ++++++
>   1 file changed, 6 insertions(+)
>=20
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 8400b0e07f65..c53fd354d955 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -213,6 +213,9 @@ class BaseVM(object):
>       def console_init(self, timeout =3D 120):
>           vm =3D self._guest
>           vm.console_socket.settimeout(timeout)
> +        self.console_raw_path =3D os.path.join(vm._temp_dir,
> +                                             vm._name + "-console.raw")
> +        self.console_raw_file =3D open(self.console_raw_path, 'wb')
>  =20
>       def console_log(self, text):
>           for line in re.split("[\r\n]", text):
> @@ -234,6 +237,9 @@ class BaseVM(object):
>           while True:
>               try:
>                   chars =3D vm.console_socket.recv(1)
> +                if self.console_raw_file:
> +                    self.console_raw_file.write(chars)
> +                    self.console_raw_file.flush()
>               except socket.timeout:
>                   sys.stderr.write("console: *** read timeout ***\n")
>                   sys.stderr.write("console: waiting for: '%s'\n" % expec=
t)
>=20


