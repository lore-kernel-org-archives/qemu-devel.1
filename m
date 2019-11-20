Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F48C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE7B720878
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHMMolLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7B720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXUAP-0004RM-3q
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 12:53:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iXU9Z-0002Ty-30
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:52:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iXU9Y-0002k8-1L
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:52:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57941
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iXU9X-0002jm-TU
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:52:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574272351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAR8MfjVK4V42e6jVIwF1XUYdIzF0wFyJUlThOcGw0Y=;
 b=KHMMolLbh9LpQ1+uUeQ3g4NlpeooCrtfCweYTtWR16vIzbLWa9TjGxgl22//iRiIoWagEj
 UuzZO77Z3uomloix9RqtaoM2ETBJg8SaIRV17Z5+Vw54aTtlY3OgvADxGzosyae3vgYMeV
 a1jN7v9wGnVSozoJ1IeZESexgfMMo5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-1VpDyMd4PUyJEvhLD7XgnA-1; Wed, 20 Nov 2019 12:52:27 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A81A801E5D;
 Wed, 20 Nov 2019 17:52:26 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-98.rdu2.redhat.com
 [10.10.120.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 140522AA8B;
 Wed, 20 Nov 2019 17:52:22 +0000 (UTC)
Subject: Re: [PATCH for 4.2?] tests/vm/centos: fix centos build target
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191120161436.13937-1-alex.bennee@linaro.org>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <edfafd2b-35f7-c7b9-96c3-048dcb5988fb@redhat.com>
Date: Wed, 20 Nov 2019 15:52:21 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191120161436.13937-1-alex.bennee@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 1VpDyMd4PUyJEvhLD7XgnA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 11/20/19 2:14 PM, Alex Benn=C3=A9e wrote:
> To be able to run the docker tests centos has here we have to install
> python3 as well as the basic tools.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   tests/vm/centos | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


>
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


