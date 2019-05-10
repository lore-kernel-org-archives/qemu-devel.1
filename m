Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C693AC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DBC42070D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DBC42070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46071 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP89d-00025v-NM
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:13:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hP88e-0001Cj-Nd
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hP88d-0005dT-Fr
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:12:48 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hP88d-0005cf-BS
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:12:47 -0400
Received: by mail-qk1-f196.google.com with SMTP id c14so4011863qke.3
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 09:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=O9jWEPRSdNQojQ6Xbqh2HQtr0aZwZ7qiR3MYEcuQ0qQ=;
	b=cF3j4n/mRd2kuzzYjedU9oNOSvmASr178nldb60fBKzZC2rEvHe5BvYmAdH06n4Dn/
	WVYyBun18IFjfB+SmIQcVbBmjAC8X2HisouJbKoWMPdPz3NoQrybyvgraL7neEM041AA
	E5Vj1s7i6faj4eO6sdDQbVieVBJD2DLM424AAYWuAA6XIibLr3WX0fmcckZq1AkvLKh8
	sXWLCupRCc9g5aL3k1A2E0PegpBk4LQpe058BiqVYfNzfmJA+kccpuGBaTUv8a2CuTnC
	qV3YBHDa7UvPxxy6zZMelwws7k5+BC3FWnTAJlk98LSK6zFdI/sFE0dNcBiPGSGkN1+t
	41eA==
X-Gm-Message-State: APjAAAWyXL8mIhLZryLiX/fqOyDyEnhEjH53tDvOPGLgcqPdDvvXfA72
	iQuZu2/hwSVEK6lHFOxyPauDUw==
X-Google-Smtp-Source: APXvYqyI9n2x66khrK9jdbnNtRaJCEEDGHd7I1/vtdoYldtJ6iNFG+etk1B1+S+Z+cm52f6jp2v0Jg==
X-Received: by 2002:a37:49ce:: with SMTP id w197mr9272136qka.330.1557504765892;
	Fri, 10 May 2019 09:12:45 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	n201sm2637506qka.10.2019.05.10.09.12.43
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 10 May 2019 09:12:44 -0700 (PDT)
Date: Fri, 10 May 2019 12:12:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190510121135-mutt-send-email-mst@kernel.org>
References: <20190510134203.24012-1-lvivier@redhat.com>
	<20190510134203.24012-2-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190510134203.24012-2-lvivier@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.196
Subject: Re: [Qemu-devel] [PATCH v3 1/3] VirtIO-RNG: Update default entropy
 source to `/dev/urandom`
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
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Amit Shah <amit@kernel.org>, Kashyap Chamarthy <kchamart@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
	"Richard W . M . Jones" <rjones@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 10, 2019 at 03:42:01PM +0200, Laurent Vivier wrote:
> From: Kashyap Chamarthy <kchamart@redhat.com>
> 
> When QEMU exposes a VirtIO-RNG device to the guest, that device needs a
> source of entropy, and that source needs to be "non-blocking", like
> `/dev/urandom`.  However, currently QEMU defaults to the problematic
> `/dev/random`, which is "blocking" (as in, it waits until sufficient
> entropy is available).
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

So how about just using getrandom then?

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
> index 0191ef8b1eb7..4df0ea3aed5c 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4286,7 +4286,7 @@ Creates a random number generator backend which obtains entropy from
>  a device on the host. The @option{id} parameter is a unique ID that
>  will be used to reference this entropy backend from the @option{virtio-rng}
>  device. The @option{filename} parameter specifies which file to obtain
> -entropy from and if omitted defaults to @option{/dev/random}.
> +entropy from and if omitted defaults to @option{/dev/urandom}.
>  
>  @item -object rng-egd,id=@var{id},chardev=@var{chardevid}
>  
> -- 
> 2.20.1

