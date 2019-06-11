Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FF0C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 12:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48FD20896
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 12:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHzbqU+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48FD20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57802 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hag5X-00068D-2t
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 08:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52421)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rfried.dev@gmail.com>) id 1hafBw-00071Q-2t
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 07:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rfried.dev@gmail.com>) id 1haewu-00015V-Od
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 07:28:23 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54611)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rfried.dev@gmail.com>)
 id 1haewu-00014N-Ds; Tue, 11 Jun 2019 07:28:20 -0400
Received: by mail-wm1-x344.google.com with SMTP id g135so2531598wme.4;
 Tue, 11 Jun 2019 04:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hqXHWwI+6YLDY2XPkJyKYaUQ0K7IV5tHdMlx1gZ34CE=;
 b=KHzbqU+RBnzQPi6PE8my31XDM7I8tIJQBemibSIqblOb7XDr+6DOUetrc5L36tbyW6
 8klmUoylaFObVaPCwsMHtZYXWOxeKXIEsTELmmcBkWbNwdKFM4qpBmQN7wsXU//ByAZE
 UgU9rPk4iiGqn1Yqjlez+wPyx6cGv2nW5Nd3m9P+IGOhLzlx9opkQMP6hiCFNefdXqgs
 mjovm9C17WtRyTTal1zWCH7slDKSjzfQnWAY991q7ndVtSlf00ns+ItzClcQf8H2OVWk
 RSczX1WswMlOvjLDfblSYdB4++fwyWnLNDgmid4ZfjtH/DxKMUVen+PKq6rpNyHdmjKh
 3wZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hqXHWwI+6YLDY2XPkJyKYaUQ0K7IV5tHdMlx1gZ34CE=;
 b=KcWS/Hvj8952bn9V9SJe+bwHsJX9Kr2NziUVTV/ulKoUTE1tYv8UmJ8ika7yLmoSHS
 G2eUjT1SUB7rs4LD5Fpj0xJTGmJ9NfHdIMshV7qJJNekABIjInpO6xTQee7US32WembQ
 PKuFtmZJmjdkFkUCEg1sGr9d+5JoqR1LiAFps8FzpBoi6jZ73U8Komu5wznhqbs+o9ch
 awmnldqctqdsifSAtX4B389EnRnwHTFm+8fBx5nRZW40kUbChdveoIsAXFF9sA9u+4zP
 bIVCYwjLo3qSVgOP2N0gWICqGSxbmMXs+JkXkW/BpEg9QQyNrAyezjoTK7FuES3+wQ3P
 PirA==
X-Gm-Message-State: APjAAAViWvw2cvnUUwQ/r8aBToNLul3XSIVqsm5a0PHU0JLyNpeHDSs9
 nemjFcin95UCwK6qlOhnieQGm42QGxCHQp8KQxE=
X-Google-Smtp-Source: APXvYqxq3qBEh1XBrEoEdjx7lBPjQRngnVvws0JBaghk9Wk7e9ZKCFB1EyFRnmqIz6WMNnQHqBqrtgKPhhZP6oyn+EU=
X-Received: by 2002:a1c:b782:: with SMTP id h124mr17358696wmf.20.1560252498265; 
 Tue, 11 Jun 2019 04:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190609100837.17586-1-rfried.dev@gmail.com>
 <04cd3c78-9d8e-8958-1cdf-f65ab7d91dc7@redhat.com>
In-Reply-To: <04cd3c78-9d8e-8958-1cdf-f65ab7d91dc7@redhat.com>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Tue, 11 Jun 2019 14:28:07 +0300
Message-ID: <CAGi-RUJEwpyzFg3qe18CuR+aO1NXX3O8sUBxKyP1ooncFpcOrA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] net: cadence_gem: fix compilation error
 when debug is on
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 11, 2019 at 11:34 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com>
wrote:

> Hi Ramon,
>
> On 6/9/19 12:08 PM, Ramon Fried wrote:
> > defining CADENCE_GEM_ERR_DEBUG causes compilation
> > errors, fix that.
> >
> > Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
> > ---
> >  hw/net/cadence_gem.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> > index 7f63411430..5cc5a71524 100644
> > --- a/hw/net/cadence_gem.c
> > +++ b/hw/net/cadence_gem.c
> > @@ -982,8 +982,8 @@ static ssize_t gem_receive(NetClientState *nc, cons=
t
> uint8_t *buf, size_t size)
> >              return -1;
> >          }
> >
> > -        DB_PRINT("copy %d bytes to 0x%x\n", MIN(bytes_to_copy,
> rxbufsize),
> > -                rx_desc_get_buffer(s->rx_desc[q]));
> > +        DB_PRINT("copy %d bytes to 0x%lx\n", MIN(bytes_to_copy,
> rxbufsize),
> > +                rx_desc_get_buffer(s, s->rx_desc[q]));
>
> Your patch fails on 32-bit hosts:
>
> ./hw/net/cadence_gem.c:987:18: error: format '%lx' expects argument of
> type 'long unsigned int', but argument 4 has type 'uint64_t {aka long
> long unsigned int}' [-Werror=3Dformat=3D]
>          DB_PRINT("copy %d bytes to 0x%lx\n", MIN(bytes_to_copy,
> rxbufsize),
>                   ^
> ./hw/net/cadence_gem.c:39:24: note: in definition of macro 'DB_PRINT'
>      fprintf(stderr, ## __VA_ARGS__); \
>                         ^
> ./hw/net/cadence_gem.c: In function 'gem_transmit':
> ./hw/net/cadence_gem.c:1160:26: error: format '%lx' expects argument of
> type 'long unsigned int', but argument 5 has type 'unsigned int'
> [-Werror=3Dformat=3D]
>                  DB_PRINT("TX descriptor @ 0x%x too large: size 0x%x
> space " \
>                           ^
> ./hw/net/cadence_gem.c:39:24: note: in definition of macro 'DB_PRINT'
>      fprintf(stderr, ## __VA_ARGS__); \
>                         ^
> cc1: all warnings being treated as errors
>
> QEMU provides "HWADDR_PRIx" format for addresses, see for example few
> lines earlier:
>
>     DB_PRINT("read descriptor 0x%" HWADDR_PRIx "\n", packet_desc_addr);
>
>
> >
> >          /* Copy packet data to emulated DMA buffer */
> >          address_space_write(&s->dma_as, rx_desc_get_buffer(s,
> s->rx_desc[q]) +
> > @@ -1156,7 +1156,7 @@ static void gem_transmit(CadenceGEMState *s)
> >              if (tx_desc_get_length(desc) > sizeof(tx_packet) -
> >                                                 (p - tx_packet)) {
> >                  DB_PRINT("TX descriptor @ 0x%x too large: size 0x%x
> space " \
> > -                         "0x%x\n", (unsigned)packet_desc_addr,
> > +                         "0x%lx\n", (unsigned)packet_desc_addr,
>
> Here the correct format seems to be "%zd" (difference of sizeof).
>
> >                           (unsigned)tx_desc_get_length(desc),
> >                           sizeof(tx_packet) - (p - tx_packet));
> >                  break;
> >
>
> Nowadays QEMU prefers to move from the old DB_PRINT() macros to the
> trace events API, see for example this commit:
>
>
> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dda1804d17a9ed7f060c=
072fbc4889db5fbc9c7d2;hp=3Da4f667b6714916683408b983cfe0a615a725775f
>
> The first line you changed would be replaced by a trace event, while the
> second could be replaced by a qemu_log_mask() call (it is an error
> condition).
>
> Also I suggest to include "QEMU Trivial <qemu-trivial@nongnu.org>" in
> the list of recipients, so your patch might get reviewed/merged quicker.
>
> Regards,
>
> Phil.
>

Hi Phil,
Thanks for the review, I'll send v2 soon.
