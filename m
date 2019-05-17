Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85E5C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 17:33:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0568216C4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 17:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLEjwm3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0568216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51586 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRgjM-00045V-0Z
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 13:33:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRggH-0001t7-6O
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRgRx-0006Ic-1Q
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:15:18 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:40719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRgRw-0006H3-Q2
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:15:16 -0400
Received: by mail-ot1-x32e.google.com with SMTP id u11so7386471otq.7
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 10:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=jl8QwWq83VQ8O/x9ZouOz4adzNRWH9e4nXUan8cQ6Ec=;
	b=ZLEjwm3LXI9MBxULfIGfMcXAsxo4nAmUVjeePl9VYC45fCRak+g+eQDJQPSGGy7Lf2
	3DUOSDgWCHAN53vUm0ouO/4v8x4RLia67kBWQCEH4buPKqoYB5iT37J0RO72S2hq6HI8
	fnyeRq88yKuheYT08tFawCLHfFHOvvcdjX3JzodfEPLt8jns4c5W1us/VRnFK4fG5dIF
	8Jcawi3r4mlksJ+2sgCkqKLhkeenJJZcqL7qBvnAc/NXC7JpJ0/ty45n1hB6imfBiaex
	d+jYQWtDMviE3UvRsA72uu9k9d2NMgTsr9lGEhMgsMZ3mGIB4IZxzVwOok79ZW5Swpvp
	i1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=jl8QwWq83VQ8O/x9ZouOz4adzNRWH9e4nXUan8cQ6Ec=;
	b=CdYLDGjEkz64qtxRi8KndH62LujqwVaxif0N5EHcPENG5VVd9gTY1PnOXcXDOPavRp
	Oli4FVk3az9PL7rWRgq9fBvJy1Njn1bngsRc5yg9V9K6zK0UKGwPvf1e/gIemM9ksoAI
	L6M3486XNxtl9/KsngEF+9dTU7JeNi2tWxM09mdKl2TWI67a0w6QiSkJ7AKyS3asmiE5
	MAu3vV/5UzGbYykC/EbViY0Ew9p1RUoB2imF/fOUx4YKghksyGwN3Q02qoGwXyArOWmk
	ZCfRvslsgc8wr7HUIR7+f9SE6cL8GUZ5TorRohSKnFfy0KbRxoiYzUXicLiWMIyI5HsZ
	8LhQ==
X-Gm-Message-State: APjAAAVG/rJEgGo+1K5plmEM3y/jUvahmVWGSJjtYur+g5u2JQ+pT75Y
	u1od0a7w/tl5AkkC11FhA5ZmqwIGktJuN7f+d2SPfg==
X-Google-Smtp-Source: APXvYqyAm22/fYvXDbdFRjrGpqG9i3zItJ0LG71f1ZQCLi8sF/NEZh1v+DhDqH+YHhkTUWwydIrvf/TtiTJm2wxV8EE=
X-Received: by 2002:a9d:5608:: with SMTP id e8mr3277265oti.135.1558113315799; 
	Fri, 17 May 2019 10:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190517161241.11813-1-kraxel@redhat.com>
In-Reply-To: <20190517161241.11813-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 May 2019 18:15:04 +0100
Message-ID: <CAFEAcA_6nc+TJjfC63qyzB7cUVb5KA8bcxn0Z-7AHroG5XRZmQ@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32e
Subject: Re: [Qemu-devel] [PULL 0/4] Ui 20190517 patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 May 2019 at 17:16, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit b0f9690e78827d55a508c73432c73f057f59fd41:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-staging-pull-request' into staging (2019-05-17 10:28:23 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20190517-pull-request
>
> for you to fetch changes up to 5fff13f245cddd3bc260dfe6ebe1b1f05b72116f:
>
>   kbd-state: fix autorepeat handling (2019-05-17 13:21:40 +0200)
>
> ----------------------------------------------------------------
> ui: bugfixes for curses, opengl console and kbd state tracker.
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (1):
>   kbd-state: fix autorepeat handling
>
> HOU Qiming (1):
>   ui/console: Precautionary glBindTexture and surface->texture
>     validation in surface_gl_update_texture
>
> Samuel Thibault (2):
>   ui/curses: do not assume wchar_t contains unicode
>   ui/curses: manipulate cchar_t with standard curses functions
>
>  ui/console-gl.c |  18 +++--
>  ui/curses.c     | 190 +++++++++++++++++++++++++++++++-----------------
>  ui/kbd-state.c  |   6 +-
>  3 files changed, 140 insertions(+), 74 deletions(-)
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

