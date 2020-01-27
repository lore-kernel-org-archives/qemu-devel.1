Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA7DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:24:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5D020702
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPfjZYAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5D020702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw4Na-0005ey-MW
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 08:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iw4N0-0005Dt-LD
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:24:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iw4Mz-0004ur-LP
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:24:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51630
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iw4Mz-0004uZ-HB
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580131441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p1O1QP5VExYcO2NDuDo/eiYwAFFLWOgSClQbqHbRZNk=;
 b=LPfjZYAX7E+PCmQG7u0PB0fjLEvVeYTV8ZuzEjtIgk8DKpxsT00j8ZM3Ea0rhQudOcNs12
 hgEhKG3xUez4MzUxcGJqmLsbcsDgICoBBQYg1tbUUJZRj7WUBPxxgxk+ujSCSjY43veGV6
 10itWBaaUQecFjtObdco/ObJdfOP19U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273--7buN78kOsasncsQN6e4Ag-1; Mon, 27 Jan 2020 08:23:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62A601005514;
 Mon, 27 Jan 2020 13:23:58 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-27.gru2.redhat.com
 [10.97.116.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0CB0F5DAB0;
 Mon, 27 Jan 2020 13:23:52 +0000 (UTC)
Subject: Re: [PATCH] .travis.yml: Drop superfluous use of --python=python3
 parameter
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200125184217.30034-1-f4bug@amsat.org>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <e3deb408-da3b-d2fd-97bc-1555d177987b@redhat.com>
Date: Mon, 27 Jan 2020 11:23:51 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200125184217.30034-1-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: -7buN78kOsasncsQN6e4Ag-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/25/20 4:42 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> As we require Python3 since commit ddf9069963, we don't need to
> explicit it with the --python=3D/usr/bin/python3 configure option.
>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Cleber Rosa <crosa@redhat.com>
> ---
>   .travis.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

Thanks!

Wainer


>
> diff --git a/.travis.yml b/.travis.yml
> index 6c1038a0f1..ee93180283 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -268,7 +268,7 @@ matrix:
>  =20
>       # Acceptance (Functional) tests
>       - env:
> -        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-soft=
mmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
> +        - CONFIG=3D"--target-list=3Dx86_64-softmmu,mips-softmmu,mips64el=
-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmm=
u,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
>           - TEST_CMD=3D"make check-acceptance"
>         after_script:
>           - python3 -c 'import json; r =3D json.load(open("tests/results/=
latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["stat=
us"] not in ("PASS", "SKIP")]' | xargs cat


