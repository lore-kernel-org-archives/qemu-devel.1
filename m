Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD74C28D1E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87C612070B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGDFPvs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C612070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58713 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYqXa-0007hu-RS
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 07:26:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hYqW0-0006dM-5J
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hYqVx-0002Cx-CA
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:25:04 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hYqVx-0002Bm-25; Thu, 06 Jun 2019 07:25:01 -0400
Received: by mail-ot1-x342.google.com with SMTP id p4so1620293oti.0;
	Thu, 06 Jun 2019 04:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=TuKbpy20S50FOjzjtwzcjwAWM/ZcxnNh7Vn6W9kFWTI=;
	b=hGDFPvs43bVUyoinkqH+263d5/fhyAedwwuoiOlF11rO+GlNzomkxf7XuCjG+zxSQO
	0rfr6FMwlhvREr+4a9Gq/IAp3H5X2oEIK+HuqaST0CHMxtx66X5sm/g1AKN7dlbOQtzy
	0Tpz743ta7XdrymwhTS/0ZQ0TxkTqtahN+ufJsM9yfEJUKc2WjSB88biZ27uCRLNRICJ
	t+GBz4jschOfm9jQwhQRrfethx2KY8ADUFUpPA59JZIcFlJOPW664KoeeSY9KHVBeOBR
	lGJaNY+8g6e88MFBCtmssPwnd+Y+1CBTSufbZjywYo8DFjZSMRS4FJ0b8zun8M2E/5PH
	Qgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=TuKbpy20S50FOjzjtwzcjwAWM/ZcxnNh7Vn6W9kFWTI=;
	b=nuM9p+EKll3JcRk8ZfriibCJlYzwrJRX6kCiU8XkTHhZAPsfrFD3uFTan5wgNpmxjH
	4DWVyvX3Ceq2qPVuhQQtTYkECiHJXHFM2GKhbp+sG4N3QQWg4Az0yqk4q9Bz5NfxcBos
	Wz+Rkz/tJhcEAOgLmEua7uGKEhK4ikZetifVywZtt0+8VNaWuCosjIIIon8nT2gq1pKH
	dQe7+0yowyhqdtUlS2Kyr6HJHnY9n3gIX+Mye1hAYh0/ou21pcIui7sFNUKeaatXSSQF
	NuJtTblS5qxhJ3RIBlZMgkcGZ8miZ+rEJZlSQjsdC/dTg6R/Rd+uGWeLAABGfrhw9JMB
	uy7Q==
X-Gm-Message-State: APjAAAWkViQtw4koS8g0EswLETp3wmKbDerZiTdk67kDCtffaNSQAvNx
	g86Qs/8/2RKMMMMmnwzWqDIEC0g9y5NPdoXTIis=
X-Google-Smtp-Source: APXvYqzuAdjkfK4lbxBHfxOW3QRt98qPviLTAyZAF8moEZxJCg1CTao0We2Jfk1HcwRq/3bgWrbKAOlzkpHqm9Qb9fQ=
X-Received: by 2002:a9d:2aa:: with SMTP id 39mr13872417otl.121.1559820300038; 
	Thu, 06 Jun 2019 04:25:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP;
	Thu, 6 Jun 2019 04:24:59 -0700 (PDT)
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP;
	Thu, 6 Jun 2019 04:24:59 -0700 (PDT)
In-Reply-To: <20190605205706.569-3-richard.henderson@linaro.org>
References: <20190605205706.569-1-richard.henderson@linaro.org>
	<20190605205706.569-3-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 6 Jun 2019 13:24:59 +0200
Message-ID: <CAL1e-=he9+=jC4XMD2jc2uhnWCkSxkncwat7UB=MSQMRjTsBhw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v6 2/6] linux-user: Validate mmap/mprotect
 prot value
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
	Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 5, 2019 11:13 PM, "Richard Henderson" <richard.henderson@linaro.org>
wrote:
>
> The kernel will return -EINVAL for bits set in the prot argument
> that are unknown or invalid.  Previously we were simply cropping
> out the bits that we care about.
>
> Introduce validate_prot_to_pageflags to perform this check in a
> single place between the two syscalls.  Differentiate between
> the target and host versions of prot.  Compute the qemu internal
> page_flags value at the same time.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/mmap.c | 106 ++++++++++++++++++++++++++++++++--------------
>  1 file changed, 75 insertions(+), 31 deletions(-)
>
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index af41339d57..3117f57fd8 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -61,11 +61,38 @@ void mmap_fork_end(int child)
>          pthread_mutex_unlock(&mmap_mutex);
>  }
>
> +/*
> + * Validate target prot bitmask.
> + * Return the prot bitmask for the host in *HOST_PROT.
> + * Return 0 if the target prot bitmask is invalid, otherwise
> + * the internal qemu page_flags (which will include PAGE_VALID).
> + */
> +static int validate_prot_to_pageflags(int *host_prot, int prot)
> +{
> +    int valid =3D PROT_READ | PROT_WRITE | PROT_EXEC | TARGET_PROT_SEM;
> +    int page_flags =3D (prot & PAGE_BITS) | PAGE_VALID;
> +
> +    /*
> +     * For the host, we need not pass anything except read/write/exec.
> +     * While PROT_SEM is allowed by all hosts, it is also ignored, so
> +     * don't bother transforming guest bit to host bit.

I don't think that making assumptions based on an undocumented behavior is
the best practice.

Your =E2=80=9CLet's don't bother=E2=80=9D about such easy to implement thin=
gs may create a
lot of bothering in future.

Regards,
Aleksandar

>  Any other
> +     * target-specific prot bits will not be understood by the host
> +     * and will need to be encoded into page_flags for qemu emulation.
> +     *
> +     * TODO: We do not actually have to map guest pages as executable,
> +     * since they will not be directly executed by the host.  We only
> +     * need to remember exec within page_flags.
> +     */
> +    *host_prot =3D prot & (PROT_READ | PROT_WRITE | PROT_EXEC);
> +
> +    return prot & ~valid ? 0 : page_flags;
> +}
> +
>  /* NOTE: all the constants are the HOST ones, but addresses are target.
*/
> -int target_mprotect(abi_ulong start, abi_ulong len, int prot)
> +int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
>  {
>      abi_ulong end, host_start, host_end, addr;
> -    int prot1, ret;
> +    int prot1, ret, page_flags, host_prot;
>
>  #ifdef DEBUG_MMAP
>      printf("mprotect: start=3D0x" TARGET_ABI_FMT_lx
> @@ -75,56 +102,65 @@ int target_mprotect(abi_ulong start, abi_ulong len,
int prot)
>             prot & PROT_EXEC ? 'x' : '-');
>  #endif
>
> -    if ((start & ~TARGET_PAGE_MASK) !=3D 0)
> +    if ((start & ~TARGET_PAGE_MASK) !=3D 0) {
>          return -TARGET_EINVAL;
> +    }
> +    page_flags =3D validate_prot_to_pageflags(&host_prot, target_prot);
> +    if (!page_flags) {
> +        return -TARGET_EINVAL;
> +    }
>      len =3D TARGET_PAGE_ALIGN(len);
>      end =3D start + len;
>      if (!guest_range_valid(start, len)) {
>          return -TARGET_ENOMEM;
>      }
> -    prot &=3D PROT_READ | PROT_WRITE | PROT_EXEC;
> -    if (len =3D=3D 0)
> +    if (len =3D=3D 0) {
>          return 0;
> +    }
>
>      mmap_lock();
>      host_start =3D start & qemu_host_page_mask;
>      host_end =3D HOST_PAGE_ALIGN(end);
>      if (start > host_start) {
>          /* handle host page containing start */
> -        prot1 =3D prot;
> -        for(addr =3D host_start; addr < start; addr +=3D TARGET_PAGE_SIZ=
E) {
> +        prot1 =3D host_prot;
> +        for (addr =3D host_start; addr < start; addr +=3D TARGET_PAGE_SI=
ZE) {
>              prot1 |=3D page_get_flags(addr);
>          }
>          if (host_end =3D=3D host_start + qemu_host_page_size) {
> -            for(addr =3D end; addr < host_end; addr +=3D TARGET_PAGE_SIZ=
E) {
> +            for (addr =3D end; addr < host_end; addr +=3D TARGET_PAGE_SI=
ZE) {
>                  prot1 |=3D page_get_flags(addr);
>              }
>              end =3D host_end;
>          }
> -        ret =3D mprotect(g2h(host_start), qemu_host_page_size, prot1 &
PAGE_BITS);
> -        if (ret !=3D 0)
> +        ret =3D mprotect(g2h(host_start), qemu_host_page_size,
> +                       prot1 & PAGE_BITS);
> +        if (ret !=3D 0) {
>              goto error;
> +        }
>          host_start +=3D qemu_host_page_size;
>      }
>      if (end < host_end) {
> -        prot1 =3D prot;
> -        for(addr =3D end; addr < host_end; addr +=3D TARGET_PAGE_SIZE) {
> +        prot1 =3D host_prot;
> +        for (addr =3D end; addr < host_end; addr +=3D TARGET_PAGE_SIZE) =
{
>              prot1 |=3D page_get_flags(addr);
>          }
> -        ret =3D mprotect(g2h(host_end - qemu_host_page_size),
qemu_host_page_size,
> -                       prot1 & PAGE_BITS);
> -        if (ret !=3D 0)
> +        ret =3D mprotect(g2h(host_end - qemu_host_page_size),
> +                       qemu_host_page_size, prot1 & PAGE_BITS);
> +        if (ret !=3D 0) {
>              goto error;
> +        }
>          host_end -=3D qemu_host_page_size;
>      }
>
>      /* handle the pages in the middle */
>      if (host_start < host_end) {
> -        ret =3D mprotect(g2h(host_start), host_end - host_start, prot);
> -        if (ret !=3D 0)
> +        ret =3D mprotect(g2h(host_start), host_end - host_start,
host_prot);
> +        if (ret !=3D 0) {
>              goto error;
> +        }
>      }
> -    page_set_flags(start, start + len, prot | PAGE_VALID);
> +    page_set_flags(start, start + len, page_flags);
>      mmap_unlock();
>      return 0;
>  error:
> @@ -364,10 +400,11 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong
size, abi_ulong align)
>  }
>
>  /* NOTE: all the constants are the HOST ones */
> -abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
> +abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>                       int flags, int fd, abi_ulong offset)
>  {
>      abi_ulong ret, end, real_start, real_end, retaddr, host_offset,
host_len;
> +    int page_flags, host_prot;
>
>      mmap_lock();
>  #ifdef DEBUG_MMAP
> @@ -402,6 +439,12 @@ abi_long target_mmap(abi_ulong start, abi_ulong len,
int prot,
>          goto fail;
>      }
>
> +    page_flags =3D validate_prot_to_pageflags(&host_prot, target_prot);
> +    if (!page_flags) {
> +        errno =3D EINVAL;
> +        goto fail;
> +    }
> +
>      /* Also check for overflows... */
>      len =3D TARGET_PAGE_ALIGN(len);
>      if (!len) {
> @@ -467,14 +510,15 @@ abi_long target_mmap(abi_ulong start, abi_ulong
len, int prot,
>          /* Note: we prefer to control the mapping address. It is
>             especially important if qemu_host_page_size >
>             qemu_real_host_page_size */
> -        p =3D mmap(g2h(start), host_len, prot,
> +        p =3D mmap(g2h(start), host_len, host_prot,
>                   flags | MAP_FIXED | MAP_ANONYMOUS, -1, 0);
> -        if (p =3D=3D MAP_FAILED)
> +        if (p =3D=3D MAP_FAILED) {
>              goto fail;
> +        }
>          /* update start so that it points to the file position at
'offset' */
>          host_start =3D (unsigned long)p;
>          if (!(flags & MAP_ANONYMOUS)) {
> -            p =3D mmap(g2h(start), len, prot,
> +            p =3D mmap(g2h(start), len, host_prot,
>                       flags | MAP_FIXED, fd, host_offset);
>              if (p =3D=3D MAP_FAILED) {
>                  munmap(g2h(start), host_len);
> @@ -508,19 +552,19 @@ abi_long target_mmap(abi_ulong start, abi_ulong
len, int prot,
>              /* msync() won't work here, so we return an error if write i=
s
>                 possible while it is a shared mapping */
>              if ((flags & MAP_TYPE) =3D=3D MAP_SHARED &&
> -                (prot & PROT_WRITE)) {
> +                (host_prot & PROT_WRITE)) {
>                  errno =3D EINVAL;
>                  goto fail;
>              }
> -            retaddr =3D target_mmap(start, len, prot | PROT_WRITE,
> +            retaddr =3D target_mmap(start, len, target_prot | PROT_WRITE=
,
>                                    MAP_FIXED | MAP_PRIVATE |
MAP_ANONYMOUS,
>                                    -1, 0);
>              if (retaddr =3D=3D -1)
>                  goto fail;
>              if (pread(fd, g2h(start), len, offset) =3D=3D -1)
>                  goto fail;
> -            if (!(prot & PROT_WRITE)) {
> -                ret =3D target_mprotect(start, len, prot);
> +            if (!(host_prot & PROT_WRITE)) {
> +                ret =3D target_mprotect(start, len, target_prot);
>                  assert(ret =3D=3D 0);
>              }
>              goto the_end;
> @@ -531,13 +575,13 @@ abi_long target_mmap(abi_ulong start, abi_ulong
len, int prot,
>              if (real_end =3D=3D real_start + qemu_host_page_size) {
>                  /* one single host page */
>                  ret =3D mmap_frag(real_start, start, end,
> -                                prot, flags, fd, offset);
> +                                host_prot, flags, fd, offset);
>                  if (ret =3D=3D -1)
>                      goto fail;
>                  goto the_end1;
>              }
>              ret =3D mmap_frag(real_start, start, real_start +
qemu_host_page_size,
> -                            prot, flags, fd, offset);
> +                            host_prot, flags, fd, offset);
>              if (ret =3D=3D -1)
>                  goto fail;
>              real_start +=3D qemu_host_page_size;
> @@ -546,7 +590,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len,
int prot,
>          if (end < real_end) {
>              ret =3D mmap_frag(real_end - qemu_host_page_size,
>                              real_end - qemu_host_page_size, end,
> -                            prot, flags, fd,
> +                            host_prot, flags, fd,
>                              offset + real_end - qemu_host_page_size -
start);
>              if (ret =3D=3D -1)
>                  goto fail;
> @@ -562,13 +606,13 @@ abi_long target_mmap(abi_ulong start, abi_ulong
len, int prot,
>              else
>                  offset1 =3D offset + real_start - start;
>              p =3D mmap(g2h(real_start), real_end - real_start,
> -                     prot, flags, fd, offset1);
> +                     host_prot, flags, fd, offset1);
>              if (p =3D=3D MAP_FAILED)
>                  goto fail;
>          }
>      }
>   the_end1:
> -    page_set_flags(start, start + len, prot | PAGE_VALID);
> +    page_set_flags(start, start + len, page_flags);
>   the_end:
>  #ifdef DEBUG_MMAP
>      printf("ret=3D0x" TARGET_ABI_FMT_lx "\n", start);
> --
> 2.17.1
>
>
