Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB3EC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 18:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09056206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 18:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09056206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48261 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYaoL-0003nG-6t
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 14:38:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hYami-0002dD-BV
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 14:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hYah9-000111-5H
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 14:31:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hYah8-0000zh-WA
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 14:31:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD3442F8BCD;
	Wed,  5 Jun 2019 18:31:29 +0000 (UTC)
Received: from work-vm (ovpn-117-13.ams2.redhat.com [10.36.117.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FABD60BC3;
	Wed,  5 Jun 2019 18:31:24 +0000 (UTC)
Date: Wed, 5 Jun 2019 19:31:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190605183122.GJ2669@work-vm>
References: <1554688616-18583-1-git-send-email-catherine.hecx@gmail.com>
	<1554712933-18682-1-git-send-email-catherine.hecx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554712933-18682-1-git-send-email-catherine.hecx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Wed, 05 Jun 2019 18:31:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4] migration: do not rom_reset() during
 incoming migration
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
	Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	Catherine Ho <catherine.hecx@gmail.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo, can you take this one please.

* Catherine Ho (catherine.hecx@gmail.com) wrote:
> Commit 18269069c310 ("migration: Introduce ignore-shared capability")
> addes ignore-shared capability to bypass the shared ramblock (e,g,
> membackend + numa node). It does good to live migration.
> 
> As told by Yury,this commit expectes that QEMU doesn't write to guest RAM
> until VM starts, but it does on aarch64 qemu:
> Backtrace:
> 1  0x000055f4a296dd84 in address_space_write_rom_internal () at
> exec.c:3458
> 2  0x000055f4a296de3a in address_space_write_rom () at exec.c:3479
> 3  0x000055f4a2d519ff in rom_reset () at hw/core/loader.c:1101
> 4  0x000055f4a2d475ec in qemu_devices_reset () at hw/core/reset.c:69
> 5  0x000055f4a2c90a28 in qemu_system_reset () at vl.c:1675
> 6  0x000055f4a2c9851d in main () at vl.c:4552
> 
> Actually, on arm64 virt marchine, ramblock "dtb" will be filled into ram
> druing rom_reset. In ignore-shared incoming case, this rom filling
> is not required since all the data has been stored in memory backend
> file.
> 
> Further more, as suggested by Peter Xu, if we do rom_reset() now with
> these ROMs then the RAM data should be re-filled again too with the
> migration stream coming in.
> 
> Fixes: commit 18269069c310 ("migration: Introduce ignore-shared
> capability")
> Suggested-by: Yury Kotov <yury-kotov@yandex-team.ru>
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
> ---
>  hw/core/loader.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index fe5cb24122..040109464b 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -1087,6 +1087,15 @@ static void rom_reset(void *unused)
>  {
>      Rom *rom;
>  
> +    /*
> +     * We don't need to fill in the RAM with ROM data because we'll fill
> +     * the data in during the next incoming migration in all cases.  Note
> +     * that some of those RAMs can actually be modified by the guest on ARM
> +     * so this is probably the only right thing to do here.
> +     */
> +    if (runstate_check(RUN_STATE_INMIGRATE))
> +        return;
> +
>      QTAILQ_FOREACH(rom, &roms, next) {
>          if (rom->fw_file) {
>              continue;
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

