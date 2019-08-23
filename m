Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8AEC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10AA22173E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10AA22173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i192L-0001DR-7r
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 08:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i190q-00082H-OQ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i190j-0005D6-Rf
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:49:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16746)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i190c-00055l-He
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:49:43 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AAFF359465
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 12:49:33 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id n13so2951777wmi.4
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 05:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WRD5ecKdphIcJ09ynHQsRdoCdxLqUZnmTnAoX3vpU5c=;
 b=rdgSYEsBjqDupymXk3dOsSbuipxVhu8JVEHZej14CMdfOrehE0pVO36swQhgtqwcNs
 YwgT0Uo3RhCA0e1U56wtQauDaYdm3IjUAzPt6Vqvk82anx8wRHXh/nSlXagulmpOxc9S
 JBpIK550xd2aWslkwXJqvg8DeT1t7G0KFHeQPXC7oL18dTzXSTBXcz/rAWmsqABoAccI
 xbjGWYc6qnhVrUD6QgQy5YJBQBtlPxbgQrAs/5phrRvzEdfV+EXbAiwZZmX1rE6o8pwt
 yUUMvbjOper7BScV4NmO2CNcVONbhJhCOtAqDR/7JoOlKAZoZ17Cy/m4OVNj3HG8csSn
 +qsg==
X-Gm-Message-State: APjAAAX9O16ZZs5rkJbjpmHN9tl97utr8J0FLCPrfOazTwobte6b8eEH
 VvjHYil5uy3U9m9ozkHSymKdPuidQIrxb0mPjqxrMmENBmeOVB6mqFm78FGBHzMakkwFOwXvyA/
 bpsHSPj8sSgeaTkw=
X-Received: by 2002:a5d:4492:: with SMTP id j18mr4939165wrq.53.1566564572098; 
 Fri, 23 Aug 2019 05:49:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxLZgLnFu0Hxo76TjenuM0ZrmYAPFrDhm7qEfbrKshizSj6pcQgJ1WC7O1jMx6jYfo1ZhZ/0w==
X-Received: by 2002:a5d:4492:: with SMTP id j18mr4939152wrq.53.1566564571970; 
 Fri, 23 Aug 2019 05:49:31 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id e3sm5200611wrs.37.2019.08.23.05.49.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Aug 2019 05:49:31 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20190823092401.11883-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ec7f6b75-abf0-dbd5-784f-404f7a78941a@redhat.com>
Date: Fri, 23 Aug 2019 14:49:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190823092401.11883-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] virtiofsd: use "fuse_log.h" APIs
 instead of <err.h>
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

On 8/23/19 11:23 AM, Stefan Hajnoczi wrote:
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

Series:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

