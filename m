Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69E3CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:43:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8312205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8312205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNPLM-0005hu-Rk
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 18:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNPJt-0004B3-6t
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNPJr-0000yx-4G
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:41:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57224)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNPJq-0000yR-Rb
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:41:31 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C362B4E938
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 22:41:29 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id v8so10861678wrt.16
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 15:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Pzf+7boHjCKGGmfqlognfYQS8TO2/QfBt1nq6ZNBjTo=;
 b=UF40Rh/X/nY4Q+8G0/aAzndoOIdBXDzY4opK5Cx1JC4+xe9LGdIpFG5e4mENeJLoaU
 VOa546oL1QruT7mFOURvMDVU6ZrCZFtutgdfX+/J530IS5HetFHQowMibYN1noNcXYSb
 MbA5ZBsYvrr7Xvtt8gyyIUlwTeV2CiB/d3sfxhNvq4ydZys9Qg5KAmHqP4A/XmSa/OgJ
 gBpS/WZquk+WfqemUTUGAbPJ6GyBKUIbqwAGuGIySXO7rorBK5F8wSkUtA5Mqgojt8q6
 Mpgi5UHbRjVSQBnNPOWdvNNaCNvkXN/GrK2IxIGrHBWJpSbkjY1W2zS+iB/SikNuoMXk
 LLxw==
X-Gm-Message-State: APjAAAW9CKRdqbhmCNOA5Y4NDd2IBP3ri7sEEji4d0uTKXi+r9vE15RF
 CIwz6m6OA301m6b8OvYCAMmeL+h3numbKtgK3//lFvF6OTX+1Zg81y1Ce8ug2oO968ruhobqg+P
 jOHycyPZl80sDbsE=
X-Received: by 2002:adf:c409:: with SMTP id v9mr870467wrf.41.1571870488518;
 Wed, 23 Oct 2019 15:41:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxjfcQH49sLCPvzbsbnYzkdGVWMiISAZaZ1fEgp1lPovqFFHUoa0zUnngwL1knxb6cFYvA0yA==
X-Received: by 2002:adf:c409:: with SMTP id v9mr870450wrf.41.1571870488340;
 Wed, 23 Oct 2019 15:41:28 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id s10sm28433136wrr.5.2019.10.23.15.41.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 15:41:27 -0700 (PDT)
Subject: Re: [PATCH v3 05/33] serial-pci-multi: factor out
 multi_serial_get_nr_ports
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-6-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6918ee75-31e8-7816-b196-5654cda451e0@redhat.com>
Date: Thu, 24 Oct 2019 00:41:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023173154.30051-6-marcandre.lureau@redhat.com>
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
Cc: Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Magnus Damm <magnus.damm@gmail.com>,
 Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 7:31 PM, Marc-Andr=C3=A9 Lureau wrote:
> Reused in following patch.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/char/serial-pci-multi.c | 26 ++++++++++++++------------
>   1 file changed, 14 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
> index 5f13b5663b..6fa1cc6225 100644
> --- a/hw/char/serial-pci-multi.c
> +++ b/hw/char/serial-pci-multi.c
> @@ -77,24 +77,26 @@ static void multi_serial_irq_mux(void *opaque, int =
n, int level)
>       pci_set_irq(&pci->dev, pending);
>   }
>  =20
> +static int multi_serial_get_nr_ports(PCIDeviceClass *pc)

static size_t multi_serial_get_port_count()?

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +{
> +    switch (pc->device_id) {
> +    case 0x0003:
> +        return 2;
> +    case 0x0004:
> +        return 4;
> +    }
> +
> +    g_assert_not_reached();
> +}
> +
> +
>   static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
>   {
>       PCIDeviceClass *pc =3D PCI_DEVICE_GET_CLASS(dev);
>       PCIMultiSerialState *pci =3D DO_UPCAST(PCIMultiSerialState, dev, =
dev);
>       SerialState *s;
>       Error *err =3D NULL;
> -    int i, nr_ports =3D 0;
> -
> -    switch (pc->device_id) {
> -    case 0x0003:
> -        nr_ports =3D 2;
> -        break;
> -    case 0x0004:
> -        nr_ports =3D 4;
> -        break;
> -    }
> -    assert(nr_ports > 0);
> -    assert(nr_ports <=3D PCI_SERIAL_MAX_PORTS);
> +    int i, nr_ports =3D multi_serial_get_nr_ports(pc);
>  =20
>       pci->dev.config[PCI_CLASS_PROG] =3D pci->prog_if;
>       pci->dev.config[PCI_INTERRUPT_PIN] =3D 0x01;
>=20

