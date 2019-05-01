Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82243C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:18:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2692B2085A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lfkoOz4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2692B2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60878 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLr0H-0000Pu-De
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 11:18:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLqz3-0008Gk-LW
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLqyz-0004Rm-Nv
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:17:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLqyx-0004PY-Vz
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:17:17 -0400
Received: by mail-wr1-x444.google.com with SMTP id s15so24893992wra.12
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 08:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=5p1L9AFWCebl88Olx4jMoDtNG2V39GUQG7dGse8qncM=;
	b=lfkoOz4oEg98WRfbwOh1hFQKRUsJgUH8j887KO0e5wKT8SpR9tiibown6lVexMKVUH
	sJ0Sh6Wimkq7uZZ1YqJK5hn5xT5Ow8UyI8GDwx71DHQN+l+P+d1n98mUSHhH5eGYOp/5
	jmipigVZYeSrCblDcLKK28nxbJ5/mY5DhBI0q56hAQICfR3+kF9tljVq2bPXRNVsjXPj
	XpiiHQxvkSBJlc9Ww5BQLCQiU/DRj0+PGNu6iP2e8EVT7CtZVkE1jAMkgozsyyJAE3Oq
	2u0t4WYOIomWyw0FBSKP/7NubGdjX99R+Yqku36FCId0hzm69BjFohnh26INRbPnyOFE
	4ZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=5p1L9AFWCebl88Olx4jMoDtNG2V39GUQG7dGse8qncM=;
	b=cmjIlpr0coYMP2zc3C6F4wv/mSV76NMpWQlwO0TA1Qn8Xv7WaH7Q98/jkdaEkwGzkb
	BdnaV/GxkFvqfO+hgark74Gpg+6nBq54pKcleilfPhlhL3Ljc9DPpmgBAirQvlIIEKqb
	OmrkxFs0XvVGu/vDcN1Y8Y/8LrwiuKgXiRCR5wfWtAbrastt0SIL43DhMiR2jmz3wNrX
	OwSu/3PUnvz9GVQHPFBlti1BH3Rk4EE2KsblQpmwUZTYi2GLspsFxtpKab3IGoOgX2cA
	HR8qY0HHyA/m2P7egWfPfvT3XsWy7lBQbfCinHtLwQ/Z1CvrspK7yWz4M13IEukX+jkr
	8pbg==
X-Gm-Message-State: APjAAAX/rsFMGvj1+rg3CB9+GLYbanLPqnuTiRBzAgxf/cA0sOMmrxMP
	Fg6jlbVrjm928g8uoQUFrYfpBQ==
X-Google-Smtp-Source: APXvYqyEp93xBi3LzhvL0KGq05QeN0hCaugmJ4INRwGbj27WiM64GOq0bGMQX5RVG82Wee0nMT4H0g==
X-Received: by 2002:adf:e3c8:: with SMTP id k8mr104453wrm.329.1556723832834;
	Wed, 01 May 2019 08:17:12 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	b184sm8154149wmh.17.2019.05.01.08.17.12
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 08:17:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id CEBDB1FF87;
	Wed,  1 May 2019 16:17:11 +0100 (BST)
References: <20190501081039.58938-1-liboxuan@connect.hku.hk>
	<20190501085805.GA8174@lap1>
	<CALM0=-=cbHTajGz8R4Who9eKh=sfa19H_nMuH4PFO8vVq2=drQ@mail.gmail.com>
	<20190501135807.GA11932@lap1>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190501135807.GA11932@lap1>
Date: Wed, 01 May 2019 16:17:11 +0100
Message-ID: <87y33q5hmw.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v2] hw/virtio/virtio-mmio: Convert DPRINTF
 to traces
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
Cc: qemu-trivial@nongnu.org, "LI, BO XUAN" <liboxuan@connect.hku.hk>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, "Michael S.
	Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501151711.MLUL4v3_2OAhsPQaa3QqQZHCPbLiDzEdzPe5HygUTNw@z>


Yuval Shaia <yuval.shaia@oracle.com> writes:

> On Wed, May 01, 2019 at 08:42:35PM +0800, LI, BO XUAN wrote:
>>    On Wed, May 1, 2019 at 4:58 PM Yuval Shaia <[1]yuval.shaia@oracle.com>
>>    wrote:
>>
>>      On Wed, May 01, 2019 at 04:10:39PM +0800, Boxuan Li wrote:
>>      > Signed-off-by: Boxuan Li <[2]liboxuan@connect.hku.hk>
>>      > ---
>>      > v2: Instead of using conditional debugs, convert DPRINTF to traces
>>      > ---
>>      >  hw/virtio/trace-events  | 13 +++++++++++++
>>      >  hw/virtio/virtio-mmio.c | 35 ++++++++++++-----------------------
>>      >  2 files changed, 25 insertions(+), 23 deletions(-)
>>      >
>>      > diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
>>      > index 60c649c4bc..37c781b487 100644
>>      > --- a/hw/virtio/trace-events
>>      > +++ b/hw/virtio/trace-events
>>      > @@ -46,3 +46,16 @@ virtio_balloon_handle_output(const char *name,
>>      uint64_t gpa) "section name: %s g
>>      >  virtio_balloon_get_config(uint32_t num_pages, uint32_t actual)
>>      "num_pages: %d actual: %d"
>>      >  virtio_balloon_set_config(uint32_t actual, uint32_t oldactual)
>>      "actual: %d oldactual: %d"
>>      >  virtio_balloon_to_target(uint64_t target, uint32_t num_pages)
>>      "balloon target: 0x%"PRIx64" num_pages: %d"
>>      > +
>>      > +# virtio-mmio.c
>>      > +virtio_mmio_read(int offset) "virtio_mmio_read offset 0x%x"
>>      > +virtio_mmio_wrong_size_read(void) "wrong size access to
>>      register!"
>>      > +virtio_mmio_read_interrupt(void) "read of write-only register"
>>      > +virtio_mmio_bad_read_offset(void) "bad register offset"
>>      > +virtio_mmio_write_offset(int offset, uint64_t value)
>>      "virtio_mmio_write offset 0x%x value 0x%" PRIx64
>>      > +virtio_mmio_wrong_size_write(void) "wrong size access to
>>      register!"
>>      > +virtio_mmio_guest_page(uint64_t size, int shift) "guest page size
>>      0x%" PRIx64 " shift %d"
>>      > +virtio_mmio_queue_write(int value, int max_size) "mmio_queue
>>      write %d max %d"
>>      > +virtio_mmio_write_interrupt(void) "write to readonly register"
>>      > +virtio_mmio_bad_write_offset(void) "bad register offset"
>>      > +virtio_mmio_setting_irq(int level) "virtio_mmio setting IRQ %d"
>>      > diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
>>      > index 5807aa87fe..4251df399d 100644
>>      > --- a/hw/virtio/virtio-mmio.c
>>      > +++ b/hw/virtio/virtio-mmio.c
>>      > @@ -27,16 +27,7 @@
>>      >  #include "sysemu/kvm.h"
>>      >  #include "hw/virtio/virtio-bus.h"
>>      >  #include "qemu/error-report.h"
>>      > -
>>      > -/* #define DEBUG_VIRTIO_MMIO */
>>      > -
>>      > -#ifdef DEBUG_VIRTIO_MMIO
>>      > -
>>      > -#define DPRINTF(fmt, ...) \
>>      > -do { printf("virtio_mmio: " fmt , ## __VA_ARGS__); } while (0)
>>      > -#else
>>      > -#define DPRINTF(fmt, ...) do {} while (0)
>>      > -#endif
>>      > +#include "trace.h"
>>      >
>>      >  /* QOM macros */
>>      >  /* virtio-mmio-bus */
>>      > @@ -107,7 +98,7 @@ static uint64_t virtio_mmio_read(void *opaque,
>>      hwaddr offset, unsigned size)
>>      >      VirtIOMMIOProxy *proxy =3D (VirtIOMMIOProxy *)opaque;
>>      >      VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
>>      >
>>      > -    DPRINTF("virtio_mmio_read offset 0x%x\n", (int)offset);
>>      > +    trace_virtio_mmio_read((int)offset);
>>      >
>>      >      if (!vdev) {
>>      >          /* If no backend is present, we treat most registers as
>>      > @@ -144,7 +135,7 @@ static uint64_t virtio_mmio_read(void *opaque,
>>      hwaddr offset, unsigned size)
>>      >          }
>>      >      }
>>      >      if (size !=3D 4) {
>>      > -        DPRINTF("wrong size access to register!\n");
>>      > +        trace_virtio_mmio_wrong_size_read();
>>      Have you considered using qemu_error_report to report such errors?
>>
>>    Thanks for the suggestion. I am a newcomer here so my question might =
be
>>    a bit dumb: I thought they are warnings instead of errors since return
>>    values are 0. Do you suggest using error_report function and changing
>>    return values from 0 to -1?
>>    Best regards,
>>    Boxuan Li
>
> I think that when driver store invalid data in device register it is an
> error but the best is to check what other devices do.

We could have:

        qemu_log_mask(LOG_GUEST_ERROR, "%s: wrong size access to register!\=
n". __func__);

--
Alex Benn=C3=A9e

