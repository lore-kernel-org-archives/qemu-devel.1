Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265E5C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:27:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF2920724
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0Du57E/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF2920724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRiR4-0008E1-1z
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 16:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRiP8-0004QN-8w
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:25:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRiP7-0006bD-GV
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:25:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23145
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRiP7-0006ZT-14
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587673500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hRuWYIm0h37MXf90sUc1NyTNNDVl+nEUAxdgAji08gY=;
 b=B0Du57E/k9w6QvxpnqUxpl5lVvL+e9TN8pDDjN1NceQGuM7NYMkF1pUEUFufbHr8shL398
 g9pS5JW35gVXLA/V9/kzt/u/iPcQdfJ1kQZP0PH3jGhS2U2pOArGyEgSPM4pTdONHH3PPW
 pHt11uL9jRujdbrX+7De0QKRQlOZpF0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-kHv04j_rPG6Qi4Ma73BZmA-1; Thu, 23 Apr 2020 16:24:58 -0400
X-MC-Unique: kHv04j_rPG6Qi4Ma73BZmA-1
Received: by mail-wm1-f70.google.com with SMTP id f81so2992775wmf.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 13:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zV4Z3fPcHI1OYVDggGNp6FNKRP8SznCFk9VObR96orc=;
 b=bdgGnF1I08qTFW5UZF1OzCRawF+tGyf8JDaDeonEp4kNTynmZI+7t8HigIE1hIyyy4
 ggYodIjRXmipRQfesNPgRQH1jyITWNQqbVblzpGgHwCyy9V68ki5J8Be02u7QX2FSe/h
 LTFpUYQksadKi0Wjp+jpVUbqJoW7ifLTjyHEHdn+YC6BFF3XuVwpsvi4oxWiooL7bZC8
 yFUn7cHZNCfGmWi5zfcDf1NhDPztFJQqGoSGCp2HhsQ4YGX/KRRDOWN+i8dDxfDjvzy9
 ef9j77mBzqLbPzzO3hjbFvw5uUjbk31/VPBqmpVf+azU1C3H9MugtHVxjcpZU2JP51GD
 frZg==
X-Gm-Message-State: AGi0PuZYwQ22UZa3H4VbrQbOBl3Na0t8yxLR5/lfnoSHLyyktjOFYj62
 VZHSNTnLmwaH/TLcousv7YRIBCJNJTpzZWBj5u1AnzrNOrDpHPXA0Abwwne6f5VaTaUA+emaSCe
 0UiKItg6GeHJnIDk=
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr5896911wmc.142.1587673496046; 
 Thu, 23 Apr 2020 13:24:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypIW4JUq7RYmK9dE4G+tWA4EQIixYMsepVbL/SlRUjKxzfgYb1cLQ7Ze4kzMPK+CSFN0qeNDDQ==
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr5896893wmc.142.1587673495788; 
 Thu, 23 Apr 2020 13:24:55 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id k184sm5159946wmf.9.2020.04.23.13.24.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2020 13:24:55 -0700 (PDT)
Subject: Re: [PATCH] elf_ops: Don't try to g_mapped_file_unref(NULL)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20200423202011.32686-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d9e2c1cf-30e5-a889-3e87-eed6480610ab@redhat.com>
Date: Thu, 23 Apr 2020 22:24:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200423202011.32686-1-peter.maydell@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 05:42:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Randy Yates <yates@ieee.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/23/20 10:20 PM, Peter Maydell wrote:
> Calling g_mapped_file_unref() on a NULL pointer is not valid, and
> glib will assert if you try it.
>=20
> $ qemu-system-arm -M virt -display none -device loader,file=3D/tmp/bad.el=
f
> qemu-system-arm: -device loader,file=3D/tmp/bad.elf: GLib: g_mapped_file_=
unref: assertion 'file !=3D NULL' failed
>=20
> (One way to produce an ELF file that fails like this is to copy just
> the first 16 bytes of a valid ELF file; this is sufficient to fool
> the code in load_elf_ram_sym() into thinking it's an ELF file and
> calling load_elf32() or load_elf64().)
>=20
> The failure-exit path in load_elf can be reached from various points
> in execution, and for some of those we haven't yet called
> g_mapped_file_new_from_fd().  Add a condition to the unref call so we
> only call it if we successfully created the GMappedFile to start with.
>=20
> This will fix the assertion; for the specific case of the generic
> loader it will then fall back from "guess this is an ELF file" to
> "maybe it's a uImage or a hex file" and eventually to "just load as
> a raw data file".
>=20
> Reported-by: Randy Yates <yates@ieee.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   include/hw/elf_ops.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> index e0bb47bb678..398a4a2c85b 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/hw/elf_ops.h
> @@ -606,7 +606,9 @@ static int glue(load_elf, SZ)(const char *name, int f=
d,
>           *highaddr =3D (uint64_t)(elf_sword)high;
>       ret =3D total_size;
>    fail:
> -    g_mapped_file_unref(mapped_file);
> +    if (mapped_file) {
> +        g_mapped_file_unref(mapped_file);
> +    }
>       g_free(phdr);
>       return ret;
>   }
>=20


