Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C17EC32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:34:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3DB2208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DB2208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxsUL-0001lv-2s
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 08:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hxsTi-0001Lo-9Y
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hxsTh-0001E1-1U
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:34:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37165)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hxsTg-0001Dc-Rr
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:34:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id z11so8996583wrt.4
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 05:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oB3Mkhc87yAv9HQd8Y4n68Ozj7m3+NmxrwFPH0xw3LU=;
 b=CiXw8Jw+6ULIyblsgYUaVuRDgrwPuQHq/vaRyCwhAXGXzYNf6Loa2DmQhTZNhk7XTm
 FZEzL+WVSxzBTCDAJhKPOZD1TV3AvwIUD0v1awcWGjECld2pcrnpymHzm+Wkl78hM1dj
 fkSD+6cMNNgCd2rP2/8xjiNm8lhgnKO+YRf6gyAS7m8QLnquH6e3zzGtXj6wtn2Svdc2
 BNbJ5NZHN0CpKaNOxi9T5RMtOGjigwJQa7OrucOW7TbPS5PhJUboWf6DquQ/u1OS6cCw
 K/ePXAawwtCO4fjuEQYlYwmPncQtVl0qVmEURCve/h2wbSyS4P/mZgGfyYl3OnVYd9Hu
 MBAQ==
X-Gm-Message-State: APjAAAX5+1iOpJVJc7eOeOG0bHFEYU9kng74vXSKnWDy8Kfzb0t/9IGe
 cyObdhRkXVbeFR4yVd+qifam2g==
X-Google-Smtp-Source: APXvYqzYXjmlUAw1boouKC9svBKjbWxvdyHqBeYb9g6TCcz40TmWnwkB6XaolO/Ht6bu34+vXPH08Q==
X-Received: by 2002:adf:c7c7:: with SMTP id y7mr51818513wrg.44.1565786047668; 
 Wed, 14 Aug 2019 05:34:07 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id e3sm133515747wrs.37.2019.08.14.05.34.06
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 14 Aug 2019 05:34:07 -0700 (PDT)
To: Catherine Ho <catherine.hecx@gmail.com>
References: <1554688616-18583-1-git-send-email-catherine.hecx@gmail.com>
 <1554712933-18682-1-git-send-email-catherine.hecx@gmail.com>
 <20190605183122.GJ2669@work-vm>
 <CAEn6zmE2UHuioWS-s89cBA+DMzphV5gzN+85FNsPD2WRDDzJjw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <84fa854c-621a-d54a-5e0d-45e574588fa2@redhat.com>
Date: Wed, 14 Aug 2019 14:34:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEn6zmE2UHuioWS-s89cBA+DMzphV5gzN+85FNsPD2WRDDzJjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v4] migration: do not rom_reset() during
 incoming migration
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
Cc: Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/08/19 12:40, Catherine Ho wrote:
> Hi Paolo
> Ping, is any other comment I hadn't addressed?

No, I queued the patch now.

Paolo

> Cheers
> Catherine
> 
> On Thu, 6 Jun 2019 at 02:31, Dr. David Alan Gilbert <dgilbert@redhat.com
> <mailto:dgilbert@redhat.com>> wrote:
> 
>     Paolo, can you take this one please.
> 
>     * Catherine Ho (catherine.hecx@gmail.com
>     <mailto:catherine.hecx@gmail.com>) wrote:
>     > Commit 18269069c310 ("migration: Introduce ignore-shared capability")
>     > addes ignore-shared capability to bypass the shared ramblock (e,g,
>     > membackend + numa node). It does good to live migration.
>     >
>     > As told by Yury,this commit expectes that QEMU doesn't write to
>     guest RAM
>     > until VM starts, but it does on aarch64 qemu:
>     > Backtrace:
>     > 1  0x000055f4a296dd84 in address_space_write_rom_internal () at
>     > exec.c:3458
>     > 2  0x000055f4a296de3a in address_space_write_rom () at exec.c:3479
>     > 3  0x000055f4a2d519ff in rom_reset () at hw/core/loader.c:1101
>     > 4  0x000055f4a2d475ec in qemu_devices_reset () at hw/core/reset.c:69
>     > 5  0x000055f4a2c90a28 in qemu_system_reset () at vl.c:1675
>     > 6  0x000055f4a2c9851d in main () at vl.c:4552
>     >
>     > Actually, on arm64 virt marchine, ramblock "dtb" will be filled
>     into ram
>     > druing rom_reset. In ignore-shared incoming case, this rom filling
>     > is not required since all the data has been stored in memory backend
>     > file.
>     >
>     > Further more, as suggested by Peter Xu, if we do rom_reset() now with
>     > these ROMs then the RAM data should be re-filled again too with the
>     > migration stream coming in.
>     >
>     > Fixes: commit 18269069c310 ("migration: Introduce ignore-shared
>     > capability")
>     > Suggested-by: Yury Kotov <yury-kotov@yandex-team.ru
>     <mailto:yury-kotov@yandex-team.ru>>
>     > Suggested-by: Peter Xu <peterx@redhat.com <mailto:peterx@redhat.com>>
>     > Signed-off-by: Catherine Ho <catherine.hecx@gmail.com
>     <mailto:catherine.hecx@gmail.com>>
>     > ---
>     >  hw/core/loader.c | 9 +++++++++
>     >  1 file changed, 9 insertions(+)
>     >
>     > diff --git a/hw/core/loader.c b/hw/core/loader.c
>     > index fe5cb24122..040109464b 100644
>     > --- a/hw/core/loader.c
>     > +++ b/hw/core/loader.c
>     > @@ -1087,6 +1087,15 @@ static void rom_reset(void *unused)
>     >  {
>     >      Rom *rom;
>     > 
>     > +    /*
>     > +     * We don't need to fill in the RAM with ROM data because
>     we'll fill
>     > +     * the data in during the next incoming migration in all
>     cases.  Note
>     > +     * that some of those RAMs can actually be modified by the
>     guest on ARM
>     > +     * so this is probably the only right thing to do here.
>     > +     */
>     > +    if (runstate_check(RUN_STATE_INMIGRATE))
>     > +        return;
>     > +
>     >      QTAILQ_FOREACH(rom, &roms, next) {
>     >          if (rom->fw_file) {
>     >              continue;
>     > --
>     > 2.17.1
>     >
>     --
>     Dr. David Alan Gilbert / dgilbert@redhat.com
>     <mailto:dgilbert@redhat.com> / Manchester, UK
> 


