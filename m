Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47010C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B12C6223EA
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EP1Po4+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12C6223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGkVx-0000zy-RC
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 10:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kGkVM-0000a0-SV
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 10:58:24 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46860)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kGkVL-0000I3-3D
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 10:58:24 -0400
Received: by mail-oi1-x242.google.com with SMTP id u126so9658598oif.13
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 07:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BrfhBORQn3/mQyfl4ULdvCNeqsrFdp2Cvw0z+3HV8Y4=;
 b=EP1Po4+4P0pjc/6eM5DGbwKwHEBGqmV9kIFbl5CDj3DL+0vF2nXV+tlg+6X/RWtnx6
 AznpX+TfTKv24EfwEKrqg0P28hM+quXdXVVpPjIcgZ3BlD2Q6z0eoSyArHOaTBP26r4D
 f1B50q8Df0GzlgyO9ekCz24JS+n5Vwrz8X32i3GucOHDoPZ7f3UK2ZpObdFu9mG//GBT
 AhO8G4FFa96CSeqQKwefIrGHKLY+VyLQiS07leFMadh4tqXtvk4E1VOTmEuMM9DKNBLW
 uNEjCoXYuppebgMsIv77jprYXJMKqNE9h93/tsNM7j3FfSIBZ6RMT1i5rZVz6+pIkZoP
 UVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BrfhBORQn3/mQyfl4ULdvCNeqsrFdp2Cvw0z+3HV8Y4=;
 b=CpfWxHi2g0ZU+cgUesXIRikJ7UHMpUICZQg/jeZMquyXzE7u9/PBvwhiLXdmhUxqtb
 ILU7iICmeirW79tejw1CxZVv7EDSUCcIii1toXJQt633mFZXosA3jw0tA7tGPaxiyq46
 vR0fAwC+kPJkkxiifrNXRIGSXJ4gZbl/G1swhew813WlyjznkylHPE9n5qH+0WPVvZl/
 KX+kLZHQ/WnWqIn2XT6TzYZTiVV5AHU/doCdpMf/sIdKy/MuM8xskSBHgqAuF+PUbZxI
 gVMM/wDlqvTY+s9YYZT5Smd39N3H3jYfB/v0YqIF4sE+OHmbTUGlEbZv28dkR1PxydSI
 uxuA==
X-Gm-Message-State: AOAM531j3FPygTjwkVgcGGjTQBnpSfzsNF34eTwe3CCvHajjqRi1Dq5A
 R4b/PqLdTjYH54UdgHiKdByppZS3f05yHIgtqzQ=
X-Google-Smtp-Source: ABdhPJy2t2ls1ALA5Ho7kJB40ksBGs0RPTG+Uoo+2u0q8sZj5q4f8PuMqiqfL/Vx1C9t5JB6tagWyNMS1u4gmWpjrFc=
X-Received: by 2002:aca:b454:: with SMTP id d81mr1441503oif.150.1599836301481; 
 Fri, 11 Sep 2020 07:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200911122703.126696-1-ppandit@redhat.com>
In-Reply-To: <20200911122703.126696-1-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 11 Sep 2020 22:57:45 +0800
Message-ID: <CAKXe6SLFG1XMCw7yNM3bres29jiqJ5oLpJUgzXGjj8ay=NkwHQ@mail.gmail.com>
Subject: Re: [PATCH] hw: usb: hcd-ohci: check len and frame_number variables
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Yi Ren <yunye.ry@alibaba-inc.com>,
 Yongkang Jia <j_kangel@163.com>, Gaoning Pan <pgn@zju.edu.cn>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

P J P <ppandit@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8811=E6=97=A5=E5=
=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:30=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> While servicing the OHCI transfer descriptors(TD), OHCI host
> controller derives variables 'start_addr', 'end_addr', 'len'
> etc. from values supplied by the host controller driver.
> Host controller driver may supply values such that using
> above variables leads to out-of-bounds access or loop issues.
> Add checks to avoid them.
>
> AddressSanitizer: stack-buffer-overflow on address 0x7ffd53af76a0
>   READ of size 2 at 0x7ffd53af76a0 thread T0
>   #0 ohci_service_iso_td ../hw/usb/hcd-ohci.c:734
>   #1 ohci_service_ed_list ../hw/usb/hcd-ohci.c:1180
>   #2 ohci_process_lists ../hw/usb/hcd-ohci.c:1214
>   #3 ohci_frame_boundary ../hw/usb/hcd-ohci.c:1257
>   #4 timerlist_run_timers ../util/qemu-timer.c:572
>   #5 qemu_clock_run_timers ../util/qemu-timer.c:586
>   #6 qemu_clock_run_all_timers ../util/qemu-timer.c:672
>   #7 main_loop_wait ../util/main-loop.c:527
>   #8 qemu_main_loop ../softmmu/vl.c:1676
>   #9 main ../softmmu/main.c:50
>

Hello Prasad,
Could you also provide the reproducer?

> Reported-by: Gaoning Pan <pgn@zju.edu.cn>
> Reported-by: Yongkang Jia <j_kangel@163.com>
> Reported-by: Yi Ren <yunye.ry@alibaba-inc.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/usb/hcd-ohci.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index 1e6e85e86a..76fb9282e3 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -691,6 +691,11 @@ static int ohci_service_iso_td(OHCIState *ohci, stru=
ct ohci_ed *ed,
>             the next ISO TD of the same ED */
>          trace_usb_ohci_iso_td_relative_frame_number_big(relative_frame_n=
umber,
>                                                          frame_count);
> +        if (OHCI_CC_DATAOVERRUN =3D=3D OHCI_BM(iso_td.flags, TD_CC)) {
> +            /* avoid infinite loop */
> +            return 1;
> +        }

I think it is better to split this patch to 2 or three as the infinite
loop as the buffer overflow are independent.

1. here the infinite loop

> +
>          OHCI_SET_BM(iso_td.flags, TD_CC, OHCI_CC_DATAOVERRUN);
>          ed->head &=3D ~OHCI_DPTR_MASK;
>          ed->head |=3D (iso_td.next & OHCI_DPTR_MASK);
> @@ -731,7 +736,11 @@ static int ohci_service_iso_td(OHCIState *ohci, stru=
ct ohci_ed *ed,
>      }
>
>      start_offset =3D iso_td.offset[relative_frame_number];
> -    next_offset =3D iso_td.offset[relative_frame_number + 1];
> +    if (relative_frame_number < frame_count) {
> +        next_offset =3D iso_td.offset[relative_frame_number + 1];
> +    } else {
> +        next_offset =3D iso_td.be;
> +    }

2. here the stack buffer overflow

>
>      if (!(OHCI_BM(start_offset, TD_PSW_CC) & 0xe) ||
>          ((relative_frame_number < frame_count) &&
> @@ -764,7 +773,12 @@ static int ohci_service_iso_td(OHCIState *ohci, stru=
ct ohci_ed *ed,
>          }
>      } else {
>          /* Last packet in the ISO TD */
> -        end_addr =3D iso_td.be;
> +        end_addr =3D next_offset;
> +    }
> +
> +    if (start_addr > end_addr) {
> +        trace_usb_ohci_iso_td_bad_cc_overrun(start_addr, end_addr);
> +        return 1;
>      }
>
>      if ((start_addr & OHCI_PAGE_MASK) !=3D (end_addr & OHCI_PAGE_MASK)) =
{
> @@ -773,6 +787,9 @@ static int ohci_service_iso_td(OHCIState *ohci, struc=
t ohci_ed *ed,
>      } else {
>          len =3D end_addr - start_addr + 1;
>      }
> +    if (len > sizeof(ohci->usb_buf)) {
> +        len =3D sizeof(ohci->usb_buf);
> +    }
>
>      if (len && dir !=3D OHCI_TD_DIR_IN) {
>          if (ohci_copy_iso_td(ohci, start_addr, end_addr, ohci->usb_buf, =
len,
> @@ -975,8 +992,16 @@ static int ohci_service_td(OHCIState *ohci, struct o=
hci_ed *ed)
>          if ((td.cbp & 0xfffff000) !=3D (td.be & 0xfffff000)) {
>              len =3D (td.be & 0xfff) + 0x1001 - (td.cbp & 0xfff);
>          } else {
> +            if (td.cbp > td.be) {
> +                trace_usb_ohci_iso_td_bad_cc_overrun(td.cbp, td.be);
> +                ohci_die(ohci);
> +                return 1;
> +            }
>              len =3D (td.be - td.cbp) + 1;
>          }
> +        if (len > sizeof(ohci->usb_buf)) {
> +            len =3D sizeof(ohci->usb_buf);
> +        }
>

3. Then here is the heap overflow.


So I think it can be more easier to review to split this to 3 patches.

Thanks,
Li Qiang

>          pktlen =3D len;
>          if (len && dir !=3D OHCI_TD_DIR_IN) {
> --
> 2.26.2
>
>

