Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C83C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:48:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51FBA2146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FBA2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiDWi-0000yu-9F
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 03:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46704)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hiDVN-0000F9-ON
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 03:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hiDVM-0006yp-D6
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 03:47:09 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:55603)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hiDVM-0006yN-2t
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 03:47:08 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MHXWL-1hmOPV2oUr-00DXUU; Tue, 02 Jul 2019 09:41:32 +0200
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20190529143106.11789-1-lvivier@redhat.com>
 <20190529143106.11789-2-lvivier@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <af09f9ab-1852-f171-5dc6-3d36348395d7@vivier.eu>
Date: Tue, 2 Jul 2019 09:41:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529143106.11789-2-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:E2Dk+MtF0A4TPXd/oTO3DmqKBTiNksyrr8aznCUIGrOTRIUPA0E
 qFaaNyGdNGshWz+xLt9JE0kj0XcfkAK+24DUqMWAyRO2eZS+EFg3fgU6cn9aJCR7zmfdNvJ
 uIbmmNeO3JcgaWmxy5B/6qAFyTpn7OO4zuniTTUV7mceCsNhenFOGwiLkHhNanbMdjW9x7L
 BLh+EqVQbba/0BvC8g/ZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LJy4myH/Uh8=:yXwvup6ZKCgksG9xT8KyR6
 XUB/v7V433hMpJJHqvUdo7rWnRkgeb0lPI1jriQfFWFx2IGkwFu528ZCvNgZc9RBqU+rFOTn0
 JXmj9xLu1zfqkiWeX5lgKotE32kmucbnS5KFrvZPg+PY7CmrnOjt6Dhrmq75wDi+JsvZcuX+9
 OPclV9cYTIqjTdLi4tDy6esLsc+CvWzwyQeQTHfCTKzbacKrsqvxeP16cNH587fkp3PcJmEmm
 mZ/9mpE10zgUiuZ7vYL3x5TK33xUGFP3Imv2o4HGlk18nes72e2C06CxnXiTmBJrEfmDHZxLn
 p+do7gauJ5dD4F/9nFmMWDilUo+X7r565biMgKZhAPbVRs+oHNJS3bC7rGBc+wx1ytZ4u+RA0
 j70lTdz/SqjPxV2BXCEPU4TjPhPu+7okBG9h9egyWzeKmuQPwiZLAFRAeOwq4b6/ZvXaFdQS0
 LQ3fnIqOrcpaa4uLdQd/zTRAMq8x4raq2ODDN1p8slIfhPHGtEdXTL2i5gp8Gb8Cps+ouPsst
 AbD0FC+tCh2RV7DCxHOcABUrI3G5etD6zc4j9Y3F4D/wrh8e+3SUJRaBDdbyloCzCn40lK5w1
 CDMc9UHUEWEY8hZXKWhurIQuhzL36hQuKqsSdjpTR2lSgV5RXtXwqvF+WOKITICtmA0IQXCLf
 e8euRX3Cbv7lcJO80thochlp2Ziwu8+LO6NWAzzVuyod5qATYsVrGOKsltjPsBD+BXAAROZHM
 cV9uZ1tAvK8GovbKfrJsfOMShvfVW7/13YfkJNwEjoqNcwELqv2Iti0EklE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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
 Amit Shah <amit@kernel.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 29/05/2019 à 16:31, Laurent Vivier a écrit :
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

As this patch is trivial and reviewed by at least 3 persons, and it
seems no one wants to take care of it, I will push it through my next
trivial pull request.

Thanks,
Laurent

