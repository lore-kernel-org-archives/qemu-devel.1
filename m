Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BD3C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:49:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D58220719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="juYgvXXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D58220719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHaND-0007Qu-LY
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 17:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHaM3-0006Vs-FY
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHaM1-0004TL-Iu
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:47:58 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:36795)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHaM0-0004RF-Rc
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:47:57 -0400
Received: by mail-ot1-x32e.google.com with SMTP id l23so7654857otf.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 14:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZFaXxcTV2mZj7ztpP7Zlz24D0mXHTvj4xwbEqB7WPNI=;
 b=juYgvXXDriG1rpjoe2C4H/Ugr3UC3p3gEye4w7GtZyXIYu+Zo+0ki3p4CAgIX15+oQ
 13h5mATdRjtEkuGPVFaxzfcsaweHEuIOXKQCjsIO+enfgSKWiu27x20N8d8AvGiHsxM/
 e4Ce1RNfFU37xU1Ue2YfH/qxSfQCfB7j7QP3+5DySd4yt8Z9JU4wQedhPF4knWQXN7A8
 NaHe8ZVDSrPQDxueQqrQlU9JVviih8K/d0bu9p7aXRExllyFV1dgv1wI0wxlqgdmypgG
 z9RsRkYOfs/e1fquBEPFlNxCbd3k6gbJwwwZ7QWHtMIzm0RlqS/PJ+udzu/7twiznYtH
 rsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZFaXxcTV2mZj7ztpP7Zlz24D0mXHTvj4xwbEqB7WPNI=;
 b=r83ULitm37hr2qbAdz1Ka9VfR/XECXqV9iQIsW6p2gx8j32wBOgmcXlvh9BqVocBK4
 sncV8hMGYTyNx8a3CAACH1/PJ2Vi4VyIFPqREUqN7bX73hrBOWQWxhDZtAmPVT1fIPOS
 XPHsekqSX23MdqjwDAQIqaJpu5O+oh8h6GgubhWNiNqf8rftFEd4JkyGGrlLC6LugPZH
 ey4aY4Y2pCVkt1V2vIIK2uFH6jdIoeJbFJV58GV6ht692SJDeQGuAQVJzu4OETGKhMFB
 8QS5giSADt6Hdq3cd3Jp0PCxIfd2ChPE/agLqOJMaGexx1Iup9Q4pzklAX2PTW0B9Iu9
 UVWQ==
X-Gm-Message-State: ANhLgQ2Ztiu9k+7mbb74Q/w4rM1Qm9uNlME601ZKkt8AJ1Fw0YHpYhxP
 PM6yWcG7Y1RZlVjul6h8o9pyNpmPk27oMYNHcmVvkg==
X-Google-Smtp-Source: ADFU+vs/DYQLrg+PY3A6R5Ck0seQHQa0rq5Ma6p3xVb/cN+6b9+7Ko2apbr98hdWTJWqo29ykVhVtUleBkYzpxXs/dQ=
X-Received: by 2002:a4a:d1a5:: with SMTP id z5mr6961361oor.63.1585259275554;
 Thu, 26 Mar 2020 14:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200325191830.16553-1-f4bug@amsat.org>
 <20200325191830.16553-9-f4bug@amsat.org>
In-Reply-To: <20200325191830.16553-9-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2020 21:47:44 +0000
Message-ID: <CAFEAcA-SJSTP==JM9xWJbSYOb-ZM=UyYtHP=2iQGq979SYvjyw@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 08/12] hw/mips/boston: Add missing
 error-propagation code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Mar 2020 at 19:18, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Running the coccinelle script produced:
>
>   $ spatch \
>     --macro-file scripts/cocci-macro-file.h --include-headers \
>     --sp-file scripts/coccinelle/object_property_missing_error_propagate.=
cocci \
>     --keep-comments --smpl-spacing --dir hw
>
>   [[manual check required: error_propagate() might be missing in object_p=
roperty_set_int() hw/mips/boston.c:462:4]]
>   [[manual check required: error_propagate() might be missing in object_p=
roperty_set_str() hw/mips/boston.c:460:4]]
>
> Since the uses are inside a MachineClass::init() function,
> directly use &error_fatal instead of error_propagate().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

