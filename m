Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42073C83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:13:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E1872082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NR9cTEvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1872082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU3OM-0001ZL-8E
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 03:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU3Mu-0008J9-6N
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU3Mt-0001Bb-MN
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:12:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42708
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jU3Mt-0001BN-8c
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588230742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xif4J33yEkm/6GAGFD7+v7ubJRUK1PD9/aYsTCnM35c=;
 b=NR9cTEvlD6/dDG4uIsWg0qvhyv0WvlP7PJN7GtHtpwgRVWAz8ZJBiixtMAZyJj2iPoJxIz
 IPjcDCS3OMA6sDVRVqRoTBeCZ5INLTcJI6yLk7TR0/QhsdnkLDAV/ZZCqZD3zHZOX8Cxu+
 TvbN9bumMWXstYz1prmsaKAYlijyin4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-QSXkVCeGNqir3HsVtyUBTA-1; Thu, 30 Apr 2020 03:12:19 -0400
X-MC-Unique: QSXkVCeGNqir3HsVtyUBTA-1
Received: by mail-wm1-f70.google.com with SMTP id 72so3657286wmb.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 00:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PbVc2lCKB6I8Bm+rMQripl99hprPRwe7oHttH4C8MZ8=;
 b=j6PaMItG0W6R0Oj7QMJSHRZa/A37BiHvB/lPgDg5ZUpPE2+s/vwNCZBudtAW8GhK+y
 eqCRdUQ+5SImUibefaGZ1wsG5x/eZ38av/4WnhhMCAxudWc8DZMBztxQdk5vcNFafgNm
 iPRaQ5FD+LaQy0occqztSi6zi7MW0Q4b2jyRUU7nmpzgdkEvTWdOPY4NonCFPt3BQDwr
 oIHtZdETlI85BIGLpRNsDK8q9fNbUtTSUGoZfXvbucrAK0tecxNwnqAUXZe3pkclCgAn
 Fs0MrqwHNUtJpneivpKXrn86qXd6xEtb0bkKsjZpkvLhTzfQBmuY2/8eodMEthvuGQtN
 61lA==
X-Gm-Message-State: AGi0PuZTJbavUX9730b98RtPeWGh6N6zggdGZQJL7q0cCI2ZFeNWicIi
 85x/12Vu6K4MF4o5+Y/pGOd2QKXTBm/4jdfgKJD2ov+mke65/xJVtjCB/YC/ZHFhnw9NvOM41zD
 mIIgIruNAunkt4Ew=
X-Received: by 2002:a5d:658e:: with SMTP id q14mr2458964wru.92.1588230738432; 
 Thu, 30 Apr 2020 00:12:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypIZnTtTtE6EdTRTe3tEkTeowT5Mwo18ubDhuLDArRp+cTjbVWrDFt+QD/skB/9+p3rlU4ROkg==
X-Received: by 2002:a5d:658e:: with SMTP id q14mr2458943wru.92.1588230738196; 
 Thu, 30 Apr 2020 00:12:18 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id e21sm2607619wrc.1.2020.04.30.00.12.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 00:12:17 -0700 (PDT)
Subject: Re: [PATCH 01/12] stubs: add isa_create_simple
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200429110214.29037-1-kraxel@redhat.com>
 <20200429110214.29037-2-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3cc48ffd-45d0-23aa-5aeb-724a56e5d287@redhat.com>
Date: Thu, 30 Apr 2020 09:12:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200429110214.29037-2-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/29/20 1:02 PM, Gerd Hoffmann wrote:
> Needed for -soundhw cleanup.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   stubs/isa-bus.c     | 7 +++++++
>   stubs/Makefile.objs | 1 +
>   2 files changed, 8 insertions(+)
>   create mode 100644 stubs/isa-bus.c
>=20
> diff --git a/stubs/isa-bus.c b/stubs/isa-bus.c
> new file mode 100644
> index 000000000000..cbebaed4ad04
> --- /dev/null
> +++ b/stubs/isa-bus.c
> @@ -0,0 +1,7 @@
> +#include "qemu/osdep.h"
> +#include "hw/isa/isa.h"
> +
> +ISADevice *isa_create_simple(ISABus *bus, const char *name)
> +{
> +    return NULL;

We want:

        g_assert_not_reached();

Otherwise:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +}
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 45be5dc0ed78..c61ff38cc801 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -13,6 +13,7 @@ stub-obj-y +=3D get-vm-name.o
>   stub-obj-y +=3D iothread.o
>   stub-obj-y +=3D iothread-lock.o
>   stub-obj-y +=3D is-daemonized.o
> +stub-obj-y +=3D isa-bus.o
>   stub-obj-$(CONFIG_LINUX_AIO) +=3D linux-aio.o
>   stub-obj-$(CONFIG_LINUX_IO_URING) +=3D io_uring.o
>   stub-obj-y +=3D machine-init-done.o
>=20


