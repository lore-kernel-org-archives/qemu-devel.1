Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B2EC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7D7820716
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RIrC9y0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D7820716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii04M-0006JY-Ak
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 12:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1ihzmz-0008Bb-9E
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:40:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1ihzmx-0003OU-AV
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:40:40 -0500
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a]:33246)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1ihzmv-0003MK-Dr
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:40:37 -0500
Received: by mail-il1-x12a.google.com with SMTP id v15so5587958iln.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 09:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pHTFsoo+fDeUfrVVk3IA2ZPm/Erta3XSoJlIyByLflk=;
 b=RIrC9y0B1XA49pFwbodtjQPzvhiOwuk1adUfiD69Cuml0ggdqDxqm+VIlIHnpePSBG
 FayIuovR6fniTFUWbWiwHpuD4/sjIacRy6JJhX1LQupQjR+1DuoFEA7cwombYHpNWZdR
 ZeUdU0Cjmr9dJzd8WFipFYn3P1fk3k/Iswj+H0fX1fBNFo7AYT5PYKz3cJZ523xN/EC0
 smA7kcXo3JXvg9qe1dtuIxX5YoY4gF8MW+MqAgVCOeHbIumKpkPl6ssg9kRze44A3Ikg
 CrLjo0lBx2FNfAQ5Jm6hijtyfwfKmvl3hpwoyvh7VZMCkXXEc6ZJiIIjy5j6iFpLnfVh
 hjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pHTFsoo+fDeUfrVVk3IA2ZPm/Erta3XSoJlIyByLflk=;
 b=MbZnB9K8nTowdRGAzDEO910v5/Z5ZeCjzGBaDeHJrffiSr2edTQzyicGWghMAikg9L
 mSc2Yok4hFRVA/FQbBFwVkhylT4RS1NUoPI1SX0B1djmoBDq1Etc57OsevBd8PbJF6hX
 eQCeSNvwRi4lpGO/vJK2KHyREIk9659gly/op/ju9rMWsU3xnvT7jfe1BIZ9sN5az/bs
 nVV2L7hAL1AjSpb9MQFc5xTv/w81Dg367MeTByYtDquB21El0ceLaA9ASSDz6RNZawbP
 A8I9HwKTP8666P8AK29qf7vfIZWYj38kf1OlNgpx590Tav2+v4Di4gvyRxEIsgbU/TuJ
 ScKg==
X-Gm-Message-State: APjAAAVQhhIfDWG+ne1vKEkmti2bNJto9DGBzzIL9SIfQfJ9Xq75aJz6
 2pRWoPLq4Uun7X0UEuP2zPNnxeRLNoLoQcXUnmL34w==
X-Google-Smtp-Source: APXvYqxGOEEkGa3aJQ23E0cRA7ebY/DzmszJB/nen6aZF4o5tCyHDwNU0KiXfCXFCWU9w/2DMDoZqKHEG08v86Allk4=
X-Received: by 2002:a05:6e02:5c3:: with SMTP id
 l3mr8533556ils.260.1576777236220; 
 Thu, 19 Dec 2019 09:40:36 -0800 (PST)
MIME-Version: 1.0
References: <20191219154214.GE1267@perard.uk.xensource.com>
In-Reply-To: <20191219154214.GE1267@perard.uk.xensource.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Thu, 19 Dec 2019 17:40:25 +0000
Message-ID: <CADSWDzuWU4UoYjtat1wa8hMXmHhc6aRUDx1rxopsADfRaxqB0Q@mail.gmail.com>
Subject: Re: Recent change pmem related breaks Xen migration
To: Anthony PERARD <anthony.perard@citrix.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::12a
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Anthony,

On Thu, 19 Dec 2019 at 15:42, Anthony PERARD <anthony.perard@citrix.com> wrote:
>
> Hi,
>
> Commit bd108a44bc29 ("migration: ram: Switch to ram block writeback")
> breaks migration on Xen. We have:
>   ramblock_ptr: Assertion `offset_in_ramblock(block, offset)' failed.
>
> I've track it down to qemu_ram_writeback() calling ramblock_ptr()
> unconditionally, even when the result will not be used.
>
> Maybe we could call ramblock_ptr() twice in that function? I've prepared
> a patch.
>
>
> FYI, full-ish trace on restore of a xen guest:
> #3  0x00007f82d0848526 in __assert_fail () from /usr/lib/libc.so.6
> #4  0x0000562dc4578122 in ramblock_ptr (block=0x562dc5ebe2a0, offset=0) at /root/build/qemu/include/exec/ram_addr.h:120
> #5  0x0000562dc457d1b7 in qemu_ram_writeback (block=0x562dc5ebe2a0, start=0, length=515899392) at /root/build/qemu/exec.c:2169
> #6  0x0000562dc45e8941 in qemu_ram_block_writeback (block=0x562dc5ebe2a0) at /root/build/qemu/include/exec/ram_addr.h:182
> #7  0x0000562dc45f0b56 in ram_load_cleanup (opaque=0x562dc510fe00 <ram_state>) at /root/build/qemu/migration/ram.c:3983
> #8  0x0000562dc49970b6 in qemu_loadvm_state_cleanup () at migration/savevm.c:2415
> #9  0x0000562dc4997548 in qemu_loadvm_state (f=0x562dc6a1c600) at migration/savevm.c:2597
> #10 0x0000562dc4987be7 in process_incoming_migration_co (opaque=0x0) at migration/migration.c:454
> #11 0x0000562dc4b907e5 in coroutine_trampoline (i0=-962514432, i1=22061) at util/coroutine-ucontext.c:115
>
> And *block in ramblock_ptr():
> (gdb) p *block
> $2 = {
>   rcu = {
>     next = 0x0,
>     func = 0x0
>   },
>   mr = 0x562dc512e140 <ram_memory>,
>   host = 0x0,
>   colo_cache = 0x0,
>   offset = 0,
>   used_length = 515899392,
>   max_length = 515899392,
>   resized = 0x0,
>   flags = 16,
>   idstr = "xen.ram", '\000' <repeats 248 times>,
>   next = {
>     le_next = 0x562dc67bf7e0,
>     le_prev = 0x562dc510f1a0 <ram_list+64>
>   },
>   ramblock_notifiers = {
>     lh_first = 0x0
>   },
>   fd = -1,
>   page_size = 4096,
>   bmap = 0x0,
>   receivedmap = 0x562dc6a24a60,
>   clear_bmap = 0x0,
>   clear_bmap_shift = 0 '\000'
> }
>
> Cheers,
>
> --
> Anthony PERARD

I have already replied to your patch submission.
Looks good and thanks for fixing .

BR
Beata

