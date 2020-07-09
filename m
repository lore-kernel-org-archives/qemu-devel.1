Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38A4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C6442065D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="axsHK+OZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6442065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtc5m-0001sG-OA
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 15:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtc5B-0001Bz-6U
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:19:45 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtc59-0005gP-N6
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:19:44 -0400
Received: by mail-ot1-x341.google.com with SMTP id h1so2453854otq.12
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 12:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=P2qYvp66cuwqIuOxXjaqzUeXwAbQY2fv8/ZXtTQnDqM=;
 b=axsHK+OZoKBvTOTWyMmTiLsz6mEUMP57JgAYTItukgVKlo/j0qVkhSECe8HZgHVXyX
 InUG1bmqckmmqqk4sOJutFIJ4T6B+emqWgAos8oSyXOJadwIRMWUK/+oWeBckxbExfXI
 YgXZgcBrHNF7gXQ8M1DUX+gM241cVyRK8ew1phoO+U0J89bkK6gZolJbNxSx0jRlu5OI
 wQr0J4UFDSukJ126Muo/A9jyHydDDz7iRcB1n6x5QQ1kunFgLnvwOgaZlTvI77eiEiGy
 SmfCXtyvAhEqq1lx92P/nBacP7Po3bxSYyef1RWdZCS+lsXIBg4VNhFUvMRcOriIWFyt
 9VVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=P2qYvp66cuwqIuOxXjaqzUeXwAbQY2fv8/ZXtTQnDqM=;
 b=o1HzOsg81e3PtGN2MwDaCTmFiPsmAkKo8S1+abR90fNJ6YuD6Wvi5lkDOhrmL2D//h
 4Od7Z/IfjukmXw4+LORj9LnWDnoErwVrnmiU1UXF1kBcY2/jRNZI2LirFWMuR5OO7Q/Y
 WKSs7lC5SYw2fhY33a0HNePh91NGoPa/chlDgIrKyygqRwHcifNgE92tyw/ATosgTV+g
 Od6OG1Ba/dm5WjXbe0LjmrUU/Z65GoZ7AL9K7LPnp8k3/c1cFnVFAs+lSVt9vj6a1Smi
 50Q+8cRet1VV5KU6gjWxj9HC2vziUDuK8EaGjwUUXyFhe4AnI6RyGmJlGyT8T/9EKT01
 LYlw==
X-Gm-Message-State: AOAM530w24yv6n1U3Nw7w9BBDL0qxpNFSki/0Rbb9hVbAPJvDSj32gv7
 tk94kpMVyh2NjWACsQrkyoqxDMTF2i26YyGSEXd0IA==
X-Google-Smtp-Source: ABdhPJwJjzA2ifNkU3eDlvaisFuMrHr+T2JLZ/0mj46EDAX5CsUoxVP9ohBunSFd9brEdMXe3hZ3tB5dkBg7UV0opoc=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr48306860oto.135.1594322382470; 
 Thu, 09 Jul 2020 12:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200703201911.26573-1-f4bug@amsat.org>
In-Reply-To: <20200703201911.26573-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 20:19:31 +0100
Message-ID: <CAFEAcA8Cu2N5qX55rUk_yd4R6PdJX+X5KPQmMiQPFakP3ShZ-A@mail.gmail.com>
Subject: Re: [PATCH 00/18] hw: Mark the device with no migratable fields
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Jul 2020 at 21:19, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> This is a proof-of-concept after chatting with Peter Maydell
> on IRC earlier.
>
> Introduce the vmstate_no_state_to_migrate structure, and
> a reference to it: vmstate_qdev_no_state_to_migrate.
> Use this reference in devices with no fields to migrate.
>
> This is useful to catch devices missing vmstate, such:
> - ads7846
> - mcf-uart
> - mcf-fec
> - versatile_i2c
> - ...
>
> I am not sure about:
> - gpex-pcihost

I think it's correct that this has no internal state:
the only interesting state is in the GPEXRootState, which
is a TYPE_GPEX_ROOT_DEVICE which migrates itself.

I made some comments on the "meaty" bits of the patchset,
and reviewed one or two of the "mark this device as
having no migration state" patches, but it doesn't seem
worth reviewing all of them until the migration submaintainers
have a chance to weigh in on whether they like the concept
(I expect they're busy right now with freeze-related stuff :-))

thanks
-- PMM

