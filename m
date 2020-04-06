Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1B1C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 14:17:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9002F23B81
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 14:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6TJWuul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9002F23B81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLSZX-0001xC-IJ
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 10:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1jLSYZ-0000zM-G2
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 10:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1jLSYX-0005T0-RW
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 10:16:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28671
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1jLSYX-0005SJ-Ll
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 10:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586182612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3gEqQSNWrHXHOJFGrx4macWg7VKZYEqB5XrSJWRVqAQ=;
 b=O6TJWuul3U0/4tJMuRTlQjyljbMGSoF1uYQh9Xm8F38OPbDVey8Au5cALEPblA+LKKx11i
 X9XE3NTTJtGrImi28LH95w819m6+ZzQ9wlQHxu2TSDg6UMo08MzSyKzzP8RmmLtXKNZJSv
 yLuta5sYLqOtJpVdzKKocALIAygcE/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-Rz3DaOahMHqedkOmcNi01w-1; Mon, 06 Apr 2020 10:16:46 -0400
X-MC-Unique: Rz3DaOahMHqedkOmcNi01w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3EBA1005509;
 Mon,  6 Apr 2020 14:16:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-15.gru2.redhat.com
 [10.97.116.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8287262697;
 Mon,  6 Apr 2020 14:16:36 +0000 (UTC)
Subject: Re: [PATCH-for-5.0 5/8] .travis.yml: Cache acceptance-test assets
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20200403172919.24621-1-philmd@redhat.com>
 <20200403172919.24621-6-philmd@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <56193f75-ff36-0718-2da1-18033d4899f6@redhat.com>
Date: Mon, 6 Apr 2020 11:16:34 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200403172919.24621-6-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 4/3/20 2:29 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Keep all acceptance-test assets in the same cache bucket.
>
> As of v5.0.0-rc1, the cache is 2610.11MB:
> https://travis-ci.org/github/philmd/qemu/jobs/670558103
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   .travis.yml | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

>
> diff --git a/.travis.yml b/.travis.yml
> index e0c72210b7..2fd63eceaa 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -318,8 +318,10 @@ jobs:
>         env:
>           - CONFIG=3D"--enable-tools --target-list=3Daarch64-softmmu,alph=
a-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el=
-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu=
,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
>           - TEST_CMD=3D"make check-acceptance"
> +        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-acceptance"
>         after_script:
>           - python3 -c 'import json; r =3D json.load(open("tests/results/=
latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["stat=
us"] not in ("PASS", "SKIP")]' | xargs cat
> +        - du -chs $HOME/avocado/data/cache
>         addons:
>           apt:
>             packages:


