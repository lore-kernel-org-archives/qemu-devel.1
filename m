Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08B6C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 09:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6931B20644
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 09:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQTsziiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6931B20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOI27-0007vQ-Jq
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 05:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOI18-0007Q2-Vq
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOI15-0007EE-8G
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:38:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28589
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOI15-0007E1-5W
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586857082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0jbB3pikUjPU9NrzFbr1fFCeXqOoX/Ra+nmoqUItGVk=;
 b=IQTsziiWW9dJrp+i3dDKqkxH1LGOMJnRzfRjSeBKoV9dY7U5FcZLogfwyJuK35bB3x8tmU
 QGZ0DIZjC14XvZbkD2s6x5Ogp6g5bg/YUVkzJ8ZZPafBwXrWZB2bnkpywiLUMQb31iuvn/
 AB43OC0OCmS1ptttlAXw8Ck5Jl67K4E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-Szdn-4YXMFmx_CNJYjTJdQ-1; Tue, 14 Apr 2020 05:38:01 -0400
X-MC-Unique: Szdn-4YXMFmx_CNJYjTJdQ-1
Received: by mail-wr1-f69.google.com with SMTP id r11so7336119wrx.21
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 02:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Tdsg6LC9X93nhI/mzVq7wwYntXPHCAZPxD700gD3evM=;
 b=E5Pk1hSmfk5r72A4jcz7SP2is/qKs6Rl0G6TuTvLVQwZwHKX58wMurJTEM9bdbrIUQ
 i/BJuWJMH7pSxNl7cjRdjGQwYuKx1XAjEj7fBgoa6LNkNksoBSV9RzC/Mq7HUK8vW3qR
 ndgO1DfECIKeu6GlCDiihLTDtVnIUNQT1UnGFLUNliwgfxw1iOqSErhEJm2wwXVzQ/NU
 wpxMIrkIxYSOnR6cUTGCl2wmNmGoq70HvRS8CsmL3QDkJVz7CZjnU89y+ZM81SiOaX+m
 a9AxyV9atvk0WUS5CWwATMNaf1xNvEHp6p7RHOz3lL7jo8/1HQsaxUZFt2PzZOJoR5Zd
 ODpw==
X-Gm-Message-State: AGi0PuYB5h/VzaC/RywZmnYU91567LYWD9ExExx473APFN2nA3XM8C6p
 2aycEHXhh+WZcyBV/P5Z6tDOaiOGqrjuVo3MkOdJseIZYo35LBpKb24bt2q1l1dlH5BLYdkN+52
 S7UpHS2XmQMaOHJE=
X-Received: by 2002:a1c:a553:: with SMTP id o80mr21965074wme.159.1586857080439; 
 Tue, 14 Apr 2020 02:38:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypInlCDQswgnT9KR5/FsgYVYvpFkow5vyMm9uBjBe7wM/fvRbYR8S/+FtJh/1HFja2mx59Az0g==
X-Received: by 2002:a1c:a553:: with SMTP id o80mr21965055wme.159.1586857080247; 
 Tue, 14 Apr 2020 02:38:00 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id x18sm18117642wrs.11.2020.04.14.02.37.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 02:37:59 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] hw/vfio: let read-only flag take effect for mmap'd
 regions
To: Yan Zhao <yan.y.zhao@intel.com>, qemu-devel@nongnu.org
References: <20200413063627.84608-1-yan.y.zhao@intel.com>
 <20200413063747.84753-1-yan.y.zhao@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c2a0631b-4c2a-6b46-ec11-cd247b751dae@redhat.com>
Date: Tue, 14 Apr 2020 11:37:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200413063747.84753-1-yan.y.zhao@intel.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: pbonzini@redhat.com, alex.williamson@redhat.com,
 Xin Zeng <xin.zeng@intel.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/13/20 8:37 AM, Yan Zhao wrote:
> along side setting host page table to be read-only, the memory regions
> are also required to be read-only, so that when guest writes to the
> read-only & mmap'd regions, vmexits would happen and region write handler=
s
> are called.
>=20
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> ---
>   hw/vfio/common.c | 4 ++++
>   1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index fd6ee1fe3e..fc7618e041 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -977,6 +977,10 @@ int vfio_region_mmap(VFIORegion *region)
>                                             name, region->mmaps[i].size,
>                                             region->mmaps[i].mmap);
>           g_free(name);
> +
> +        if (!(region->flags & VFIO_REGION_INFO_FLAG_WRITE)) {
> +            memory_region_set_readonly(&region->mmaps[i].mem, true);
> +        }
>           memory_region_add_subregion(region->mem, region->mmaps[i].offse=
t,
>                                       &region->mmaps[i].mem);
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


