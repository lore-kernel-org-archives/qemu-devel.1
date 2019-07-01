Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C2BC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A8AD206E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OeN6imAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8AD206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhxqd-0004N5-DX
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 11:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34352)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hhxnA-0001hC-RJ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hhxn5-0007vO-Ne
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:00:28 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55919)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hhxn1-0007n2-2x
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:00:20 -0400
Received: by mail-wm1-x343.google.com with SMTP id a15so16219958wmj.5
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qO0tw6/4CuHIqVaBgS7s0KxmHhX6bEPZ4Cj7kOvH6NU=;
 b=OeN6imAykCxxAy8fjgas5PEvvvM4wSO5ffrXLtHqaTmZCGzEB13KzX0DV/BS9jhArr
 M+oNwSPsyDOqRpsVvD35Jw1inbotJ+z2+LcDAwryCn2EZGuTWqspOmyF+Ub8f/n2HhDe
 KUl7JU5T8lajKgFMGMcPTMOrAPLwzqwtWl0V2g2nOuqyZ/HzGA8aejFxz/P1+FwzR5RN
 z685yj94eZQFABkFlykaxpvLvZmKk06wlqcdcPuGMBbKpMHMrFBRAEZfY3FZ5zcB48tk
 mbfa0ur/6pcMnSMkpPCkA4j45ubbJovVpTUpT2l21L8h2o/u9XVJAYUFdFtL/TSUsfBl
 PKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qO0tw6/4CuHIqVaBgS7s0KxmHhX6bEPZ4Cj7kOvH6NU=;
 b=B0+hr1jLN/OVZK2jBMyJgbKC5cNkUienBWzF8BuKNR7ufSA+rSDT3GfHVbEFFS4uYz
 g7inFYeWr0X9fOfOUbuKwtjIHBkhi0ZnB5+hCGvEhdDtd2CX6/AuPTVmNYcKKuHFOJMD
 HVU5Kfvc0iBl8BBK2Tu0SNX0ip8HWCJTweJaeCpZHrbllt4kiesO2K8Zv8/td008OPXR
 rl56H+sxnZC//czmn9QyIuj388Wzs1nHQhAPBURx12HFwKpJoDQ8DtR/EAP3BCJO1g5B
 AXYrAYlDHFPJn0blb6jTiYOOFTqPGdse9KbZ1HYvl/cS4ebREjBWVdR0P9g44DTG2mC9
 lFyw==
X-Gm-Message-State: APjAAAX7mbRvFYdBePxzzROvGUjwJ+mQstbD/kbA0Rm0FtbnBHe1Bs9f
 O0hRTAIDm/7m7DoCZ8/Oib35XA==
X-Google-Smtp-Source: APXvYqxCSqBb7SU7xa9eMOHXu8+wHPVEoyvssAag/98UtHH6KaQoGhThl+R8IAzr75RTsWQwSMv6TQ==
X-Received: by 2002:a1c:7a15:: with SMTP id v21mr17329286wmc.176.1561993210932; 
 Mon, 01 Jul 2019 08:00:10 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id z25sm17874772wmf.38.2019.07.01.08.00.09
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 08:00:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BBC091FF87;
 Mon,  1 Jul 2019 16:00:08 +0100 (BST)
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-20-alex.bennee@linaro.org>
 <20190628153044.GB26345@quinoa.localdomain>
 <87mui1ab4j.fsf@zen.linaroharston>
 <20190628175756.GC26345@quinoa.localdomain>
 <87lfxla0vs.fsf@zen.linaroharston> <20190701144009.GA5002@quinoa.localdomain>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
In-reply-to: <20190701144009.GA5002@quinoa.localdomain>
Date: Mon, 01 Jul 2019 16:00:08 +0100
Message-ID: <877e91ssuf.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v3 19/50] tcg: let plugins instrument
 memory accesses
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aaron Lindsay OS <aaron@os.amperecomputing.com> writes:

> On Jun 28 21:52, Alex Benn=C3=A9e wrote:
>> Aaron Lindsay OS <aaron@os.amperecomputing.com> writes:
>> > To make sure I understand - you're implying that one such query will
>> > return the PA from the guest's perspective, right?
>>
>> Yes - although it will be two queries:
>>
>>   struct qemu_plugin_hwaddr *hw =3D qemu_plugin_get_hwaddr(info, vaddr);
>>
>> This does the actual lookup and stores enough information for the
>> further queries.
>>
>>   uint64_t pa =3D qemu_plugin_hwaddr_to_raddr(hw);
>>
>> will return the physical address (assuming it's a RAM reference and not
>> some IO location).
>
> Sounds good, as long as we have a good way to either prevent or cleanly
> detect the failure mode for the IO accesses.
>
>> > In terms of our use case - we use QEMU to drive studies to help us
>> > design the next generation of processors. As you can imagine, having t=
he
>> > right physical addresses is important for some aspects of that. We're
>> > currently using a version of Pavel Dovgalyuk's earlier plugin patchset
>> > with some of our own patches/fixes on top, but it would obviously make
>> > our lives easier to work together to get this sort of infrastructure
>> > upstream!
>>
>> Was this:
>>
>>  Date: Tue, 05 Jun 2018 13:39:15 +0300
>>  Message-ID: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkP=
ad-T60>
>>  Subject: [Qemu-devel] [RFC PATCH v2 0/7] QEMU binary instrumentation pr=
ototype
>
> Yes, that looks like the one.
>
>> What patches did you add on top?
>
> We added:
> - plugin support for linux-user mode (I sent that one upstream, I think)
> - memory tracing support and a VA->PA conversion helper

check

> - a way for a plugin to request getting a callback just before QEMU
>   exits to clean up any internal state

check - qemu_plugin_register_atexit_cb

> - a way for a plugin to reset any instrumentation decisions made in the
>   past (essentially calls `tb_flush(cpu);` under the covers). We found
>   this critical for plugins which undergo state changes during the
>   course of their execution (i.e. watch for event X, then go into a more
>   detailed profiling mode until you see event Y)

check:

/**
 * qemu_plugin_reset() - Reset a plugin
 * @id: this plugin's opaque ID
 * @cb: callback to be called once the plugin has been reset
 *
 * Unregisters all callbacks for the plugin given by @id.
 *
 * Do NOT assume that the plugin has been reset once this function returns.
 * Plugins are reset asynchronously, and therefore the given plugin receives
 * callbacks until @cb is called.
 */
void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);


> - instrumentation at the TB granularity (in addition to the existing
>   instruction-level support)

check

/**
 * qemu_plugin_register_vcpu_tb_trans_cb() - register a translate cb
 * @id: plugin ID
 * @cb: callback function
 *
 * The @cb function is called every time a translation occurs. The @cb
 * function is passed an opaque qemu_plugin_type which it can query
 * for additional information including the list of translated
 * instructions. At this point the plugin can register further
 * callbacks to be triggered when the block or individual instruction
 * executes.
 */

and then you can have instruction or TB level callbacks:

/**
 * qemu_plugin_register_vcpu_tb_trans_exec_cb() - register execution callba=
ck
 * @tb: the opaque qemu_plugin_tb handle for the translation
 * @cb: callback function
 * @flags: does the plugin read or write the CPU's registers?
 * @userdata: any plugin data to pass to the @cb?
 *
 * The @cb function is called every time a translated unit executes.
 */
void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
                                          qemu_plugin_vcpu_udata_cb_t cb,
                                          enum qemu_plugin_cb_flags flags,
                                          void *userdata);

Or the inline equivalent.


> - the ability for a plugin to trigger a checkpoint to be taken

We don't have this at the moment. Pranith also mentioned it in his
review comments. I can see its use but I suspect it won't make the
initial implementation given the broader requirements of QEMU to do
checkpointing and how to cleanly expose that to plugins.

>
> -Aaron


--
Alex Benn=C3=A9e

