Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4339EC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:45:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1809C2070C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1809C2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBEXN-0000YL-LJ
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 04:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBEVS-0007f0-Ke
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBEVR-0004tX-Kn
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:43:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54390)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBEVR-0004tC-GK
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:43:09 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B18D57BDAE
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 08:43:08 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id r21so775838wme.5
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 01:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mValx5GfgXQ8bu2oagYYsmFFn2DUa6eYwNdCv1ePBvY=;
 b=rUNPho2v35avVYocvWNRbEmOdsmFVPKof/SRluqQtZ/uKKoiy2IPOLqtl2HIKYZ4Rx
 ISAMV+xMvSosKCwBlrD0qO2ZQfNnfwmihEMVnFOBngiFipS0bd8Oz9gqrs4qSuxshn6i
 S9mQpyVOi5Zy3RiOeOyEIj9Ke5SsTfmZRUcHIwtNnJjobEL1MxHZwF5T3xP4ek9zcZ3T
 50IDT6lBoyDWpUMzB3vBlsKWUdE2V3oA5m4YrWB+H0+mjODYp/HuIpIfy+HMZI12jh50
 jpVFGbxIiD9s4dtYOCrlLloCL1XpjzLiNtAzQPynVs0k2fvzGzL7RQDxwzG039btMV6Z
 98XA==
X-Gm-Message-State: APjAAAXJG3NVOHAaeR+YTm/8GSNMTWB0Bz2BOWBYERQsikaP3Mxc5YGn
 bq1wEwlahZtWuS8kLwF5m5vNaeh6pCDTMpyldGnMU0r3RfNKT/gDBYv7cvZo6I/b7QiB3pInRGR
 817hZWBvMqobh2Z8=
X-Received: by 2002:adf:e701:: with SMTP id c1mr10430560wrm.296.1568968987183; 
 Fri, 20 Sep 2019 01:43:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzMqEMlKVdhsFjFNUrtF6Jpw/5o7hApK0B2ac3WdZCvn+leBObWtbyR/McPaF6dr9R+65cUcw==
X-Received: by 2002:adf:e701:: with SMTP id c1mr10430542wrm.296.1568968986968; 
 Fri, 20 Sep 2019 01:43:06 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id x5sm1540292wrg.69.2019.09.20.01.43.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2019 01:43:06 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] edk2 build scripts: honor external BaseTools flags
 with uefi-test-tools
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
References: <20190920083808.21399-1-lersek@redhat.com>
 <20190920083808.21399-2-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d83a0575-5292-1049-db17-1aa54c957b74@redhat.com>
Date: Fri, 20 Sep 2019 10:43:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190920083808.21399-2-lersek@redhat.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/19 10:38 AM, Laszlo Ersek wrote:
> Unify the recipe for "build-edk2-tools" in
> "tests/uefi-test-tools/Makefile" with the recipe for "edk2-basetools" i=
n
> "roms/Makefile".
>=20
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>=20
> Notes:
>     v2:
>     - new patch
>=20
>  tests/uefi-test-tools/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/uefi-test-tools/Makefile b/tests/uefi-test-tools/Mak=
efile
> index 1d78bc14d51a..7e0177d7337e 100644
> --- a/tests/uefi-test-tools/Makefile
> +++ b/tests/uefi-test-tools/Makefile
> @@ -99,7 +99,9 @@ Build/bios-tables-test.%.efi: build-edk2-tools
>  	+./build.sh $(edk2_dir) BiosTablesTest $* $@
> =20
>  build-edk2-tools:
> -	$(MAKE) -C $(edk2_dir)/BaseTools
> +	$(MAKE) -C $(edk2_dir)/BaseTools \
> +		EXTRA_OPTFLAGS=3D'$(EDK2_BASETOOLS_OPTFLAGS)' \
> +		EXTRA_LDFLAGS=3D'$(EDK2_BASETOOLS_LDFLAGS)'
> =20
>  clean:
>  	rm -rf Build Conf log
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

