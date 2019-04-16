Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEE8C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 01:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C83F20854
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 01:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkrOWE7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C83F20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57896 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGDCP-0002e6-J7
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 21:47:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hGDBZ-0002NK-Jj
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:46:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <catherine.hecx@gmail.com>) id 1hGDBY-0003rR-Fv
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:46:57 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <catherine.hecx@gmail.com>)
	id 1hGDBY-0003r1-6Q
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:46:56 -0400
Received: by mail-ot1-x344.google.com with SMTP id f10so16234917otb.6
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 18:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=elLHJTsvyL8/Wb2FluGWteuq/k7sF8k2TIdO/jmcxh0=;
	b=FkrOWE7OuBRSJYROUUQO0TDXMUCp2Vn+w95TEDLFexs1+Bf7sdSUwaX21LQRQSMB3Q
	pl7E1K2h3BaD/xNbfwwW/5IGz5JfO2tScbNmaZZVfkHj4Z5yCqaXs62T1UjByl8yQotf
	KQ2FJ1iAa/0tZsBCBjqmIj+mxZvV1pOCQD+VUFbamiQx8aTZCGn0jFB1VBS6fn7i3jb5
	QRAI6zDNLnQeV6JoUwP8/DN30XpsrIPmd+9pFVWGSyz/fQrY7OXEwbaaBEHFDZmwPIHg
	OzVxJuKti6NayU7wWmfe71CkZXd+ZuDmgy/psaxGg9PWR7EzPxGOon/ikCJ6wGkZe2V7
	fyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=elLHJTsvyL8/Wb2FluGWteuq/k7sF8k2TIdO/jmcxh0=;
	b=cKkQhhk3I6T5dkMFUW4vSlC2OqWcYqHqYy7qjSs38ug6ruCUUqE+vt4K1sJ3Siqi4T
	KXMx1WmVLTSDMtsbvSPOicaCLUBuVqpTj6rb2vS8Ma7FYNbAUvfYKXU+Zy0PQzVrO4z/
	evU/S43kUCattREJ0AA7ePck5rXWMiL73z9fOIvQVtIYavNVle2DbNhbNjXtxyNbfomY
	REEkHcJu+AmhzvzKlab3ezDd6VaJn7ssT6KR6UCof/Th3+f5/DHc/qcr09Smd0onsaJm
	4TaiumKU1hmxL08hTNlieXogFPNja7SF3V7zFjBC5B5jRIDg8Q2/Y7Jk9jW+A1EPsXy2
	oAew==
X-Gm-Message-State: APjAAAUJjQYo6q2Sy791NNtOx95+glg6xLbFy7uvCE9u4v8ElNTRKNzH
	LgnOqfpscoa638GybOLHBJ4y0Q2lo4GR9xRcQ7s=
X-Google-Smtp-Source: APXvYqzEjGHWQbzrJu6IGS0xdXH37jBuEn3d53FelVxtNMRilKSKUaFpfe6AXG1XpB7z3TSX62FDoLilJs6QMCmIqtI=
X-Received: by 2002:a05:6830:51:: with SMTP id
	d17mr46800644otp.178.1555379213669; 
	Mon, 15 Apr 2019 18:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <1554688616-18583-1-git-send-email-catherine.hecx@gmail.com>
	<1554712933-18682-1-git-send-email-catherine.hecx@gmail.com>
In-Reply-To: <1554712933-18682-1-git-send-email-catherine.hecx@gmail.com>
From: Catherine Ho <catherine.hecx@gmail.com>
Date: Tue, 16 Apr 2019 09:46:40 +0800
Message-ID:
 <CAEn6zmE-QJh260_Se7ygQdWyQ_jObViJ5173ErU3Z+ECF2=9YQ@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416014640.n_3Py-Ix36qzDaNV3dinWvymfVMGbTh88xkf7Eoax7c@z>

Ping, thanks

B.R.
Catherine

On Mon, 8 Apr 2019 at 16:43, Catherine Ho <catherine.hecx@gmail.com> wrote:

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
> +     * that some of those RAMs can actually be modified by the guest on
> ARM
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
>
