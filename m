Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C576EC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C2DB20722
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EX5u3JHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2DB20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFEn0-0002VD-Pu
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 06:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFEmP-00021E-Lf
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:21:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFEmO-0003Sa-MS
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:21:29 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:56859)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFEmO-0003S9-JX
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584699687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w1BVYF1/gUGu4o60IpbflJ+WZGEJriA5XEMEc7EKGu8=;
 b=EX5u3JHFCptjCVAaus+sNNuzuSL/kkt2TbJcV17UqsCx5LHtmagbCXEiW2VvfQoNobqlA3
 u/DOwsTUCzpoaYHqOGaEXtiYB9qbDTrN9QLld9MAGU7oqpdG0dzLamaQTZv2xlKb9ZyVEI
 GrfvuS9b5VuBmRKzkEXVknf3DtPu2HE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-lG0LvJdyNumUZ157ExIU-A-1; Fri, 20 Mar 2020 06:21:24 -0400
X-MC-Unique: lG0LvJdyNumUZ157ExIU-A-1
Received: by mail-ed1-f71.google.com with SMTP id b12so1745595edy.7
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 03:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QfgPsMObFkSCKoo66PQFjgLx3fL9DzKvLlsiIWEzoCI=;
 b=e4jrYuimyFq+b2Q1srj/QXJiV6gLxOGoHa/OSdVUTEzKRNJPkYOOTl7jLNdMjaLDzq
 CzP4AeAKD8rKK25zEi/NqsShxtaD2kZwsuDhZLQje0tvti2HxfOxEk7yqHsgdAwJv9NI
 DQBWua+qHEcVIXN5qX1FRTLE3B6Oj//V/8uNgsS2RI5jAGaEShd8dXQjDjcTbHB1qggC
 GpuJj8iZ9ez2VPGxBMfmDk10CDS9vySTMc8tknJ6vefIJQVNujRw3AqbDawgb+2iUrup
 XblFvM8MHFnt0+mIwwQJeV2IApho7qCcy5jZWANwxBemMNMNzyK2Q5wkQJPHZ15FkGxe
 P9hw==
X-Gm-Message-State: ANhLgQ2QjJQDPDJXWwmGG+ugAOjJfMfnTjpRrgmlK+ExDFbN7owvKGJo
 edhQ0lGyFMhmI+bnQG7IkzEydEX0vhzxpeurh77ZOdpZt5xWqI9MhWCZC0aC0T2XyigxoqLo/UC
 Suw/TQgJ1WJiZMmg=
X-Received: by 2002:a17:906:1805:: with SMTP id
 v5mr7190804eje.261.1584699683668; 
 Fri, 20 Mar 2020 03:21:23 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuM835ILaJG3rXpFFF1h5g6Ni23YENKrjQzLSRTA9OPhJuNZF/Wbbs+cSRWZ0n3ZJtSSwRLlA==
X-Received: by 2002:a17:906:1805:: with SMTP id
 v5mr7190785eje.261.1584699683317; 
 Fri, 20 Mar 2020 03:21:23 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id q8sm323784edn.84.2020.03.20.03.21.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2020 03:21:22 -0700 (PDT)
Subject: Re: [PATCH 3/3] iotests: Increase pause_wait() timeout
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200313083617.8326-1-kwolf@redhat.com>
 <20200313083617.8326-4-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0bce89e1-7bce-68bf-7bf0-194a273eebb4@redhat.com>
Date: Fri, 20 Mar 2020 11:21:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313083617.8326-4-kwolf@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 9:36 AM, Kevin Wolf wrote:
> Waiting for only 1 second proved to be too short on a loaded system,
> resulting in false positives when testing pull requests. Increase the
> timeout a bit to make this less likely.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index b859c303a2..7bc4934cd2 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -925,7 +925,7 @@ class QMPTestCase(unittest.TestCase):
>           self.assert_qmp(event, 'data/type', 'mirror')
>  =20
>       def pause_wait(self, job_id=3D'job0'):
> -        with Timeout(1, "Timeout waiting for job to pause"):
> +        with Timeout(3, "Timeout waiting for job to pause"):
>               while True:
>                   result =3D self.vm.qmp('query-block-jobs')
>                   found =3D False
>=20

I wonder if this might be more accurate:

   load_timeout =3D math.ceil(os.getloadavg()[0])
   with Timeout(1 + load_timeout, "Timeout waiting for job to pause"):
     ...

Anyhow:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


