Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE4DC34047
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A3C24654
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A3C24654
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j48z0-0001Nz-Hv
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 14:56:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j48y3-0000hG-3I
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j48y2-0007rD-0P
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:55:38 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:54007)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j48y1-0007lu-Me
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:55:37 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mr8zO-1jqBcL1vBm-00oFNf; Tue, 18 Feb 2020 20:55:31 +0100
Subject: Re: [Qemu-devel] [PATCH] configure: linux-user doesn't need neither
 fdt nor slirp
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20190621130544.18860-1-lvivier@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <25fc9e3e-9244-88fa-80ab-c0ffd95bdba0@vivier.eu>
Date: Tue, 18 Feb 2020 20:55:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20190621130544.18860-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lr4/ia5Fgn33HYE5vn9zyBcFl2vY3LjE0h5Ds/0SpnwONT0lxxj
 Qh7hN0ngjAK95F4UtFLs2E0lEkGqmH2rVtLqjXw5GRCn2km4vbgVuZNvfOSRJvqgodeTrNQ
 kqjlqhcCyQgnHWnlqYq/hQtkSlvzYXem+l+LGVPVnro9Q+WAelDj8oQ3kGlkQUO2D19QXnh
 hgDGEB2MmCMLXFMVwOAbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hTB9LtTtQXM=:9yVsdoja72+9WIu6/IVmt/
 lNJMgAo1dZWROFbpBJ4qKM9N+wBknX5aX1UFUw0Fr/Xosf1lgXtp1fg7Q1psJ5hvKz/HNo/2u
 8mB3ZNijaI6nCoe6mL5OPnDq8nGnByUZcHqSmJQEFcXQ6cKctyawgOA0ar0Ym7iTKA5YJAZ0H
 ryh5qGkiIFgYOWHkVBJNZUwGDAC5wPgxotUek54F8Ft92aVdH/rnsOubmmJgx5kKTgKrSW82/
 iy1mXFqPFsV6u/zkkf14G4rS2Cwg3TZp08ZGkC1pGMyObT/OEO8oqRMlXQI/RTXNTsQ4xRv1V
 D6NI6WxtOJR07k6eZXY2X3rRDBWX1AOjgFJmPlhqdNDzoTSwk57XoZeUF14WygEvl95KPYQda
 l+lr6tvvpZ5sZzDDKvP7aAMtiuITu10dndagqKFMjEXUfYw1zIMYShL7oTeD2wrZOBV8ci+46
 WWWL+4B/NiD9CZQ5yT1bMLCp4tsusS5+3hxtVnzRAGTbLUytup37jCuZqUAxGR1LeXxS2R6zk
 Js7Ni0rrb8qXrqbtqgwGCAwWkXC6NDmB1dCUHbmfWNrDV9sxu88B7qEVl2Wk4IZmGrcIQs7Pv
 pbCutPWT1rsvsWkleSL4lPRGzBiz9+q9CIbr3mvGx05F9Zqxt9ZqZl7iUT9JMw7hbm1px97o1
 LXxaF0gOW6X35fjRNZk70EFzMZ5fFz6E1dGDT+VBa/7EoFk8JAzmkN8DcQAmLMIz0Djt4+qWi
 Qr8S4N4F/eLosI5RYGXVgQk48yZVSHP4/62vXZn+ipwrYc8VcAt6GF2lbAwnCit5C6Ksl609Y
 fzsCorq6a32879Dp14Vnq2kmwMhpsWxsUjEa9YJjk0thtbVNX1FRRkbWhFzH/vXp0g/xqxR
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 21/06/2019 à 15:05, Laurent Vivier a écrit :
> if softmmu is not enabled, we disable by default fdt and
> slirp as they are only used by -softmmu targets.
> 
> A side effect is the git submodules are not cloned
> if they are not needed.
> 
> Clone and build can be forced with --enable-fdt and
> --enable-slirp.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  configure | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/configure b/configure
> index b091b82cb371..4b3853298c79 100755
> --- a/configure
> +++ b/configure
> @@ -4066,6 +4066,11 @@ if test "$fdt_required" = "yes"; then
>    fdt=yes
>  fi
>  
> +# linux-user doesn't need fdt
> +if test -z "$fdt" -a "$softmmu" != "yes" ; then
> +    fdt="no"
> +fi
> +
>  if test "$fdt" != "no" ; then
>    fdt_libs="-lfdt"
>    # explicitly check for libfdt_env.h as it is missing in some stable installs
> @@ -5923,6 +5928,11 @@ fi
>  ##########################################
>  # check for slirp
>  
> +# linux-user doesn't need slirp
> +if test -z "$slirp" -a "$softmmu" != "yes" ; then
> +    slirp="no"
> +fi
> +
>  case "$slirp" in
>    "" | yes)
>      if $pkg_config slirp; then
> 

I've updated the comments according to Philippe's comments and applied
it to my linux-user branch.

Thanks,
Laurent

