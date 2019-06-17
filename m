Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F2EC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA422084A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA422084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48216 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hct4s-00089h-OS
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45085)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <arndbergmann@gmail.com>) id 1hcsdU-00087i-Qj
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arndbergmann@gmail.com>) id 1hcsdS-0004ww-VD
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:29:28 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:32888)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arndbergmann@gmail.com>)
 id 1hcsdS-0004vC-Np
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:29:26 -0400
Received: by mail-qk1-f193.google.com with SMTP id r6so6303988qkc.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+lE6PJY96jkgqBzd8cZhUb5M0BshV+I6TfB7s0gn0zU=;
 b=jt3UmoTjuxiXTQr42Bl/Btz35CL/PeDv4RPfWuHZ4slDVndjUSQfVbsGl5uMHn5GTD
 45u+kn9QUz95JViHL3KoCzXmdiPWC4TAnTLg6JluY9yAvjzycWDPwHxe+GSGI+cqj4/g
 W9zat6u9o2HnUSTN7WyjxAVBBDfQhob5HZlJyBNr1cfeTWB5ywO94xulGqkxUNZUnnrK
 UJCQZZaJQnfMffL4X8rCgwEN113OxPMQt6UqQWHAuaBupAxGfKLYtWIFIa2/2NQwySBy
 bakd9Wn9A3qRvsSJtPOMONC/vK11InTfhPTVQ1sEbkaF/heES86GvIBwtxGvHXd6Og2s
 5qwA==
X-Gm-Message-State: APjAAAV8GkVa5gkLtbaX2RETqV7FGFwjLKod3JNw1fd4r6KoYjc+QwYR
 odwZJTXYcXRJaI+psNdqEzUL8iQINj3zdDztbqU=
X-Google-Smtp-Source: APXvYqzMvFSE8waZZH9d8wQuBOdUF0upWZCJq/qvZ6OTMgOlJyvFNTtC+ASmHyePIZCFejkKFs7duxRItCIQIkXXesE=
X-Received: by 2002:ae9:e608:: with SMTP id z8mr80412952qkf.182.1560781764609; 
 Mon, 17 Jun 2019 07:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190617131103.1413-1-berrange@redhat.com>
In-Reply-To: <20190617131103.1413-1-berrange@redhat.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 17 Jun 2019 16:29:06 +0200
Message-ID: <CAK8P3a3puU=oLJFyv99gZ2tjmejWqkE96o_OtmUynHd=gBxY0Q@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.193
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: fix to handle variably
 sized SIOCGSTAMP with new kernels
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
Cc: Gerhard Stenzel <gerhard.stenzel@de.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 17, 2019 at 3:11 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> The SIOCGSTAMP symbol was previously defined in the
> asm-generic/sockios.h header file. QEMU sees that header
> indirectly via sys/socket.h
>
> In linux kernel commit 0768e17073dc527ccd18ed5f96ce85f9985e9115
> the asm-generic/sockios.h header no longer defines SIOCGSTAMP.
> Instead it provides only SIOCGSTAMP_OLD, which only uses a
> 32-bit time_t on 32-bit architectures.

This is a bit misleading, as we still define SIOCGSTAMP in the
right place. asm-generic/sockios.h should not be used by normal
user space.

> The linux/sockios.h header then defines SIOCGSTAMP using
> either SIOCGSTAMP_OLD or SIOCGSTAMP_NEW as appropriate. If
> SIOCGSTAMP_NEW is used, then the tv_sec field is 64-bit even
> on 32-bit architectures
>
> To cope with this we must now define two separate syscalls,
> with corresponding old and new sizes, as well as including
> the new linux/sockios.h header.

The overall concept seems right. A few more comments on
details that may have gone wrong here. I'm not familiar with
the qemu-user implementation, so it's mostly guesswork
on my end.

>    IOCTL(SIOCGIWNAME, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_char_ifreq))=
)
>    IOCTL(SIOCSPGRP, IOC_W, MK_PTR(TYPE_INT)) /* pid_t */
>    IOCTL(SIOCGPGRP, IOC_R, MK_PTR(TYPE_INT)) /* pid_t */
> +
> +#ifdef SIOCGSTAMP_OLD
> +  IOCTL(SIOCGSTAMP_OLD, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
> +#else
>    IOCTL(SIOCGSTAMP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
> +#endif
> +#ifdef SIOCGSTAMPNS_OLD
> +  IOCTL(SIOCGSTAMPNS_OLD, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec)))
> +#else
>    IOCTL(SIOCGSTAMPNS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec)))
> +#endif
> +#ifdef SIOCGSTAMP_NEW
> +  IOCTL(SIOCGSTAMP_NEW, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval64)))
> +#endif
> +#ifdef SIOCGSTAMPNS_NEW
> +  IOCTL(SIOCGSTAMPNS_NEW, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec64)))
> +#endif

Is timespec64 a qemu type? How is it defined?

> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 7f141f699c..7830b600e7 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -750,6 +750,11 @@ struct target_pollfd {
>
>  #define TARGET_SIOCGSTAMP      0x8906          /* Get stamp (timeval) */
>  #define TARGET_SIOCGSTAMPNS    0x8907          /* Get stamp (timespec) *=
/
> +#define TARGET_SIOCGSTAMP_OLD   0x8906          /* Get stamp (timeval) *=
/
> +#define TARGET_SIOCGSTAMPNS_OLD 0x8907          /* Get stamp (timespec) =
*/

Note that these types are architecture specific. It seems that only
one architecture is left that has its own definitions though, so this
is only broken on arch/sh for current linux (and remains broken).

Future architectures, including 32-bit risc-v should only have the _NEW
version and not support SIOCGSTAMP_OLD at all.

When emulating risc-v user space on old kernels (pre-5.1), you may need to
translate the ioctl command and all system calls that take a 64-bit time_t =
into
the variants with a 32-bit time_t on the way into the kernel, and then back=
.

Similarly, running an old user binary on a riscv32 machine, you may
need to do the reverse translation.

> +#define TARGET_SIOCGSTAMP_NEW   TARGET_IOC(TARGET_IOC_READ, 's', 6, size=
of(long long) + sizeof(long)) /* Get stamp (timeval64) */
> +#define TARGET_SIOCGSTAMPNS_NEW TARGET_IOC(TARGET_IOC_READ, 's', 7, size=
of(long long) + sizeof(long)) /* Get stamp (timespec64) */

"sizeof(long long) + sizeof(long)" is not always the size of the argument t=
o
TARGET_SIOCGSTAMP{NS}_NEW. On 32-bit architectures, the size is
two 64-bit values. sparc64 is potentially another special case, as 'struct
timeval is 'long + int' there (12 bytes).

On big-endian architectures, the nanoseconds are returned in the last
four bytes of the 16-byte structure.

>  /* Networking ioctls */
>  #define TARGET_SIOCADDRT       0x890B          /* add routing table entr=
y */
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index b98a23b0f1..de4c5a5b6f 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -20,6 +20,10 @@ STRUCT(timeval,
>  STRUCT(timespec,
>         MK_ARRAY(TYPE_LONG, 2))
>
> +STRUCT(timeval64, TYPE_LONGLONG, TYPE_LONG)
> +
> +STRUCT(timespec64, TYPE_LONGLONG, TYPE_LONG)

Same here.

        Arnd

