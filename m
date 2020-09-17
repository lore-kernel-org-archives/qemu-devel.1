Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99744C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F7A2072E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IuwdPPHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F7A2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIoNu-0003qI-Va
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 03:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1kIoMJ-0002hM-5b
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:29:35 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:39343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1kIoME-0002PW-TB
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:29:34 -0400
Received: by mail-ed1-x543.google.com with SMTP id e22so1414148edq.6
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 00:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ysc/7nFHdIwmMK3+P5SqSWtAKAbpDqF9oz7k5kekciQ=;
 b=IuwdPPHtesDvkrz5B0ZGkfmMN23ppAw0mPrKr7okNTO8jkaiDdPi8Sc8qKjC3v8NAl
 v/h6cHJhVJwiasCb3iYUiSKJBk95wlaTbYxf0G7FMo7uHrnRRJijjY0doaPg/nqmo3nv
 m/TeERhSF9983TJH+dQ7iTtcVmEvgMlguNlis5FNG/jAKkSUTyr+Cz7mQ0gGaZupTJuc
 vuIZ9NgLqc1UI1QWq2n/IljWxJtqKWmXVnsVgpymxYomPDXUVVaM7rUTxacbismjPq8r
 qSh7HknirVk7gWNEgYhLkKsVPb/Jr36Q8VK5stiEB1hN5H+XEIDt0N1Go7ZfzGBRbxi4
 2pKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ysc/7nFHdIwmMK3+P5SqSWtAKAbpDqF9oz7k5kekciQ=;
 b=s18FEfODl/9sDWdi92h11uKIoLtmirr0mqFHelfM2oNczBF1/NgfFI+aB6EfRenrro
 +4C3g45o2n8QCwtRzEEDq0gao53KKVbBMN45c/Bev7irdq4YvwAgLwUj2Dos6oWhydko
 NewoxDnuCp+9hYgPoe6vq60P/J3heYYwfhUlKsLoeUYz9r7bHHN99hWDbQf88CJJm8wP
 xosWFWHYHh8sxpUmcwwU8CLv/heL1GbuDY10Bh+RWA30usUOgRJDNlYPnbc4vS1+fgE3
 6JuWohMxLDkYid1omlGcR9ozIohigDgTL0jkge6L9TYlDe0gIJ0hqfLwIY4StbrV13YM
 2UPw==
X-Gm-Message-State: AOAM530XE3b+bxg2//ZVV1k9iro9dz3fJL74pRNIiV4YZjOCmHvDoG09
 cQtwuxM4AuLdXEqx5cJWJ0hQMs63RsjMxNcG627IhCnp99BtNQ==
X-Google-Smtp-Source: ABdhPJwLM6K86ekwVlhe1ArNeYGXvNaLAGEc/tT3LYM4h7zd/hY/IrMAyLbwAyY+EN0bVBB2Wk2MuTno3i/X3TkKmLg=
X-Received: by 2002:a05:6402:b1a:: with SMTP id
 bm26mr31686605edb.209.1600327768800; 
 Thu, 17 Sep 2020 00:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597129029.git.scw@google.com>
 <611db81c87911cb38a35e5f761e11b76e1f0d538.1597129029.git.scw@google.com>
In-Reply-To: <611db81c87911cb38a35e5f761e11b76e1f0d538.1597129029.git.scw@google.com>
From: Shu-Chun Weng <scw@google.com>
Date: Thu, 17 Sep 2020 00:29:17 -0700
Message-ID: <CAF3nBxhvL9Us8BgxD2Dhk2ULmrNSxv7mUQCOV5GBrqTXKt8ARw@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] linux-user: Update SO_TIMESTAMP to
 SO_TIMESTAMP_OLD/NEW
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000371f0805af7d58cf"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=scw@google.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000371f0805af7d58cf
Content-Type: multipart/alternative; boundary="0000000000002f6bc305af7d58f4"

--0000000000002f6bc305af7d58f4
Content-Type: text/plain; charset="UTF-8"

Ping -- any comments on the four patches start with this?
https://patchew.org/QEMU/cover.1597129029.git.scw@google.com/

On Tue, Aug 11, 2020 at 12:10 AM Shu-Chun Weng <scw@google.com> wrote:

> Both guest options map to host SO_TIMESTAMP while keeping a global bit to
> remember if the guest expects the old or the new format. Don't support
> programs mixing two formats.
>
> Added a multiarch test to verify.
>
> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
> v1 -> v2:
>   Only keep track of old or new format globally, remove support for
> different
>   sockets mixing different formats.
>   Fix style problems.
>
>  linux-user/alpha/sockbits.h            |   8 +-
>  linux-user/generic/sockbits.h          |   9 +-
>  linux-user/hppa/sockbits.h             |   8 +-
>  linux-user/mips/sockbits.h             |   8 +-
>  linux-user/sparc/sockbits.h            |   8 +-
>  linux-user/strace.c                    |   7 +-
>  linux-user/syscall.c                   |  91 ++++++--
>  tests/tcg/multiarch/socket_timestamp.c | 296 +++++++++++++++++++++++++
>  8 files changed, 408 insertions(+), 27 deletions(-)
>  create mode 100644 tests/tcg/multiarch/socket_timestamp.c
>
> diff --git a/linux-user/alpha/sockbits.h b/linux-user/alpha/sockbits.h
> index d54dc98c09..40f0644df0 100644
> --- a/linux-user/alpha/sockbits.h
> +++ b/linux-user/alpha/sockbits.h
> @@ -48,8 +48,6 @@
>  #define TARGET_SO_DETACH_FILTER        27
>
>  #define TARGET_SO_PEERNAME      28
> -#define TARGET_SO_TIMESTAMP     29
> -#define TARGET_SCM_TIMESTAMP        TARGET_SO_TIMESTAMP
>
>  #define TARGET_SO_PEERSEC       30
>  #define TARGET_SO_PASSSEC       34
> @@ -75,6 +73,12 @@
>  /* Instruct lower device to use last 4-bytes of skb data as FCS */
>  #define TARGET_SO_NOFCS     43
>
> +#define TARGET_SO_TIMESTAMP_OLD        29
> +#define TARGET_SCM_TIMESTAMP_OLD       TARGET_SO_TIMESTAMP_OLD
> +
> +#define TARGET_SO_TIMESTAMP_NEW        63
> +#define TARGET_SCM_TIMESTAMP_NEW       TARGET_SO_TIMESTAMP_NEW
> +
>  /* TARGET_O_NONBLOCK clashes with the bits used for socket types.
> Therefore we
>   * have to define SOCK_NONBLOCK to a different value here.
>   */
> diff --git a/linux-user/generic/sockbits.h b/linux-user/generic/sockbits.h
> index e44733c601..532cf2d3dc 100644
> --- a/linux-user/generic/sockbits.h
> +++ b/linux-user/generic/sockbits.h
> @@ -49,10 +49,15 @@
>  #define TARGET_SO_DETACH_FILTER        27
>
>  #define TARGET_SO_PEERNAME             28
> -#define TARGET_SO_TIMESTAMP            29
> -#define TARGET_SCM_TIMESTAMP           TARGET_SO_TIMESTAMP
>
>  #define TARGET_SO_ACCEPTCONN           30
>
>  #define TARGET_SO_PEERSEC              31
> +
> +#define TARGET_SO_TIMESTAMP_OLD        29
> +#define TARGET_SCM_TIMESTAMP_OLD       TARGET_SO_TIMESTAMP_OLD
> +
> +#define TARGET_SO_TIMESTAMP_NEW        63
> +#define TARGET_SCM_TIMESTAMP_NEW       TARGET_SO_TIMESTAMP_NEW
> +
>  #endif
> diff --git a/linux-user/hppa/sockbits.h b/linux-user/hppa/sockbits.h
> index 23f69a3293..284a47e74e 100644
> --- a/linux-user/hppa/sockbits.h
> +++ b/linux-user/hppa/sockbits.h
> @@ -29,8 +29,6 @@
>  #define TARGET_SO_BSDCOMPAT    0x400e
>  #define TARGET_SO_PASSCRED     0x4010
>  #define TARGET_SO_PEERCRED     0x4011
> -#define TARGET_SO_TIMESTAMP    0x4012
> -#define TARGET_SCM_TIMESTAMP   TARGET_SO_TIMESTAMP
>  #define TARGET_SO_TIMESTAMPNS  0x4013
>  #define TARGET_SCM_TIMESTAMPNS TARGET_SO_TIMESTAMPNS
>
> @@ -67,6 +65,12 @@
>
>  #define TARGET_SO_CNX_ADVICE           0x402E
>
> +#define TARGET_SO_TIMESTAMP_OLD        0x4012
> +#define TARGET_SCM_TIMESTAMP_OLD       TARGET_SO_TIMESTAMP_OLD
> +
> +#define TARGET_SO_TIMESTAMP_NEW        0x4038
> +#define TARGET_SCM_TIMESTAMP_NEW       TARGET_SO_TIMESTAMP_NEW
> +
>  /* TARGET_O_NONBLOCK clashes with the bits used for socket types.
> Therefore we
>   * have to define SOCK_NONBLOCK to a different value here.
>   */
> diff --git a/linux-user/mips/sockbits.h b/linux-user/mips/sockbits.h
> index 0f022cd598..b4c39d9588 100644
> --- a/linux-user/mips/sockbits.h
> +++ b/linux-user/mips/sockbits.h
> @@ -61,14 +61,18 @@
>  #define TARGET_SO_DETACH_FILTER        27
>
>  #define TARGET_SO_PEERNAME             28
> -#define TARGET_SO_TIMESTAMP            29
> -#define SCM_TIMESTAMP          SO_TIMESTAMP
>
>  #define TARGET_SO_PEERSEC              30
>  #define TARGET_SO_SNDBUFFORCE          31
>  #define TARGET_SO_RCVBUFFORCE          33
>  #define TARGET_SO_PASSSEC              34
>
> +#define TARGET_SO_TIMESTAMP_OLD        29
> +#define TARGET_SCM_TIMESTAMP_OLD       TARGET_SO_TIMESTAMP_OLD
> +
> +#define TARGET_SO_TIMESTAMP_NEW        63
> +#define TARGET_SCM_TIMESTAMP_NEW       TARGET_SO_TIMESTAMP_NEW
> +
>  /** sock_type - Socket types
>   *
>   * Please notice that for binary compat reasons MIPS has to
> diff --git a/linux-user/sparc/sockbits.h b/linux-user/sparc/sockbits.h
> index 0a822e3e1f..07440efd14 100644
> --- a/linux-user/sparc/sockbits.h
> +++ b/linux-user/sparc/sockbits.h
> @@ -48,8 +48,6 @@
>  #define TARGET_SO_GET_FILTER           TARGET_SO_ATTACH_FILTER
>
>  #define TARGET_SO_PEERNAME             0x001c
> -#define TARGET_SO_TIMESTAMP            0x001d
> -#define TARGET_SCM_TIMESTAMP           TARGET_SO_TIMESTAMP
>
>  #define TARGET_SO_PEERSEC              0x001e
>  #define TARGET_SO_PASSSEC              0x001f
> @@ -104,6 +102,12 @@
>
>  #define TARGET_SO_ZEROCOPY             0x003e
>
> +#define TARGET_SO_TIMESTAMP_OLD        0x001d
> +#define TARGET_SCM_TIMESTAMP_OLD       TARGET_SO_TIMESTAMP_OLD
> +
> +#define TARGET_SO_TIMESTAMP_NEW        0x0046
> +#define TARGET_SCM_TIMESTAMP_NEW       TARGET_SO_TIMESTAMP_NEW
> +
>  /* Security levels - as per NRL IPv6 - don't actually do anything */
>  #define TARGET_SO_SECURITY_AUTHENTICATION              0x5001
>  #define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT        0x5002
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 089fb3968e..a11a5e9e86 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -2257,8 +2257,11 @@ print_optint:
>          case TARGET_SO_PASSCRED:
>              qemu_log("SO_PASSCRED,");
>              goto print_optint;
> -        case TARGET_SO_TIMESTAMP:
> -            qemu_log("SO_TIMESTAMP,");
> +        case TARGET_SO_TIMESTAMP_OLD:
> +            qemu_log("SO_TIMESTAMP_OLD,");
> +            goto print_optint;
> +        case TARGET_SO_TIMESTAMP_NEW:
> +            qemu_log("SO_TIMESTAMP_NEW,");
>              goto print_optint;
>          case TARGET_SO_RCVLOWAT:
>              qemu_log("SO_RCVLOWAT,");
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index cda194a7cc..e6b1a18cc0 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1697,6 +1697,18 @@ static inline abi_long target_to_host_cmsg(struct
> msghdr *msgh,
>      return 0;
>  }
>
> +/*
> + * Linux kernel actually keeps track of whether the old version
> (potentially
> + * 32-bit time_t) or the new version is used for each socket. Instead of
> + * replicate it will all the complexity, we only keep track of one global
> state,
> + * which is enough for guest programs that don't intentionally mix the two
> + * versions.
> + */
> +static enum TargetTimestampVersion {
> +    TARGET_TIMESTAMP_OLD,
> +    TARGET_TIMESTAMP_NEW,
> +} target_expected_timestamp_version = TARGET_TIMESTAMP_OLD;
> +
>  static inline abi_long host_to_target_cmsg(struct target_msghdr
> *target_msgh,
>                                             struct msghdr *msgh)
>  {
> @@ -1747,8 +1759,17 @@ static inline abi_long host_to_target_cmsg(struct
> target_msghdr *target_msgh,
>          switch (cmsg->cmsg_level) {
>          case SOL_SOCKET:
>              switch (cmsg->cmsg_type) {
> -            case SO_TIMESTAMP:
> -                tgt_len = sizeof(struct target_timeval);
> +            case SCM_TIMESTAMP:
> +                switch (target_expected_timestamp_version) {
> +                case TARGET_TIMESTAMP_OLD:
> +                    tgt_len = sizeof(struct target_timeval);
> +                    target_cmsg->cmsg_type =
> tswap32(TARGET_SCM_TIMESTAMP_OLD);
> +                    break;
> +                case TARGET_TIMESTAMP_NEW:
> +                    tgt_len = sizeof(struct target__kernel_sock_timeval);
> +                    target_cmsg->cmsg_type =
> tswap32(TARGET_SCM_TIMESTAMP_NEW);
> +                    break;
> +                }
>                  break;
>              default:
>                  break;
> @@ -1782,20 +1803,39 @@ static inline abi_long host_to_target_cmsg(struct
> target_msghdr *target_msgh,
>                  }
>                  break;
>              }
> -            case SO_TIMESTAMP:
> +            case SCM_TIMESTAMP:
>              {
>                  struct timeval *tv = (struct timeval *)data;
> -                struct target_timeval *target_tv =
> -                    (struct target_timeval *)target_data;
> -
> -                if (len != sizeof(struct timeval) ||
> -                    tgt_len != sizeof(struct target_timeval)) {
> +                if (len != sizeof(struct timeval)) {
>                      goto unimplemented;
>                  }
>
> -                /* copy struct timeval to target */
> -                __put_user(tv->tv_sec, &target_tv->tv_sec);
> -                __put_user(tv->tv_usec, &target_tv->tv_usec);
> +                switch (target_expected_timestamp_version) {
> +                case TARGET_TIMESTAMP_OLD:
> +                {
> +                    struct target_timeval *target_tv =
> +                        (struct target_timeval *)target_data;
> +                    if (tgt_len != sizeof(struct target_timeval)) {
> +                        goto unimplemented;
> +                    }
> +
> +                    __put_user(tv->tv_sec, &target_tv->tv_sec);
> +                    __put_user(tv->tv_usec, &target_tv->tv_usec);
> +                    break;
> +                }
> +                case TARGET_TIMESTAMP_NEW:
> +                {
> +                    struct target__kernel_sock_timeval *target_tv =
> +                        (struct target__kernel_sock_timeval *)target_data;
> +                    if (tgt_len != sizeof(struct
> target__kernel_sock_timeval)) {
> +                        goto unimplemented;
> +                    }
> +
> +                    __put_user(tv->tv_sec, &target_tv->tv_sec);
> +                    __put_user(tv->tv_usec, &target_tv->tv_usec);
> +                    break;
> +                }
> +                }
>                  break;
>              }
>              case SCM_CREDENTIALS:
> @@ -1937,6 +1977,8 @@ static abi_long do_setsockopt(int sockfd, int level,
> int optname,
>      int val;
>      struct ip_mreqn *ip_mreq;
>      struct ip_mreq_source *ip_mreq_source;
> +    enum TargetTimestampVersion target_timestamp_version =
> +        target_expected_timestamp_version;
>
>      switch(level) {
>      case SOL_TCP:
> @@ -2331,9 +2373,14 @@ set_timeout:
>          case TARGET_SO_PASSSEC:
>                  optname = SO_PASSSEC;
>                  break;
> -        case TARGET_SO_TIMESTAMP:
> -               optname = SO_TIMESTAMP;
> -               break;
> +        case TARGET_SO_TIMESTAMP_OLD:
> +                target_timestamp_version = TARGET_TIMESTAMP_OLD;
> +                optname = SO_TIMESTAMP;
> +                break;
> +        case TARGET_SO_TIMESTAMP_NEW:
> +                target_timestamp_version = TARGET_TIMESTAMP_NEW;
> +                optname = SO_TIMESTAMP;
> +                break;
>          case TARGET_SO_RCVLOWAT:
>                 optname = SO_RCVLOWAT;
>                 break;
> @@ -2346,6 +2393,9 @@ set_timeout:
>         if (get_user_u32(val, optval_addr))
>              return -TARGET_EFAULT;
>         ret = get_errno(setsockopt(sockfd, SOL_SOCKET, optname, &val,
> sizeof(val)));
> +        if (!is_error(ret) && optname == SO_TIMESTAMP) {
> +            target_expected_timestamp_version = target_timestamp_version;
> +        }
>          break;
>  #ifdef SOL_NETLINK
>      case SOL_NETLINK:
> @@ -2396,6 +2446,7 @@ static abi_long do_getsockopt(int sockfd, int level,
> int optname,
>      abi_long ret;
>      int len, val;
>      socklen_t lv;
> +    int timestamp_format_matches = 0;
>
>      switch(level) {
>      case TARGET_SOL_SOCKET:
> @@ -2576,7 +2627,14 @@ get_timeout:
>          case TARGET_SO_PASSCRED:
>              optname = SO_PASSCRED;
>              goto int_case;
> -        case TARGET_SO_TIMESTAMP:
> +        case TARGET_SO_TIMESTAMP_OLD:
> +            timestamp_format_matches =
> +                (target_expected_timestamp_version ==
> TARGET_TIMESTAMP_OLD);
> +            optname = SO_TIMESTAMP;
> +            goto int_case;
> +        case TARGET_SO_TIMESTAMP_NEW:
> +            timestamp_format_matches =
> +                (target_expected_timestamp_version ==
> TARGET_TIMESTAMP_NEW);
>              optname = SO_TIMESTAMP;
>              goto int_case;
>          case TARGET_SO_RCVLOWAT:
> @@ -2604,6 +2662,9 @@ get_timeout:
>          if (optname == SO_TYPE) {
>              val = host_to_target_sock_type(val);
>          }
> +        if (optname == SO_TIMESTAMP) {
> +            val = val && timestamp_format_matches;
> +        }
>          if (len > lv)
>              len = lv;
>          if (len == 4) {
> diff --git a/tests/tcg/multiarch/socket_timestamp.c
> b/tests/tcg/multiarch/socket_timestamp.c
> new file mode 100644
> index 0000000000..71ab1845de
> --- /dev/null
> +++ b/tests/tcg/multiarch/socket_timestamp.c
> @@ -0,0 +1,296 @@
> +#include <assert.h>
> +#include <errno.h>
> +#include <linux/types.h>
> +#include <netinet/in.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <sys/socket.h>
> +#include <sys/time.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +#ifdef __kernel_old_timeval
> +#define kernel_old_timeval __kernel_old_timeval
> +#else
> +struct kernel_old_timeval {
> +    __kernel_long_t tv_sec;
> +    __kernel_long_t tv_usec;
> +};
> +#endif
> +
> +struct kernel_sock_timeval {
> +    int64_t tv_sec;
> +    int64_t tv_usec;
> +};
> +
> +int create_udp_socket(struct sockaddr_in *sockaddr)
> +{
> +    socklen_t sockaddr_len;
> +    int sock = socket(AF_INET, SOCK_DGRAM, 0);
> +    if (sock < 0) {
> +        int err = errno;
> +        fprintf(stderr, "Failed to create server socket: %s\n",
> strerror(err));
> +        exit(err);
> +    }
> +
> +    memset(sockaddr, 0, sizeof(*sockaddr));
> +    sockaddr->sin_family = AF_INET;
> +    sockaddr->sin_port = htons(0);  /* let kernel select a port for us */
> +    sockaddr->sin_addr.s_addr = htonl(INADDR_LOOPBACK);
> +
> +    if (bind(sock, (struct sockaddr *)sockaddr, sizeof(*sockaddr)) < 0) {
> +        int err = errno;
> +        fprintf(stderr, "Failed to bind server socket: %s\n",
> strerror(err));
> +        exit(err);
> +    }
> +
> +    sockaddr_len = sizeof(*sockaddr);
> +    if (getsockname(sock, (struct sockaddr *)sockaddr, &sockaddr_len) <
> 0) {
> +        int err = errno;
> +        fprintf(stderr, "Failed to get socket name: %s\n", strerror(err));
> +        exit(err);
> +    }
> +    return sock;
> +}
> +
> +/*
> + * Checks that the timestamp in the message is not after the reception
> timestamp
> + * as well as the reception time is within 10 seconds of the message time.
> + */
> +void check_timestamp_difference(const struct timeval *msg_tv,
> +                                const struct timeval *pkt_tv)
> +{
> +    if (pkt_tv->tv_sec < msg_tv->tv_sec ||
> +        (pkt_tv->tv_sec == msg_tv->tv_sec && pkt_tv->tv_usec <
> msg_tv->tv_usec))
> +    {
> +        fprintf(stderr,
> +                "Packet received before sent: %lld.%06lld <
> %lld.%06lld\n",
> +                (long long)pkt_tv->tv_sec, (long long)pkt_tv->tv_usec,
> +                (long long)msg_tv->tv_sec, (long long)msg_tv->tv_usec);
> +        exit(-1);
> +    }
> +
> +    if (pkt_tv->tv_sec > msg_tv->tv_sec + 10 ||
> +        (pkt_tv->tv_sec == msg_tv->tv_sec + 10 &&
> +         pkt_tv->tv_usec > msg_tv->tv_usec)) {
> +        fprintf(stderr,
> +                "Packet received more than 10 seconds after sent: "
> +                "%lld.%06lld > %lld.%06lld + 10\n",
> +                (long long)pkt_tv->tv_sec, (long long)pkt_tv->tv_usec,
> +                (long long)msg_tv->tv_sec, (long long)msg_tv->tv_usec);
> +        exit(-1);
> +    }
> +}
> +
> +void send_current_time(int sock, struct sockaddr_in server_sockaddr)
> +{
> +    struct timeval tv = {0, 0};
> +    gettimeofday(&tv, NULL);
> +    sendto(sock, &tv, sizeof(tv), 0, (struct sockaddr *)&server_sockaddr,
> +           sizeof(server_sockaddr));
> +}
> +
> +typedef void (*get_timeval_t)(const struct cmsghdr *cmsg, struct timeval
> *tv);
> +
> +
> +void receive_packet(int sock, get_timeval_t get_timeval)
> +{
> +    struct msghdr msg = {0};
> +
> +    char iobuf[1024];
> +    struct iovec iov;
> +
> +    union {
> +        /*
> +         * 128 bytes are enough for all existing
> +         * timeval/timespec/scm_timestamping structures.
> +         */
> +        char cmsg_buf[CMSG_SPACE(128)];
> +        struct cmsghdr align;
> +    } u;
> +    struct cmsghdr *cmsg;
> +    struct timeval msg_tv, pkt_tv;
> +
> +    int res;
> +
> +    iov.iov_base = iobuf;
> +    iov.iov_len = sizeof(iobuf);
> +
> +    msg.msg_iov = &iov;
> +    msg.msg_iovlen = 1;
> +    msg.msg_control = (caddr_t)u.cmsg_buf;
> +    msg.msg_controllen = sizeof(u.cmsg_buf);
> +
> +    res = recvmsg(sock, &msg, 0);
> +    if (res < 0) {
> +        int err = errno;
> +        fprintf(stderr, "Failed to receive packet: %s\n", strerror(err));
> +        exit(err);
> +    }
> +
> +    assert(res == sizeof(struct timeval));
> +    assert(iov.iov_base == iobuf);
> +    memcpy(&msg_tv, iov.iov_base, sizeof(msg_tv));
> +    printf("Message timestamp: %lld.%06lld\n",
> +           (long long)msg_tv.tv_sec, (long long)msg_tv.tv_usec);
> +
> +    cmsg = CMSG_FIRSTHDR(&msg);
> +    assert(cmsg);
> +    (*get_timeval)(cmsg, &pkt_tv);
> +    printf("Packet timestamp: %lld.%06lld\n",
> +           (long long)pkt_tv.tv_sec, (long long)pkt_tv.tv_usec);
> +
> +    check_timestamp_difference(&msg_tv, &pkt_tv);
> +}
> +
> +void get_timeval_from_so_timestamp(const struct cmsghdr *cmsg,
> +                                   struct timeval *tv)
> +{
> +    assert(cmsg->cmsg_level == SOL_SOCKET);
> +    assert(cmsg->cmsg_type == SCM_TIMESTAMP);
> +    assert(cmsg->cmsg_len == CMSG_LEN(sizeof(struct timeval)));
> +    memcpy(tv, CMSG_DATA(cmsg), sizeof(*tv));
> +}
> +
> +#ifdef SO_TIMESTAMP_OLD
> +void get_timeval_from_so_timestamp_old(const struct cmsghdr *cmsg,
> +                                       struct timeval *tv)
> +{
> +    struct kernel_old_timeval old_tv;
> +    assert(cmsg->cmsg_level == SOL_SOCKET);
> +    assert(cmsg->cmsg_type == SO_TIMESTAMP_OLD);
> +    assert(cmsg->cmsg_len == CMSG_LEN(sizeof(old_tv)));
> +
> +    memcpy(&old_tv, CMSG_DATA(cmsg), sizeof(old_tv));
> +    tv->tv_sec = old_tv.tv_sec;
> +    tv->tv_usec = old_tv.tv_usec;
> +}
> +
> +#ifdef SO_TIMESTAMP_NEW
> +void get_timeval_from_so_timestamp_new(const struct cmsghdr *cmsg,
> +                                       struct timeval *tv)
> +{
> +    struct kernel_sock_timeval sock_tv;
> +    assert(cmsg->cmsg_level == SOL_SOCKET);
> +    assert(cmsg->cmsg_type == SO_TIMESTAMP_NEW);
> +    assert(cmsg->cmsg_len == CMSG_LEN(sizeof(sock_tv)));
> +
> +    memcpy(&sock_tv, CMSG_DATA(cmsg), sizeof(sock_tv));
> +    tv->tv_sec = sock_tv.tv_sec;
> +    tv->tv_usec = sock_tv.tv_usec;
> +}
> +#endif /* defined(SO_TIMESTAMP_NEW) */
> +#endif /* defined(SO_TIMESTAMP_OLD) */
> +
> +void set_socket_option(int sock, int sockopt, int on)
> +{
> +    socklen_t len;
> +    int val = on;
> +    if (setsockopt(sock, SOL_SOCKET, sockopt, &val, sizeof(val)) < 0) {
> +        int err = errno;
> +        fprintf(stderr, "Failed to setsockopt %d (%s): %s\n",
> +                sockopt, on ? "on" : "off", strerror(err));
> +        exit(err);
> +    }
> +
> +    len = sizeof(val);
> +    val = -1;
> +    if (getsockopt(sock, SOL_SOCKET, sockopt, &val, &len) < 0) {
> +        int err = errno;
> +        fprintf(stderr, "Failed to getsockopt (%d): %s\n", sock,
> strerror(err));
> +        exit(err);
> +    }
> +    assert(len == sizeof(val));
> +    assert(val == on);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    int parent_sock, child_sock;
> +    struct sockaddr_in parent_sockaddr, child_sockaddr;
> +    int pid;
> +    struct timeval tv = {0, 0};
> +    gettimeofday(&tv, NULL);
> +
> +    parent_sock = create_udp_socket(&parent_sockaddr);
> +    child_sock = create_udp_socket(&child_sockaddr);
> +
> +    printf("Parent sock bound to port %d\nChild sock bound to port %d\n",
> +           parent_sockaddr.sin_port, child_sockaddr.sin_port);
> +
> +    pid = fork();
> +    if (pid < 0) {
> +        fprintf(stderr, "SKIPPED. Failed to fork: %s\n", strerror(errno));
> +    } else if (pid == 0) {
> +        close(child_sock);
> +
> +        /* Test 1: SO_TIMESTAMP */
> +        send_current_time(parent_sock, child_sockaddr);
> +
> +        if (tv.tv_sec > 0x7fffff00) {
> +            /* Too close to y2038 problem, old system may not work. */
> +            close(parent_sock);
> +            return 0;
> +        }
> +
> +#ifdef SO_TIMESTAMP_OLD
> +        if (SO_TIMESTAMP_OLD != SO_TIMESTAMP) {
> +            /* Test 2a: SO_TIMESTAMP_OLD */
> +            set_socket_option(parent_sock, SO_TIMESTAMP_OLD, 1);
> +            receive_packet(parent_sock,
> &get_timeval_from_so_timestamp_old);
> +            set_socket_option(parent_sock, SO_TIMESTAMP_OLD, 0);
> +        }
> +#ifdef SO_TIMESTAMP_NEW
> +        else {
> +            /* Test 2b: SO_TIMESTAMP_NEW */
> +            set_socket_option(parent_sock, SO_TIMESTAMP_NEW, 1);
> +            receive_packet(parent_sock,
> &get_timeval_from_so_timestamp_new);
> +            set_socket_option(parent_sock, SO_TIMESTAMP_NEW, 0);
> +        }
> +#endif /* defined(SO_TIMESTAMP_NEW) */
> +#endif /* defined(SO_TIMESTAMP_OLD) */
> +
> +        close(parent_sock);
> +    } else {
> +        int child_status;
> +        close(parent_sock);
> +
> +        /* Test 1: SO_TIMESTAMP */
> +        set_socket_option(child_sock, SO_TIMESTAMP, 1);
> +        receive_packet(child_sock, &get_timeval_from_so_timestamp);
> +        set_socket_option(child_sock, SO_TIMESTAMP, 0);
> +
> +        if (tv.tv_sec > 0x7fffff00) {
> +            /* Too close to y2038 problem, old system may not work. */
> +            close(child_sock);
> +            return 0;
> +        }
> +
> +#ifdef SO_TIMESTAMP_OLD
> +        if (SO_TIMESTAMP_OLD != SO_TIMESTAMP) {
> +            /* Test 2a: SO_TIMESTAMP_OLD */
> +            send_current_time(child_sock, parent_sockaddr);
> +        }
> +#ifdef SO_TIMESTAMP_NEW
> +        else {
> +            /* Test 2b: SO_TIMESTAMP_NEW */
> +            send_current_time(child_sock, parent_sockaddr);
> +        }
> +#endif /* defined(SO_TIMESTAMP_NEW) */
> +#endif /* defined(SO_TIMESTAMP_OLD) */
> +
> +        close(child_sock);
> +
> +        if (waitpid(pid, &child_status, 0) < 0) {
> +            int err = errno;
> +            fprintf(stderr, "Final wait() failed: %s\n", strerror(err));
> +            return err;
> +        }
> +        return child_status;
> +    }
> +    return 0;
> +}
> --
> 2.28.0.220.ged08abb693-goog
>
>

--0000000000002f6bc305af7d58f4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ping -- any comments on the four patches start with this?=
=C2=A0<a href=3D"https://patchew.org/QEMU/cover.1597129029.git.scw@google.c=
om/">https://patchew.org/QEMU/cover.1597129029.git.scw@google.com/</a></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tu=
e, Aug 11, 2020 at 12:10 AM Shu-Chun Weng &lt;<a href=3D"mailto:scw@google.=
com" target=3D"_blank">scw@google.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Both guest options map to host SO_TIME=
STAMP while keeping a global bit to<br>
remember if the guest expects the old or the new format. Don&#39;t support<=
br>
programs mixing two formats.<br>
<br>
Added a multiarch test to verify.<br>
<br>
Signed-off-by: Shu-Chun Weng &lt;<a href=3D"mailto:scw@google.com" target=
=3D"_blank">scw@google.com</a>&gt;<br>
---<br>
v1 -&gt; v2:<br>
=C2=A0 Only keep track of old or new format globally, remove support for di=
fferent<br>
=C2=A0 sockets mixing different formats.<br>
=C2=A0 Fix style problems.<br>
<br>
=C2=A0linux-user/alpha/sockbits.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 =C2=A08 +-<br>
=C2=A0linux-user/generic/sockbits.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A09 +-<br>
=C2=A0linux-user/hppa/sockbits.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A08 +-<br>
=C2=A0linux-user/mips/sockbits.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A08 +-<br>
=C2=A0linux-user/sparc/sockbits.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 =C2=A08 +-<br>
=C2=A0linux-user/strace.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +-<br>
=C2=A0linux-user/syscall.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 91 ++++++--<br>
=C2=A0tests/tcg/multiarch/socket_timestamp.c | 296 ++++++++++++++++++++++++=
+<br>
=C2=A08 files changed, 408 insertions(+), 27 deletions(-)<br>
=C2=A0create mode 100644 tests/tcg/multiarch/socket_timestamp.c<br>
<br>
diff --git a/linux-user/alpha/sockbits.h b/linux-user/alpha/sockbits.h<br>
index d54dc98c09..40f0644df0 100644<br>
--- a/linux-user/alpha/sockbits.h<br>
+++ b/linux-user/alpha/sockbits.h<br>
@@ -48,8 +48,6 @@<br>
=C2=A0#define TARGET_SO_DETACH_FILTER=C2=A0 =C2=A0 =C2=A0 =C2=A0 27<br>
<br>
=C2=A0#define TARGET_SO_PEERNAME=C2=A0 =C2=A0 =C2=A0 28<br>
-#define TARGET_SO_TIMESTAMP=C2=A0 =C2=A0 =C2=A029<br>
-#define TARGET_SCM_TIMESTAMP=C2=A0 =C2=A0 =C2=A0 =C2=A0 TARGET_SO_TIMESTAM=
P<br>
<br>
=C2=A0#define TARGET_SO_PEERSEC=C2=A0 =C2=A0 =C2=A0 =C2=A030<br>
=C2=A0#define TARGET_SO_PASSSEC=C2=A0 =C2=A0 =C2=A0 =C2=A034<br>
@@ -75,6 +73,12 @@<br>
=C2=A0/* Instruct lower device to use last 4-bytes of skb data as FCS */<br=
>
=C2=A0#define TARGET_SO_NOFCS=C2=A0 =C2=A0 =C2=A043<br>
<br>
+#define TARGET_SO_TIMESTAMP_OLD=C2=A0 =C2=A0 =C2=A0 =C2=A0 29<br>
+#define TARGET_SCM_TIMESTAMP_OLD=C2=A0 =C2=A0 =C2=A0 =C2=A0TARGET_SO_TIMES=
TAMP_OLD<br>
+<br>
+#define TARGET_SO_TIMESTAMP_NEW=C2=A0 =C2=A0 =C2=A0 =C2=A0 63<br>
+#define TARGET_SCM_TIMESTAMP_NEW=C2=A0 =C2=A0 =C2=A0 =C2=A0TARGET_SO_TIMES=
TAMP_NEW<br>
+<br>
=C2=A0/* TARGET_O_NONBLOCK clashes with the bits used for socket types.=C2=
=A0 Therefore we<br>
=C2=A0 * have to define SOCK_NONBLOCK to a different value here.<br>
=C2=A0 */<br>
diff --git a/linux-user/generic/sockbits.h b/linux-user/generic/sockbits.h<=
br>
index e44733c601..532cf2d3dc 100644<br>
--- a/linux-user/generic/sockbits.h<br>
+++ b/linux-user/generic/sockbits.h<br>
@@ -49,10 +49,15 @@<br>
=C2=A0#define TARGET_SO_DETACH_FILTER=C2=A0 =C2=A0 =C2=A0 =C2=A0 27<br>
<br>
=C2=A0#define TARGET_SO_PEERNAME=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A028<br>
-#define TARGET_SO_TIMESTAMP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 29<br=
>
-#define TARGET_SCM_TIMESTAMP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TARGE=
T_SO_TIMESTAMP<br>
<br>
=C2=A0#define TARGET_SO_ACCEPTCONN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
30<br>
<br>
=C2=A0#define TARGET_SO_PEERSEC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 31<br>
+<br>
+#define TARGET_SO_TIMESTAMP_OLD=C2=A0 =C2=A0 =C2=A0 =C2=A0 29<br>
+#define TARGET_SCM_TIMESTAMP_OLD=C2=A0 =C2=A0 =C2=A0 =C2=A0TARGET_SO_TIMES=
TAMP_OLD<br>
+<br>
+#define TARGET_SO_TIMESTAMP_NEW=C2=A0 =C2=A0 =C2=A0 =C2=A0 63<br>
+#define TARGET_SCM_TIMESTAMP_NEW=C2=A0 =C2=A0 =C2=A0 =C2=A0TARGET_SO_TIMES=
TAMP_NEW<br>
+<br>
=C2=A0#endif<br>
diff --git a/linux-user/hppa/sockbits.h b/linux-user/hppa/sockbits.h<br>
index 23f69a3293..284a47e74e 100644<br>
--- a/linux-user/hppa/sockbits.h<br>
+++ b/linux-user/hppa/sockbits.h<br>
@@ -29,8 +29,6 @@<br>
=C2=A0#define TARGET_SO_BSDCOMPAT=C2=A0 =C2=A0 0x400e<br>
=C2=A0#define TARGET_SO_PASSCRED=C2=A0 =C2=A0 =C2=A00x4010<br>
=C2=A0#define TARGET_SO_PEERCRED=C2=A0 =C2=A0 =C2=A00x4011<br>
-#define TARGET_SO_TIMESTAMP=C2=A0 =C2=A0 0x4012<br>
-#define TARGET_SCM_TIMESTAMP=C2=A0 =C2=A0TARGET_SO_TIMESTAMP<br>
=C2=A0#define TARGET_SO_TIMESTAMPNS=C2=A0 0x4013<br>
=C2=A0#define TARGET_SCM_TIMESTAMPNS TARGET_SO_TIMESTAMPNS<br>
<br>
@@ -67,6 +65,12 @@<br>
<br>
=C2=A0#define TARGET_SO_CNX_ADVICE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x402E<br>
<br>
+#define TARGET_SO_TIMESTAMP_OLD=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x4012<br>
+#define TARGET_SCM_TIMESTAMP_OLD=C2=A0 =C2=A0 =C2=A0 =C2=A0TARGET_SO_TIMES=
TAMP_OLD<br>
+<br>
+#define TARGET_SO_TIMESTAMP_NEW=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x4038<br>
+#define TARGET_SCM_TIMESTAMP_NEW=C2=A0 =C2=A0 =C2=A0 =C2=A0TARGET_SO_TIMES=
TAMP_NEW<br>
+<br>
=C2=A0/* TARGET_O_NONBLOCK clashes with the bits used for socket types.=C2=
=A0 Therefore we<br>
=C2=A0 * have to define SOCK_NONBLOCK to a different value here.<br>
=C2=A0 */<br>
diff --git a/linux-user/mips/sockbits.h b/linux-user/mips/sockbits.h<br>
index 0f022cd598..b4c39d9588 100644<br>
--- a/linux-user/mips/sockbits.h<br>
+++ b/linux-user/mips/sockbits.h<br>
@@ -61,14 +61,18 @@<br>
=C2=A0#define TARGET_SO_DETACH_FILTER=C2=A0 =C2=A0 =C2=A0 =C2=A0 27<br>
<br>
=C2=A0#define TARGET_SO_PEERNAME=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A028<br>
-#define TARGET_SO_TIMESTAMP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 29<br=
>
-#define SCM_TIMESTAMP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SO_TIMESTAMP<br>
<br>
=C2=A0#define TARGET_SO_PEERSEC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 30<br>
=C2=A0#define TARGET_SO_SNDBUFFORCE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 31<br=
>
=C2=A0#define TARGET_SO_RCVBUFFORCE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 33<br=
>
=C2=A0#define TARGET_SO_PASSSEC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 34<br>
<br>
+#define TARGET_SO_TIMESTAMP_OLD=C2=A0 =C2=A0 =C2=A0 =C2=A0 29<br>
+#define TARGET_SCM_TIMESTAMP_OLD=C2=A0 =C2=A0 =C2=A0 =C2=A0TARGET_SO_TIMES=
TAMP_OLD<br>
+<br>
+#define TARGET_SO_TIMESTAMP_NEW=C2=A0 =C2=A0 =C2=A0 =C2=A0 63<br>
+#define TARGET_SCM_TIMESTAMP_NEW=C2=A0 =C2=A0 =C2=A0 =C2=A0TARGET_SO_TIMES=
TAMP_NEW<br>
+<br>
=C2=A0/** sock_type - Socket types<br>
=C2=A0 *<br>
=C2=A0 * Please notice that for binary compat reasons MIPS has to<br>
diff --git a/linux-user/sparc/sockbits.h b/linux-user/sparc/sockbits.h<br>
index 0a822e3e1f..07440efd14 100644<br>
--- a/linux-user/sparc/sockbits.h<br>
+++ b/linux-user/sparc/sockbits.h<br>
@@ -48,8 +48,6 @@<br>
=C2=A0#define TARGET_SO_GET_FILTER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
TARGET_SO_ATTACH_FILTER<br>
<br>
=C2=A0#define TARGET_SO_PEERNAME=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x001c<br>
-#define TARGET_SO_TIMESTAMP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x001=
d<br>
-#define TARGET_SCM_TIMESTAMP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TARGE=
T_SO_TIMESTAMP<br>
<br>
=C2=A0#define TARGET_SO_PEERSEC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0x001e<br>
=C2=A0#define TARGET_SO_PASSSEC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0x001f<br>
@@ -104,6 +102,12 @@<br>
<br>
=C2=A0#define TARGET_SO_ZEROCOPY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x003e<br>
<br>
+#define TARGET_SO_TIMESTAMP_OLD=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x001d<br>
+#define TARGET_SCM_TIMESTAMP_OLD=C2=A0 =C2=A0 =C2=A0 =C2=A0TARGET_SO_TIMES=
TAMP_OLD<br>
+<br>
+#define TARGET_SO_TIMESTAMP_NEW=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0046<br>
+#define TARGET_SCM_TIMESTAMP_NEW=C2=A0 =C2=A0 =C2=A0 =C2=A0TARGET_SO_TIMES=
TAMP_NEW<br>
+<br>
=C2=A0/* Security levels - as per NRL IPv6 - don&#39;t actually do anything=
 */<br>
=C2=A0#define TARGET_SO_SECURITY_AUTHENTICATION=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x5001<br>
=C2=A0#define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0x5002<br>
diff --git a/linux-user/strace.c b/linux-user/strace.c<br>
index 089fb3968e..a11a5e9e86 100644<br>
--- a/linux-user/strace.c<br>
+++ b/linux-user/strace.c<br>
@@ -2257,8 +2257,11 @@ print_optint:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case TARGET_SO_PASSCRED:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log(&quot;SO_PASSCRED,=
&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto print_optint;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_TIMESTAMP:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;SO_TIMESTAMP,&quo=
t;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_TIMESTAMP_OLD:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;SO_TIMESTAMP_OLD,=
&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_TIMESTAMP_NEW:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;SO_TIMESTAMP_NEW,=
&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto print_optint;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case TARGET_SO_RCVLOWAT:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log(&quot;SO_RCVLOWAT,=
&quot;);<br>
diff --git a/linux-user/syscall.c b/linux-user/syscall.c<br>
index cda194a7cc..e6b1a18cc0 100644<br>
--- a/linux-user/syscall.c<br>
+++ b/linux-user/syscall.c<br>
@@ -1697,6 +1697,18 @@ static inline abi_long target_to_host_cmsg(struct ms=
ghdr *msgh,<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
+/*<br>
+ * Linux kernel actually keeps track of whether the old version (potential=
ly<br>
+ * 32-bit time_t) or the new version is used for each socket. Instead of<b=
r>
+ * replicate it will all the complexity, we only keep track of one global =
state,<br>
+ * which is enough for guest programs that don&#39;t intentionally mix the=
 two<br>
+ * versions.<br>
+ */<br>
+static enum TargetTimestampVersion {<br>
+=C2=A0 =C2=A0 TARGET_TIMESTAMP_OLD,<br>
+=C2=A0 =C2=A0 TARGET_TIMESTAMP_NEW,<br>
+} target_expected_timestamp_version =3D TARGET_TIMESTAMP_OLD;<br>
+<br>
=C2=A0static inline abi_long host_to_target_cmsg(struct target_msghdr *targ=
et_msgh,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct msghdr *msgh)<br>
=C2=A0{<br>
@@ -1747,8 +1759,17 @@ static inline abi_long host_to_target_cmsg(struct ta=
rget_msghdr *target_msgh,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (cmsg-&gt;cmsg_level) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case SOL_SOCKET:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (cmsg-&gt;cmsg_type)=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case SO_TIMESTAMP:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tgt_len =3D sizeof=
(struct target_timeval);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case SCM_TIMESTAMP:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (target_exp=
ected_timestamp_version) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_TIMEST=
AMP_OLD:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tgt_=
len =3D sizeof(struct target_timeval);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 targ=
et_cmsg-&gt;cmsg_type =3D tswap32(TARGET_SCM_TIMESTAMP_OLD);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brea=
k;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_TIMEST=
AMP_NEW:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tgt_=
len =3D sizeof(struct target__kernel_sock_timeval);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 targ=
et_cmsg-&gt;cmsg_type =3D tswap32(TARGET_SCM_TIMESTAMP_NEW);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brea=
k;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -1782,20 +1803,39 @@ static inline abi_long host_to_target_cmsg(struct t=
arget_msghdr *target_msgh,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case SO_TIMESTAMP:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case SCM_TIMESTAMP:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct timeva=
l *tv =3D (struct timeval *)data;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct target_time=
val *target_tv =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (str=
uct target_timeval *)target_data;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len !=3D sizeo=
f(struct timeval) ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tgt_=
len !=3D sizeof(struct target_timeval)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len !=3D sizeo=
f(struct timeval)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0goto unimplemented;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* copy struct tim=
eval to target */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __put_user(tv-&gt;=
tv_sec, &amp;target_tv-&gt;tv_sec);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __put_user(tv-&gt;=
tv_usec, &amp;target_tv-&gt;tv_usec);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (target_exp=
ected_timestamp_version) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_TIMEST=
AMP_OLD:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stru=
ct target_timeval *target_tv =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (struct target_timeval *)target_data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
tgt_len !=3D sizeof(struct target_timeval)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto unimplemented;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __pu=
t_user(tv-&gt;tv_sec, &amp;target_tv-&gt;tv_sec);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __pu=
t_user(tv-&gt;tv_usec, &amp;target_tv-&gt;tv_usec);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brea=
k;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_TIMEST=
AMP_NEW:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stru=
ct target__kernel_sock_timeval *target_tv =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (struct target__kernel_sock_timeval *)target_data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
tgt_len !=3D sizeof(struct target__kernel_sock_timeval)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto unimplemented;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __pu=
t_user(tv-&gt;tv_sec, &amp;target_tv-&gt;tv_sec);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __pu=
t_user(tv-&gt;tv_usec, &amp;target_tv-&gt;tv_usec);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brea=
k;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case SCM_CREDENTIALS:<br>
@@ -1937,6 +1977,8 @@ static abi_long do_setsockopt(int sockfd, int level, =
int optname,<br>
=C2=A0 =C2=A0 =C2=A0int val;<br>
=C2=A0 =C2=A0 =C2=A0struct ip_mreqn *ip_mreq;<br>
=C2=A0 =C2=A0 =C2=A0struct ip_mreq_source *ip_mreq_source;<br>
+=C2=A0 =C2=A0 enum TargetTimestampVersion target_timestamp_version =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_expected_timestamp_version;<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch(level) {<br>
=C2=A0 =C2=A0 =C2=A0case SOL_TCP:<br>
@@ -2331,9 +2373,14 @@ set_timeout:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case TARGET_SO_PASSSEC:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0optname =3D S=
O_PASSSEC;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_TIMESTAMP:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0optname =3D SO_TIME=
STAMP;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_TIMESTAMP_OLD:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_timestamp_v=
ersion =3D TARGET_TIMESTAMP_OLD;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optname =3D SO_TIM=
ESTAMP;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_TIMESTAMP_NEW:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_timestamp_v=
ersion =3D TARGET_TIMESTAMP_NEW;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optname =3D SO_TIM=
ESTAMP;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case TARGET_SO_RCVLOWAT:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optname =3D SO_RCVL=
OWAT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
@@ -2346,6 +2393,9 @@ set_timeout:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_user_u32(val, optval_addr))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -TARGET_EFAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(setsockopt(sockfd, SOL_SOCKET=
, optname, &amp;val, sizeof(val)));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!is_error(ret) &amp;&amp; optname =3D=3D S=
O_TIMESTAMP) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_expected_timestamp_versio=
n =3D target_timestamp_version;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0#ifdef SOL_NETLINK<br>
=C2=A0 =C2=A0 =C2=A0case SOL_NETLINK:<br>
@@ -2396,6 +2446,7 @@ static abi_long do_getsockopt(int sockfd, int level, =
int optname,<br>
=C2=A0 =C2=A0 =C2=A0abi_long ret;<br>
=C2=A0 =C2=A0 =C2=A0int len, val;<br>
=C2=A0 =C2=A0 =C2=A0socklen_t lv;<br>
+=C2=A0 =C2=A0 int timestamp_format_matches =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch(level) {<br>
=C2=A0 =C2=A0 =C2=A0case TARGET_SOL_SOCKET:<br>
@@ -2576,7 +2627,14 @@ get_timeout:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case TARGET_SO_PASSCRED:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0optname =3D SO_PASSCRED;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto int_case;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_TIMESTAMP:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_TIMESTAMP_OLD:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timestamp_format_matches =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (target_expected_t=
imestamp_version =3D=3D TARGET_TIMESTAMP_OLD);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optname =3D SO_TIMESTAMP;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto int_case;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case TARGET_SO_TIMESTAMP_NEW:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timestamp_format_matches =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (target_expected_t=
imestamp_version =3D=3D TARGET_TIMESTAMP_NEW);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0optname =3D SO_TIMESTAMP;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto int_case;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case TARGET_SO_RCVLOWAT:<br>
@@ -2604,6 +2662,9 @@ get_timeout:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (optname =3D=3D SO_TYPE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D host_to_target_sock=
_type(val);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (optname =3D=3D SO_TIMESTAMP) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D val &amp;&amp; timestamp=
_format_matches;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (len &gt; lv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D lv;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (len =3D=3D 4) {<br>
diff --git a/tests/tcg/multiarch/socket_timestamp.c b/tests/tcg/multiarch/s=
ocket_timestamp.c<br>
new file mode 100644<br>
index 0000000000..71ab1845de<br>
--- /dev/null<br>
+++ b/tests/tcg/multiarch/socket_timestamp.c<br>
@@ -0,0 +1,296 @@<br>
+#include &lt;assert.h&gt;<br>
+#include &lt;errno.h&gt;<br>
+#include &lt;linux/types.h&gt;<br>
+#include &lt;netinet/in.h&gt;<br>
+#include &lt;stdint.h&gt;<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;stdlib.h&gt;<br>
+#include &lt;string.h&gt;<br>
+#include &lt;sys/ioctl.h&gt;<br>
+#include &lt;sys/socket.h&gt;<br>
+#include &lt;sys/time.h&gt;<br>
+#include &lt;sys/types.h&gt;<br>
+#include &lt;sys/wait.h&gt;<br>
+#include &lt;unistd.h&gt;<br>
+<br>
+#ifdef __kernel_old_timeval<br>
+#define kernel_old_timeval __kernel_old_timeval<br>
+#else<br>
+struct kernel_old_timeval {<br>
+=C2=A0 =C2=A0 __kernel_long_t tv_sec;<br>
+=C2=A0 =C2=A0 __kernel_long_t tv_usec;<br>
+};<br>
+#endif<br>
+<br>
+struct kernel_sock_timeval {<br>
+=C2=A0 =C2=A0 int64_t tv_sec;<br>
+=C2=A0 =C2=A0 int64_t tv_usec;<br>
+};<br>
+<br>
+int create_udp_socket(struct sockaddr_in *sockaddr)<br>
+{<br>
+=C2=A0 =C2=A0 socklen_t sockaddr_len;<br>
+=C2=A0 =C2=A0 int sock =3D socket(AF_INET, SOCK_DGRAM, 0);<br>
+=C2=A0 =C2=A0 if (sock &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int err =3D errno;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Failed to create server =
socket: %s\n&quot;, strerror(err));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(err);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 memset(sockaddr, 0, sizeof(*sockaddr));<br>
+=C2=A0 =C2=A0 sockaddr-&gt;sin_family =3D AF_INET;<br>
+=C2=A0 =C2=A0 sockaddr-&gt;sin_port =3D htons(0);=C2=A0 /* let kernel sele=
ct a port for us */<br>
+=C2=A0 =C2=A0 sockaddr-&gt;sin_addr.s_addr =3D htonl(INADDR_LOOPBACK);<br>
+<br>
+=C2=A0 =C2=A0 if (bind(sock, (struct sockaddr *)sockaddr, sizeof(*sockaddr=
)) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int err =3D errno;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Failed to bind server so=
cket: %s\n&quot;, strerror(err));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(err);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 sockaddr_len =3D sizeof(*sockaddr);<br>
+=C2=A0 =C2=A0 if (getsockname(sock, (struct sockaddr *)sockaddr, &amp;sock=
addr_len) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int err =3D errno;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Failed to get socket nam=
e: %s\n&quot;, strerror(err));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(err);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return sock;<br>
+}<br>
+<br>
+/*<br>
+ * Checks that the timestamp in the message is not after the reception tim=
estamp<br>
+ * as well as the reception time is within 10 seconds of the message time.=
<br>
+ */<br>
+void check_timestamp_difference(const struct timeval *msg_tv,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct timeval *pkt_tv)<br>
+{<br>
+=C2=A0 =C2=A0 if (pkt_tv-&gt;tv_sec &lt; msg_tv-&gt;tv_sec ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (pkt_tv-&gt;tv_sec =3D=3D msg_tv-&gt;tv_sec &a=
mp;&amp; pkt_tv-&gt;tv_usec &lt; msg_tv-&gt;tv_usec))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Packet recei=
ved before sent: %lld.%06lld &lt; %lld.%06lld\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (long long)pkt_tv-=
&gt;tv_sec, (long long)pkt_tv-&gt;tv_usec,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (long long)msg_tv-=
&gt;tv_sec, (long long)msg_tv-&gt;tv_usec);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(-1);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (pkt_tv-&gt;tv_sec &gt; msg_tv-&gt;tv_sec + 10 ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (pkt_tv-&gt;tv_sec =3D=3D msg_tv-&gt;tv_sec + =
10 &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pkt_tv-&gt;tv_usec &gt; msg_tv-&gt;tv_us=
ec)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Packet recei=
ved more than 10 seconds after sent: &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%lld.%06lld =
&gt; %lld.%06lld + 10\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (long long)pkt_tv-=
&gt;tv_sec, (long long)pkt_tv-&gt;tv_usec,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (long long)msg_tv-=
&gt;tv_sec, (long long)msg_tv-&gt;tv_usec);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(-1);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+void send_current_time(int sock, struct sockaddr_in server_sockaddr)<br>
+{<br>
+=C2=A0 =C2=A0 struct timeval tv =3D {0, 0};<br>
+=C2=A0 =C2=A0 gettimeofday(&amp;tv, NULL);<br>
+=C2=A0 =C2=A0 sendto(sock, &amp;tv, sizeof(tv), 0, (struct sockaddr *)&amp=
;server_sockaddr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(server_sockaddr));<br>
+}<br>
+<br>
+typedef void (*get_timeval_t)(const struct cmsghdr *cmsg, struct timeval *=
tv);<br>
+<br>
+<br>
+void receive_packet(int sock, get_timeval_t get_timeval)<br>
+{<br>
+=C2=A0 =C2=A0 struct msghdr msg =3D {0};<br>
+<br>
+=C2=A0 =C2=A0 char iobuf[1024];<br>
+=C2=A0 =C2=A0 struct iovec iov;<br>
+<br>
+=C2=A0 =C2=A0 union {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* 128 bytes are enough for all existing<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* timeval/timespec/scm_timestamping stru=
ctures.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char cmsg_buf[CMSG_SPACE(128)];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cmsghdr align;<br>
+=C2=A0 =C2=A0 } u;<br>
+=C2=A0 =C2=A0 struct cmsghdr *cmsg;<br>
+=C2=A0 =C2=A0 struct timeval msg_tv, pkt_tv;<br>
+<br>
+=C2=A0 =C2=A0 int res;<br>
+<br>
+=C2=A0 =C2=A0 iov.iov_base =3D iobuf;<br>
+=C2=A0 =C2=A0 iov.iov_len =3D sizeof(iobuf);<br>
+<br>
+=C2=A0 =C2=A0 msg.msg_iov =3D &amp;iov;<br>
+=C2=A0 =C2=A0 msg.msg_iovlen =3D 1;<br>
+=C2=A0 =C2=A0 msg.msg_control =3D (caddr_t)u.cmsg_buf;<br>
+=C2=A0 =C2=A0 msg.msg_controllen =3D sizeof(u.cmsg_buf);<br>
+<br>
+=C2=A0 =C2=A0 res =3D recvmsg(sock, &amp;msg, 0);<br>
+=C2=A0 =C2=A0 if (res &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int err =3D errno;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Failed to receive packet=
: %s\n&quot;, strerror(err));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(err);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 assert(res =3D=3D sizeof(struct timeval));<br>
+=C2=A0 =C2=A0 assert(iov.iov_base =3D=3D iobuf);<br>
+=C2=A0 =C2=A0 memcpy(&amp;msg_tv, iov.iov_base, sizeof(msg_tv));<br>
+=C2=A0 =C2=A0 printf(&quot;Message timestamp: %lld.%06lld\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(long long)msg_tv.tv_sec, (long l=
ong)msg_tv.tv_usec);<br>
+<br>
+=C2=A0 =C2=A0 cmsg =3D CMSG_FIRSTHDR(&amp;msg);<br>
+=C2=A0 =C2=A0 assert(cmsg);<br>
+=C2=A0 =C2=A0 (*get_timeval)(cmsg, &amp;pkt_tv);<br>
+=C2=A0 =C2=A0 printf(&quot;Packet timestamp: %lld.%06lld\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(long long)pkt_tv.tv_sec, (long l=
ong)pkt_tv.tv_usec);<br>
+<br>
+=C2=A0 =C2=A0 check_timestamp_difference(&amp;msg_tv, &amp;pkt_tv);<br>
+}<br>
+<br>
+void get_timeval_from_so_timestamp(const struct cmsghdr *cmsg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct timeval *tv)<br>
+{<br>
+=C2=A0 =C2=A0 assert(cmsg-&gt;cmsg_level =3D=3D SOL_SOCKET);<br>
+=C2=A0 =C2=A0 assert(cmsg-&gt;cmsg_type =3D=3D SCM_TIMESTAMP);<br>
+=C2=A0 =C2=A0 assert(cmsg-&gt;cmsg_len =3D=3D CMSG_LEN(sizeof(struct timev=
al)));<br>
+=C2=A0 =C2=A0 memcpy(tv, CMSG_DATA(cmsg), sizeof(*tv));<br>
+}<br>
+<br>
+#ifdef SO_TIMESTAMP_OLD<br>
+void get_timeval_from_so_timestamp_old(const struct cmsghdr *cmsg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ti=
meval *tv)<br>
+{<br>
+=C2=A0 =C2=A0 struct kernel_old_timeval old_tv;<br>
+=C2=A0 =C2=A0 assert(cmsg-&gt;cmsg_level =3D=3D SOL_SOCKET);<br>
+=C2=A0 =C2=A0 assert(cmsg-&gt;cmsg_type =3D=3D SO_TIMESTAMP_OLD);<br>
+=C2=A0 =C2=A0 assert(cmsg-&gt;cmsg_len =3D=3D CMSG_LEN(sizeof(old_tv)));<b=
r>
+<br>
+=C2=A0 =C2=A0 memcpy(&amp;old_tv, CMSG_DATA(cmsg), sizeof(old_tv));<br>
+=C2=A0 =C2=A0 tv-&gt;tv_sec =3D old_tv.tv_sec;<br>
+=C2=A0 =C2=A0 tv-&gt;tv_usec =3D old_tv.tv_usec;<br>
+}<br>
+<br>
+#ifdef SO_TIMESTAMP_NEW<br>
+void get_timeval_from_so_timestamp_new(const struct cmsghdr *cmsg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ti=
meval *tv)<br>
+{<br>
+=C2=A0 =C2=A0 struct kernel_sock_timeval sock_tv;<br>
+=C2=A0 =C2=A0 assert(cmsg-&gt;cmsg_level =3D=3D SOL_SOCKET);<br>
+=C2=A0 =C2=A0 assert(cmsg-&gt;cmsg_type =3D=3D SO_TIMESTAMP_NEW);<br>
+=C2=A0 =C2=A0 assert(cmsg-&gt;cmsg_len =3D=3D CMSG_LEN(sizeof(sock_tv)));<=
br>
+<br>
+=C2=A0 =C2=A0 memcpy(&amp;sock_tv, CMSG_DATA(cmsg), sizeof(sock_tv));<br>
+=C2=A0 =C2=A0 tv-&gt;tv_sec =3D sock_tv.tv_sec;<br>
+=C2=A0 =C2=A0 tv-&gt;tv_usec =3D sock_tv.tv_usec;<br>
+}<br>
+#endif /* defined(SO_TIMESTAMP_NEW) */<br>
+#endif /* defined(SO_TIMESTAMP_OLD) */<br>
+<br>
+void set_socket_option(int sock, int sockopt, int on)<br>
+{<br>
+=C2=A0 =C2=A0 socklen_t len;<br>
+=C2=A0 =C2=A0 int val =3D on;<br>
+=C2=A0 =C2=A0 if (setsockopt(sock, SOL_SOCKET, sockopt, &amp;val, sizeof(v=
al)) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int err =3D errno;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Failed to setsockopt %d =
(%s): %s\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sockopt, on ? &quo=
t;on&quot; : &quot;off&quot;, strerror(err));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(err);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 len =3D sizeof(val);<br>
+=C2=A0 =C2=A0 val =3D -1;<br>
+=C2=A0 =C2=A0 if (getsockopt(sock, SOL_SOCKET, sockopt, &amp;val, &amp;len=
) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int err =3D errno;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Failed to getsockopt (%d=
): %s\n&quot;, sock, strerror(err));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(err);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 assert(len =3D=3D sizeof(val));<br>
+=C2=A0 =C2=A0 assert(val =3D=3D on);<br>
+}<br>
+<br>
+int main(int argc, char **argv)<br>
+{<br>
+=C2=A0 =C2=A0 int parent_sock, child_sock;<br>
+=C2=A0 =C2=A0 struct sockaddr_in parent_sockaddr, child_sockaddr;<br>
+=C2=A0 =C2=A0 int pid;<br>
+=C2=A0 =C2=A0 struct timeval tv =3D {0, 0};<br>
+=C2=A0 =C2=A0 gettimeofday(&amp;tv, NULL);<br>
+<br>
+=C2=A0 =C2=A0 parent_sock =3D create_udp_socket(&amp;parent_sockaddr);<br>
+=C2=A0 =C2=A0 child_sock =3D create_udp_socket(&amp;child_sockaddr);<br>
+<br>
+=C2=A0 =C2=A0 printf(&quot;Parent sock bound to port %d\nChild sock bound =
to port %d\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parent_sockaddr.sin_port, child_s=
ockaddr.sin_port);<br>
+<br>
+=C2=A0 =C2=A0 pid =3D fork();<br>
+=C2=A0 =C2=A0 if (pid &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;SKIPPED. Failed to fork:=
 %s\n&quot;, strerror(errno));<br>
+=C2=A0 =C2=A0 } else if (pid =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(child_sock);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Test 1: SO_TIMESTAMP */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 send_current_time(parent_sock, child_sockaddr)=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tv.tv_sec &gt; 0x7fffff00) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Too close to y2038 problem, o=
ld system may not work. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close(parent_sock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+#ifdef SO_TIMESTAMP_OLD<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (SO_TIMESTAMP_OLD !=3D SO_TIMESTAMP) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Test 2a: SO_TIMESTAMP_OLD */<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_socket_option(parent_sock, S=
O_TIMESTAMP_OLD, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 receive_packet(parent_sock, &amp=
;get_timeval_from_so_timestamp_old);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_socket_option(parent_sock, S=
O_TIMESTAMP_OLD, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+#ifdef SO_TIMESTAMP_NEW<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Test 2b: SO_TIMESTAMP_NEW */<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_socket_option(parent_sock, S=
O_TIMESTAMP_NEW, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 receive_packet(parent_sock, &amp=
;get_timeval_from_so_timestamp_new);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_socket_option(parent_sock, S=
O_TIMESTAMP_NEW, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+#endif /* defined(SO_TIMESTAMP_NEW) */<br>
+#endif /* defined(SO_TIMESTAMP_OLD) */<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(parent_sock);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int child_status;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(parent_sock);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Test 1: SO_TIMESTAMP */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_socket_option(child_sock, SO_TIMESTAMP, 1)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 receive_packet(child_sock, &amp;get_timeval_fr=
om_so_timestamp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_socket_option(child_sock, SO_TIMESTAMP, 0)=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tv.tv_sec &gt; 0x7fffff00) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Too close to y2038 problem, o=
ld system may not work. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close(child_sock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+#ifdef SO_TIMESTAMP_OLD<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (SO_TIMESTAMP_OLD !=3D SO_TIMESTAMP) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Test 2a: SO_TIMESTAMP_OLD */<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_current_time(child_sock, pa=
rent_sockaddr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+#ifdef SO_TIMESTAMP_NEW<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Test 2b: SO_TIMESTAMP_NEW */<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send_current_time(child_sock, pa=
rent_sockaddr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+#endif /* defined(SO_TIMESTAMP_NEW) */<br>
+#endif /* defined(SO_TIMESTAMP_OLD) */<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(child_sock);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (waitpid(pid, &amp;child_status, 0) &lt; 0)=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int err =3D errno;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Final wait=
() failed: %s\n&quot;, strerror(err));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return child_status;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
-- <br>
2.28.0.220.ged08abb693-goog<br>
<br>
</blockquote></div>

--0000000000002f6bc305af7d58f4--

--000000000000371f0805af7d58cf
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPkgYJKoZIhvcNAQcCoIIPgzCCD38CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggzsMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
--000000000000371f0805af7d58cf--

