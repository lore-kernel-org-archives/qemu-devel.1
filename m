Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F09CC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC0CA21882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FG/LQDcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0CA21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS6We-0007rP-ND
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:38:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iS5vM-0000Nv-Db
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:59:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iS5vL-0006ac-5T
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:59:36 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45130)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iS5vK-0006aG-GD
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:59:35 -0500
Received: by mail-oi1-x241.google.com with SMTP id k2so18866410oij.12
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 12:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uYAcSA/WjIczAnI+8WCrdQT6qS+iw0ZmLhpdXJxOK4Y=;
 b=FG/LQDcqSe0QvdiUUnKMsFM9jOzEcJTEt5EiFH5tDuCzlY4w2/Qx3UOLIDaOAkI40s
 WIJW2+dVvhixg3wzGmzIaUtOtzMH67izlgriVKFBtV092Xdl5tdbxSXi9yvzBwI3tomC
 9ihj+X1qeCiedrsG3regAQSQkR6yBWaKP6zSQLj+CWskwxvVF+QYpamg0/shHIFrb7Xo
 bZGzx0iLgvtZj2t84yBV48MW/HoKlOhwcqYwGFYsXKohH5msLlkRsYjYQPu4mazDNyDR
 JpBPqOyJu81rwvE/QPJHYxrE1MzBbUvXGUhp93JaEBLlaqz7atpsDSFSQc7s10/u32E9
 c9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uYAcSA/WjIczAnI+8WCrdQT6qS+iw0ZmLhpdXJxOK4Y=;
 b=R1+OfIsHEkLEg/W7gi1e9MQspcOBRDcFqKgf9/SAtfOYEMyOc9D27tP3LlLyjo6lLF
 hBYaEq3cpQL0kzcMjaeln6FZdaqXVSGSJ7S3nGeDNGx+GNZbOZxDIzW4W4xVnUaIrBPK
 8mvbvwgrHZAjw/VuNZ3ypr4c3seU1xTLVUBaNNDQwEGGL+HK1WEByZpye7p8vbLagm+L
 3irdqbq0VT3loHUJjpyRRv6A0zAmUwbv+79slrIkcW8+C0aj5cGS4zSUt505lLIcCKAY
 ajyawysWaVMsyurcwNbkWt6dvyGxFhL6Wu6iJc0AhUlkaHGG77DGIGr0paLAFppeEAuQ
 IkxQ==
X-Gm-Message-State: APjAAAV5yJtHmZeEsAcLydOo9JwIRGOSXqBLT0CF1ty3+Y9QfVYTaWOf
 XOkKmgV4FOEQK5go9bnOj/4+iST6oGPVHjgefQmpEg==
X-Google-Smtp-Source: APXvYqy6YItJ+aNTNBhr2AM147PXJnkmdWdMXq9s2oh1knG+6NnidXTW/+mPGV8Ta+kGUDEXYrsAjaqdf/bVoGfMAEs=
X-Received: by 2002:aca:4945:: with SMTP id w66mr920440oia.98.1572987573432;
 Tue, 05 Nov 2019 12:59:33 -0800 (PST)
MIME-Version: 1.0
References: <20191103222511.17478-1-philmd@redhat.com>
In-Reply-To: <20191103222511.17478-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2019 20:59:21 +0000
Message-ID: <CAFEAcA_PC80+E1Sb7CTrE0OdBZfn9VHUzXBh9NH3xGUhnfMF0A@mail.gmail.com>
Subject: Re: [PULL 0/2] fw_cfg for-4.2-soft-freeze patches
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Thomas Huth <thuth@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 3 Nov 2019 at 22:26, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> Hi Peter,
>
> One fw_cfg fix from David Gilbert.
>
> The following changes since commit f3cad9c6dbd4b9877232c44bf2dd877353a732=
09:
>
>   iotests: Remove 130 from the "auto" group (2019-10-31 11:04:10 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/fw_cfg-next-pull-request
>
> for you to fetch changes up to eda4e62cc2f5d12fcedcf799a5a3f9eba855ad77:
>
>   tests/fw_cfg: Test 'reboot-timeout=3D-1' special value (2019-11-01 19:1=
9:24 +0100)
>
> ----------------------------------------------------------------
> Fix the fw_cfg reboot-timeout=3D-1 special value, add a test for it.
>
> ----------------------------------------------------------------
>
> Dr. David Alan Gilbert (1):
>   fw_cfg: Allow reboot-timeout=3D-1 again
>
> Philippe Mathieu-Daud=C3=A9 (1):
>   tests/fw_cfg: Test 'reboot-timeout=3D-1' special value
>
>  hw/nvram/fw_cfg.c   |  7 ++++---
>  tests/fw_cfg-test.c | 21 +++++++++++++++++++++
>  2 files changed, 25 insertions(+), 3 deletions(-)

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

