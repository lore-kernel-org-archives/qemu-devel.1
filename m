Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0E0C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 16:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 906922081C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 16:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906922081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47898 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVIDn-0005sM-Lc
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 12:11:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hVICr-0005Sy-T7
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hVICq-0003Vy-04
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:10:37 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1hVICm-0003AD-BX
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:10:34 -0400
Received: by mail-ua1-f65.google.com with SMTP id i48so5965444uae.11
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 09:10:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=PteWuLIiN/BbO0o4DPcsCRTpEC8VUErV1fB0MXQtoKM=;
	b=U7+1Dfm7vfWd/W5nVto4tsJUuYIgQX2CyC8XIRUhUupJr9c2QkytEvQN2zSc4stO6x
	3sbBLNJHACKAKITQPtjarTG7qzvywfcngqTvfy6l7HpNPVATg9yMxDhXt0PL3Fj3CBzo
	aGc+QYQu6XFi1J94PXX7JCv+Lcetcv8Z6fm7jJYHjbDSxoTG7n9+0W/YUaG/b5U6RTQT
	crjYXgNVh/LDOLqKn5OrdSMAGic4sUuV38bMvpUQpGweOvUBqXvI6TCUlJL6AVkiwc8R
	L728r6j77ZbO2+WKQcquO9VGOC/5y+Fe5q+r+QMnXr4b8ClsX5MdR7s9oXck+38fuOhB
	CBFQ==
X-Gm-Message-State: APjAAAVDKo+pajdZBa2qKO12GOmc14gqWlJfHHCfBV+GBfyp/NfFKZU/
	fWtPDnToD3fowayB0ox7RGkk3Si2UK9JxvBRa3WoMw==
X-Google-Smtp-Source: APXvYqzHtw/QIPsXNR5JOaCOuhe0S0l7f+a/yCjOT8TdKWvYQ5OBu3n3kel2LnaifJ8iqEdy+XvRK/UCdVwXogDzwBY=
X-Received: by 2002:a9f:3241:: with SMTP id y1mr55975uad.107.1558973413782;
	Mon, 27 May 2019 09:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190427141459.19728-1-philmd@redhat.com>
	<dadba93d-fdf3-25b8-b3e2-5b43a4618292@redhat.com>
In-Reply-To: <dadba93d-fdf3-25b8-b3e2-5b43a4618292@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Mon, 27 May 2019 18:10:02 +0200
Message-ID: <CAP+75-UKFxtHrfzAF4G=YD6XDGcDVyvTeHdzYTvOD4vecT0feA@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.65
Subject: Re: [Qemu-devel] [PATCH 0/3] hw/microblaze: Kconfig cleanup
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

On Tue, Apr 30, 2019 at 9:55 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 27/04/19 16:14, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Edgar, Peter,
> >
> > Few fixes while cleaning Kconfig, trying to optimize builds.
> >
> > Regards,
> >
> > Phil.
> >
> > Philippe Mathieu-Daud=C3=A9 (3):
> >   hw/Kconfig: Move the generic XLNX_ZYNQMP to the root hw/Kconfig
> >   hw/intc: Only build the xlnx-iomod-intc device for the MicroBlaze PMU
> >   hw/dma: Do not build the xlnx_dpdma device for the MicroBlaze machine=
s
> >
> >  hw/Kconfig            | 3 +++
> >  hw/dma/Makefile.objs  | 1 -
> >  hw/intc/Makefile.objs | 2 +-
> >  hw/timer/Kconfig      | 3 ---
> >  4 files changed, 4 insertions(+), 5 deletions(-)
> >
>
> Queued, thanks.

I don't see these patches in your queue merged on "Fri 17 May", are
you planning to include them in your next batch?

Thanks,

Phil.

