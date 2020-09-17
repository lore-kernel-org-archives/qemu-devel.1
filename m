Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99700C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AAB720684
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e2oF2ZCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AAB720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIpOZ-0005GT-3y
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 04:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIpLk-0001pM-IP
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 04:33:04 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:43495)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIpLi-0006oM-8U
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 04:33:04 -0400
Received: by mail-wr1-x436.google.com with SMTP id k15so1070953wrn.10
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 01:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=cTiKarSd8/bNFfpXk1/sti6C4yR53qEfj3unD5jl9hE=;
 b=e2oF2ZChr5WSi3Eylo/Tn0Fl/i3Z7vbyb4SKdpGRC3aoc65c1ofXkx3qdqJNriCxgx
 7RFsyTo5cOxaHkfPZGY/z+sYAJkX5afC2VLV8lEql6gmLlQ8e90vl+StdbPJDhpL9Ren
 bH7ac7B0zUZmmiahTJSw55mpfGb9ldedNqKgTgXjIczlypSre1NetM6ibz/1le/jcok9
 QLn2cPbG86qe9YPwDxCHsaGgKur0nzTLR0NjPnCnFLtqj6ThqgdOXuwZzAk5ch/5pRT/
 kIhy5jRy/ehi93Gsf6M2f/4RfCiXCnAO7Tmu2tnTt8TPL13NAMOxdPQ21LKcjOCB7ssc
 T6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=cTiKarSd8/bNFfpXk1/sti6C4yR53qEfj3unD5jl9hE=;
 b=ACNZvAMpXdCKPvmJeLQ0xEL60MXihQalaONqlmqmA9VwjF8y/pmsZ0cMTam6oTCj1x
 NBhjsvZEP/RoEWM1xc3Mshey+Y7LgPOxF3cy+td8+SAxX336KMhsTM6oSG9rNAEhrVZf
 iHK55N2PDYBw1rmaSZ0VHB3i8+hcw0sPGcptDUpdelVfaHdha2ALrc3Ix4ij3gNgBJ+0
 JSR7vgRVCskmyxE/eRlTbjjly//sdlCYhPsS8q4Y5aqJA2lvlkhaqELFAespc02tPBNM
 On4Gp/cnXABHwRjpeKEvejUBOKdcZUqsMxuA/6lUde8/9Ip0EZ/g/HciUlXFkRPweB8C
 OPmg==
X-Gm-Message-State: AOAM5328FPrCZsv1ioh+k2Qbc8UtLiG+VCmo/4I1hi00wbCE61HhAIVU
 pk+yaq9MDBtiIrNjeIu3QuhJOQ==
X-Google-Smtp-Source: ABdhPJw8tLOCdrncEL/v3pKVecRWUajoLr9aOCkghGwowkXS2Xjt/d1RkNGCg769JjRrgTC4oIIOqw==
X-Received: by 2002:adf:e391:: with SMTP id e17mr29817600wrm.289.1600331579061; 
 Thu, 17 Sep 2020 01:32:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u126sm12362413wmu.9.2020.09.17.01.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 01:32:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 613CE1FF7E;
 Thu, 17 Sep 2020 09:32:57 +0100 (BST)
References: <878sdp4ks9.fsf@linaro.org>
 <20200908141701.GB7154@stefanha-x1.localdomain> <87zh5puw8k.fsf@ebb.org>
 <bf85f4c7-bbea-bb33-3455-222d7f101b9a@gnu.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Should we apply for GitLab's open source program?
In-reply-to: <bf85f4c7-bbea-bb33-3455-222d7f101b9a@gnu.org>
Date: Thu, 17 Sep 2020 09:32:57 +0100
Message-ID: <877dssztty.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "qemu@sfconservancy.org" <qemu@sfconservancy.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <bonzini@gnu.org> writes:

> On 17/09/20 01:39, Bradley M. Kuhn wrote:
>> One thing to note is that my understanding is that most of what you're
>> getting access to through this program is proprietary software features =
that
>> GitLab offers as add-ons.
>
> Basically all we need is the increased access to the CI environment (not
> just 400 minutes), and none of the add-on features.  Self-hosting would
> of course help but we'd have to pay for the hardware resources to run
> the CI, and have someone that can keep the hardware running.

It seems for the time being that public CI is still unlimited. The idea
of making our position as an FLOSS project "official" was to preempt any
changes to that might come down the track.

The question of using proprietary features hadn't come up beyond a
hand-waving of "ohh there is a long list". We are however thinking about
consolidating some of our more disparate infrastructure onto gitlab so
it's mostly in one place - for example the bug tracker currently hosted
on launchpad. Personally I'd think it's unlikely we want to move things
like the mailing lists which are currently on nongnu (via Savannah).

Ultimately as developers having to manage infrastructure is a bit of a
time-sink and currently it's hard for volunteer admins to be as
responsive as cloud-scale hosting companies who's income from non-free
software hosting pays for all our server time. If there was a free
software only instance of GitLab which offered the same level of service
I would personally be interested but I don't know how much of the
projects income could be diverted to supporting that versus the travel
bursaries and other such things we usually spend our money on.

In this regard FLOSS projects are both leaches on paid for services as
well as being useful public facing PR for a SaaS platforms abilities.

--=20
Alex Benn=C3=A9e

