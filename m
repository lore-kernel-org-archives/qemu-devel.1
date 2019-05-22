Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0404C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:47:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93AE420881
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93AE420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46356 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTTSi-0004Rp-Qs
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 11:47:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTM7-0006e9-JX
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTT9Q-0008SR-DO
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:27:33 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:56771)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hTT9Q-0008N1-3Q; Wed, 22 May 2019 11:27:32 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1N6svJ-1gZh6f354B-018Gru; Wed, 22 May 2019 17:27:10 +0200
To: Li Qiang <liq3ea@163.com>, alex.williamson@redhat.com, lvivier@redhat.com
References: <20190521151543.92274-1-liq3ea@163.com>
	<20190521151543.92274-4-liq3ea@163.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <29b405ff-b73c-af05-11ca-086338713e64@vivier.eu>
Date: Wed, 22 May 2019 17:27:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190521151543.92274-4-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+IjbU3nAF4sELYJG69JIK/gqVQN6oceL9m1+VL3MCoENd2LNtYy
	FP1kbtUjPFOe8ak8uciYjRBUy6QqqhNVB1fxHCuWKfVF+U0MeZxOvHmRRWvNNVZJXeSEp4l
	nDpoXgBLJHtfJXF1+VCbSXRpIi1SQkmq63Vz5Not3ukZGwAywX9yZ3m8DE8u2JmnrmDop8d
	KFgzdXOM1osjAk2qhUm1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0iA2R0aZ4Jg=:ilpz9MEWUfquIERcu7FVyf
	z0rcbQmRkRhMicfvLQ9WlCBCZI6a5EusANLEyZSYjgF6AhY6ITsQ/Z/hdb5SllxvU8eYEn0MP
	hjLa6GtYo9+kcAggBgpdZ/Fwf+/8/pQ2UHhWQX3fihJi11hHEnG7h+MmvO/f1agWg963lx7e0
	6HCNf7cS4kVs+QNATzdZAve6L6G+EjQNh+7uE+Z2woD6sQseGkVsXcoDvTtWL1xstM/uDSnZC
	rryPonrI1faYnLyInzcbiUoApUPM9Pxeft+HqLOq9dGNAwYPDWQ3yvosjdPXmquyCZN1kDc76
	l4ztGracijpQLlH/FoYtGMef6A5kTF1eEIF47Qa+IsTlESsBBR7ydpD003EVKc63Iq3PILWiR
	WATkGogba5s1QuIkIhYUnxT9hbYZCK7kFsMFoYvob18TNGJoXcLaMND2FIpFmNYdEWGiF8Dug
	+Wl4K+6NGF9QkfKAwwL1deZQXTpqETmiFis8WoyZAuR9A33z4zbhuLL0aZC3zV6lhTkuGN+TV
	2hp7cB2nuGVq+ms3q695Lcpoz+5cKGBQbSTZhuUKvz+DNaAzVXR62Ek+awVxqfE6Q++Y8tUYX
	emwSyIdu0OT8LVxOh+GkongKZCS8SIPk4HFvRKV0THriGPWIUzBad4sASxADK1iXh97vxXO2n
	3+SwfnADVihVkOjysQEEEjZ/CurlE37fXNkARNPl3GvK0LafOw8vUVKfZWSqXRyYunPw5ubQ1
	gpu71VpnKcA/cA9ZpuCw7UPPYj8X5D2gdlkaV46xdsENqmC+7qs3/+Kcf5Y=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2 3/4] vfio: platform: fix
 a typo
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
Cc: qemu-trivial@nongnu.org, liq3ea@gmail.com, philmd@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/05/2019 17:15, Li Qiang wrote:
> 'eventd' should be 'eventfd'.
> 
> CC: qemu-trivial@nongnu.org
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>   hw/vfio/platform.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index e59a0234dd..d52d6552e0 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -72,7 +72,7 @@ static VFIOINTp *vfio_init_intp(VFIODevice *vbasedev,
>           g_free(intp->interrupt);
>           g_free(intp);
>           error_setg_errno(errp, -ret,
> -                         "failed to initialize trigger eventd notifier");
> +                         "failed to initialize trigger eventfd notifier");
>           return NULL;
>       }
>       if (vfio_irq_is_automasked(intp)) {
> @@ -84,7 +84,7 @@ static VFIOINTp *vfio_init_intp(VFIODevice *vbasedev,
>               g_free(intp->unmask);
>               g_free(intp);
>               error_setg_errno(errp, -ret,
> -                             "failed to initialize resample eventd notifier");
> +                             "failed to initialize resample eventfd notifier");
>               return NULL;
>           }
>       }
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

