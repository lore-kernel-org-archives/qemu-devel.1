Return-Path: <SRS0=wjfX=SQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D22FC10F13
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 16:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10EC42084E
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 16:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10EC42084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=durchholz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37512 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFhg8-0001ZW-Tz
	for qemu-devel@archiver.kernel.org; Sun, 14 Apr 2019 12:08:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jo@durchholz.org>) id 1hFhfE-0001GX-2T
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 12:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jo@durchholz.org>) id 1hFhfD-0003KN-7h
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 12:07:28 -0400
Received: from 5.itsy.de ([188.40.84.14]:51798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jo@durchholz.org>) id 1hFhfC-0003IN-TH
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 12:07:27 -0400
Received: from [192.168.178.32] (unknown [195.48.33.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 5.itsy.de (Postfix) with ESMTPSA id 0C98364478
	for <qemu-devel@nongnu.org>; Sun, 14 Apr 2019 18:07:23 +0200 (CEST)
References: <91dddf37-77fe-79c6-59f5-4e60d45c3c7e@durchholz.org>
	<CAMo8BfLEEF2_FVU88ydBWVmcRbCJ9T0ULrDEKRa-+hmCYo9cmg@mail.gmail.com>
From: Joachim Durchholz <jo@durchholz.org>
To: qemu-devel@nongnu.org
Message-ID: <0492144e-fcd1-c013-2211-fbc31a17ce2f@durchholz.org>
Date: Sun, 14 Apr 2019 18:07:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMo8BfLEEF2_FVU88ydBWVmcRbCJ9T0ULrDEKRa-+hmCYo9cmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.40.84.14
Subject: Re: [Qemu-devel] How to I trigger a rebuild?
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190414160723.hymuervTYNmN73ge-wQ8gcHA9N5ZrFlswi-bcedzExA@z>

Am 14.04.19 um 03:15 schrieb Max Filippov:
> On Sat, Apr 13, 2019 at 8:28 AM Joachim Durchholz <jo@durchholz.org> wrote:
>> I did the usual ./configure; make dance.
>> Then modified a source file (ui/curses.c), called make again, but didn't
>> see curses.c recompiled, and the change was indeed ineffective.
>> make clean; make didn't help either.
> 
> Perhaps you don't have CONFIG_CURSES enabled?
> Did you call configure with --enable-curses ?

Strange. "make help" tells me that everything is enabled by default if 
possible, and I didn't tell configure to do anything specific.

But I find that curses is disabled indeed.
Heh. An explicit --enable-curses tells me it was missing the dev version 
of ncurses.

However... even with curses enabled, "make" does not do anything  after 
modifying ui/curses.c.
In fact, just "make" tell's me I should have run ./config (WTF I did??), 
and "make all"
But after ./configure is recompiles everything... nothing of this is 
something that "make" should do, so I'm pretty confused.

Regards,
Jo

