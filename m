Return-Path: <SRS0=wjfX=SQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1664EC10F13
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 19:15:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E606820870
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 19:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E606820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=durchholz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39175 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFkbT-0005XK-7c
	for qemu-devel@archiver.kernel.org; Sun, 14 Apr 2019 15:15:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jo@durchholz.org>) id 1hFkaW-00059Z-0o
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 15:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jo@durchholz.org>) id 1hFkaU-0005L8-AM
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 15:14:47 -0400
Received: from 5.itsy.de ([188.40.84.14]:56021)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jo@durchholz.org>) id 1hFkaS-000577-8P
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 15:14:46 -0400
Received: from [192.168.178.32] (unknown [195.48.33.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 5.itsy.de (Postfix) with ESMTPSA id D614C643C8
	for <qemu-devel@nongnu.org>; Sun, 14 Apr 2019 21:14:31 +0200 (CEST)
To: qemu-devel@nongnu.org
References: <91dddf37-77fe-79c6-59f5-4e60d45c3c7e@durchholz.org>
	<CAMo8BfLEEF2_FVU88ydBWVmcRbCJ9T0ULrDEKRa-+hmCYo9cmg@mail.gmail.com>
	<0492144e-fcd1-c013-2211-fbc31a17ce2f@durchholz.org>
	<CAFEAcA8vUhuEbtLnmOxui3K_UW8eOET3xbWap3E23EWeGzqv7w@mail.gmail.com>
From: Joachim Durchholz <jo@durchholz.org>
Message-ID: <5daf8566-fe07-fa64-89e4-5c18676e2f1b@durchholz.org>
Date: Sun, 14 Apr 2019 21:14:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8vUhuEbtLnmOxui3K_UW8eOET3xbWap3E23EWeGzqv7w@mail.gmail.com>
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
Message-ID: <20190414191431.bV61wEFFkdRr5n-BLVOYpaamUVFuWwxmoiB-LmRhsDI@z>

Am 14.04.19 um 20:12 schrieb Peter Maydell:
> On Sun, 14 Apr 2019 at 17:08, Joachim Durchholz <jo@durchholz.org> wrote:
>>
>> Am 14.04.19 um 03:15 schrieb Max Filippov:
>>> On Sat, Apr 13, 2019 at 8:28 AM Joachim Durchholz <jo@durchholz.org> wrote:
>>>> I did the usual ./configure; make dance.
>>>> Then modified a source file (ui/curses.c), called make again, but didn't
>>>> see curses.c recompiled, and the change was indeed ineffective.
>>>> make clean; make didn't help either.
>>>
>>> Perhaps you don't have CONFIG_CURSES enabled?
>>> Did you call configure with --enable-curses ?
>>
>> Strange. "make help" tells me that everything is enabled by default if
>> possible, and I didn't tell configure to do anything specific.
>>
>> But I find that curses is disabled indeed.
>> Heh. An explicit --enable-curses tells me it was missing the dev version
>> of ncurses.
> 
> Configure's default behaviour is "enable everything that we can
> enable, but don't complain about not enabling optional features
> which we can't build (eg because of missing -dev libraries)".
> For "insist that foo is built and error out if it can't be done",
> use "--enable-foo". For "definitely don't build foo even if we
> could", use --disable-foo.

Well, that's what I guessed after the fact... it didn't occur to me that 
"what's possible" was defined as "what libraries are available".
Now that I know this, I know what to watch out for.

>> However... even with curses enabled, "make" does not do anything  after
>> modifying ui/curses.c.
>> In fact, just "make" tell's me I should have run ./config (WTF I did??),
>> and "make all"
>> But after ./configure is recompiles everything... nothing of this is
>> something that "make" should do, so I'm pretty confused.
> 
> This sounds like maybe you got confused somewhere along the line
> about whether you'd (re-)run configure or not (or didn't
> do a 'make clean' after running configure with the curses
> support enabled).

Actually I got confused about where I was building.
I had set up things for an out-of-tree build but accidentally hit "make" 
in the source tree.

> The other thing that might confuse you is that make will try
> to spot when it needs to rerun configure and will rerun it
> for you.

Oh dear. That didn't happen to me, but I see the trap-in-waiting.

> I recommend doing builds only in a separate directory, by the way:
>   mkdir build
>   (cd build && ../configure [configure args])
>   make -C build -j8

Yep, doing that already.

Regards,
Jo

