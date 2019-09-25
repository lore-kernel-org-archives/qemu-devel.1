Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6B0C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 20:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE6A2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 20:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE6A2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDEHi-000106-OJ
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 16:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDEG8-0008P0-KJ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 16:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDEG3-0001B5-BJ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 16:51:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33620)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDEG3-00019c-2j
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 16:51:31 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8F625796E4
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 20:51:26 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id n6so66439wrm.20
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 13:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G0a1Q1SNOiSk2yoBA0w/CGsHzCylQb5rfNdC1Jqzmu8=;
 b=Vk26PyqR76fHS2r9DV+qask3PjIDlIZaJoFMq8H3YPS5lORXXEXtnVBKusxAEMO65D
 IF4N+CbZc2EXkncTI1quHQsRcp4p+3me2KnuiRAF+z2JUE+3aB3pGRz1RbnbyAYP1Uqc
 34HmOioN1l0AuiepxvouJzvO9dxB4FkQKwYNCJU3h7e5sHIHlIQGp8oqKgx5gEry49Db
 Cfb7zCOdbAKqtRc1Dc6hJCUDiTuRb/anhGm4qCOQqV6GUfPGikFSW7EwsDJQ0S2GBdXg
 Ki5475wfJunaa1AYlkZgFUSVCprT3bfrVp72Bq/nWXSgQj8fSBJmxidpWVownj+HD5dx
 oPjw==
X-Gm-Message-State: APjAAAVZU0qgKQQ+OOr03aCuYD39z6MuiL6QA0w0Gt9x0F1vhUJq1Ww9
 PjFzbDTxecmv2888Qvfa7wR4EIZGARbzDSnGjCMG4bFytNl3ZyBa4Vfya8TnkuLCmWeLBARgI2K
 Avo6DYf7cCo4pKJE=
X-Received: by 2002:a05:6000:10ce:: with SMTP id
 b14mr199130wrx.96.1569444685352; 
 Wed, 25 Sep 2019 13:51:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy+v5yQQq64eyPoTxHa64nWTrk7vtc3ajg2bsPd2QZYUy/0Lk6JEsz4k8fF4DdF/CO28e7sdg==
X-Received: by 2002:a05:6000:10ce:: with SMTP id
 b14mr199036wrx.96.1569444683135; 
 Wed, 25 Sep 2019 13:51:23 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id g4sm329374wrw.9.2019.09.25.13.51.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 13:51:22 -0700 (PDT)
Subject: Re: [PATCH] hw/core/loader: Fix possible crash in rom_copy()
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
References: <20190925130331.27825-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ca146886-12e5-14c7-7b18-76494b1d7c8f@redhat.com>
Date: Wed, 25 Sep 2019 22:51:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190925130331.27825-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, mdroth@linux.vnet.ibm.com,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Thomas,

On 9/25/19 3:03 PM, Thomas Huth wrote:
> Both, "rom->addr" and "addr" are derived from the binary image
> that can be loaded with the "-kernel" paramer. The code in
> rom_copy() then calculates:
>=20
>     d =3D dest + (rom->addr - addr);
>=20
> and uses "d" as destination in a memcpy() some lines later. Now with
> bad kernel images, it is possible that rom->addr is smaller than addr,
> thus "rom->addr - addr" gets negative and the memcpy() then tries to
> copy contents from the image to a bad memory location. In the best case=
,
> this just crashes QEMU, in the worst case, this could maybe be used to
> inject code from the kernel image into the QEMU binary, so we better fi=
x
> it with an additional sanity check here.
>=20
> Cc: qemu-stable@nongnu.org
> Reported-by: Guangming Liu
> Buglink: https://bugs.launchpad.net/qemu/+bug/1844635

"This page does not exist, or you may not have permission to see it."

This seems security related. Shouldn't we open a CVE for this?
https://wiki.qemu.org/SecurityProcess#CVE_allocation

Let's say I have write access to a LAN TFTP server used by some PXE
bootloader where I can store my crafted nasty kernel, then I get this sco=
re:

https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator?vector=3DAV:A/AC:L/P=
R:N/UI:N/S:C/C:H/I:H/A:H/E:P/RL:O/RC:C&version=3D3.1

CVSS Base Score:     9.6
CVSS Temporal Score: 8.6

Which seems quite high.

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/core/loader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 0d60219364..5099f27dc8 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -1281,7 +1281,7 @@ int rom_copy(uint8_t *dest, hwaddr addr, size_t s=
ize)

$ git show 235f86ef014
Date:   Thu Nov 12 21:53:11 2009 +0100

This function is old and poorly documented.

>          if (rom->addr + rom->romsize < addr) {
>              continue;
>          }
> -        if (rom->addr > end) {
> +        if (rom->addr > end || rom->addr < addr) {

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>              break;
>          }
> =20
>=20

