Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FBBC33CB2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D5724680
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D5724680
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irNQ1-0002Tp-P5
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 09:43:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1irNOh-0001Ms-Rs
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:42:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1irNOe-0003BO-6a
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:42:23 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:56623)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1irNOd-00039u-UN
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:42:20 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MYvoW-1jDK711ruK-00Unts; Tue, 14 Jan 2020 15:42:03 +0100
Subject: Re: [PATCH v5 17/20] linux-user: Add support for FDGETFDCSTAT ioctl
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1578947683-21011-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1578947683-21011-18-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6752dfe8-00b7-838a-0b1b-39f4a3970951@vivier.eu>
Date: Tue, 14 Jan 2020 15:42:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1578947683-21011-18-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:heLaHCjlddbaIS6rOyNqMffiMGgD7pJmICW/M9Dt8yCmHE4oT3V
 ZM++UFUC5i+TuZz5gONxAhAPmGXNLvIHPVjqc6UIldymLYl7jMwOo4LXmSSAEN5/3nFTEJO
 dL4VXX2ciZOVOVlW8DnP+GpWnr03ywsXTTgE5gbhywi3PK0hbQSclPh3pUnk89CS8NVr6C2
 TEV1oWvXBcxiRjGT5Gm5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PlOR1ZMCD+w=:NdoAq87qWa+YrnudWUDY6/
 +WfzTygoA08llUwHOKsgMXwKiZl5JuLQNw1TbU0QTJQJ39nkW8KoZ6O49U9OBgZc05nrnxOwy
 7s7TE3OCXFFH5IOfi0oQPu5ud9zMiaNqeJBaf6kTR/8Ie8rvMsDSEiaSJmQUbEqGM7fMTikmq
 zJMI7bl9CaWhW7ykZqUzw7mo5wgIBIah1GGbEtY7RpZcbvPDmfucYsEpUko9W+PfstE7fb+bk
 TMJGGVdkPNPjxhrUqeo9YXS2iOcmIjTqhHf4POS5b50sJq7K2ZcwmgXXZIp64elnJzyx4GeIS
 RhD00+fIGXik1pfPktD0Yb+0YxL0lY4janwCA7fPTFgGTQZwssFQJawiCLwEVtGZ0iuAfHM9T
 Md0rxTTHtRsJv+z4rP8UF12FXbxXWFA5g3/TqrIMwA4mw/7Xdikg1U9XCbnaGkdL+xoL0dn53
 oKpTx8rZ5lWy47Fck0ow9UuUA/vPfZ1p5korhVahKo9jlVRV98sJfQVpRpW+TnDLHNdKAihCt
 GdJBraQQGQ6P+SQfXJLZFD8bW93lnNNWoQNKzcBNtiKhmXnEy5TIGovb7pL5aeohuLmh3ktMk
 dafY0reEC5JH71KLGciokdp8e7ibqoo8Kk/br3T3b+j4SVc4J4cLJn/x98IUmlaQ72YM/Dv/Q
 YWPjw1Vl5iDzeBrCuRY1M8W211MSuVHUwNQylzNuUF9KJ3nT/CJujeKWz3Ekbc2CvL00DxbSu
 9iLUr8tYqjsBZLsoumdnH7fcGqXxINwmYdNQf7ZeL7DguXs7B471js2iWv2OalN9cKaGRUpI+
 1HOg1eGIKykDPnrLelGLnbOt7GM0pJWFCvN8y7LXu4yRY9K6UtDe8RHvvNkO02prV0ta+SYDv
 aONXlrcZVqhxPmngzTpXD0kbW+m4AcoQ/gqldq1PI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.134
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
Cc: amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 13/01/2020 à 21:34, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> FDGETFDCSTAT's third agrument is a pointer to the structure:
> 
> struct floppy_fdc_state {
>     int spec1;
>     int spec2;
>     int dtr;
>     unsigned char version;
>     unsigned char dor;
>     unsigned long address;
>     unsigned int rawcmd:2;
>     unsigned int reset:1;
>     unsigned int need_configure:1;
>     unsigned int perp_mode:2;
>     unsigned int has_fifo:1;
>     unsigned int driver_version;
>     unsigned char track[4];
> };
> 
> defined in Linux kernel header <linux/fd.h>.
> 
> Since there is a fields of the structure of type 'unsigned long', there is
> a need to define "target_format_descr". Also, five fields rawcmd, reset,
> need_configure, perp_mode, and has_fifo are all just bitfields and are
> part od a single 'unsigned int' field.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/ioctls.h        |  2 ++
>  linux-user/syscall_defs.h  | 18 ++++++++++++++++++
>  linux-user/syscall_types.h | 12 ++++++++++++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index e754a6b..d72cd76 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -122,6 +122,8 @@
>       IOCTL(FDSETMAXERRS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_floppy_max_errors)))
>       IOCTL(FDGETMAXERRS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_floppy_max_errors)))
>       IOCTL(FDRESET, 0, TYPE_NULL)
> +     IOCTL(FDGETFDCSTAT, IOC_R,
> +           MK_PTR(MK_STRUCT(STRUCT_target_floppy_fdc_state)))
>       IOCTL(FDRAWCMD, 0, TYPE_NULL)
>       IOCTL(FDTWADDLE, 0, TYPE_NULL)
>       IOCTL(FDEJECT, 0, TYPE_NULL)
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index d85ab46..225dcfb 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -897,6 +897,23 @@ struct target_pollfd {
>  
>  /* From <linux/fd.h> */
>  
> +struct target_floppy_fdc_state {
> +    int spec1;      /* spec1 value last used */
> +    int spec2;      /* spec2 value last used */
> +    int dtr;
> +    unsigned char version;  /* FDC version code */
> +    unsigned char dor;
> +    abi_long address;  /* io address */

s/abi_long/abi_ulong/

Thanks,
Laurent

