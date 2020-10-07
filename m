Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A2AC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 06:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA22206F7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 06:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZ6r9bwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA22206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ3Dr-0003ON-VR
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 02:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kQ3BE-0001vk-VT
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 02:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kQ3BD-00058D-0P
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 02:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602053042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K5HkoXL0p6BDlBw5EYi/PnxPTeHvpeahPhnZHvYBp6s=;
 b=LZ6r9bwE84oKv9lW07FqyNuxxTOq3rfwcz6gcX/bZwnwxGb+Vw/BuC8WW6nF0EECC9//ks
 qMLZQmYbnk99MpjHqqkXTUxRoG7rPqvi0MBfAchExvwQXippbEKlObnsG04U9viVhnRV1o
 rPure3Cx27Z2J8HIORXapVtiwX9w2JA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-e6WrnHpANdSunrT07LF28w-1; Wed, 07 Oct 2020 02:43:49 -0400
X-MC-Unique: e6WrnHpANdSunrT07LF28w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1A411007B23;
 Wed,  7 Oct 2020 06:43:47 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-72.ams2.redhat.com [10.36.113.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5972C5D9DD;
 Wed,  7 Oct 2020 06:43:46 +0000 (UTC)
Subject: Re: [PATCH 1/2] docker: Add win32/msys2/mingw64 docker
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20201007024135.1885-1-luoyonggang@gmail.com>
 <20201007024135.1885-2-luoyonggang@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e437f0ed-20a9-c370-8c87-ceb845513805@redhat.com>
Date: Wed, 7 Oct 2020 08:43:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201007024135.1885-2-luoyonggang@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/10/2020 04.41, Yonggang Luo wrote:
> This docker is used to preparing a msys2/mingw with basic software installed.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  tests/docker/dockerfiles/msys2.docker | 57 +++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/msys2.docker
> 
> diff --git a/tests/docker/dockerfiles/msys2.docker b/tests/docker/dockerfiles/msys2.docker
> new file mode 100644
> index 0000000000..ce1404cbb8
> --- /dev/null
> +++ b/tests/docker/dockerfiles/msys2.docker
> @@ -0,0 +1,57 @@
> +FROM mcr.microsoft.com/windows/servercore:2004
> +RUN cmd /S /C powershell -NoLogo -NoProfile -Command netsh interface ipv4 show interfaces ; netsh interface ipv4 set subinterface 18 mtu=1460 store=persistent ; netsh interface ipv4 show interfaces ; Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) ;
> +RUN choco install -y --no-progress git 7zip
> +RUN cmd /S /C powershell -NoLogo -NoProfile -Command Remove-Item C:\ProgramData\chocolatey\logs -Force -Recurse ; Remove-Item C:\Users\ContainerAdministrator\AppData\Local\Temp -Force -Recurse
> +RUN mkdir C:\tools
> +RUN bitsadmin /transfer msys_download /dynamic /download /priority FOREGROUND https://github.com/msys2/msys2-installer/releases/download/2020-09-03/msys2-base-x86_64-20200903.sfx.exe C:\tools\base.exe
> +RUN cd /d C:\tools && base.exe -y
> +RUN cmd /S /C powershell -NoLogo -NoProfile -Command "((Get-Content -path C:\tools\msys64\etc\\post-install\\07-pacman-key.post -Raw) -replace '--refresh-keys', '--version') | Set-Content -Path C:\tools\msys64\etc\\post-install\\07-pacman-key.post"
> +RUN C:\tools\msys64\usr\bin\bash.exe -lc "sed -i 's/^CheckSpace/#CheckSpace/g' /etc/pacman.conf"
> +RUN C:\tools\msys64\usr\bin\bash.exe -lc "echo $MSYSTEM" >nul 2>&1
> +# RUN C:\tools\msys64\usr\bin\bash.exe -lc "sed -i 's/Server = http:\/\/repo.msys2.org\/msys\/.arch\///g' /etc/pacman.d/mirrorlist.msys"
> +# RUN C:\tools\msys64\usr\bin\bash.exe -lc "sed -i 's/Server = http:\/\/repo.msys2.org\/mingw\/i686\///g' /etc/pacman.d/mirrorlist.mingw32"
> +# RUN C:\tools\msys64\usr\bin\bash.exe -lc "sed -i 's/Server = http:\/\/repo.msys2.org\/mingw\/x86_64\///g' /etc/pacman.d/mirrorlist.mingw64"
> +RUN C:\tools\msys64\usr\bin\bash.exe -lc "grep -rl 'repo.msys2.org/' /etc/pacman.d/mirrorlist.* | xargs sed -i 's/repo.msys2.org\//mirrors.tuna.tsinghua.edu.cn\/msys2\//g'"
> +RUN C:\tools\msys64\usr\bin\pacman.exe --noconfirm -Sy
> +RUN echo Y | C:\tools\msys64\usr\bin\pacman.exe -Suu --noconfirm --needed
> +RUN taskkill /F /FI "MODULES eq msys-2.0.dll"
> +RUN tasklist
> +RUN C:\tools\msys64\usr\bin\bash.exe -lc "pacman.exe --noconfirm -S --needed \
> +base-devel \

base-devel pulls in a lot of stuff that we do not really need (automake...),
can you please replace it with the packages that are really required? See:

https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg00072.html

 Thanks,
  Thomas


