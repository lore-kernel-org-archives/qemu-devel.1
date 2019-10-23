Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A057CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 23:08:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E9532064B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 23:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9532064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNPkF-0001LU-6y
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 19:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNPjG-00075K-HX
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 19:07:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNPjF-0001uo-IB
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 19:07:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46894)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNPjF-0001uI-AQ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 19:07:45 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 11DE93B717
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 23:07:43 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id o188so183290wmo.5
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 16:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yBnIzIRWnC1PwBFYZOLXIfan46JBj2GdcoEJiFRPnSc=;
 b=oO3GeoYIyZeww8Enkt/DdUvyM/ND7qhY+udrDI/lEtqme7lj9qV3uW8BwSQny906Xw
 v4hyfsJ1MXYyj6/pideYCx8o1etyYuMEDUQ40ckHlWzmsk99TG2VebR/qv8ejDcQXTRz
 01rWmjxbQ6xSn/Ql/7TYCj6ZEO/5XQT4MpygNoyL9F+BseuT2Qib1LolVKm+IgsBSbiY
 +CHiTba/TkXkUfaNaZKZ8pE+eDjQQgQUh0NQ8vHKJ66OO01rxnBf7G5AMb7tfq2yWCNC
 RnFVAphQnPW2M9BPRGMihc5CmFehT/SMPXkn+WJuVBDPrHF9nSTwE7BQ4dim62mm+N6U
 V2cA==
X-Gm-Message-State: APjAAAXpVfF5Nf0WkbFIxa1JyLOGIIJBIKTO86WZy1yZ0DIZlcBWfOqf
 KzvH0P2TSJBGmLr5UBydS5WHRU8fFpl2jmYMcdUUdxg+o2juk3O3h5Gg+QN8rcKv2JWokJb1Gda
 R4hJXgDfh6mRxCPk=
X-Received: by 2002:a1c:a849:: with SMTP id r70mr1908154wme.59.1571872061746; 
 Wed, 23 Oct 2019 16:07:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzNPUa579x7BZ55JB5Xrk8JjggWbukp2qx6rkgxIaSkJ7Q436Gwd19nRLBKxXg2LE7vcZHQ6Q==
X-Received: by 2002:a1c:a849:: with SMTP id r70mr1908123wme.59.1571872061501; 
 Wed, 23 Oct 2019 16:07:41 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id n1sm27987009wrg.67.2019.10.23.16.07.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 16:07:40 -0700 (PDT)
Subject: Re: [PATCH v3 32/33] qdev: remove PROP_MEMORY_REGION
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-33-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <93780bab-1ae4-19e5-7ea8-247803f21cac@redhat.com>
Date: Thu, 24 Oct 2019 01:07:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023173154.30051-33-marcandre.lureau@redhat.com>
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
> PROP_MEMORY_REGION was a derivative of PROP_PTR, added in commit
> ed03d749f3f513b8fb0287757cfda2cb6825f063 (qdev: add MemoryRegion
> property) and thankfully no longer needed since commit
> 3eff40dbf44896a8180c86c84dbdefb2eb173fbe (hw/misc: Remove
> mmio_interface device).
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/qdev-properties.h | 2 --
>   1 file changed, 2 deletions(-)
>=20
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.=
h
> index 690ff07ae2..5bba033b7b 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -213,8 +213,6 @@ extern const PropertyInfo qdev_prop_pcie_link_width=
;
>       DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t=
)
>   #define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
>       DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDevice=
Address)
> -#define DEFINE_PROP_MEMORY_REGION(_n, _s, _f)             \
> -    DEFINE_PROP(_n, _s, _f, qdev_prop_ptr, MemoryRegion *)
>   #define DEFINE_PROP_OFF_AUTO_PCIBAR(_n, _s, _f, _d) \
>       DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_off_auto_pcibar, \
>                           OffAutoPCIBAR)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

