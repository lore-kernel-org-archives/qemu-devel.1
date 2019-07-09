Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB46C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 05:51:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B26D20861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 05:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B26D20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkj2T-0005PQ-0M
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 01:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53306)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hkj1b-0004w4-2W
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 01:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hkj1a-0007Py-1E
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 01:50:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57120)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hkj1Z-0007Pc-SA
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 01:50:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C71013099FC5;
 Tue,  9 Jul 2019 05:42:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EFFD5C2F1;
 Tue,  9 Jul 2019 05:42:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3F10A1138648; Tue,  9 Jul 2019 07:42:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1534182832-554-5-git-send-email-aleksandar.markovic@rt-rk.com>
 <4da49ffe-902f-2cf2-8a21-2bbd511b17a4@weilnetz.de>
 <CAFEAcA8fW0odS4pT9XNWoti7PM6TpdJ06o=43vmdRBArNM=iuw@mail.gmail.com>
Date: Tue, 09 Jul 2019 07:42:01 +0200
In-Reply-To: <CAFEAcA8fW0odS4pT9XNWoti7PM6TpdJ06o=43vmdRBArNM=iuw@mail.gmail.com>
 (Peter Maydell's message of "Mon, 8 Jul 2019 09:42:31 +0100")
Message-ID: <87zhlnahna.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 09 Jul 2019 05:42:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Handling of fall through code (was: [PATCH v8
 04/87] target/mips: Mark switch fallthroughs with interpretable comments
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Stefan Markovic <smarkovic@wavecomp.com>, Stefan Weil <sw@weilnetz.de>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philippe.mathieu.daude@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Petar Jovanovic <pjovanovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Sun, 7 Jul 2019 at 21:26, Stefan Weil <sw@weilnetz.de> wrote:
>> This is a general problem all over the QEMU code. I usually compile with
>> nearly all warnings enabled and get now lots of errors with the latest
>> code and after updating to gcc-8.3.0 (Debian buster). It should be
>> reproducible by enabling -Werror=implicit-fallthrough.
>
> Coverity warns about implicit fallthroughs, and we are
> currently warning-free in that department, so I think
> our remaining problems are largely down to perhaps
> using idioms which the compiler doesn't spot.
> Being able to enable gcc implicit-fallthrough errors would
> definitely be better than spotting them only after the
> fact with Coverity.
>
>> I suggest to enable -Werror=implicit-fallthrough by default and add a
>> new macro to mark all fallthrough locations which are correct, but not
>> accepted by the compiler.
>
> I'm not sure why we need a macro. Our standard way to
> mark fallthrough is /* fall through */, which has hundreds
> of uses in the codebase. -Wimplicit-fallthrough=2 will match this,
> so it seems simpler to just use that rather than to rework
> how we mark fallthroughs.
>
> Since vixl is 3rd-party code it might be easier to just
> add -Wno-implicit-fallthrough to the cflags that
> disas/libvixl/Makefile.objs sets up for building those files.
> (We should check also for newer libvixl and/or suggest
> something upstream that works with gcc.)

Concur.

