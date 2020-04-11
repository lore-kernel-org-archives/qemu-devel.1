Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC3AC2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 18:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBBB220732
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 18:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBBB220732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNKWM-0000iu-09
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 14:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jNKVZ-00007r-1X
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 14:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jNKVS-0006fo-2L
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 14:05:32 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:18552)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jNKVQ-0006W3-Jy; Sat, 11 Apr 2020 14:05:26 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 949D17475F6;
 Sat, 11 Apr 2020 20:05:13 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6437074637F; Sat, 11 Apr 2020 20:05:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 627E8745953;
 Sat, 11 Apr 2020 20:05:13 +0200 (CEST)
Date: Sat, 11 Apr 2020 20:05:13 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.0 1/2] hw/display/sm501: Avoid heap overflow in
 sm501_2d_operation()
In-Reply-To: <20200411091453.30371-2-f4bug@amsat.org>
Message-ID: <alpine.BSF.2.22.395.2004111953020.75236@zero.eik.bme.hu>
References: <20200411091453.30371-1-f4bug@amsat.org>
 <20200411091453.30371-2-f4bug@amsat.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1175392547-1586628313=:75236"
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, qemu-devel@nongnu.org,
 Zhang Zi Ming <1015138407@qq.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1175392547-1586628313=:75236
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Sat, 11 Apr 2020, Philippe Mathieu-Daud=C3=A9 wrote:
> Zhang Zi Ming reported a heap overflow in the Drawing Engine of
> the SM501 companion chip model, in particular in the COPY_AREA()
> macro in sm501_2d_operation().
>
> As I have no idea what this code is supposed to do, add a simple
> check to avoid the heap overflow. This fixes:

As the function name says it performs a 2D blitter operation. The code ha=
d=20
no bounds checking at all and there are easier ways to crash it by writin=
g=20
any unimplemented register for which it has abort() calls in the device=20
implementation. I'm not sure this patch fixes all possible overflows but=20
at least plugs this particular one so why not.

Acked-by: BALATON Zoltan <balaton@eik.bme.hu>

Otherwise this device emulation should be rewritten sometimes but I had=20
not time for that.

Regards,
BALATON Zoltan

>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  =3D=3D20518=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on addr=
ess 0x7f6f4c3fffff at pc 0x55b1e1d358f0 bp 0x7ffce464dfb0 sp 0x7ffce464df=
a8
>  READ of size 1 at 0x7f6f4c3fffff thread T0
>      #0 0x55b1e1d358ef in sm501_2d_operation hw/display/sm501.c:788:13
>      #1 0x55b1e1d32c38 in sm501_2d_engine_write hw/display/sm501.c:1466=
:13
>      #2 0x55b1e0cd19d8 in memory_region_write_accessor memory.c:483:5
>      #3 0x55b1e0cd1404 in access_with_adjusted_size memory.c:544:18
>      #4 0x55b1e0ccfb9d in memory_region_dispatch_write memory.c:1476:16
>      #5 0x55b1e0ae55a8 in flatview_write_continue exec.c:3125:23
>      #6 0x55b1e0ad3e87 in flatview_write exec.c:3165:14
>      #7 0x55b1e0ad3a24 in address_space_write exec.c:3256:18
>
>  0x7f6f4c3fffff is located 4194303 bytes to the right of 4194304-byte r=
egion [0x7f6f4bc00000,0x7f6f4c000000)
>  allocated by thread T0 here:
>      #0 0x55b1e0a6e715 in __interceptor_posix_memalign (ppc64-softmmu/q=
emu-system-ppc64+0x19c0715)
>      #1 0x55b1e31c1482 in qemu_try_memalign util/oslib-posix.c:189:11
>      #2 0x55b1e31c168c in qemu_memalign util/oslib-posix.c:205:27
>      #3 0x55b1e11a00b3 in spapr_reallocate_hpt hw/ppc/spapr.c:1560:23
>      #4 0x55b1e11a0ce4 in spapr_setup_hpt hw/ppc/spapr.c:1593:5
>      #5 0x55b1e11c2fba in spapr_machine_reset hw/ppc/spapr.c:1644:9
>      #6 0x55b1e1368b01 in qemu_system_reset softmmu/vl.c:1391:9
>      #7 0x55b1e1375af3 in qemu_init softmmu/vl.c:4436:5
>      #8 0x55b1e2fc8a59 in main softmmu/main.c:48:5
>      #9 0x7f6f8150bf42 in __libc_start_main (/lib64/libc.so.6+0x23f42)
>
>  SUMMARY: AddressSanitizer: heap-buffer-overflow hw/display/sm501.c:788=
:13 in sm501_2d_operation
>  Shadow bytes around the buggy address:
>    0x0fee69877fa0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>    0x0fee69877fb0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>    0x0fee69877fc0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>    0x0fee69877fd0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>    0x0fee69877fe0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>  =3D>0x0fee69877ff0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa[fa]
>    0x0fee69878000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    0x0fee69878010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    0x0fee69878020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    0x0fee69878030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    0x0fee69878040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  Shadow byte legend (one shadow byte represents 8 application bytes):
>    Addressable:           00
>    Partially addressable: 01 02 03 04 05 06 07
>    Heap left redzone:       fa
>    Freed heap region:       fd
>    Poisoned by user:        f7
>    ASan internal:           fe
>  =3D=3D20518=3D=3DABORTING
>
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1786026
> Reported-by: Zhang Zi Ming <1015138407@qq.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Per the links on
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1808510 there is probably
> a CVE assigned to this, but I don't have access to the information,
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1786593 only show:
>
>  You are not authorized to access bug #1786593.
>  Most likely the bug has been restricted for internal development proce=
sses and we cannot grant access.
> ---
> hw/display/sm501.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index de0ab9d977..902acb3875 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -726,6 +726,12 @@ static void sm501_2d_operation(SM501State *s)
>     int crt =3D (s->dc_crt_control & SM501_DC_CRT_CONTROL_SEL) ? 1 : 0;
>     int fb_len =3D get_width(s, crt) * get_height(s, crt) * get_bpp(s, =
crt);
>
> +    if (rtl && (src_x < operation_width || src_y < operation_height)) =
{
> +        qemu_log_mask(LOG_GUEST_ERROR, "sm501: Illegal RTL address (%i=
, %i)\n",
> +                      src_x, src_y);
> +        return;
> +    }
> +
>     if (addressing !=3D 0x0) {
>         printf("%s: only XY addressing is supported.\n", __func__);
>         abort();
>
--3866299591-1175392547-1586628313=:75236--

