Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391FDC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 13:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 029B8222C6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 13:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrPWcoXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029B8222C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUskC-000209-85
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 08:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iUsjG-0001Xq-1V
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 08:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iUsjD-0006oK-VC
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 08:30:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26122
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iUsjD-0006nk-Rd
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 08:30:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573651834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LTFmDWd/KafWhCImWW0P0bBQkqmOUws8D+s+PYN5xNs=;
 b=hrPWcoXRwyO71cQmlgmx9KMMWPXA3DbCk1iodK8LZ8zysY1SFncxizODfbXDdkOlgxc8sl
 +ao3/TzoS4Rcz0Q1w3kKVa9BR/13EmnqYdqRGdygd1QPP3BrMcSGbPcfy4CmwpMxg5mTMC
 4JMZApqDZPdkyGcOEKJhB7Mm3DSajLE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-IBuJyWnUNimkgaGVkkYaMA-1; Wed, 13 Nov 2019 08:30:33 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF143800C77;
 Wed, 13 Nov 2019 13:30:31 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-183.ams2.redhat.com
 [10.36.116.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1196B6293B;
 Wed, 13 Nov 2019 13:30:19 +0000 (UTC)
Subject: Re: [PATCH v1 5/5] .travis.yml: drop 32 bit systems from
 MAIN_SOFTMMU_TARGETS
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191113115952.775-1-alex.bennee@linaro.org>
 <20191113115952.775-6-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3782cc8a-72c4-3509-0c70-7f03753b36f3@redhat.com>
Date: Wed, 13 Nov 2019 14:30:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191113115952.775-6-alex.bennee@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: IBuJyWnUNimkgaGVkkYaMA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/11/2019 12.59, Alex Benn=C3=A9e wrote:
> The older clangs are still struggling to build and run everything
> withing the 50 minute timeout so lets lighten the load a bit more. We
> still have coverage for GCC and hopefully no obscure 32 bit guest only
> breakages slip through the cracks.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index b9a026c8eeb..c09b6a00143 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -79,7 +79,7 @@ env:
>      - BASE_CONFIG=3D"--disable-docs --disable-tools"
>      - TEST_CMD=3D"make check V=3D1"
>      # This is broadly a list of "mainline" softmmu targets which have su=
pport across the major distros
> -    - MAIN_SOFTMMU_TARGETS=3D"aarch64-softmmu,arm-softmmu,i386-softmmu,m=
ips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_=
64-softmmu"
> +    - MAIN_SOFTMMU_TARGETS=3D"aarch64-softmmu,mips64-softmmu,ppc64-softm=
mu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
>      - CCACHE_SLOPPINESS=3D"include_file_ctime,include_file_mtime"
>      - CCACHE_MAXSIZE=3D1G

Reviewed-by: Thomas Huth <thuth@redhat.com>


