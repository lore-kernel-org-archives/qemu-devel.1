Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244D3C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 14:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B397721850
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 14:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B397721850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36355 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1higFn-0004YL-Pl
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 10:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54931)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1higDn-0002pQ-GV
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1higDk-0004C3-UB
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:26:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34493)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1higDk-0004BG-Nv
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 10:26:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so3059224wmd.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 07:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tgzX6rVVnyCLSC+wuKjcQaxmaXkMZpLr50XLNOBJxlM=;
 b=DeGLScpdkKm9KOuK6Po5XfIZt7MnPKVYeeX62WgfQTzuNWEGYpvOUxO8RRS0lB//gL
 NzRLWJjqUFbSrkM0n+xXIer4dH5Tj6frgm5HmnZPwf+DxHF23lOjhl29E7qo87Mct2aL
 rzV8D9RuLgMq+oqKZifKXNaAkHQF0XKyedmVti8S7hwWZ/hC4bGf+QJEebYXJ6MUUH4F
 VPHp7R3wEE/itD4fNxK2nH1H7SirJchwK1M2fe6SlRNuFdFZ39BzFWchsLgaPh2fTOFh
 9gEBYjakCdaVvqqiveLJoZ6r2+eEB/QUbw6qREY5kwCfsop45LjGkuqZL1uIsU62k5ot
 SQnw==
X-Gm-Message-State: APjAAAUXOctmSkmvBa717jfTBVfpfl+wBvVxFyxUzxvy5y+QUeJcEjYo
 TlVLJyM4M7XAT1PUszi0xQgdKg==
X-Google-Smtp-Source: APXvYqxppswujj3dwOCuF2TSXYE27T/rUbB+9Hc/8NzQMVe4KJVo7ChsVjsT6jCnPL8+1ZsAvW7NGQ==
X-Received: by 2002:a1c:a842:: with SMTP id r63mr8255782wme.117.1562164011713; 
 Wed, 03 Jul 2019 07:26:51 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id 60sm4789488wrc.68.2019.07.03.07.26.50
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 07:26:51 -0700 (PDT)
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20190529143106.11789-1-lvivier@redhat.com>
 <20190529143106.11789-2-lvivier@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a7b460f1-c927-748e-e75b-1d1ea5059701@redhat.com>
Date: Wed, 3 Jul 2019 16:26:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529143106.11789-2-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v7 1/4] VirtIO-RNG: Update default entropy
 source to `/dev/urandom`
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
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Amit Shah <amit@kernel.org>, Kashyap Chamarthy <kchamart@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/19 4:31 PM, Laurent Vivier wrote:
> From: Kashyap Chamarthy <kchamart@redhat.com>
> 
> When QEMU exposes a VirtIO-RNG device to the guest, that device needs a
> source of entropy, and that source needs to be "non-blocking", like
> `/dev/urandom`.  However, currently QEMU defaults to the problematic
> `/dev/random`, which on Linux is "blocking" (as in, it waits until
> sufficient entropy is available).
> 
> Why prefer `/dev/urandom` over `/dev/random`?
> ---------------------------------------------
> 
> The man pages of urandom(4) and random(4) state:
> 
>     "The /dev/random device is a legacy interface which dates back to a
>     time where the cryptographic primitives used in the implementation
>     of /dev/urandom were not widely trusted.  It will return random
>     bytes only within the estimated number of bits of fresh noise in the
>     entropy pool, blocking if necessary.  /dev/random is suitable for
>     applications that need high quality randomness, and can afford
>     indeterminate delays."
> 
> Further, the "Usage" section of the said man pages state:
> 
>     "The /dev/random interface is considered a legacy interface, and
>     /dev/urandom is preferred and sufficient in all use cases, with the
>     exception of applications which require randomness during early boot
>     time; for these applications, getrandom(2) must be used instead,
>     because it will block until the entropy pool is initialized.
> 
>     "If a seed file is saved across reboots as recommended below (all
>     major Linux distributions have done this since 2000 at least), the
>     output is cryptographically secure against attackers without local
>     root access as soon as it is reloaded in the boot sequence, and
>     perfectly adequate for network encryption session keys.  Since reads
>     from /dev/random may block, users will usually want to open it in
>     nonblocking mode (or perform a read with timeout), and provide some
>     sort of user notification if the desired entropy is not immediately
>     available."
> 
> And refer to random(7) for a comparison of `/dev/random` and
> `/dev/urandom`.
> 
> What about other OSes?
> ----------------------
> 
> `/dev/urandom` exists and works on OS-X, FreeBSD, DragonFlyBSD, NetBSD
> and OpenBSD, which cover all the non-Linux platforms we explicitly
> support, aside from Windows.
> 
> On Windows `/dev/random` doesn't work either so we don't regress.
> This is actually another argument in favour of using the newly
> proposed 'rng-builtin' backend by default, as that will work on
> Windows.
> 
>     - - -
> 
> Given the above, change the entropy source for VirtIO-RNG device to
> `/dev/urandom`.
> 
> Related discussion in these[1][2] past threads.
> 
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg08335.html
>     -- "RNG: Any reason QEMU doesn't default to `/dev/urandom`?"
> [2] https://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02724.html
>     -- "[RFC] Virtio RNG: Consider changing the default entropy source to
>        /dev/urandom"
> 
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  backends/rng-random.c | 2 +-
>  qemu-options.hx       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/backends/rng-random.c b/backends/rng-random.c
> index e2a49b0571d7..eff36ef14084 100644
> --- a/backends/rng-random.c
> +++ b/backends/rng-random.c
> @@ -112,7 +112,7 @@ static void rng_random_init(Object *obj)
>                              rng_random_set_filename,
>                              NULL);
>  
> -    s->filename = g_strdup("/dev/random");
> +    s->filename = g_strdup("/dev/urandom");
>      s->fd = -1;
>  }
>  
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 39dc17042967..f6e9bd1d9c42 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4328,7 +4328,7 @@ Creates a random number generator backend which obtains entropy from
>  a device on the host. The @option{id} parameter is a unique ID that
>  will be used to reference this entropy backend from the @option{virtio-rng}
>  device. The @option{filename} parameter specifies which file to obtain
> -entropy from and if omitted defaults to @option{/dev/random}.
> +entropy from and if omitted defaults to @option{/dev/urandom}.
>  
>  @item -object rng-egd,id=@var{id},chardev=@var{chardevid}
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

