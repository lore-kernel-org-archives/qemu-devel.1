Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A60C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 09:39:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55FC420652
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 09:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hYLR8ujE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FC420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33876 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGKZ6-0007SY-Gh
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 05:39:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGKYI-00079I-Nb
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGKYH-0003DE-Qc
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:38:54 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGKYH-0003Ck-JC
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:38:53 -0400
Received: by mail-oi1-x244.google.com with SMTP id j132so16399075oib.2
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 02:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Da64giMSswQc3+eRqPUWfjQL/4dsVUHVzHxC0cXdJ8I=;
	b=hYLR8ujEXi/kGlPwoxX6fm116vbVDk+uO/IhbBP7ki43Nr9OL9Pei3rMFXC39esPbh
	lF39NbPPKhv/rPXobyIXq6hyFI61k0rhQSpvnQh5Mt/Y8Y4jMOcPs5WgETGW740KN1js
	HDU0t6ojT+Mj1yIUP2D3/sZ9EtJlOK6+mSxcLmwT8ANxh21R/4s9nPyj50e969WethbF
	5BkkG3qjBZKwrp30Fbqz5eN0N24chZyplmSVqHMz6nZ6TJeJeNZMaU2cRZ4gDPIE/sb4
	875RNTZ98R6aIPUcmJsGlnMbXL0ANEZzQDGjgwawjlIDyxoi4/RR7wTlpuAa+Vz26gDT
	VaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Da64giMSswQc3+eRqPUWfjQL/4dsVUHVzHxC0cXdJ8I=;
	b=iKwN9tJK8cibD18VV3t8fpiSU2c67hgIsB1R308Xvinn3eppHHXbHrZncWgb+nOSH/
	G7DY/ZUA0DX3V0ND4H8I05tIK16O60oz9/wEtpnNg/VKUMv2zoRm+IKDNLPTp00knwW0
	RqVjBNHAuvfo6zdkhDjVHE3yNmC/KEfDI+geF5VSFsz95ujzk8g1dhtaPhHpuEHVZD/G
	4NzWv/LtwHzvECNVxwTHIUd3BiPJb+pAVvU18zHsiZlXAo0c8pnUXxOTnuePK2UIXj67
	H81WWBzoEanxAqYI7M2+PzEjZ18dVN0K0oU8gGMMa6PF5LlU8mQ0LclTKDX2FtLruJVB
	rwCA==
X-Gm-Message-State: APjAAAXxaZcP+kQbgP8jNpYCN+1116aHh2VrJDOmRVHp+JdZ8ZY7+xwW
	YlLUzoJbnm3bITDhuifKrgS4XiWCQp5ZnkmA8VDkDA==
X-Google-Smtp-Source: APXvYqzOKCw2VmsC0GvHu6t94jjGtgbseeB7xbK0POvAMfXLcpl49rakGCy+RCE0FdmgNJqvWNhBjbUbMAdA7uBqPHI=
X-Received: by 2002:aca:b3c2:: with SMTP id c185mr23372904oif.98.1555407530027;
	Tue, 16 Apr 2019 02:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190415180618.1450-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190415180618.1450-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2019 10:38:38 +0100
Message-ID:
 <CAFEAcA9z-ELZJ+WunWYwprzMOpC7WPxPiwNjdtFoNxL+LE=jQQ@mail.gmail.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PULL 0/1] slirp gcc9 build fix
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416093838.ojwUsR-Xo5pEl1TLA9wI148t3JisL24pwN2zC2oAnIg@z>

On Mon, 15 Apr 2019 at 19:06, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> The following changes since commit afccfc0c4c6134a7bc9da6375996b3b91d291de4:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-04-12 17:06:49 +0100)
>
> are available in the Git repository at:
>
>   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to 6fabae61a9393fd2bc703837e464b9c34ec5ef25:
>
>   slirp: Gcc 9 -O3 fix (2019-04-15 20:01:18 +0200)
>
> ----------------------------------------------------------------
> Slirp updates
>
> Dr. David Alan Gilbert (1):
>   slirp: Gcc 9 -O3 fix
>
> ----------------------------------------------------------------
> Dr. David Alan Gilbert (1):
>       slirp: Gcc 9 -O3 fix
>
>  slirp/src/socket.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

