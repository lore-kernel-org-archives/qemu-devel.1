Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C4FC5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:45:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85434218A3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85434218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjIum-0002Q3-B2
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 03:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47979)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlureau@redhat.com>) id 1hjIsZ-0000pm-By
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1hjIsY-0000UE-A7
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:43:35 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34467)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1hjIsY-0000Rw-5A
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:43:34 -0400
Received: by mail-ot1-f65.google.com with SMTP id n5so8214630otk.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 00:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SrY0bUqYim8fJ27fobjyqu8mDkwZ8lbSUB7TVDZ/EYY=;
 b=TT3kK6NG9paDxmpI00JIcgfP6ULFe41XXJ+3gVaVGPsN1UyQ851P2LuBGssjFAcXkK
 6nZwugjgJ+uWkZV+W0gD9sC/pg53x2ZH0qwnl5Xdy4YwLSru+6JV6PA6RlIAuGQlN0BR
 ZxThnI811imAPRekPbahOKRJdMVVHKmhc3/Q1Iq7A3jLRIeqF/yNvxmpl3o7Htv2KviN
 EKmU6pOd8JYDlffX+GekNggOZs3c6zE4b/xCyEzD8UcvAom8ILQ4lxCgpmnVmNnxLZyZ
 A1EBS6ZdXg10BOETypuNKVxMG4X/HyNoSZndcNsifcXj894yS85Wc9Y9r7JGvwejOmFL
 2v6Q==
X-Gm-Message-State: APjAAAVPcDD2H0DdxUx3B2pclTxbM8ieBIP14mLgdhKhsmBVcYodGxBF
 JqjE3bUX8gdMm10a7ipcZExA+o/60Q0RA5zG3bPwl/BC
X-Google-Smtp-Source: APXvYqxOsQvPEs48zrffHdS/mQzCc4oqfu5jy1CQNkFyBEWHpSz557Zg9q9XuuHqyr2YRW1YfLHYW26cyP0u9RPuq+M=
X-Received: by 2002:a9d:6d12:: with SMTP id o18mr1851416otp.166.1562312612133; 
 Fri, 05 Jul 2019 00:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190705073957.2921-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190705073957.2921-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 5 Jul 2019 11:43:21 +0400
Message-ID: <CAMxuvazqS2PWn80WEhOA+5Z86AyOE0ba25M_czqff0uSDB6uZw@mail.gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.65
Subject: Re: [Qemu-devel] [PATCH] usbredir: fix buffer-overflow on migration
 load
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
Cc: "Hoffmann, Gerd" <kraxel@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Jul 5, 2019 at 11:40 AM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> NO_INTERFACE_INFO (255) is used to indicate no info.
>
> /home/elmarco/src/qemu/hw/usb/redirect.c:1504:71: runtime error: index 32=
 out of bounds for type 'uint8_t [32]'
> /home/elmarco/src/qemu/hw/usb/redirect.c:1503:71: runtime error: index 32=
 out of bounds for type 'uint8_t [32]'
> /home/elmarco/src/qemu/hw/usb/redirect.c:1502:68: runtime error: index 32=
 out of bounds for type 'uint8_t [32]'
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D32073=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address=
 0x625000252930 at pc 0x556c5126b0b6 bp 0x7fc7793ffa50 sp 0x7fc7793ffa40
> READ of size 1 at 0x625000252930 thread T0
>     #0 0x556c5126b0b5 in usbredir_check_bulk_receiving /home/elmarco/src/=
qemu/hw/usb/redirect.c:1504
>     #1 0x556c51275a2a in usbredir_post_load /home/elmarco/src/qemu/hw/usb=
/redirect.c:2154
>     #2 0x556c51306f5e in vmstate_load_state /home/elmarco/src/qemu/migrat=
ion/vmstate.c:168
>     #3 0x556c512efb43 in vmstate_load /home/elmarco/src/qemu/migration/sa=
vevm.c:829
>     #4 0x556c512f9967 in qemu_loadvm_section_start_full /home/elmarco/src=
/qemu/migration/savevm.c:2212
>     #5 0x556c512faee1 in qemu_loadvm_state_main /home/elmarco/src/qemu/mi=
gration/savevm.c:2396
>     #6 0x556c512fb16b in qemu_loadvm_state /home/elmarco/src/qemu/migrati=
on/savevm.c:2468
>     #7 0x556c512c0d2b in process_incoming_migration_co /home/elmarco/src/=
qemu/migration/migration.c:449
>     #8 0x556c51b62bcc in coroutine_trampoline /home/elmarco/src/qemu/util=
/coroutine-ucontext.c:115
>     #9 0x7fc80fba637f  (/lib64/libc.so.6+0x4d37f)
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

To be even safer, we should check interface_count has a value <=3D 32 on lo=
ad.

> ---
>  hw/usb/redirect.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
> index 998fc6e4b0..3bda19bd64 100644
> --- a/hw/usb/redirect.c
> +++ b/hw/usb/redirect.c
> @@ -1495,6 +1495,9 @@ static void usbredir_check_bulk_receiving(USBRedirD=
evice *dev)
>      for (i =3D EP2I(USB_DIR_IN); i < MAX_ENDPOINTS; i++) {
>          dev->endpoint[i].bulk_receiving_enabled =3D 0;
>      }
> +    if (dev->interface_info.interface_count =3D=3D NO_INTERFACE_INFO) {
> +        return;
> +    }
>      for (i =3D 0; i < dev->interface_info.interface_count; i++) {
>          quirks =3D usb_get_quirks(dev->device_info.vendor_id,
>                                  dev->device_info.product_id,
> --
> 2.22.0.214.g8dca754b1e
>

