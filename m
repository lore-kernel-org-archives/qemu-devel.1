Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97F3C4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 15:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B26C0205F4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 15:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26C0205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCQbh-0004zI-LW
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 11:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iCQaO-0004Sm-LM
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 11:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iCQaM-0006tm-82
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 11:49:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32507)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iCQaL-0006tE-Ul
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 11:49:10 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 67CAAC034E71
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 15:49:08 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id t185so5160028wmg.4
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 08:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rLZoAHL4053TY5LQ3zIiL03ZSfiWx+NpcRtn9F9VpRw=;
 b=NG9NlvMA+iXIt1TMyhtB0EP/ck3Oby/3EA2s3YKibDkf2d+AcyqwUeXfQPKPEF9Zzq
 Y5JWZLQQoiyoSZEd/kfKMZvF9IMqumxsDeIk2xFuebAkvnuI9dkXOwQ2nxCxcNYfGwoE
 4T/6+eFoYuV5SEMfd2FUZLifWEgq9jRPJhZYOltxW28sVr3tZOnGfMu2dRaCTN0BpGzL
 6eCkVgJrH53t1QzYQ5Qt4girxpHnL7VJX+kszsDeBYhvkpq3lwAKnnjbI7jFWaCZ0/p4
 Cmdj+/Q+1PVkcFrOBX4UauvDRXDWxwxTL5Xl5W6ysSrtFvsXXap5N2Lm+WS5iw0NBHHH
 9uPQ==
X-Gm-Message-State: APjAAAVFjO0DJP1wzv6NqONwKdM2amsdf5r5Zvy+vNpytEFzd7JfiJU7
 H254rs9s7zowol22dgtcfL1xEHPfK5UplDcQB/KzC3wWJ1c5pOWFtIjUkfM8NdIm2o6DjvFR1zp
 U7nu1JRy6UTHFmh0=
X-Received: by 2002:adf:ec44:: with SMTP id w4mr57322wrn.251.1569253747180;
 Mon, 23 Sep 2019 08:49:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzlXxA88Gvahzr3GdjuKvl/WRUNi2a+PQbi3QBtq+MiXLLP+2GOQKnZCXkSYBheOsx+UwAmCw==
X-Received: by 2002:adf:ec44:: with SMTP id w4mr57305wrn.251.1569253746989;
 Mon, 23 Sep 2019 08:49:06 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id y13sm15094095wrg.8.2019.09.23.08.49.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2019 08:49:06 -0700 (PDT)
Subject: Re: [PATCH v24 06/22] target/rx: CPU definition
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190912060701.4642-1-ysato@users.sourceforge.jp>
 <20190912060701.4642-7-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <17bfddf9-1f17-a16d-4091-8ed3d78b0376@redhat.com>
Date: Mon, 23 Sep 2019 17:49:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190912060701.4642-7-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/12/19 8:06 AM, Yoshinori Sato wrote:
> v21 changes

FYI Please add changes bellow the '---' separator.

> Add cpu-param.h
> Remove CPU_COMMON
> rx_load_image move to rx-virt.
>=20
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>=20
> Message-Id: <20190616142836.10614-4-ysato@users.sourceforge.jp>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20190607091116.49044-4-ysato@users.sourceforge.jp>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> [PMD: Use newer QOM style, split cpu-qom.h, restrict access to
>  extable array, use rx_cpu_tlb_fill() extracted from patch of
>  Yoshinori Sato 'Convert to CPUClass::tlb_fill']
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> cpu.c: remove rx_load_image
>=20
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

This one has:
Acked-by: Igor Mammedov <imammedo@redhat.com>
https://www.mail-archive.com/qemu-devel@nongnu.org/msg625231.html

> ---

Here:

Changes since v21:
  ...

>  target/rx/cpu-param.h   |  31 ++++++
>  target/rx/cpu-qom.h     |  42 ++++++++
>  target/rx/cpu.h         | 181 +++++++++++++++++++++++++++++++++
>  target/rx/cpu.c         | 217 ++++++++++++++++++++++++++++++++++++++++
>  target/rx/gdbstub.c     | 112 +++++++++++++++++++++
>  target/rx/Makefile.objs |   1 -
>  6 files changed, 583 insertions(+), 1 deletion(-)
>  create mode 100644 target/rx/cpu-param.h
>  create mode 100644 target/rx/cpu-qom.h
>  create mode 100644 target/rx/cpu.h
>  create mode 100644 target/rx/cpu.c
>  create mode 100644 target/rx/gdbstub.c
[...]

