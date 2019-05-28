Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59485C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 16:51:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22578216FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 16:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U1XKA3g0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22578216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39537 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVfJe-0008Eu-DP
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 12:51:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVfGq-0006Mp-Fs
	for qemu-devel@nongnu.org; Tue, 28 May 2019 12:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVfGo-0006eD-EJ
	for qemu-devel@nongnu.org; Tue, 28 May 2019 12:48:16 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hVfGn-0006EY-VY
	for qemu-devel@nongnu.org; Tue, 28 May 2019 12:48:14 -0400
Received: by mail-oi1-x244.google.com with SMTP id u199so14796393oie.5
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 09:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=KJW3RwpOP6LW47PF2ENP0DSUzzMyv5RPjCuGE4kQ/gU=;
	b=U1XKA3g0RZK1Tbi8JHbcQb0jW2gd5Le289/Fahq+G2FbdKf1VZCEFVnTWIVHtDXjea
	56OgmCommXH6ZS+IHM45g55F9/309L5ZXOMhP960N4gbO+i/8/gewyh/6uVhrsw6gnit
	J/0DDQB6+jJ+ZBQmoiqs1Ovii7EeBBm6uSuqwP2M5nkbZxAFeGsVmXAHAM1SKAFj1xkR
	Knw+jbTDfujK5T6IIuCYZ71Ld3SMukXmSKCUBdRI6mmaTUiglkIav+OGphXC2OFT1jbP
	b5mpGgUiGkmbb8bTnP4lYxHPVPTQAQJm9H1s707VqY2ixCgeq1aCHjC07ludteX82kww
	Nu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=KJW3RwpOP6LW47PF2ENP0DSUzzMyv5RPjCuGE4kQ/gU=;
	b=b5qQVFncAmYqZh8m+o2FBn4dUR8dKJ89XkrgAoEIlY0oNZ85y2Ua9/udpH9dAiJTGI
	jYd7FDAD3nH1ghnX55MbLj+PGIY72Pq74EEyMZqkn/k6ElCLanegBZf1gPGXO4Py/Qqj
	081S/0jqoq7rmDnU8z8oX2RTy4huQGhn8eLdudwddyqSmvrwBSNioVHY6b7M2AIMxXNa
	m3nYxPK7VYOb3wQt+u30crPhVgKxLD2BfXbkjVZyAb1wdE088wR18fLwKn4XYy2AYVwx
	NPpS0Ikvy7evZt70d6ZYKtoIa9Jl2//rfjGpRzXn8O2SGdqPY4piMDzME+BDCmvQVYSv
	zwIw==
X-Gm-Message-State: APjAAAWQn+QThFclDnqSQROg67IAx5oYlwzeteXjRnXWf2fFiobT8XwG
	cRVxm8nDnSh87qgLuBxxkxW4blt32urBo7S/njhV3Q==
X-Google-Smtp-Source: APXvYqyQ3GWdeshPJkCM/RshxdKrTLMQ+AorFWNBkk7HUYhqLHt0UPCbayqhHYIuG7TAU5REouOseI0oXvc43kXrgBo=
X-Received: by 2002:aca:845:: with SMTP id 66mr3270959oii.163.1559062042880;
	Tue, 28 May 2019 09:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190528164020.32250-1-philmd@redhat.com>
	<20190528164020.32250-6-philmd@redhat.com>
In-Reply-To: <20190528164020.32250-6-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2019 17:47:11 +0100
Message-ID: <CAFEAcA9GhZwCb6WLa75i1ep5VX7S_kP3YEo-VOxXbnogXZ=W1A@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v2 05/10] hw/sd: Use the QOM BUS() macro to
 access BusState.qbus
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
Cc: Fam Zheng <fam@euphon.net>, qemu-s390x <qemu-s390x@nongnu.org>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	QEMU Trivial <qemu-trivial@nongnu.org>,
	David Hildenbrand <david@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Michael Walle <michael@walle.cc>,
	Gerd Hoffmann <kraxel@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 May 2019 at 17:42, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Rather than looking inside the definition of a BusState with "s->bus.qbus=
",
> use the QOM prefered style: "BUS(&s->bus)".
>
> This patch was generated using the following Coccinelle script:
>
>     // Use BUS() macros to access BusState.qbus
>     @use_bus_macro_to_access_qbus@
>     expression obj;
>     identifier bus;
>     @@
>     -&obj->bus.qbus
>     +BUS(&obj->bus)
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/sd/milkymist-memcard.c | 2 +-
>  hw/sd/ssi-sd.c            | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

