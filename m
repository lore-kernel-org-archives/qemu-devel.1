Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CB8C73C53
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 17:05:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 219462082A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 17:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPYCbjNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219462082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hktY8-0002VB-0J
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 13:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46157)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hktRz-0007L0-46
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hktRu-0000Q9-1w
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:58:42 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:38778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hktRt-0000Nr-O9; Tue, 09 Jul 2019 12:58:37 -0400
Received: by mail-lf1-x144.google.com with SMTP id h28so9571904lfj.5;
 Tue, 09 Jul 2019 09:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=B+qh/ApQkXMn4HseSP48lVMnG6hVBYWQPWRivAa1eus=;
 b=YPYCbjNy7drtBhmXn1RdwPPB1i+i0t2hQ4ZqXIvmW/YmiiewJhxwWFDNeIXSxHNndj
 kroxzFRjMkyeTZveGOuLVaW0bO8dIjOoc9O3xuSN4NjnaMaNzLMfRXbPCo8UpziLFlGx
 dQFu9slahJ1MfwZw+avoSYuI21dujLgQhY5GKvMzNirPVG0BUcyQTxNIp6WsMGzFrNNI
 l6L0mXL1f6FqgOwJNbEENE4v9PPJ49KAjlNbNW5+h5NlHjtQp8eUaFddZfuJf2WNg0d8
 mzSJSzBc9WKY9sojdj925JyT9LYlAtV3ZuAqRzZXE8FSVG2yO/KxMmhcT3lKdiRii9Ix
 KPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=B+qh/ApQkXMn4HseSP48lVMnG6hVBYWQPWRivAa1eus=;
 b=D/O2Zhuy1iebEImDOK5FRuuWGrBhQmi3cflsm+JsRU/91ka2hWKCmqWSapnEkAz3tN
 aUZlsc4tc78H3lV+Q+uIm2+SD6KXnkcSqK0DuGGZlSTrw/vDHbypYELikNuF/yNzAWj0
 9zBfvRlQJEm9WA8Lv/LBDia8evjXAnY6OToLXMMOVfvFWyH2HEreaTuUyEJiWtz5LBco
 NeZYxduDasBLHU8R2t199/tDQKUTR+4UoX3As5zIvv9fvKDNyNybjG/mVN40bDLTydP7
 EKYBWeqpImqxpJ8dkRgOytwvrdj75eb+sxq5dgc6Vozko3lxtTmgS6uXd3pCpfvH9bxH
 Aqmg==
X-Gm-Message-State: APjAAAV6cmgn73IPAVSo7TeYsdvmQpMEwYeXEdLgOq3akME/O5F/WAG4
 00fPMZyQ/R4pBCZ4fqeUmIXiBqraubFN4+LEc9U=
X-Google-Smtp-Source: APXvYqxD3yIk/HBNhjw7JWTBHz2fpSyknmzzdFStCRq0R0IeU6eOM4OhYAiyIqHiE0gELWRi64i47ayv7MPlAftu/mM=
X-Received: by 2002:a19:7709:: with SMTP id s9mr11595074lfc.86.1562691516331; 
 Tue, 09 Jul 2019 09:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190709113715.7761-1-philmd@redhat.com>
 <20190709113715.7761-3-philmd@redhat.com>
In-Reply-To: <20190709113715.7761-3-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 9 Jul 2019 09:55:26 -0700
Message-ID: <CAKmqyKMxA6Dh=-=Pb3UnOdLStyVSW+HoWJK8Z4JfLXmVk=yEOA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [PATCH-for-4.1 2/3] hw/ssi/mss-spi: Avoid crash
 when reading empty RX FIFO
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 9, 2019 at 4:42 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> Reading the RX_DATA register when the RX_FIFO is empty triggers
> an abort. This can be easily reproduced:
>
>   $ qemu-system-arm -M emcraft-sf2 -monitor stdio -S
>   QEMU 4.0.50 monitor - type 'help' for more information
>   (qemu) x 0x40001010
>   Aborted (core dumped)
>
>   (gdb) bt
>   #1  0x00007f035874f895 in abort () at /lib64/libc.so.6
>   #2  0x00005628686591ff in fifo8_pop (fifo=3D0x56286a9a4c68) at util/fif=
o8.c:66
>   #3  0x00005628683e0b8e in fifo32_pop (fifo=3D0x56286a9a4c68) at include=
/qemu/fifo32.h:137
>   #4  0x00005628683e0efb in spi_read (opaque=3D0x56286a9a4850, addr=3D4, =
size=3D4) at hw/ssi/mss-spi.c:168
>   #5  0x0000562867f96801 in memory_region_read_accessor (mr=3D0x56286a9a4=
b60, addr=3D16, value=3D0x7ffeecb0c5c8, size=3D4, shift=3D0, mask=3D4294967=
295, attrs=3D...) at memory.c:439
>   #6  0x0000562867f96cdb in access_with_adjusted_size (addr=3D16, value=
=3D0x7ffeecb0c5c8, size=3D4, access_size_min=3D1, access_size_max=3D4, acce=
ss_fn=3D0x562867f967c3 <memory_region_read_accessor>, mr=3D0x56286a9a4b60, =
attrs=3D...) at memory.c:569
>   #7  0x0000562867f99940 in memory_region_dispatch_read1 (mr=3D0x56286a9a=
4b60, addr=3D16, pval=3D0x7ffeecb0c5c8, size=3D4, attrs=3D...) at memory.c:=
1420
>   #8  0x0000562867f99a08 in memory_region_dispatch_read (mr=3D0x56286a9a4=
b60, addr=3D16, pval=3D0x7ffeecb0c5c8, size=3D4, attrs=3D...) at memory.c:1=
447
>   #9  0x0000562867f38721 in flatview_read_continue (fv=3D0x56286aec6360, =
addr=3D1073745936, attrs=3D..., buf=3D0x7ffeecb0c7c0 "\340=C7=B0\354\376\17=
7", len=3D4, addr1=3D16, l=3D4, mr=3D0x56286a9a4b60) at exec.c:3385
>   #10 0x0000562867f38874 in flatview_read (fv=3D0x56286aec6360, addr=3D10=
73745936, attrs=3D..., buf=3D0x7ffeecb0c7c0 "\340=C7=B0\354\376\177", len=
=3D4) at exec.c:3423
>   #11 0x0000562867f388ea in address_space_read_full (as=3D0x56286aa3e890,=
 addr=3D1073745936, attrs=3D..., buf=3D0x7ffeecb0c7c0 "\340=C7=B0\354\376\1=
77", len=3D4) at exec.c:3436
>   #12 0x0000562867f389c5 in address_space_rw (as=3D0x56286aa3e890, addr=
=3D1073745936, attrs=3D..., buf=3D0x7ffeecb0c7c0 "\340=C7=B0\354\376\177", =
len=3D4, is_write=3Dfalse) at exec.c:3466
>   #13 0x0000562867f3bdd7 in cpu_memory_rw_debug (cpu=3D0x56286aa19d00, ad=
dr=3D1073745936, buf=3D0x7ffeecb0c7c0 "\340=C7=B0\354\376\177", len=3D4, is=
_write=3D0) at exec.c:3976
>   #14 0x000056286811ed51 in memory_dump (mon=3D0x56286a8c32d0, count=3D1,=
 format=3D120, wsize=3D4, addr=3D1073745936, is_physical=3D0) at monitor/mi=
sc.c:730
>   #15 0x000056286811eff1 in hmp_memory_dump (mon=3D0x56286a8c32d0, qdict=
=3D0x56286b15c400) at monitor/misc.c:785
>   #16 0x00005628684740ee in handle_hmp_command (mon=3D0x56286a8c32d0, cmd=
line=3D0x56286a8caeb2 "0x40001010") at monitor/hmp.c:1082
>
> From the datasheet "Actel SmartFusion Microcontroller Subsystem
> User's Guide" Rev.1, Table 13-3 "SPI Register Summary", this
> register has a reset value of 0.
>
> Check the FIFO is not empty before accessing it, else log an
> error message.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/ssi/mss-spi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ssi/mss-spi.c b/hw/ssi/mss-spi.c
> index 4878279482..3201a577a1 100644
> --- a/hw/ssi/mss-spi.c
> +++ b/hw/ssi/mss-spi.c
> @@ -155,7 +155,13 @@ spi_read(void *opaque, hwaddr addr, unsigned int siz=
e)
>      case R_SPI_RX:
>          s->regs[R_SPI_STATUS] &=3D ~S_RXFIFOFUL;
>          s->regs[R_SPI_STATUS] &=3D ~S_RXCHOVRF;
> -        ret =3D fifo32_pop(&s->rx_fifo);
> +        if (fifo32_is_empty(&s->rx_fifo)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Reading empty RX_FIFO\n",
> +                          __func__);
> +        } else {
> +            ret =3D fifo32_pop(&s->rx_fifo);
> +        }
>          if (fifo32_is_empty(&s->rx_fifo)) {
>              s->regs[R_SPI_STATUS] |=3D S_RXFIFOEMP;
>          }
> --
> 2.20.1
>
>

