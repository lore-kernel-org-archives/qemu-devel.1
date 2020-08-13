Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF06C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A322020771
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 22:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A322020771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6M8U-0004fp-Rv
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 18:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1k6LoZ-0002g1-0v; Thu, 13 Aug 2020 18:35:15 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:54617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1k6LoW-0003eZ-Ba; Thu, 13 Aug 2020 18:35:14 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MnagF-1kVHF40MQ1-00jbhZ; Fri, 14 Aug 2020 00:35:03 +0200
Subject: Re: [PATCH] nvram: Exit QEMU if NVRAM cannot contain all -prom-env
 data
To: Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>
References: <159733411975.310189.16449844820314232863.stgit@bahia.lan>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <115f9868-01af-f887-c5ba-00da3501c9f7@vivier.eu>
Date: Fri, 14 Aug 2020 00:35:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159733411975.310189.16449844820314232863.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hSjliPfRgw+TzWsVBZMsHE37mMTarEjRAxtsJq9QnoGJauq/gS7
 b6+LIIlK2LLCEcUgiG4SSmNjT0xdEe9i5P3h/P003LPiL8Kwws6UsL+nZ8VckYVPJnMEgeP
 Aq7LV+aDN09XD0aUfLLtpowAcfkkuH/ft110S81OEA3UqtlhWpERiwzChDOMYLFe1pNs+SB
 7nrCatBUFqJtvOJttKNxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6Ag26ud2oLk=:9r1pi/b+7smvnfYcKqhLPg
 jsNu6k3BYEcH4cgUbNnGQS4kgn1R5n8ZBeBu5yPLAyypLXZOCFhxwvUW96yM0gC9qUD/eNNFI
 o98BbKg77XQuyggmmLhwcA6JESEwfofKkdD1mWs5G4r0ekipkwk+RtwrzEPk8JedvjNC2/xGh
 C4zCiJVlsc9aWkd4v22Ff5r1SDcnvMXlGGOv+8yub0qYQhdwcjDX0BNUMnimzVbCACI8m1mLg
 vR7an08VdLvMWVd3DwuGIAgAj+on7e5mF4BrbE6AikD7gwIMUH+qvsKBhIjMAYBUjfxrktu3l
 o7VyD48hWYaIHX63sXoY3EDb3yPeqvK5XxLr1IQ3i5YZ0u4gZDktlAlpWUq7Cm8rnRhte9Oxv
 P2vKOXqTQfqBE+Pf12PZGCnnMK/fYM11mnp954scFDTRdf3Ev3Px/dwuuex8eJogl0gSJBVEV
 BJfGpuhkktCQf72VTHnwuN00Pvg9ptZswNINchovfRFmjyOjsh5BPegzO4Yao1fVzQ0JygVZz
 ixIXwzFVHMFRCmywcF1ezMGF4s8xbhlS/bIO3OuA7UDTitlg2jisYnYeH/Da35eIhj/Ii6Zq6
 pRGZlEKqC9/+F8alvBNVtswkp6777u/SsBmh6EryW2m96gr/Jx8QHo+K3ONq6/OoYf2vlkzKl
 XfPPTi5u+YEpMkdUUU9CfTKnPZb0+gViaqakblx9B9vDkxS8bb/ppwkXawCUxwZP8RYGvJv6y
 hKtu4JzF5bLh+7HBrBUBnZRcRaIg9nVKU494xnAsX2BdVVIaWp4lj/n2pBFwtIuteW/4rv8bD
 Ht4iyBZPWvWzBZcBjCUs5eL3Ia1KqUNVPSeFyvCC3yqYv0bEvH4w5B9i0zLBeIEUQr4E0PB
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 18:35:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 13/08/2020 à 17:55, Greg Kurz a écrit :
> Since commit 61f20b9dc5b7 ("spapr_nvram: Pre-initialize the NVRAM to
> support the -prom-env parameter"), pseries machines can pre-initialize
> the "system" partition in the NVRAM with the data passed to all -prom-env
> parameters on the QEMU command line.
> 
> In this case it is assumed that all the data fits in 64 KiB, but the user
> can easily pass more and crash QEMU:
> 
> $ qemu-system-ppc64 -M pseries $(for ((x=0;x<128;x++)); do \
>   echo -n " -prom-env " ; printf "%0.sx" {1..1024}; \
>   done) # this requires ~128 Kib
> malloc(): corrupted top size
> Aborted (core dumped)
> 
> This happens because we don't check if all the prom-env data fits in
> the NVRAM and chrp_nvram_set_var() happily memcpy() it passed the
> buffer.
> 
> This crash affects basically all ppc/ppc64 machine types that use -prom-env:
> - pseries (all versions)
> - g3beige
> - mac99
> 
> and also sparc/sparc64 machine types:
> - LX
> - SPARCClassic
> - SPARCbook
> - SS-10
> - SS-20
> - SS-4
> - SS-5
> - SS-600MP
> - Voyager
> - sun4u
> - sun4v
> 
> Add a max_len argument to chrp_nvram_create_system_partition() so that
> it can check the available size before writing to memory.
> 
> Since NVRAM is populated at machine init, it seems reasonable to consider
> this error as fatal. So, instead of reporting an error when we detect that
> the NVRAM is too small and adapt all machine types to handle it, we simply
> exit QEMU in all cases. This is still better than crashing. If someone
> wants another behavior, I guess this can be reworked later.
> 
> Tested with:
> 
> $ yes q | \
>   (for arch in ppc ppc64 sparc sparc64; do \
>        echo == $arch ==; \
>        qemu=${arch}-softmmu/qemu-system-$arch; \
>        for mach in $($qemu -M help | awk '! /^Supported/ { print $1 }'); do \
>            echo $mach; \
>            $qemu -M $mach -monitor stdio -nodefaults -nographic \
>            $(for ((x=0;x<128;x++)); do \
>                  echo -n " -prom-env " ; printf "%0.sx" {1..1024}; \
>              done) >/dev/null; \
>         done; echo; \
>    done)
> 
> Without the patch, affected machine types cause QEMU to report some
> memory corruption and crash:
> 
> malloc(): corrupted top size
> 
> free(): invalid size
> 
> *** stack smashing detected ***: terminated
> 
> With the patch, QEMU prints the following message and exits:
> 
> NVRAM is too small. Try to pass less data to -prom-env
> 
> It seems that the conditions for the crash have always existed, but it
> affects pseries, the machine type I care for, since commit 61f20b9dc5b7
> only.
> 
> Fixes: 61f20b9dc5b7 ("spapr_nvram: Pre-initialize the NVRAM to support the -prom-env parameter")
> RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=1867739
> Reported-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> 
> This replaces the following series:
> 
> [PATCH v2 0/2] spapr/nvram: Fix QEMU crash
> http://patchwork.ozlabs.org/project/qemu-devel/list/?series=195269
> ---
>  hw/nvram/chrp_nvram.c         |   24 +++++++++++++++++++++---
>  hw/nvram/mac_nvram.c          |    2 +-
>  hw/nvram/spapr_nvram.c        |    3 ++-
>  hw/sparc/sun4m.c              |    2 +-
>  hw/sparc64/sun4u.c            |    2 +-
>  include/hw/nvram/chrp_nvram.h |    3 ++-
>  6 files changed, 28 insertions(+), 8 deletions(-)
> 
...
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 9be930415f8e..7d791ee82368 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -143,7 +143,7 @@ static void nvram_init(Nvram *nvram, uint8_t *macaddr,
>      memset(image, '\0', sizeof(image));
>  
>      /* OpenBIOS nvram variables partition */
> -    sysp_end = chrp_nvram_create_system_partition(image, 0);
> +    sysp_end = chrp_nvram_create_system_partition(image, 0, sizeof(image));
>  
>      /* Free space partition */
>      chrp_nvram_create_free_partition(&image[sysp_end], 0x1fd0 - sysp_end);

It seems the max size of the system partition is 0x1fd0, not sizeof(image).

> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 9e30203dcc44..bd0a6283f339 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -136,7 +136,7 @@ static int sun4u_NVRAM_set_params(Nvram *nvram, uint16_t NVRAM_size,
>      memset(image, '\0', sizeof(image));
>  
>      /* OpenBIOS nvram variables partition */
> -    sysp_end = chrp_nvram_create_system_partition(image, 0);
> +    sysp_end = chrp_nvram_create_system_partition(image, 0, sizeof(image));
>  
>      /* Free space partition */
>      chrp_nvram_create_free_partition(&image[sysp_end], 0x1fd0 - sysp_end);

ditto

All the other changes seem good.

With the sizeof(image) fixed:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>



