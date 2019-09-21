Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4404C49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 09:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1BCB2086A
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 09:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BCB2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBc65-0005sv-Qw
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 05:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBc53-0005JE-JQ
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 05:53:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBc51-0002Yg-4D
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 05:53:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33416)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBc50-0002YC-Vc
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 05:53:27 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5C1712A41
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 09:53:25 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id a4so3252001wrg.8
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 02:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PEMER9FwqqNka00xrifdwyrLgSgxHaZ5PxH5hgYIET0=;
 b=AW17zjjfjIdmKJc0fu8eV9aahw2VtxMobKsygy4QBCdVbvMct7fgMCmrvGRFC0SzZW
 5HpcTjP8aK4w/gYgphWIPdsmK8mMUeMYYk3soPs7zE4fHiq0PHcANEXnZ71bfU2xW9Rh
 lOJaT/0mKD5D54OLDKYpTDUT0/dzmzszqPfR+u6fTfc1Z+w/942HiNbH0kTF5EHViDMr
 uaBWZNra61kIKgQn/Cb5tZBtu6nhHHrb5MTDT/Xz4OfoqrhPz/G19va2sC8+gDQRWT5J
 pB9p3Ig8s2h36VmKgiTdBMbkuJAbvSRhE0dsIhokcIMx4yoTBkMRZAHPVGX0KShnmB87
 dSsw==
X-Gm-Message-State: APjAAAU37kZSl6d4FHh7HFB8zWncPf5jmBNsjCkvZ68hTN7yvI6HDprX
 EyzxLEtKebK7LbPv0zfKH1NLzm8d1LGXSyiaYqKGtKTO34xLi30nJ4PJzQJI0rh+lVC0JZB3tPB
 cTEtq0YbTJRiTQoQ=
X-Received: by 2002:a7b:cbd0:: with SMTP id n16mr6342391wmi.82.1569059604112; 
 Sat, 21 Sep 2019 02:53:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzxOaJuJ4daycYK5X4A26Te7NOFEKJ+w/j1WAlxzshFH4kz0nKyMg7DCoFOlux+LmNxtN/9Pw==
X-Received: by 2002:a7b:cbd0:: with SMTP id n16mr6342379wmi.82.1569059603938; 
 Sat, 21 Sep 2019 02:53:23 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id 207sm8685330wme.17.2019.09.21.02.53.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Sep 2019 02:53:23 -0700 (PDT)
Subject: Re: [PATCH 3/3] docker: remove unused debian-sid and debian-ports
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190920001413.22567-1-jsnow@redhat.com>
 <20190920001413.22567-4-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <03273f50-3146-328c-fe7c-e437d7b65e0a@redhat.com>
Date: Sat, 21 Sep 2019 11:53:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190920001413.22567-4-jsnow@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi John,

On 9/20/19 2:14 AM, John Snow wrote:
> These are listed as "partial" images, but have no user.
> Remove them.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/docker/Makefile.include                |  4 +--
>  tests/docker/dockerfiles/debian-ports.docker | 36 --------------------
>  tests/docker/dockerfiles/debian-sid.docker   | 35 -------------------
>  3 files changed, 2 insertions(+), 73 deletions(-)
>  delete mode 100644 tests/docker/dockerfiles/debian-ports.docker
>  delete mode 100644 tests/docker/dockerfiles/debian-sid.docker

Can you split this patch in 2, one per image? That will ease the reverts.

Once splitted feel free to add to each new patch:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks,

Phil.

