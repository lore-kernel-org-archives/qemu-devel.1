Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C54C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 15:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E0DB20663
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 15:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0DB20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJfud-0000I5-9J
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 11:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <samuel.thibault@gnu.org>) id 1iJftV-0007mU-CE
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 11:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <samuel.thibault@gnu.org>) id 1iJftU-0003n7-Bs
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 11:34:53 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:42642)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <samuel.thibault@gnu.org>)
 id 1iJftU-0003my-4p
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 11:34:52 -0400
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 75BB7176A;
 Sun, 13 Oct 2019 17:34:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ot_beCGA1eJB; Sun, 13 Oct 2019 17:34:45 +0200 (CEST)
Received: from function (unknown [IPv6:2a01:cb19:979:800:9eb6:d0ff:fe88:c3c7])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id C3CEA1765;
 Sun, 13 Oct 2019 17:34:45 +0200 (CEST)
Received: from samy by function with local (Exim 4.92.2)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1iJftN-0006ti-Cf; Sun, 13 Oct 2019 17:34:45 +0200
Date: Sun, 13 Oct 2019 17:34:45 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Matthew Kilgore <mattkilgore12@gmail.com>
Subject: Re: [PATCH v2 2/2] curses: correctly pass the color pair to setcchar()
Message-ID: <20191013153445.2n62uokrvhdd7jo4@function>
References: <20191004035338.25601-1-mattkilgore12@gmail.com>
 <20191004035338.25601-3-mattkilgore12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004035338.25601-3-mattkilgore12@gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 185.233.100.1
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Matthew Kilgore, le jeu. 03 oct. 2019 23:53:38 -0400, a ecrit:
> The current code does not correctly pass the color pair information to
> setcchar(), it instead always passes zero. This results in the curses
> output always being in white on black.
> 
> This patch fixes this by using PAIR_NUMBER() to retrieve the color pair
> number from the chtype value, and then passes that value as an argument
> to setcchar().
> 
> Signed-off-by: Matthew Kilgore <mattkilgore12@gmail.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Tested-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Thanks!

> ---
>  ui/curses.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/ui/curses.c b/ui/curses.c
> index 84003f56a323..3a1b71451c93 100644
> --- a/ui/curses.c
> +++ b/ui/curses.c
> @@ -77,12 +77,14 @@ static void curses_update(DisplayChangeListener *dcl,
>          for (x = 0; x < width; x++) {
>              chtype ch = line[x] & A_CHARTEXT;
>              chtype at = line[x] & A_ATTRIBUTES;
> +            short color_pair = PAIR_NUMBER(line[x]);
> +
>              ret = getcchar(&vga_to_curses[ch], wch, &attrs, &colors, NULL);
>              if (ret == ERR || wch[0] == 0) {
>                  wch[0] = ch;
>                  wch[1] = 0;
>              }
> -            setcchar(&curses_line[x], wch, at, 0, NULL);
> +            setcchar(&curses_line[x], wch, at, color_pair, NULL);
>          }
>          mvwadd_wchnstr(screenpad, y, 0, curses_line, width);
>      }
> -- 
> 2.23.0
> 

-- 
Samuel
<macavity> bash: ls: Computer bought the farm
<macavity> THAT frightens ppl! :P
<macavity> id rather see: "bash: ls: Initialization of googol(AWAX)
        disengaged in HYPER32/64 mode due to faulty page request at
        AX:12A34F84B"
<macavity> at least that would give me the feeling that the
        *programmers* knows what is going on :P
(lovely Hurd...)

