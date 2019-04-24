Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C84C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:00:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B63A218FC
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ht0U6Cys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B63A218FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42168 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJIS0-0005HZ-Rs
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:00:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hJIM6-0008ST-CL
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hJIFC-00013o-OD
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:47:27 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:34251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hJIFB-00011r-7S
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:47:26 -0400
Received: by mail-oi1-x22f.google.com with SMTP id v10so14315951oib.1
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=bPX+Ha9KAcoABMlhU24iAtQgy0TBMVdaO7DDEhW0PXw=;
	b=Ht0U6Cys2AGJ8Q9mKJQaES/1SYO6hNpb3dwRktMxRiPvskTVAtKj0regNpJ/EZpA+S
	6adA9x440g+LURHovZkl/n6qToxw8T0rIiOL066zM2Hsmkv4jpRAetfzSBlfZ1SjJB0b
	DT0FnUTzRHKPcE0uQdKm4JPbWJfGAeWdJyjcsp/d+cGpt5eQtjPbRlZQYFiN7r1p3p70
	HYT373mUyLUp89QDw8G0+Em0Eaix8YYnWVaJrkvSRshMOwUKQ6bIdizrOA6huO18l6PK
	wrfwHo86lwn4Dlmon9Vb832I22arBQU0h3nzA2SUZOTicrxZT/YV+GmIXPNgdI+tVlZb
	a/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=bPX+Ha9KAcoABMlhU24iAtQgy0TBMVdaO7DDEhW0PXw=;
	b=j0FXQO2M7pfENVXeKW1aNZz4QhUdZLKpKmBF4dffh8L44K2SbeJ3gFeHNgSYo9BIFV
	AIGGl2GFpdNLeOKIJ+QqcDPiLKY8jKQ/2zLxfKs0YMi1ign83eiPHNO/sOuE5eWqXWSH
	dbkuEXZQKYQC+QDwXeNwQyoHd53fr2M4MUBSCIa6iJB8dxWJaytNpf6fAr0dWtZywcKb
	w+8QH+Jwohc1y8w5JGET6S77suNoOIPgt9epdw/wF7TcLVwXoKNkUiZxcG8UUtmbzaRy
	EpdU0Ilni4hQ3YxilK46USgbJBeDdgiX+L1CcBIA7brSEVvfk7zsnQk/jBjqUVToVblw
	INMA==
X-Gm-Message-State: APjAAAUEItCRHBFB5myDvez96j6pQdy7gpG4sulmOvH0nFHaL435kQgC
	Fv3MXj6jN23e13sLlcopOWNB9s8LQht2ba3POIlXBg==
X-Google-Smtp-Source: APXvYqz5s7cPBmaCueVVd0fuPeY1JLg0RAzaO24Ihr/lu7+lQHu4ezVWpdr8jvFH0v3dQ9VoLUL8kTpRFlAWUkN3Iik=
X-Received: by 2002:aca:c7d3:: with SMTP id x202mr5116342oif.48.1556113642846; 
	Wed, 24 Apr 2019 06:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190423171520.4511-1-lersek@redhat.com>
In-Reply-To: <20190423171520.4511-1-lersek@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Apr 2019 14:47:10 +0100
Message-ID:
 <CAFEAcA9B-FpTySXUKTxYaw=8V=to0VTjCAvCAMGF-x=yQY3G9A@mail.gmail.com>
To: Laszlo Ersek <lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22f
Subject: Re: [Qemu-devel] [PULL 00/12] bundle edk2 platform firmware with
 QEMU
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Michal Privoznik <mprivozn@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424134710.WumZ2k66dJc8B4GcLW_Dazl6jjJFLNflA22MDIhKWe0@z>

On Tue, 23 Apr 2019 at 18:15, Laszlo Ersek <lersek@redhat.com> wrote:
>
> Picked up the new feedback tags from the v4 thread, which had been
> posted at:
> - https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01549.html
> - http://mid.mail-archive.com/20190409230022.6462-1-lersek@redhat.com
>
> The following changes since commit eeba63fc7fface36f438bcbc0d3b02e7dcb59983:
>
>   Update version for v4.0.0-rc4 release (2019-04-16 21:53:00 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/lersek/qemu.git tags/edk2-pull-2019-04-22
>
> for you to fetch changes up to 6739df3fafaa3e2ec37af23fd77d2119869f4a4f:
>
>   MAINTAINERS: add the "EDK2 Firmware" subsystem (2019-04-17 15:38:35 +0200)
>
> ----------------------------------------------------------------
> Advance the roms/edk2 submodule to the "edk2-stable201903" release, and
> build and capture platform firmware binaries from that release. The
> binaries are meant to be used by both end-users and by the "BIOS tables"
> unit tests in qtest ("make check").
>
> ----------------------------------------------------------------
> Laszlo Ersek (12):
>       roms: lift "edk2-funcs.sh" from "tests/uefi-test-tools/build.sh"
>       roms/edk2-funcs.sh: require gcc-4.8+ for building i386 and x86_64
>       tests/uefi-test-tools/build.sh: work around TianoCore#1607
>       roms/edk2: advance to tag edk2-stable201903
>       roms/edk2-funcs.sh: add the qemu_edk2_get_thread_count() function
>       roms/Makefile: replace the $(EDK2_EFIROM) target with "edk2-basetools"
>       roms: build edk2 firmware binaries and variable store templates
>       pc-bios: add edk2 firmware binaries and variable store templates
>       pc-bios: document the edk2 firmware images; add firmware descriptors
>       tests: add missing dependency to build QTEST_QEMU_BINARY, round 2
>       Makefile: install the edk2 firmware images and their descriptors
>       MAINTAINERS: add the "EDK2 Firmware" subsystem



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

