Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D65C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 748BB22284
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748BB22284
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUevs-00016k-JF
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 19:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kUeql-0006HN-Ml
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:45:59 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:21264)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kUeqh-0003hN-M0
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:45:58 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id CC7F6746383;
 Tue, 20 Oct 2020 01:45:52 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 898E9745953; Tue, 20 Oct 2020 01:45:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 87FB974594E;
 Tue, 20 Oct 2020 01:45:52 +0200 (CEST)
Date: Tue, 20 Oct 2020 01:45:52 +0200 (CEST)
To: Joelle van Dyne <j@getutm.app>
Subject: Re: [PATCH v2 6/9] tcg: implement mirror mapped JIT for iOS
In-Reply-To: <CA+E+eSAYV50ACGaAvd_e-eR3FoSiBq6EXqDVRH7vJZyYHvhA8w@mail.gmail.com>
Message-ID: <5d2ac3fc-cb2f-4a69-3d6-b834edc8ff8c@eik.bme.hu>
References: <20201019013928.72770-1-j@getutm.app>
 <20201019013928.72770-7-j@getutm.app>
 <aa4c227-c33-72dc-92c6-75792f60b58e@eik.bme.hu>
 <CA+E+eSAYV50ACGaAvd_e-eR3FoSiBq6EXqDVRH7vJZyYHvhA8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

On Mon, 19 Oct 2020, Joelle van Dyne wrote:
>> Explicit cast may not be needed here so this could be a macro if caling it
>> differently helps or why don't you just use tcg_mirror_prr_rw directly
>> everywhere?
>
> There are quite a bit of code that depends on tcg_insn_unit * type such as
>
> *tcg_code_ptr_rw(s, code_ptr) = insn;
>
> and
>
> (tcg_code_ptr_rw(s, p))[i] = NOP;

OK that explains it, haven't looked at it at that detail.

> I think it's cleaner to not have to manually cast in every one of 30+
> instances of this. In v1, I used a macro but was told to use an inline
> function instead.

Definitely cleaner to have the cast either in a macro or inline func than 
manually having it everywhere. The static inline in v2 looks better than 
the macro in v1 so unless others disagree it's fine this way, I'm not the 
one who decides, I was just asking if we can avoid having two static 
inlines relying on casting void * but if you also dereference as above 
then returning the right type is needed. Let's see what Richard says who 
suggested the function instead of a macro but it does look more readable 
than the previous macro.

>> Is that !defined or are you missing an implementation and #else here?
> No, `flush_dcache_range` is only needed when mirror mapped (after
> writing to the RW mirror). Now there is no iOS compatible compiler for
> any other arch than x86 and ARM. However, in the slim chance that

But this was in tcg/arm/tcg-target.h which is ARM but maybe you mean only 
x86 and 64bit ARM which is aarch64 but not 32bit ARM. I've noticed this 
only after sending the question.

> Apple decides to change arch again in the future and moves to RISC-V
> or something, then we get a nice compiler error.
>
>> Maybe this patch could be split up some more, making the RW offset
>> handling and cache management separate patches even if they don't work
>> separately just to make it easier to review.
>
> I can probably do that for v3 but imo most of the LOC here is because
> the same change has to be done to every TCG target. No matter how you
> split up the patches, it will look like a lot of changes.

Sure but it's easier to review if a single patch has only similar changes 
even if it touches a lot of files than if it does independent stuff 
intermixed unless it's a small patch (but even then QEMU tends to prefer a 
lot of smaller patches instead of combining changes in a single patch). 
That's also good for bisectability so that's also something to consider 
when splitting patches. Not sure if in this case this can be split up into 
two working changes because RW mapping may not work without cache flushes 
and cache flushes may not be added before having the RW split but having 
two patches for the review that can be squashed in the final series may 
still help. But lets see if this gets reviewed without further splitting 
or what others say.

Not sure you're aware of this: https://wiki.qemu.org/Planning/5.2 but if 
this series does not get merged this week don't be surprised if your next 
opportunity to pick it up will be in December (when most people who can 
review it will be on holyday so it can be easily take longer). So maybe 
you could try pushing it and do everything to make reviewers' job easier 
if you want it in the next release. Otherwise you'll have time to polish 
it until next year.

Also it may be good to fix checkpatch errors (warnings may be OK but 
errors are not) that are reported even if it's not in your code (it could 
be a separate clean up patch before your changes or for small things in 
the same patch) otherwise automated tests may not run which can also delay 
reviews and merging:

https://patchew.org/QEMU/20201019051953.90107-1-j@getutm.app/

and I assume you already know this:

https://wiki.qemu.org/Contribute/SubmitAPatch

It might be overwhelming and off putting sometimes to try getting series 
into QEMU but please don't give up.

Regards,
BALATON Zoltan

