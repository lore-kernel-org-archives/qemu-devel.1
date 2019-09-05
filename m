Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7694FC41514
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 09:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AB1921848
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 09:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB1921848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5nuO-0002je-GR
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 05:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i5nti-0002Ku-9X
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 05:17:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i5ntf-0004ph-AL
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 05:17:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54672)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i5ntf-0004oO-58
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 05:17:43 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4BC8719D381
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 09:17:41 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id v16so699153wrt.17
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 02:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KiLtTlwsNv5qpuxxhRs2H+wtHK5OPrcJKhSIwYvwUkA=;
 b=FbWOUoqf/F+yxOqVYkuLWKaZpsQGet+jJhVXnL66Ua+3N0Z377+M9/C/nLDVkAc566
 l71/tkCgbEZIgW5oGPdALu3tA+OUvYRpniiZxGZhiDK6Td3a2in8Hn0gYDGAsNeEFaCq
 qJtv7D1TuWOAIeeObzuT9ioFsO0cIlbK6ZErdcP1s0hsA5U4bo3MWPTxA+PxDSRKyHeq
 zhI+2rVBZJP9K+pENrCE/0BbUKcyS0fNuhx/DMfe/abKc/kM40vLtll6YfREvmdIuBrJ
 kfHcM21w+z6GKxc1lOw9O10P2n/zYRH2d5WIxeJj4UtDLdZjkZuTewNw5cTYBc6mpYaY
 PS1w==
X-Gm-Message-State: APjAAAXt5QK8kxniY3KBxie7B6Czs+Begmx+AYdgEfg5+ctUZZNJMxwz
 U7r7iAcLw/lr+7P4YIt2JwLN2FOWHTf9CFFr+uTuKuJew5ze41CvinNkdhBascM2qNUVE5akwzP
 H9crRc1a0B2ehNH8=
X-Received: by 2002:a1c:ed1a:: with SMTP id l26mr2234501wmh.34.1567675060090; 
 Thu, 05 Sep 2019 02:17:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwcZjSclZ2AzTVgs8xyXlWdOjGcBWjo5Rt4ny4t4r5dsbMCrlZzyjPrucCCAo+byuBd/8KOAg==
X-Received: by 2002:a1c:ed1a:: with SMTP id l26mr2234491wmh.34.1567675059936; 
 Thu, 05 Sep 2019 02:17:39 -0700 (PDT)
Received: from [192.168.1.48] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id y186sm2258190wmd.26.2019.09.05.02.17.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2019 02:17:39 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 virtio-fs@redhat.com
References: <20190905082947.6633-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6e9ff4f7-2906-3c11-8191-05cff3e60f53@redhat.com>
Date: Thu, 5 Sep 2019 11:17:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190905082947.6633-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH RESEND 0/2] virtiofsd: use "fuse_log.h"
 APIs instead of <err.h>
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

Hi Stefan,

On 9/5/19 10:29 AM, Stefan Hajnoczi wrote:
> warn(3), warnx(3), err(3), and errx(3) print to stderr even when the --=
syslog
> option was given.  In this case messages to stderr are likely to be los=
t and
> this makes troubleshooting hard.  Use "fuse_log.h" APIs instead of <err=
.h>.
>=20
> Stefan Hajnoczi (2):
>   virtiofsd: replace warn(3) and warnx(3) with fuse_warning()
>   virtiofsd: replace err(3) and errx(3) with fuse_err()

Is this a straight RESEND or are there any changes in this series?

I'm asking because IIRC your first series had:
- Reviewed-by: Jun Piao <piaojun@huawei.com>
- Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

If this isn't a RESEND then I'll review it again.

Thanks,

Phil.

