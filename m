Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E1AC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:00:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6827A208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6827A208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkTs-0001ky-II
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 10:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60071)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnkTf-0001IL-EE
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnkTa-0007AU-0q
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:00:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37072)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hnkTZ-00076b-QS
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:00:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so22276240wme.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 07:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=anIiPly3Laa6zJaJDv5DB+OM70pYOQJzvDrDXM9w8to=;
 b=LPHrNI2/+DppfazxQp3L8s0xbqzLdPR3KdeW4mPzYoMY5vsT4P2tAKYCorrvQqIDDx
 AMuEekT09AVhf/iN58fu5eRUSvTjMTszBCukfK2UUMeRJp/1tpqWCWTjeTWQStt6Runq
 mE/oPMlznaeqy7hF+WMs6z+Ycy7L4HYx+TtXsm8jzVD8UZvyZVeP5DGEPE20l4pq77s1
 yyd48Gk1vOLiLbn+KTxBnKSjP69tafXTzO4so0VN8mKYLJ/Yv9GbHXmmsv+6Jz4Lqzw+
 ropR1iTAYkykr8F23DWJrtwLi5kt65CaQc3ld6w7zrI1A16sCXOtz2UqmffAkK/ZXVDz
 j6dQ==
X-Gm-Message-State: APjAAAVCTr/3Ycayx9kZiB9d9+DVdYjONJY1RBRgYPls2BGuD5AnoANm
 AfXUuyKsnmy2/A2cO2/EHCFqHw==
X-Google-Smtp-Source: APXvYqye6TK8bjyVSdutQSj7zHggCBy4T8YXwsASRdCLeYNUX9EcPdJimPwxBoQeX0EZyU7DE1gLrA==
X-Received: by 2002:a1c:720e:: with SMTP id n14mr36789635wmc.53.1563372008697; 
 Wed, 17 Jul 2019 07:00:08 -0700 (PDT)
Received: from [10.32.224.209] (red-hat-inc.vlan560.asr1.mad1.gblx.net.
 [159.63.51.90])
 by smtp.gmail.com with ESMTPSA id w67sm27299046wma.24.2019.07.17.07.00.07
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Jul 2019 07:00:08 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
References: <20190716221555.11145-1-philmd@redhat.com>
 <7f45fc26-4063-5b8d-d103-a0ac6e873bef@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2c58bae8-7a9c-4827-109f-741dc8461a2b@redhat.com>
Date: Wed, 17 Jul 2019 16:00:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7f45fc26-4063-5b8d-d103-a0ac6e873bef@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v6 0/5] hw/block/pflash_cfi01: Add
 DeviceReset() handler
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 John Snow <jsnow@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Laszlo,

On 7/17/19 2:24 PM, Laszlo Ersek wrote:
> Hi Phil,
> 
> On 07/17/19 00:15, Philippe Mathieu-Daudé wrote:
>> Hello it's me again, insisting with this series because there are at
>> least 2 different report of guests bricked on reset due to the bug
>> fixed by patch #5:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1678713
>> https://bugzilla.redhat.com/show_bug.cgi?id=1704584
>>
>> Patches missing review: 2 and 3
>>
>> The pflash device lacks a reset() function.
>> When a machine is resetted, the flash might be in an
>> inconsistent state, leading to unexpected behavior.
>> Resolve this issue by adding a DeviceReset() handler.
>>
>> Since v1: https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg00962.html
>> - addressed Laszlo review comments
>>
>> Since v2: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg00395.html
>> - consider migration (Laszlo, Peter)
>>
>> Since v3: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01668.html
>> - more reliable migration (Dave)
>> - dropped patches 6-9 not required for next release
>>
>> Since v4: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg02785.html
>> - document why using READ_ARRAY value 0x00 for migration is safe
>>
>> Since v5: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg03366.html
>> - avoid trying to be spec-compliant and messing with migration. KISS.
>>   review/test tags reset, sorry.
> 
> I have a number of questions / requests.
> 
> 
> (1) The last I recall from the v5 discussion is Markus asking about some
> risky cases (corner cases?) related to migration.
> 
> So what is the new avenue taken in v6? What does "continue ignoring spec
> compliance" mean, with regard to migration?
> 
> My vague understanding is that we're not trying to answer Markus's
> questions; instead, we're side-stepping them, by doing something else.

I'd love to keep the v5 series and address Markus issues, but as shown
by the quantity of respins, I don't understand the migration feature
enough to fix it in time for the next release. I plan to address them
(and other issues reported by Markus in other reviews) during the next
dev cycle.

> That works for me, but can we please summarize in a bit more detail?
> Like, "in v6, we're not mapping 0x00 vs. 0xff across migration because..."

Since it is very late in the release process and this series intend to
fix a guest corruption bug worthwhile for release, the approch taken by
v6 is "try to change the strict minimum regarding to migration, do not
worry about spec issues". I even tried to make no migration change at
all, but as explained in patch 6 "Extract pflash_mode_read_array" there
is still one.

I could make no migration change, and in patch 6 not call
memory_region_rom_device_set_romd() in pflash_mode_read_array() [and
call it in other places instead], but then we still have the undefined
behavior described in the patch. We always lived with this UNDEF, so...
I could work on a simpler v7.

> Yes, I could inter-diff v5 vs. v6, but I know way too little about
> pflash. I'd miss how our *dropping* of the special 0xff mapping impacts
> our conformance to the data sheet.

To reassure you, it never worked well but nobody cared, I noticed while
converting DPRINTF to trace-events and adding more, then follow the
model state machine. While it's probably not worth fixing, it makes
debugging slighly harder when looking at the CFI spec workflow. Now I'm
used to it.

> I'm not asking for commit message updates, just a bit more explanation
> in this free-form discussion. (I looked for it under v5, and couldn't
> find it.)

I tried to be verbose in the patch description, so for reference:

0xff on v5:
https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg03368.html

not 0xff on v6:
https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg03931.html

migration impact on v6 [1]:
https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg03932.html

> (2) Has someone regression-tested v6 for migration specifically?

No, neither were tested the previous versions.

> 
> Or, is v6 not "risky" wrt. migration any longer?

v6 should be way less risky than previous versions (still one issue
noted in [1]).

> (3) I'm fine regression testing v6 too (without migration, again).
> Please ping me separately once the reviews have converged and the series
> is otherwise ready for merging.

Yes, I know your testing takes very long, so let's wait first.

Thanks for having a look.

Phil.

> 
> Thanks!
> Laszlo
> 
> 
>> $ git backport-diff -u v5
>> Key:
>> [----] : patches are identical
>> [####] : number of functional differences between upstream/downstream patch
>> [down] : patch is downstream-only
>> The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
>>
>> 001/5:[----] [-C] 'hw/block/pflash_cfi01: Removed an unused timer'
>> 002/5:[down] 'hw/block/pflash_cfi01: Document use of non-CFI compliant command '0x00''
>> 003/5:[0031] [FC] 'hw/block/pflash_cfi01: Extract pflash_mode_read_array()'
>> 004/5:[down] 'hw/block/pflash_cfi01: Rename 'reset_flash' label as 'mode_read_array''
>> 005/5:[----] [--] 'hw/block/pflash_cfi01: Add the DeviceReset() handler'
>>
>> Regards,
>>
>> Phil.
>>
>> Philippe Mathieu-Daudé (5):
>>   hw/block/pflash_cfi01: Removed an unused timer
>>   hw/block/pflash_cfi01: Document use of non-CFI compliant command
>>     '0x00'
>>   hw/block/pflash_cfi01: Extract pflash_mode_read_array()
>>   hw/block/pflash_cfi01: Rename 'reset_flash' label as 'mode_read_array'
>>   hw/block/pflash_cfi01: Add the DeviceReset() handler
>>
>>  hw/block/pflash_cfi01.c | 77 +++++++++++++++++++++--------------------
>>  hw/block/trace-events   |  1 +
>>  2 files changed, 41 insertions(+), 37 deletions(-)
>>
> 

