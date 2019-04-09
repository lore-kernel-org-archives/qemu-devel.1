Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74155C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 353BE20833
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353BE20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45790 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtVF-0002pr-Dz
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:21:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDtPG-0006eE-W6
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:15:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDtPF-0007YO-Kr
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:15:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDtPF-0007WX-BH
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:15:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so21708556wrp.2
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 09:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=xlZMRGsGCBiJaem3ywtrdSpesXz/5PWyQhhy3vQ2QSk=;
	b=GXRg84U4inHTihkghvqX7s1t20NC8r9KbnHlENGdOL6RY+M4+/v0WgMjQyIL8xvDzO
	k5NvncWCC1ay8Ah6VQfNDDSetk5buayCSrHs7kFv8X2mC9Zi0EJ6u1o68MpQ7sTyW3Fp
	I52vAwj7KssaHKuceGPrn56MSykZMWUIGIVPWP2YHJqNT8RqdXdBMsLdCaZ4gEditj/I
	SeYlmA1ZPmCHoSBOHlKyEZlLn2lJNywCmhPQC4Eky2t8D4uY2uwEA4Yp7iEdnLgZBRlG
	G6gbGL3616dHa2JMfHkKNY8/tzVXLvdhiczs34GYtVKhV00sKiYWLra22hu15QZ39yU8
	dxWA==
X-Gm-Message-State: APjAAAVFs/GGqMbFCZFncJTZIUShQ0jTDUizCS15do9gbZ4TLUQGwmPh
	IeD3vAHcggTlJhMhC7WdeXSaeQ==
X-Google-Smtp-Source: APXvYqyKa2m7zZ/PDZefOtXYlztnTMLCmTmTrvrF/tY0iYg04yk0D6f6aXecYS9tGq5EfQBfYMMfTQ==
X-Received: by 2002:adf:fa47:: with SMTP id y7mr3785020wrr.27.1554826528351;
	Tue, 09 Apr 2019 09:15:28 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	o10sm50270383wru.54.2019.04.09.09.15.27
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 09:15:27 -0700 (PDT)
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
	<6cf20899-f643-950b-37b9-dcc47df0d72e@redhat.com>
	<5C484463-F00B-4EC0-9272-DC23CEE8F376@oberlin.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0437475a-10ff-b8e0-3914-536a78f99b6e@redhat.com>
Date: Tue, 9 Apr 2019 18:15:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5C484463-F00B-4EC0-9272-DC23CEE8F376@oberlin.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 00/10] block/pflash_cfi02: Implement
 missing AMD pflash functionality
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409161526.N0nsHd52Y6xp4nJoI0IiOp5vZfVxyhXXPS5Xn7WjzIU@z>

On 4/9/19 5:55 PM, Stephen Checkoway wrote:
> Hi Phil,
> 
>> On Apr 9, 2019, at 06:34, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> Hi Stephen,
>>
>> [Cc'ing Markus and Laszlo, we have similar interest in pflash01 testing]
>>
>> On 4/8/19 10:55 PM, Stephen Checkoway wrote:
>>> The goal of this patch series implement the following AMD command-set parallel
>>> flash functionality:
>>> - flash interleaving;
>>> - nonuniform sector sizes;
>>> - erase suspend/resume commands; and
>>> - multi-sector erase.
>>
>> I am very glad you addressed these long overdue issues and very pleased
>> by your patches :)
>> I'll thoroughly review it during next week (this won't get merge for the
>> current 4.0 cycle anyway).
> 
> Great!
> 
>> I started a similar cleanup (mostly pflash01 focused) and converted
>> DPRINTF to trace events, added few constants. I'll see if I can rebase
>> your work on top of mine. So far only your patch 2 (refactor) would be
>> modified, simplified as the "pull out all of the code to modify the
>> status into simple helper functions" part (which else I'd ask you to
>> move in a separate patch).
>>
>> We should think of more intereleaved tests, I'll prepare a table of
>> current QEMU models using this device and how is their intereleave
>> mapping. Hopefully it would be enough to simply add the existing
>> machines to your current musicpal qtest.
>>
>> Also I'd like to see some Top/Bottom block configuration qtests, your
>> patch #5 doesn't seem tested.
> 
> I included four tests <https://patchew.org/QEMU/cover.1554774454.git.stephen.checkoway@oberlin.edu/bbe417c354dfa908d5e1bc8f8ad7121ec9451682.1554774454.git.stephen.checkoway@oberlin.edu/>.
> 
> Patchew makes it hard to link to particular lines. Here's the same patch on Github <https://github.com/qemu/qemu/commit/a851d21347121a91ba9a39c133a8fbee6e84e557#diff-d2ed797ca8898de80768bdfb390781dfR498>.
> 
> Are those sufficient or would you like more tests?

Ah you don't mention the tests in the patch description, that's why I
missed them :) Sometimes I prefer to keep the test addition in a
separate patch, it eases rebases, however in your series it seems fine.

Since you did changes in the CFI table, I think we should add a tests
verifying the table is correctly generated for all you FlashConfig entries.

>>> During refactoring and implementation, I discovered several bugs that are
>>> fixed here as well:
>>> - flash commands use only 11-bits of the address in most cases, but the
>>>  current code uses all of them [1];
>>> - entering CFI mode from autoselect mode and then exiting CFI mode should
>>>  return the chip to autoselect mode, but the current code returns to read
>>>  array mode; and
>>> - reset command should be ignored during sector/chip erase, but the current
>>>  code performs the reset.
>>>
>>> The first patch in the series adds a test for the existing behavior. Tests for
>>> additional behavior/bug fixes are added in the relevant patch.
>>>
>>> 1. I found firmware in the wild that relies on the 11-bit address behavior,
>>>   probably due to a bug in the firmware itself.
>>
>> Is it a musicpal firmware? Are you able to compare with real hardware?
> 
> No, it's not musicpal. I'm not even sure what musicpal is, it was just the most convenient choice for testing.  The real hardware is an embedded system using an old AMD processor (Am486) with three different AMD command set flash chips. The unlock addresses the firmware uses don't actually match the part sheets (in most cases). It took quite a while to realize that the flash hardware only uses 11 bits of address. (It's clearly spelled out in the various part sheets, but I guess I missed it on the first 15 or so readings.)

I suppose you can not share the firmware binary. Can you share these
unlock addresses? Maybe once I reviewed carefully your series I might
ask you the (pflash) trace event output.

>> I vaguely remember some issue regarding address bus width when trying to
>> implement the TopBlock small sectors, but I wasn't using the musicpal.
>> I'll see if I can find my old notes and test with your series.
> 
> The one boot chip I'm using is the AM29F080B-90SI with top boot blocks. It has an 8-bit address bus.

