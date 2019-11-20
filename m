Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DECC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D6520637
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKZx9Puw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D6520637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXT4y-0001N6-B1
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:43:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iXT3i-0000OF-3P
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:42:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iXT3h-000147-0H
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:42:26 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52659
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iXT3g-00013d-TN
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:42:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574268144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9KI43LfNLY1yvwVstRW6qlRhYW7vbci8u7TYLANb7bc=;
 b=NKZx9PuwTtPnhtroctN7qFJwkBsoq74On2qV6q9o/pF+wQbe/vpAVgUNH+Zca+vQfrmEgQ
 RJEZerc6gepjDnF6vZU7mvJRqAXhGmcolteGgNjIRlVi0FHJCdclcHSpi8qf5KeLW00Dr6
 qW06i+aBjJ4HAg+/mnRvef6yOnWM3aU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-ka0zkqmMMPK_v4ucNN-s5Q-1; Wed, 20 Nov 2019 11:42:23 -0500
Received: by mail-wr1-f71.google.com with SMTP id z10so4582618wrr.5
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:42:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R50SDX6rAN6EiTQYpY/YuNv7/p9X/91RVUYaeedhswA=;
 b=RLEc+X15np92MWh/BznK5qXPeqBJKgQUuZ9d1ZvvApeNnw0ZD9ZBBmJ6ATDMA6QDmB
 nemB6LfpldZelTQ9uT3rKhXfK8UBQWaddhC/vMabSjPmN6//wji4OSQgjk9iHsv7qbWP
 a3ZIWkZvRChfWWhZiDpSpPpsAoRmJOfs033QHeFiSLrs4ZtqF1n7PSEfQ6rfeZhfM13A
 ZRUepNrqar7mcSyn00+wfnK+WGjzhCZOV1EAriiZV3imUaarH4QN3KRWngFmxgpHKAGg
 JzlZmgp4i5gNqPlhBjUjQrOC53XWkCO+ZMfONdzUKlB1PdEQb9/26uhIsf8pNyCk2HR3
 EVjQ==
X-Gm-Message-State: APjAAAWPFctF83h/GsGxM1cjNUI2jZDoI6KAKpAaQaIg1smadY3tgHqD
 7AWhsUdR2MAGLWyYPH8rzC695j0ykxS5QwnKCKeDo9WdhNls3q7/A/5ZN2SkU49zfLDjrqbhLIe
 IKMwVvWYDZqjRZ7I=
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr4416625wru.52.1574268141979;
 Wed, 20 Nov 2019 08:42:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqzjqv4fPtXxo5LyUfMtNmVDqMJJa8OLq6Zeougm5OVMDPE+IjbEw/k3E/pN5g7n0khE7reobg==
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr4416591wru.52.1574268141807;
 Wed, 20 Nov 2019 08:42:21 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id n1sm32559877wrr.24.2019.11.20.08.42.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2019 08:42:21 -0800 (PST)
Subject: Re: [PATCH for 4.2?] tests/vm/centos: fix centos build target
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191120161436.13937-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6500bd91-3d39-3979-83c7-5717e5dc1676@redhat.com>
Date: Wed, 20 Nov 2019 17:42:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120161436.13937-1-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: ka0zkqmMMPK_v4ucNN-s5Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 5:14 PM, Alex Benn=C3=A9e wrote:
> To be able to run the docker tests centos has here we have to install
> python3 as well as the basic tools.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   tests/vm/centos | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/vm/centos b/tests/vm/centos
> index 53976f1c4c9..b9e851f2d33 100755
> --- a/tests/vm/centos
> +++ b/tests/vm/centos
> @@ -73,7 +73,7 @@ class CentosVM(basevm.BaseVM):
>           self.wait_ssh()
>           self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
>           self.ssh_root_check("yum update -y")
> -        self.ssh_root_check("yum install -y docker make git")
> +        self.ssh_root_check("yum install -y docker make git python3")
>           self.ssh_root_check("systemctl enable docker")
>           self.ssh_root("poweroff")
>           self.wait()
>=20

It would be nice to have this fixed in 4.2.
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


