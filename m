Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF96C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C71EF20708
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vlwLkF1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71EF20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuvwT-0002nF-RW
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iuvvn-0002Du-FT
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:11:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iuvvm-0007QX-CA
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:11:15 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:33499)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iuvvm-0007Pg-5u
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:11:14 -0500
Received: by mail-ot1-x333.google.com with SMTP id b18so1138699otp.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 02:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BfCojYil1OiD2Vp0D0ZKJaK+JLnUyOcA7erIIjTUYfw=;
 b=vlwLkF1M6LSNJIOA4eID1RhgY4k/CqzD6mfEabpjgXkPFNkXY/KXAbMgIuy8k63nal
 ixHithWeFPrqb+6NUDyagArqnN1pFRXGjPt9ONxZlVrMLBC9kNp0myjmAlyrG0IK17BK
 OEBuWBMSdBgedwbend0eAm61HGIx+uZtL/c091YxuidtM9z+PFUBWkVp5Nz8o4YAsUNX
 V2ovCqOzzpGmZRs0FL6V1YUfZ9eCyMHX3v8jcsfE5v/zeCUHhog63SVoUpSg43CoeHX2
 37cXXtodBj3Y1kQ6T/4hpQfQ4Ds8ZAKccX1DyswSKuq8VdKjq46/wL4R9MeJ5hJQckIg
 CoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BfCojYil1OiD2Vp0D0ZKJaK+JLnUyOcA7erIIjTUYfw=;
 b=jXwBTEXIAvn4JiQfT+3whgG1WcqWWkA5X7PWRdcb+nYVjB+W1b3RaVbb/M61BanqHz
 mLPvL8uCWI4bdckEg6bXLNxRLRNiWYfcnaTC1g1+fVED+/xzRBPwawvn1GmwD+cTytAW
 ild9hvNFtG2tm3HTMWgos02Lt7EZJ0T9EXNEP5HNnNDY89iq26LDAoeoNKIfvOCWzHP0
 IOXJh1qfYswihlbWCJr9pLcehNqWJYJJ3/SUkp/ztEX9AlZfD+ycI5Gvnu4MDr5r6gGJ
 cyMV342DjX/wO8iPDw7QcGpKtQfHAid2qQ9jhH3W/dKC+6kzV7i/UqpvUj8Oyp/DwlGi
 J+CA==
X-Gm-Message-State: APjAAAUwS8X7Os5ixFT2jotgHYwlyVdlzN5hTZ301UsmYb8gooLLu3SJ
 4Qt9RsAXEvR4Ohz8UyJc+OtJ/cmeC+NipUmLqQ9dsw==
X-Google-Smtp-Source: APXvYqyAdxJ/2ntHd6vLesiPFWuN0o0x3o4hnJ13wRYNRpy+P7/3PvSkBFOy7ASzlOO/n30zFUfsyUE713X2f/pcLjM=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr2143287ota.232.1579860673163; 
 Fri, 24 Jan 2020 02:11:13 -0800 (PST)
MIME-Version: 1.0
References: <1579857411-12996-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579857411-12996-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jan 2020 10:11:01 +0000
Message-ID: <CAFEAcA-XOP=z+2NU-vebFO7qenOf-V21Vbwp-+VH5oDZfm+WGg@mail.gmail.com>
Subject: Re: [PULL v2 00/59] Misc (x86 and QOM) patches for 2020-01-23
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jan 2020 at 09:18, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 3e08b2b9cb64bff2b73fa9128c0e49bfcde0dd=
40:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-2020=
0121' into staging (2020-01-21 15:29:25 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to b0993e347e065d2323fbb051fdd5a72c95a6e872:
>
>   tests: fix test-qga on macosx (2020-01-24 10:14:32 +0100)
>
> ----------------------------------------------------------------
> * Register qdev properties as class properties (Marc-Andr=C3=A9)
> * Cleanups (Philippe)
> * virtio-scsi fix (Pan Nengyuan)
> * Tweak Skylake-v3 model id (Kashyap)
> * x86 UCODE_REV support and nested live migration fix (myself)
> * Advisory mode for pvpanic (Zhenwei

Hi -- this says 'v2', which is the same as the previous one
did, but the commit hash to fetch is different. Presumably
it's a v3? What are the v2->v3 differences, please?

thanks
-- PMM

