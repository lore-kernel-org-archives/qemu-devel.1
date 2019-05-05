Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868F2C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 04:20:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 343F920675
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 04:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ec2BSCn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343F920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36176 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hN8dc-0007Bh-U5
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 00:20:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hN8cm-0006oT-HD
	for qemu-devel@nongnu.org; Sun, 05 May 2019 00:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hN8cl-0006w4-Hn
	for qemu-devel@nongnu.org; Sun, 05 May 2019 00:19:40 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hN8ck-0006qk-En
	for qemu-devel@nongnu.org; Sun, 05 May 2019 00:19:39 -0400
Received: by mail-wr1-x441.google.com with SMTP id o4so12824766wra.3
	for <qemu-devel@nongnu.org>; Sat, 04 May 2019 21:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=nopKnFwOjHc6KR6x8SXga92c2x3wMzHUKDPYgW2ZjOQ=;
	b=Ec2BSCn8U0LXznTUeyfmg5oLUjKJIdMBzmA6r+/yh1jKq2XilRGMBMN/avu1s2ytaE
	qF9mS9bIDPvHzzX4bNKICLBC3VzY42y6r1uAJuWmhWDcn//FWVPkg9BNvkviMfdyRi0W
	NG2HMb3Qyvy+/7FJnxYq4zQlpdrRb5uJRDUhHPK0LRU8aCZ9DWTEKov+W+qdNTffs3aX
	wTH92Q/S5Wkx20QsjDKHa6Hul6hYl1CyrsxNEJDJVjW+CfKdKL0RyXGpiE4w4GdkBxC7
	CoEN4SOWq4mAtyUaaQLk1/Ra5HJZa6pBb9M9XpJf2oV6wiuIpN18/AtO2omYrw2kIL9S
	xJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=nopKnFwOjHc6KR6x8SXga92c2x3wMzHUKDPYgW2ZjOQ=;
	b=BHy0OvYfhmY0QIiRSUb8YhFvGDHE2gxjV6xaMjthqhujvbMWRWjJ4tuWSCa2veVY0w
	+fIEdRLkpEqXTVwesQTjUAXpFkOLn0PSoY4ETmRbm5b2UosXTY3se3F4Gp/PccA2YSjS
	Exvf66xQwUEoBXsSV+T+ggCsLCbiXdGmWlwFSyAzH+htdRp008NN4sNddkrXCx/bDkN5
	bs2G4yp30NZ4qRmY9l/WRrXQiakhqE4iP5Hb6Ce3xXFXu8cWcKTnML/X3JH7TgCiT58F
	iHslGwrIXdxmUvM/IFPot2eamXibLwpdT5V1E1iaQxjh5niLu4GLu/1oBSCBdQdnZZAt
	bb4g==
X-Gm-Message-State: APjAAAUzh0E33TcG9qD4RM8TtpcOFGOBYchBbhEAKcnPXuCqsb8TvNG8
	DsSZvswc3KXa78odwrBxoW8=
X-Google-Smtp-Source: APXvYqww/1gBojsXRJMDZeveTzjyhVy0r4AWplHumaGPgu30wqXL43A/pD12V+lSYrJgq/juQCD29w==
X-Received: by 2002:a5d:438d:: with SMTP id i13mr2979001wrq.33.1557029976665; 
	Sat, 04 May 2019 21:19:36 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
	by smtp.gmail.com with ESMTPSA id g3sm5740779wmf.9.2019.05.04.21.19.33
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Sat, 04 May 2019 21:19:35 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
References: <20190504055440.20406-1-philmd@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <0d57dc87-b22a-e034-da26-bb4bd83ef5c3@gmail.com>
Date: Sun, 5 May 2019 07:19:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190504055440.20406-1-philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH] tests/docker: Test more components on the
 Fedora default image
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
	Eduardo Otubo <otubo@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>,
	"Michael R . Hines" <michael@hinespot.com>,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	Junyan He <junyan.he@intel.com>,
	=?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505041932.qZJRVexWQdC5K9FmrQbEPASl7s9Lo6GIntCK0TOj7Uk@z>

Hi Philippe,

On 5/4/19 8:54 AM, Philippe Mathieu-Daudé wrote:
> Install optional dependencies of QEMU to get better coverage.
>
> The following components are now enabled:
>
>    $ ./configure
>    ...
>    Multipath support yes
>    VNC SASL support  yes
>    RDMA support      yes
>    PVRDMA support    yes

Appreciated!

Acked-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel

>    libiscsi support  yes
>    seccomp support   yes
>    libpmem support   yes
>    libudev           yes
>
> Note: The udev-devel package is provided by systemd-devel.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>   tests/docker/dockerfiles/fedora.docker | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
> index 69d4a7f5d75..afbba29adaa 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -8,6 +8,7 @@ ENV PACKAGES \
>       bzip2-devel \
>       ccache \
>       clang \
> +    cyrus-sasl-devel \
>       device-mapper-multipath-devel \
>       findutils \
>       flex \
> @@ -23,13 +24,17 @@ ENV PACKAGES \
>       libaio-devel \
>       libasan \
>       libattr-devel \
> +    libblockdev-mpath-devel \
>       libcap-devel \
>       libcap-ng-devel \
>       libcurl-devel \
>       libfdt-devel \
> +    libiscsi-devel \
>       libjpeg-devel \
> +    libpmem-devel \
>       libpng-devel \
>       librbd-devel \
> +    libseccomp-devel \
>       libssh2-devel \
>       libubsan \
>       libusbx-devel \
> @@ -74,10 +79,12 @@ ENV PACKAGES \
>       pixman-devel \
>       python3 \
>       PyYAML \
> +    rdma-core-devel \
>       SDL2-devel \
>       snappy-devel \
>       sparse \
>       spice-server-devel \
> +    systemd-devel \
>       systemtap-sdt-devel \
>       tar \
>       usbredir-devel \


