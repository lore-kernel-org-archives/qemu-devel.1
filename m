Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6B3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5247208A7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5247208A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeFkW-00036N-Qe
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 06:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jeFjq-0002hJ-RP
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:26:14 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:55601)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jeFjo-0005EV-Gg
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:26:14 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MQ6C0-1jR6b23uQy-00M4rY; Thu, 28 May 2020 12:26:01 +0200
To: chengang@emindsoft.com.cn, riku.voipio@iki.fi
References: <20200523132442.22538-1-chengang@emindsoft.com.cn>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v3] linux-user: syscall: ioctls: support DRM_IOCTL_VERSION
Message-ID: <767ce983-c676-9d0b-3167-5165ceb48262@vivier.eu>
Date: Thu, 28 May 2020 12:25:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200523132442.22538-1-chengang@emindsoft.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ki2H0vQodCzp4KsJUUKI65OVi4LjYo/fwNIns7BDK2vuNpJhsKW
 Wq7UwU3zy+C/SkfE/CzyNW19cK50Kf4/+1e03qkm5eFyDNLHqWZwYGlTBTx2UCXqUNtpK+v
 Enmpd5bhifBXNYIJD5O7+EOwFZk0YbpfWuSAEeD4JP4F/sOR5V0NY5BXv2ML/7fl2AiV+9a
 cAKd/3niM4TqZa0YAtLuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PhjNH53SNWg=:iouNPlBuqyHp+G2gE3IpXO
 CB4eZYCyf+vb2rR6VdpldS96SdRnAGQvmgQ0bSm9AJQ6g1BpUuJ1G8Z66E91eIZlc1iicQss8
 8Ubbk2wU7ARnuUy97SymbWP2SHptwz4JZx9mgZORyIjTWQG26ampfI8KJh0+MrA/LlYH9LRvq
 /q7OBXbSFIRyw0pIOBPH5rvoTlVtkHCSKlhoQGAULcyiIaIsyr5nxVJ/iIKXBquK+A9EzMJCJ
 BOB5SsmseeYNcCW8Om0aoGfAfo6G/v9KfOTHJTqihVhx49QeQ/ugNlXxBIvhEAmO1rIkKyJe4
 5y+2qwNDKAE7qNN5SABwTohhlgdGd4T90DaqLeosdp7dkmJQrWXSsY4eXZkXzSHicx3hL4ovq
 iC201+HlisOPNYjMv1eo8Fg/Fl0dvCBNIjlJYDyoNaoLsgHHQ1YO1vCmV15YJIe0DbkjzP3Ja
 Uvrr+7mz9S1deqhRy+rrrAlbMxoSFmn+HsasH8+llETap1B1P+/hC2ev+qzHdDKII7PRH7yK+
 Nzod/CzHR/Vd920NzJo/FNZm1hkzZSL0BWipN+LY1JJ6v4oFF7/Q7hravpmAi5YCmwNz1cOKc
 WF6zahRjSykrv0njXTTBbZCBGWxULg+q7eh53ZP9wCawATBvnBvz6O2A8KxxNuQa1nny/bakO
 KWe25odwCwusYM5HYczebAf0syRJpCs7HdzuEG328xluEGWsZIJw/JxpQrIVjlJhoguQ7A097
 w4WADXcNt6eWzINjH/7Lfz4r9P7wVQutndgV9AULieEmp0kCJVCxUSAjOrr5qZbieRA7Q3Kn3
 ECsX71x5bOTkZx1A2W1Ad2Zm61byjeQ+OI5MFa6UJZGX5yKbZEbcbkvPP3f2w1XDFUsVM+T
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 05:34:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 23/05/2020 à 15:24, chengang@emindsoft.com.cn a écrit :
> From: Chen Gang <chengang@emindsoft.com.cn>
> 
> Another DRM_IOCTL_* commands will be done later.
> 
> Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
> ---
>  configure                  | 18 +++++++++++
>  linux-user/ioctls.h        |  3 ++
>  linux-user/syscall.c       | 61 ++++++++++++++++++++++++++++++++++++++
>  linux-user/syscall_defs.h  | 15 ++++++++++
>  linux-user/syscall_types.h | 11 +++++++
>  5 files changed, 108 insertions(+)
> 
> diff --git a/configure b/configure
> index e225a1e3ff..2c2c489d1e 100755
> --- a/configure
> +++ b/configure
> @@ -3912,6 +3912,24 @@ EOF
>      fi
>  fi
>  
> +#########################################
> +# libdrm check
> +
> +cat > $TMPC << EOF
> +#include <libdrm/drm.h>
> +#include <sys/ioctl.h>
> +int main(void)
> +{
> +        struct drm_version version;
> +        ioctl(-1, DRM_IOCTL_VERSION, &version);
> +        return 0;
> +}
> +EOF
> +if ! compile_prog "" ; then
> +    error_exit "libdrm check failed" \
> +        "Make sure to have the libdrm/drm.h installed."
> +fi

You break the build of qemu if libdrm is not available, not a good idea.

In fact, you should only check for the include with something like
"check_include libdrm/drm.h" and then define a HAVE_DRM_H to use it
around the new code:

#ifdef HAVE_DRM_H
#include <libdrm/drm.h>
#endif

...
#ifdef HAVE_DRM_H
static inline abi_long target_to_host_drmversion(...
...
#endif
...

#ifdef HAVE_DRM_H
IOCTL_SPECIAL(DRM_IOCTL_VERSION,...
...
#endif

Thanks,
Laurent

