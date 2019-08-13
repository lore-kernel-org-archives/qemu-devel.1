Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA25C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 07:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D3720679
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 07:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IL9WrcV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D3720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxRYk-00010V-QJ
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 03:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37360)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hikarupsp@gmail.com>) id 1hxRYM-0000av-UB
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 03:49:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hikarupsp@gmail.com>) id 1hxRYL-0005W6-UX
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 03:49:10 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:33927)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hikarupsp@gmail.com>) id 1hxRYL-0005Ul-Mi
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 03:49:09 -0400
Received: by mail-lf1-x144.google.com with SMTP id b29so68854911lfq.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 00:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zr/RgXvFskWFonmp0zxd+VXjOcBkpek9LeIRqoFS8pU=;
 b=IL9WrcV7cjxRu5POeb5s/AbbMah6d/r1NsbWYjDYDmwlODqreGjZLlZJDMdOP38Uzl
 TH2zVEc4Edirjhvcl8tkgxyVPddq5M3jRUw8Ql2CyxJTt5kCgTmnmgjH2WE6Ja52ZD71
 dU4n0HhNhijxs+Y5D1dl642U7VoyE2aNiuW5PzYmvzE3MGTQZMFrz3XEURbZn8e8eC4T
 427jg5cRJbOS5oX9/CwrUPXXEZpxfKrY3y6bCz0cKD2bf/G4hRH0230WkialiXLL9aWW
 m7F1yPqLyVo3c21cqmLwKbSVR4bZPpY+Ziiysn8cwgrKxSNsB5FmehhQ7LIKIwbGFeAr
 K9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zr/RgXvFskWFonmp0zxd+VXjOcBkpek9LeIRqoFS8pU=;
 b=PrgIG5c8ip8lcp3Vu2rPYdE/V+Pd0J8WvY0k+0LA5e5/c/W8e7ifJ4DGslkT3oi20B
 ETWHcmA167Fvzgo5ce/yyJqWILeqFC7e3xCDZfl9Xh7dxAgxjAFlavAMDkkFKBIQ9r8Y
 nv5iHRsuw+NskNQGdSZY17tX21pKjXRjHZj9FMgh6X/I6UhmS6nmKyxp5OnfZwY2XOIs
 C6w7qW8FUH+htcEOc8VuR5UnwWM4aJ4VO4M/vWnRSXtsT8tnWpAKhMZH2aZuN0JOl5SG
 Ytel6G2wta90NYi4QpcjSaEdLANCjpOFlUy3tTXI1aQU/RrNoJJyCBaNe0MjMIlvs+aV
 nIUQ==
X-Gm-Message-State: APjAAAUit5Ky4eYlWKPF3gDgq6kt+SOVy9J3F+A2ROqcncBBFDY+qPNx
 NpqA312vnEAfL5Ga8bLrxxJ5l8FFwo95a4OCL1ANwwmk
X-Google-Smtp-Source: APXvYqwHkR8VZnCnnMlODIpYPTkz3GOoZTOlD37KSWtROeySXppVquOnT+vwjmNdTWIGJYFoKNP95uv8RckGyQlm0RI=
X-Received: by 2002:ac2:592f:: with SMTP id v15mr1494548lfi.57.1565682547218; 
 Tue, 13 Aug 2019 00:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190720060427.50457-1-hikarupsp@gmail.com>
 <CAD-w0GD_YGE-3iRbm=Qf+_zqWNyt36sHD3uKB9q2P0ff=0M55Q@mail.gmail.com>
In-Reply-To: <CAD-w0GD_YGE-3iRbm=Qf+_zqWNyt36sHD3uKB9q2P0ff=0M55Q@mail.gmail.com>
From: Hikaru Nishida <hikarupsp@gmail.com>
Date: Tue, 13 Aug 2019 16:48:54 +0900
Message-ID: <CAD-w0GBFhypGzHjziMxiZJHWSgHuwyLwtWV8S3izh3YZ-+zBAw@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] xhci: Add No Op Command
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping^2

2019=E5=B9=B48=E6=9C=886=E6=97=A5(=E7=81=AB) 0:38 Hikaru Nishida <hikarupsp=
@gmail.com>:

> ping...
>
> 2019=E5=B9=B47=E6=9C=8820=E6=97=A5(=E5=9C=9F) 15:04 <hikarupsp@gmail.com>=
:
>
>> From: Hikaru Nishida <hikarupsp@gmail.com>
>>
>> This commit adds No Op Command (23) to xHC for verifying the operation
>> of the Command Ring mechanisms.
>> No Op Command is defined in XHCI spec (4.6.2) and just reports Command
>> Completion Event with Completion Code =3D=3D Success.
>> Before this commit, No Op Command is not implemented so xHC reports
>> Command Completion Event with Completion Code =3D=3D TRB Error. This com=
mit
>> fixes this behaviour to report Completion Code correctly.
>>
>> Signed-off-by: Hikaru Nishida <hikarupsp@gmail.com>
>> ---
>>  hw/usb/hcd-xhci.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
>> index 5894a18663..5ceff78280 100644
>> --- a/hw/usb/hcd-xhci.c
>> +++ b/hw/usb/hcd-xhci.c
>> @@ -2542,6 +2542,9 @@ static void xhci_process_commands(XHCIState *xhci)
>>          case CR_GET_PORT_BANDWIDTH:
>>              event.ccode =3D xhci_get_port_bandwidth(xhci, trb.parameter=
);
>>              break;
>> +        case CR_NOOP:
>> +            event.ccode =3D CC_SUCCESS;
>> +            break;
>>          case CR_VENDOR_NEC_FIRMWARE_REVISION:
>>              if (xhci->nec_quirks) {
>>                  event.type =3D 48; /* NEC reply */
>> --
>> 2.20.1 (Apple Git-117)
>>
>>
