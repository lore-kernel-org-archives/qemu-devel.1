Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CFBC3F2D7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:18:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EAAA207FD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="gLHtUEHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EAAA207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=comstyle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9u8g-0006yS-Dp
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 12:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <brad@comstyle.com>) id 1j9u7P-0005M0-8B
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:17:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brad@comstyle.com>) id 1j9u7O-0008II-2v
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:17:07 -0500
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]:23142
 helo=mail.comstyle.com) by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <brad@comstyle.com>) id 1j9u7N-00089Y-QP
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:17:06 -0500
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 48YHHr4k0Qz8Pb1;
 Thu,  5 Mar 2020 12:07:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=comstyle.com; h=subject:to
 :references:from:message-id:date:mime-version:in-reply-to
 :content-type:content-transfer-encoding; s=selector1; bh=gS0lXuQ
 WV3HlXHFIDK3tCbRvBb4=; b=gLHtUEHVzxWGzwlx8WoDUCbGks+OW7no2Rx/7yf
 0Q1v/moMeYz1LRnT2hA9IqbT13OBkwA0MTQkWByNoGGa3NbmhAoJ/VPlP/GNhECM
 xtCU+4rw10ZN9rKpgSI/TTa840WXMhoCaCUWSsAEyfvP2pud3mhy7MrpGbtunlrC
 7I/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=subject:to
 :references:from:message-id:date:mime-version:in-reply-to
 :content-type:content-transfer-encoding; q=dns; s=selector1; b=R
 4x3aOn6JYMHE8+oTdazp9/zdJbtaCmsS7Sy5QUeGlK96OODBasNHhHHo52uqDKvK
 mvUQ3htlHZf7+lVKgxE4g1uK7DgKQ2UK3uTmJZTixrhBIYhLqWLW67X8DF5JPyv5
 ++nEW3APtBXDNAw8W1bgpMfUKAAv+/Wl2dUa0A1/j4=
Received: from [IPv6:2001:470:b0db:100:895a:8c19:9d35:e8fb] (unknown
 [IPv6:2001:470:b0db:100:895a:8c19:9d35:e8fb])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 48YHHr2M3Jz8Pb0;
 Thu,  5 Mar 2020 12:07:52 -0500 (EST)
Subject: Re: [PATCH] audio: Add sndio backend
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200304145003.GB15649@humpty.home.comstyle.com>
 <158333424649.21741.12510392429749383012@abdcc9e1aa82>
 <20200305085019.hbmih2m43vmpdc5v@sirius.home.kraxel.org>
From: Brad Smith <brad@comstyle.com>
Message-ID: <a4e6c1e0-6c8b-5281-e945-c6a032752e3e@comstyle.com>
Date: Thu, 5 Mar 2020 12:07:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:74.0) Gecko/20100101
 Thunderbird/74.0
MIME-Version: 1.0
In-Reply-To: <20200305085019.hbmih2m43vmpdc5v@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f938:3000:8::2
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/5/2020 3:50 AM, Gerd Hoffmann wrote:

> On Wed, Mar 04, 2020 at 07:04:07AM -0800, no-reply@patchew.org wrote:
>> Patchew URL: https://patchew.org/QEMU/20200304145003.GB15649@humpty.home.comstyle.com/
>>
>>
>>
>> Hi,
>>
>> This series seems to have some coding style problems. See output below for
>> more information:
>>
>> Subject: [PATCH] audio: Add sndio backend
>> Message-id: 20200304145003.GB15649@humpty.home.comstyle.com
>> Type: series
>>
>> === TEST SCRIPT BEGIN ===
>> #!/bin/bash
>> git rev-parse base > /dev/null || exit 0
>> git config --local diff.renamelimit 0
>> git config --local diff.renames True
>> git config --local diff.algorithm histogram
>> ./scripts/checkpatch.pl --mailback base..
>> === TEST SCRIPT END ===
>>
>>  From https://github.com/patchew-project/qemu
>>   * [new tag]         patchew/20200304145003.GB15649@humpty.home.comstyle.com -> patchew/20200304145003.GB15649@humpty.home.comstyle.com
>> Switched to a new branch 'test'
>> 421ab62 audio: Add sndio backend
>>
>> === OUTPUT BEGIN ===
>> ERROR: space prohibited before that close parenthesis ')'
>> #41: FILE: audio/audio.c:1977:
>> +        CASE(SNDIO, sndio, );
> False positive I'd say.
>
>> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> Adding an entry to the MAINTAINERS file is a good idea though.


Ok. Will do.

>> ERROR: g_free(NULL) is safe this check is probably not required
>> #381: FILE: audio/sndioaudio.c:318:
>> +    if (self->pfds) {
>> +        g_free(self->pfds);
> Reasonable too.


Not clear to me. Leave as is or needs a change?


