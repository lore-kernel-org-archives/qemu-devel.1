Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6414C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 09:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9012F20673
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 09:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xU670heP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9012F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55690 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heFRv-0002e3-Kw
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 05:03:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58042)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1heEzc-00044x-7U
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 04:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1heEnd-0000VS-DD
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 04:21:35 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55567)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1heEnb-0000TF-Ho
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 04:21:33 -0400
Received: by mail-wm1-x344.google.com with SMTP id a15so5479564wmj.5
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 01:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=oodsVL7vyAxVv9uT4qGXKR36RaCYnBzdwK+DfeAtf10=;
 b=xU670hePXrDVV4Tq3XohrLxVTUujK1LO7xX/ay5ARY9mcLh9cmE+kNHKL3dv8FwK03
 vUKmiFnu8qtpmyur4SgsDOQQQX363M0Ni1Rg1HcTPwk7a+TJgkPB1dn6Wm3fnFJaflf8
 WJXEpPoXJFtzRiioX3FUdFfY1iV7lMBTG7sAR7c9jwlYzTYs1bdC2ZccCsF+4wJxO78W
 HGiPvEaiWufoCe0tQh8zoKgQWPcePAT8srsX0Sf+H/EvG289MsAxrpFXGRss00AOI4aY
 /d/lqeeEU9GNdmT8dj8NGFarrfQyQ2a4YzDLVvRW+8F+bFd0LGjz3mee3flagLMDTgbD
 brOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=oodsVL7vyAxVv9uT4qGXKR36RaCYnBzdwK+DfeAtf10=;
 b=b1zNUiz+mye2EU1iRzuhk8GiwUqaBdF4A6BbNGj1obsABO55ljipNoqfuZho+hWWfq
 VZip/pFlaZxK4bsBB63tFBgsCvctiy1rQ8/2tD0YV2Bv3eJpI0uCcg/ArfyZkWB4h6tl
 6zxCq0+oWHTwW9kS8+SpiEwAAfFA8FimHJQmqrcQvhPdgKR1IQNEECrJNNVc++svpIJ+
 nIxmwx7NnE+L6ViQi2XuqhbqYiYDW9YxJqxEteb0zkk243Qhy0uD0Q9mldBrAEfocVE9
 yDYcUT8fqLrxfZ8WAtpy8Il09xNqhKmQ2BeCMSwCIfHBjHozDPtuXHWCkoMiHW1TTbxZ
 +M8A==
X-Gm-Message-State: APjAAAUIQWNWRjhy2t8XXtLXRVyP85yA3136NpcydPtNhJt6PwN33ypD
 RMlDyqT3Ib4cEsVI0J04XK42SA==
X-Google-Smtp-Source: APXvYqzlFKUyWQLKfy0skmFOvzSh5AYtNKxIuCO4COaFnP4Hp9w4kKiz/u9wPutuxG46UMbj2/xIzg==
X-Received: by 2002:a1c:b457:: with SMTP id d84mr3290342wmf.153.1561105289199; 
 Fri, 21 Jun 2019 01:21:29 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id g2sm1968588wmh.0.2019.06.21.01.21.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 21 Jun 2019 01:21:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 30EF51FF87;
 Fri, 21 Jun 2019 09:21:28 +0100 (BST)
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <CADYwmhFw8ujwz+NN9prKc+Za6=dD1aN==JnKmC0gnr4V7LPU4w@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pranith Kumar <bobby.prani@gmail.com>
In-reply-to: <CADYwmhFw8ujwz+NN9prKc+Za6=dD1aN==JnKmC0gnr4V7LPU4w@mail.gmail.com>
Date: Fri, 21 Jun 2019 09:21:28 +0100
Message-ID: <87r27n8i2f.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v3 00/50] tcg plugin support
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
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pranith Kumar <bobby.prani@gmail.com> writes:

> Hi Alex/Emilio,
>
> I am really happy to see the progress you made on the plugin feature. Loo=
king
> forward to seeing it merged soon! Please CC me on future versions of the
> patchset. I am happy to help review and contribute to this effort.

Will do.

>
> I have a few general comments from experience writing a very similar syst=
em
> (qsim) below.
>
> On Fri, Jun 14, 2019 at 10:23 AM Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
>>
>> Hi,
>>
>> This is v3 of the proposed plugins API for QEMU. As Emilio is busy
>> having finished his time at Columbia I have volunteered to take the
>> patch series forward. Emilio's RFC v2 was posted last year:
>>
>>   Subject: [RFC v2 00/38] Plugin support
>>   Date: Sun,  9 Dec 2018 14:37:11 -0500
>>   Message-Id: <20181209193749.12277-1-cota@braap.org>
>>
>
> * Register and memory read/write API
>
>   It would be great to have register and memory read/write API i.e., abil=
ity
>   to read/write to registers/memory from within the callback. This gives =
the
>   plugin ability to do system introspection. (Not sure if the current pat=
chset
>   implements this already).

Not currently. The trick is to have something flexible enough without
exposing internals. I guess we could consider the gdb register
enumeration or maybe hook into stuff declared as
tcg_global_mem_new_i[64|32]. That won't get every "register" but it
should certainly cover the main general purpose ones. Things like SVE
and AdvSIMD vector registers wouldn't be seen though.

> * Register callbacks
>
>   A callback needs to be invoked whenever a specified registers is read or
>   written to.

Again tricky as not every register read/write is obvious from TCG -
vector registers tweaked from helpers would be a good example.

>
> * Where do new plugins live in the tree?
>
>   The current source files in plugins (api, core etc.,) I think are bette=
r if
>   moved to tcg/plugins/.  The various plugins we write would then live in=
 the
>   plugins/ folder instead of the current tests/plugin/ folder.

The example plugins are really just toys for experimenting with the API
- I don't see too much problem with them being in tests. However the
howvec plugin is very guest architecture specific so we could consider a
bit more of a hierarchy. Maybe these should all live in tests/tcg?

>
> * Timer interrupts
>
>   What I observed is that the system execution is affected by what you do=
 in
>   the callbacks because of timer interrupts. For example, if you spend ti=
me in
>   the memory callback doing a bit of processing and writing to a file, you
>   will see more timer interrupt instructions. One solution to this would =
be to
>   use 'icount', but it does not work that well. I think we need to do
>   something similar to what gdb does in debug mode. How would you handle =
MTTCG
>   guests in that case?

icount is going to be the best you can get for deterministic time -
other efforts to pause/restart virtual time going in and out of plugins
are just going to add a lot of overhead.

Remember QEMU doesn't even try to be a cycle accurate emulation so
expecting to get reasonable timing information out of these plugins is a
stretch. Maybe I should make that clearer in the design document?

The gdb behaviour is just a massive hack. When single-stepping in GDB we
prevent timer IRQs from being delivered - they have still fired and are
pending and will execute as soon as you hit continue.

>   Another approach would be to offload callback generation to a separate
>   plugin thread. The main thread will copy data required by a callback and
>   invoke the callback asynchronously (std::async in C++ if you are
>   familiar).

This would complicate things - the current iteration I'm working on
drops the haddr cb in favour of dynamically resolving the vaddr in the
callback. But that approach is only valid during the callback before
something else potentially pollutes the TLB.

>
> * Starting and stopping callback generation
>
>   It would be great if we have a mechanism to dynamically start/stop call=
backs
>   when a sequence of code (magic instruction) is executed. This would be
>   useful to annotate region-of-interest (ROI) in benchmarks to
> generate callbacks.

Well we have that now. At each TB generation event the callback is free to =
register
as many or few callbacks as it likes dynamically.

>
>   Also, the return value from a callback can be used to decide further co=
urse
>   of action. For example, if our plugin needs 10000 callbacks, it can ind=
icate
>   to stop generating further callbacks in the return value of the callback
>   once it got the necessary callbacks.

This can be done internally - a plugin can unregister itself once it has
collected everything it wanted. If it wants to hang around you can
qemu_plugin_reset to reset all callbacks.

Do you want something finer grained?

> * State saving API
>
>   An API to save the state of the VM from the plugin code.

This would be tricky for -smp > 1 because other threads will have run on
while you are making your decision. It would certainly be useful for
analyzing failed states though.

>
> Let me know your thoughts and any other ideas you might have.
>
> Thanks,


--
Alex Benn=C3=A9e

