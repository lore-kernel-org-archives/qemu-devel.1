Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81602CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:25:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E7E21783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E7E21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMrMD-0007Pl-En
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 06:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMrJR-0003ya-15
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMrJP-0002St-GQ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:22:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMrJP-0002SS-8J
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:22:47 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2CC6CC049E1A
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 10:22:46 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id z5so4207583wma.5
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 03:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vr4CyH5FsjQ8ehEcFfRUpSQggMXreidJjn0G64Qc2gY=;
 b=eSIAfnXJ7tAeGNjt+Cl4tUClt4nWwJH2exlyyL1RlcHBSAN8UiWtBzq56sbvN+oAa2
 1BFwAOPL5YLbqjI990ZVlmidbKpW1BpWxMxTa5PIv6A6txdnEv6ABbYSMNPaxaWo7hGG
 pCROrkbH2cM/biSlw0dLXHmEZzIldvTNgzeY7eGI66wtOur6L98x28PGZ8ljvn9ftJ7W
 IAnjR6YbWXGkyaprCFHbZMl1baL4LZ35kOcmOTKDmaTw6ozTY0mM2H53qL9aHB/aVqJe
 WODWxFJAYwFlI/Kp8uK5AUyArvnla3cpnMOnh4+/xgF+AB5uzfSq+AtPvugFnbbp8FcS
 x/cA==
X-Gm-Message-State: APjAAAVLgwC7cnti+jwodeJLli8J5JAsJD3DnHihgEF48vcWBPquPxqd
 xOI0Xy8n6Yqt3IIrYkaocIGPgLdCnPXR+kX133X2D5kLNVNWBpP9E2b6/WC3ml5piBmBVylch6H
 5cuUAxApG0kCVvHc=
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr2834175wrs.358.1571739764868; 
 Tue, 22 Oct 2019 03:22:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwr3VsA7v7ybGFyXj4xBkAXhJeKl51DxieJULIb6RM4vSX/rYGuLOkmhQc4ErEWwuVFgcVqtA==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr2834149wrs.358.1571739764624; 
 Tue, 22 Oct 2019 03:22:44 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id f18sm15421287wmh.43.2019.10.22.03.22.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 03:22:44 -0700 (PDT)
Subject: Re: [PATCH v8 3/8] bootdevice: Add interface to gather LCHS
To: Sam Eiderman <sameid@google.com>, qemu-devel@nongnu.org
References: <20191016164145.115898-1-sameid@google.com>
 <20191016164145.115898-5-sameid@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <49349913-41ed-0861-fc89-dcefc76bc9ea@redhat.com>
Date: Tue, 22 Oct 2019 12:22:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016164145.115898-5-sameid@google.com>
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 jsnow@redhat.com, seabios@seabios.org, kevin@koconnor.net,
 liran.alon@oracle.com, kraxel@redhat.com,
 Sam Eiderman <shmuel.eiderman@oracle.com>, lersek@redhat.com,
 karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/19 6:41 PM, Sam Eiderman wrote:
> From: Sam Eiderman <shmuel.eiderman@oracle.com>
>=20
> Add an interface to provide direct logical CHS values for boot devices.
> We will use this interface in the next commits.
>=20
> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
> Signed-off-by: Sam Eiderman <sameid@google.com>
> ---
>   bootdevice.c            | 55 ++++++++++++++++++++++++++++++++++++++++=
+
>   include/sysemu/sysemu.h |  3 +++
>   2 files changed, 58 insertions(+)
>=20
> diff --git a/bootdevice.c b/bootdevice.c
> index 1d225202f9..bc5e1c2de4 100644
> --- a/bootdevice.c
> +++ b/bootdevice.c
> @@ -343,3 +343,58 @@ void device_add_bootindex_property(Object *obj, in=
t32_t *bootindex,
>       /* initialize devices' bootindex property to -1 */
>       object_property_set_int(obj, -1, name, NULL);
>   }
> +
> +typedef struct FWLCHSEntry FWLCHSEntry;
> +
> +struct FWLCHSEntry {
> +    QTAILQ_ENTRY(FWLCHSEntry) link;
> +    DeviceState *dev;
> +    char *suffix;
> +    uint32_t lcyls;
> +    uint32_t lheads;
> +    uint32_t lsecs;
> +};
> +
> +static QTAILQ_HEAD(, FWLCHSEntry) fw_lchs =3D
> +    QTAILQ_HEAD_INITIALIZER(fw_lchs);
> +
> +void add_boot_device_lchs(DeviceState *dev, const char *suffix,
> +                          uint32_t lcyls, uint32_t lheads, uint32_t ls=
ecs)
> +{
> +    FWLCHSEntry *node;
> +
> +    if (!lcyls && !lheads && !lsecs) {
> +        return;
> +    }
> +
> +    assert(dev !=3D NULL || suffix !=3D NULL);
> +
> +    node =3D g_malloc0(sizeof(FWLCHSEntry));
> +    node->suffix =3D g_strdup(suffix);
> +    node->dev =3D dev;
> +    node->lcyls =3D lcyls;
> +    node->lheads =3D lheads;
> +    node->lsecs =3D lsecs;
> +
> +    QTAILQ_INSERT_TAIL(&fw_lchs, node, link);
> +}
> +
> +void del_boot_device_lchs(DeviceState *dev, const char *suffix)
> +{
> +    FWLCHSEntry *i;
> +
> +    if (dev =3D=3D NULL) {
> +        return;
> +    }
> +
> +    QTAILQ_FOREACH(i, &fw_lchs, link) {
> +        if ((!suffix || !g_strcmp0(i->suffix, suffix)) &&
> +             i->dev =3D=3D dev) {
> +            QTAILQ_REMOVE(&fw_lchs, i, link);
> +            g_free(i->suffix);
> +            g_free(i);
> +
> +            break;
> +        }
> +    }
> +}
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 44f18eb739..5bc5c79cbc 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -103,6 +103,9 @@ void device_add_bootindex_property(Object *obj, int=
32_t *bootindex,
>                                      DeviceState *dev, Error **errp);
>   void restore_boot_order(void *opaque);
>   void validate_bootdevices(const char *devices, Error **errp);
> +void add_boot_device_lchs(DeviceState *dev, const char *suffix,
> +                          uint32_t lcyls, uint32_t lheads, uint32_t ls=
ecs);
> +void del_boot_device_lchs(DeviceState *dev, const char *suffix);
>  =20
>   /* handler to set the boot_device order for a specific type of Machin=
eClass */
>   typedef void QEMUBootSetHandler(void *opaque, const char *boot_order,
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

