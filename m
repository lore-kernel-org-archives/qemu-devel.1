Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00011C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 11:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2636207C4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 11:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNgwF4q7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2636207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbNH9-0008ET-Vc
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 07:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbNGX-0007Qw-0i
 for qemu-devel@nongnu.org; Wed, 20 May 2020 07:52:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41269
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbNGV-0008Ce-O3
 for qemu-devel@nongnu.org; Wed, 20 May 2020 07:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589975521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vnHlZkpkMD88YLwfQaGLyZ1jkoDQo7m4X1Goc6uh+/g=;
 b=fNgwF4q7OJaNg73SlHyK6a7MZITg9Zh/M6NmawvchuFAkiPI6/FS2Troy8frYBCZprAkmG
 /6DleZUVh2hhe6lqpQv/eqqkPo5SAN9BKD2BxYEQKrO6ADRnxMNPiS6lWCDMvPKS2GY1jo
 E/DdKiUfau7fidR9mjC1SXJS4fqgdd4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-kHTwb_LXNR6VaN7OQ0SHOA-1; Wed, 20 May 2020 07:52:00 -0400
X-MC-Unique: kHTwb_LXNR6VaN7OQ0SHOA-1
Received: by mail-wm1-f71.google.com with SMTP id x11so813682wmc.9
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 04:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vnHlZkpkMD88YLwfQaGLyZ1jkoDQo7m4X1Goc6uh+/g=;
 b=hnXyyeb+5DolFGCy9xYjREYPBNn7vGrjcOa6NH177rSPaLqampNMphXS9sT3ny1ICY
 HEdwz5KQ0B2zXfW1Ssh1vxhc1vN1tIHpuJkrDiPg31kOWos3Aod5YqUfrNNnOPsHnw84
 1Cg352dQYyGyzmwzbwfzBebxeshxRJ3JfrDdoJ1fbS/nSitYdDWxaE94hWpnOoRveQRD
 iQmKEZisAVEY/lLdl4hA3rNscjtQfNYw4mCv3eSDP6TsbtW0PpaFgI2ZIRArbL1bp6mK
 DxW2LmeJe7gDMrypdIYQwR4jlkeZrXFN/I3M6cCyS2n5kq7NKejs7+a+ZlO28LrcbT6x
 P95A==
X-Gm-Message-State: AOAM5303Xc1tz9kmgZ893j2pgYRTgAzzBb/MaQe8+CkfzVua9kv72jgf
 5k9ekoozPXPOEHcjdKv/pjbrfN1uY3WjWpwZfCrBkLTiFvTl3orsZM1XxvUHWowWAa/ZqOoneF8
 Fw0c3Le6sDJzZRlA=
X-Received: by 2002:a5d:6145:: with SMTP id y5mr3630769wrt.195.1589975518191; 
 Wed, 20 May 2020 04:51:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztol5Aa0OhfAsiUuZAVLRcg4l+A3BnkXsOB6edHo+uZCX9bVRj0kdU91sEsWO8hO3gvSs3MQ==
X-Received: by 2002:a5d:6145:: with SMTP id y5mr3630752wrt.195.1589975517974; 
 Wed, 20 May 2020 04:51:57 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id m1sm2813974wrx.44.2020.05.20.04.51.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 04:51:57 -0700 (PDT)
Subject: Re: [PATCH 40/55] hw/arm/armsse: Pass correct child size to
 sysbus_init_child_obj()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-41-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cf2296d8-13dd-8a6a-2d12-5d852ef8d3e8@redhat.com>
Date: Wed, 20 May 2020 13:51:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200519145551.22836-41-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 02:22:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 4:55 PM, Markus Armbruster wrote:
> armsse_init() initializes s->armv7m[i] for all i.  It passes the size
> of the entire array instead of the array element to
> sysbus_init_child_obj().  Harmless, but fix it anyway.

Harmless because the size used to initialize the object is the one 
declared by its TypeInfo::instance_size. In this case for TYPE_ARMV7M it is:

static const TypeInfo armv7m_info = {
     .name = TYPE_ARMV7M,
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(ARMv7MState),

How did you notice btw?

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/arm/armsse.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
> index 20bedbe044..b6276b7327 100644
> --- a/hw/arm/armsse.c
> +++ b/hw/arm/armsse.c
> @@ -258,7 +258,8 @@ static void armsse_init(Object *obj)
>   
>           name = g_strdup_printf("armv7m%d", i);
>           sysbus_init_child_obj(OBJECT(&s->cluster[i]), name,
> -                              &s->armv7m[i], sizeof(s->armv7m), TYPE_ARMV7M);
> +                              &s->armv7m[i], sizeof(s->armv7m[i]),
> +                              TYPE_ARMV7M);
>           qdev_prop_set_string(DEVICE(&s->armv7m[i]), "cpu-type",
>                                ARM_CPU_TYPE_NAME("cortex-m33"));
>           g_free(name);
> 


