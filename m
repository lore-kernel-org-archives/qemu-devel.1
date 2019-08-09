Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B7CC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C5152166E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5152166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw1fp-0001py-S2
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 05:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53894)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hw1fR-0001Ol-7B
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hw1fQ-0000Tb-6L
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:58:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hw1fP-0000Sx-VK
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:58:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id q12so7414525wrj.12
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 02:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ME7GlRtQW6slHLJe9Jwo11j0CK5qf8aYLBG7O4WasOE=;
 b=i56IKpeVLJ79ZIPX6iomDv7XqEEJbMah1A7PaPrJwp0WTaWPT7Dqt474nctofQLCeG
 mqjE6zg9Vlyug2EgfiYNQ3qy0yiCgKmFL47J076XcglNJmcFrM1QeY/wutMh0OiiO4VD
 /MhBMRzCEalCR/w9xO710nKVbarsIRmqXE/dIWEphOvTyZBq5IAH/f9qWAzuEIgT5ffJ
 KwzV3oUj6BOQiHsmYfacrlG03MocvDpyg9xIsyMX19GlmreIsWCWOSC0ZWWR/FTuXdDz
 C++DTQwtaQhuT0DqWw+ewwEJ6lm6qPVlgvjWehTZA37UlKx2uJUSjQewAJGQxIu7zzWl
 2RGQ==
X-Gm-Message-State: APjAAAUfupiAHV3eACU5lUyPBoWoyK+GmSetpdZG6cGTglzG/Iw59KyE
 kxeNBnfIbJyRxo28WaMWjVOEcnlA43A=
X-Google-Smtp-Source: APXvYqwqo24xlzeAKVyzmIhW3bGMUE1P7iXRKKrmxjKs+zC/PIXtszNAMxtYRqfUTeHjPJbY8aP0aQ==
X-Received: by 2002:a5d:4cca:: with SMTP id c10mr21917868wrt.233.1565344714801; 
 Fri, 09 Aug 2019 02:58:34 -0700 (PDT)
Received: from [192.168.50.36] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id q124sm7344910wma.33.2019.08.09.02.58.33
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Aug 2019 02:58:34 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190809064645.22656-1-armbru@redhat.com>
 <20190809064645.22656-10-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0d4d0864-36e3-cdab-f389-ce725382175f@redhat.com>
Date: Fri, 9 Aug 2019 11:58:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190809064645.22656-10-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v3 09/29] Include
 migration/qemu-file-types.h a lot less
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

On 8/9/19 8:46 AM, Markus Armbruster wrote:
> In my "build everything" tree, changing migration/qemu-file-types.h
> triggers a recompile of some 2600 out of 6600 objects (not counting
> tests and objects that don't depend on qemu/osdep.h).
> 
> The culprit is again hw/hw.h, which supposedly includes it for
> convenience.
> 
> Include migration/qemu-file-types.h only where it's needed.  Touching
> it now recompiles less than 200 objects.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
[...]
> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
> index d0be755c82..83c72ee18d 100644
> --- a/hw/intc/s390_flic.c
> +++ b/hw/intc/s390_flic.c
> @@ -22,6 +22,7 @@
>  #include "hw/qdev.h"
>  #include "qapi/error.h"
>  #include "hw/s390x/s390-virtio-ccw.h"
> +#include "migration/qemu-file-types.h"
>  
>  S390FLICStateClass *s390_get_flic_class(S390FLICState *fs)
>  {

I am not sure this one requires it.
Did you edit the incorrect file? I still get:

$ make docker-run-test-build@debian-s390x-cross
[...]
hw/intc/s390_flic_kvm.c: In function 'kvm_flic_save':
hw/intc/s390_flic_kvm.c:395:9: error: implicit declaration of function
'qemu_put_be64' [-Werror=implicit-function-declaration]
         qemu_put_be64(f, FLIC_FAILED);
         ^~~~~~~~~~~~~

