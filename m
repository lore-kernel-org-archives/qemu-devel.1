Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ECDC2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 08:04:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CC0020736
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 08:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2UJl8HX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC0020736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRtJg-0002w0-5U
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 04:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1jRtIa-0001Ud-1w
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1jRtIV-0004p4-15
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:02:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22542
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jRtIU-0004jw-Im
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 04:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587715373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dbgYanLLwwglleg12BWjhG+qKbHxC2VxBwlFdlOgqkU=;
 b=L2UJl8HXpRyVpWMTjwUoqWp3YwGoO7tTW0k7kc75fz8pyiD6J79e+g3WHDlyYzDMcD0F2l
 10YCNnddIQNKsx/RMiKrNGBeuxW1FyH9GL+hrPkZcgaZKgkJq5X2bbOtobZ+CU02rlRB/J
 pkC+bAQN+PoERWIcmu29a5Acsj1ESLM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-dXi3HbkqO72HDwibp7c1Gg-1; Fri, 24 Apr 2020 04:02:51 -0400
X-MC-Unique: dXi3HbkqO72HDwibp7c1Gg-1
Received: by mail-wm1-f70.google.com with SMTP id h22so3481318wml.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 01:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=A+3aAMTf+vkTiLcHgLUV+t/6fgE2FIUpNF1647W+5mE=;
 b=Ih/G0OqRhl3rrXfs4pFypPbYBdp4NIS7WxaqQqc30UA6miP57JjX0iFELTAIZbCWx1
 zCHEXm7Y+e6GoS+cSEoe58y5tuW6X4p/AvLINFOdgUPRYgJrBLCPjOAUCqVfIPXpz8rr
 pF/OmaJzRnEQ5lxSS/DiTbw2W6OsZSieXzg3g5ciJ1GzbHpf0b/jFHxRD8aF69A6zsHM
 X9icc25GIqrLnlXE2T5aogav+doIdGxZwGDu2MvWTS7qZSuaJbiklWt32yg38eqY6HHr
 BpNCD3d3swd4Q9K1P4V2WDwDqzxjoYheCZu9MxSdUgXlX0yZb2NTpuQM8M6fA8OlQvTb
 +WXg==
X-Gm-Message-State: AGi0PuYdZYdwKVlnpkNMFH+qNgB7uSP77QaKc8eQQn3Ox1IvnkPzPQNG
 gHvyEgjmRW2MuhKYCQvPTA7C0+fi/4Anew6B9k8WFXjoIeeckxSQyu0a1KiDWsjeJ0dynuWWHR8
 1H4AgANlmi6onRMs=
X-Received: by 2002:a1c:41d7:: with SMTP id o206mr8714446wma.89.1587715370343; 
 Fri, 24 Apr 2020 01:02:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypImT4jzw9pIbk2S5XLz2ol770pnZzVKuMrI4VNtTwrl6ep7qreBomqri7lvcjWMUChmlmi0Ig==
X-Received: by 2002:a1c:41d7:: with SMTP id o206mr8714420wma.89.1587715370080; 
 Fri, 24 Apr 2020 01:02:50 -0700 (PDT)
Received: from steredhat (host108-207-dynamic.49-79-r.retail.telecomitalia.it.
 [79.49.207.108])
 by smtp.gmail.com with ESMTPSA id l4sm7164935wrw.25.2020.04.24.01.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 01:02:49 -0700 (PDT)
Date: Fri, 24 Apr 2020 10:02:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] elf_ops: Don't try to g_mapped_file_unref(NULL)
Message-ID: <20200424080247.iqpjfnzrera7uvy6@steredhat>
References: <20200423202011.32686-1-peter.maydell@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200423202011.32686-1-peter.maydell@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:54:07
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
Cc: qemu-trivial@nongnu.org, Randy Yates <yates@ieee.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 23, 2020 at 09:20:11PM +0100, Peter Maydell wrote:
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
> ---
>  include/hw/elf_ops.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> index e0bb47bb678..398a4a2c85b 100644
> --- a/include/hw/elf_ops.h
> +++ b/include/hw/elf_ops.h
> @@ -606,7 +606,9 @@ static int glue(load_elf, SZ)(const char *name, int f=
d,
>          *highaddr =3D (uint64_t)(elf_sword)high;
>      ret =3D total_size;
>   fail:
> -    g_mapped_file_unref(mapped_file);
> +    if (mapped_file) {
> +        g_mapped_file_unref(mapped_file);
> +    }
>      g_free(phdr);
>      return ret;
>  }

Oooops, my fault :-(

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Maybe we can add:
Fixes: 816b9fe450 ("elf-ops.h: Map into memory the ELF to load")

Thanks,
Stefano


