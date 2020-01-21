Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB0EC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A78C2253D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lkKm8BXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A78C2253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ituh0-0006nq-Ie
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:39:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1itufM-00050A-PZ
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:38:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1itufL-0005hH-DW
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:38:04 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1itufL-0005fI-3n
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 09:38:03 -0500
Received: by mail-wr1-x441.google.com with SMTP id c14so3458264wrn.7
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 06:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ROOYN1ctfCYBjn11qqR2j8UxTG/vGJxmvE2N0Lqjgmo=;
 b=lkKm8BXhWsuutW+M2E1JXhJP5bOvcA2oUn147/WTZOP8TN9hnfj9pG8rYs8cz4VngA
 QvxhKdmySDzy/dW/JDOITRGQSix8VP0xaCypA+CV8232lNCWskTgHks8jOe65GB7jt2A
 QN1T1lm+MjzqiTZjgtipO2vzRSS3rEZWneNPeTe2oZuXmN1ik7pn65b0G4W6XKPvW3hb
 YjaeVpxz+AR0jWg2Rxn/cRtog9HnReWPm0Dh18Tgj9G0lXGGEQu8bbj0QXSYtt99TsEG
 ncIs1OeKk8v4e1LtdMTcO32CkoGblhzTWLPLEE3u/hEfU28t7anG1tGcUgwZ6Z5gWXlr
 pOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ROOYN1ctfCYBjn11qqR2j8UxTG/vGJxmvE2N0Lqjgmo=;
 b=Uae+Qv7XdK2ahEGZ3ektNjDHuuZydgQuNpkPbLg+1dOszuxuiP6UkQh4v9EdLSwY1A
 IyeuP7vLC7F602WCrf9lRreTVqhRL8l2kX3e+l6tlr1GxCnq5rsq4r4CvXeSkHtxZWCp
 rZ4mOjdwJLCW0xoX2zZ8R4jWoD6j7502XKpFBhg1BCiGKxxE2p/7KNflZwIqR1GZpLbu
 NxSfzq7xtu1fApDfDrcF6hIMxNnQPlm9FnJy8JzDPArgoT9dmajeen4i07mOxSe3JeLT
 IYGia1E7HLH3yztW/Z2e6/KpSqgcoLJxJmng5bGiN3DVcdvB9eVuEFt3DbZCO+5Y7GCZ
 vXBg==
X-Gm-Message-State: APjAAAVwA0YS2+Ttkied7S2kvUkuP2INkA49UxrfXP9NLsS+9gI/0cfN
 9nrP7z2sMRFrvLlgJs0vRg/i3A==
X-Google-Smtp-Source: APXvYqwTr8poDt1a1299M8lwR6YAmO1x/Y9J5tz2wC5UNWx3Of2alHja5iD9mLnc8ydRQOuxMtU/dA==
X-Received: by 2002:adf:f64b:: with SMTP id x11mr5527181wrp.355.1579617481520; 
 Tue, 21 Jan 2020 06:38:01 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d8sm51676407wrx.71.2020.01.21.06.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 06:38:00 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C344D1FF87;
 Tue, 21 Jan 2020 14:37:59 +0000 (GMT)
References: <20190717054655.14104-1-npiggin@gmail.com>
 <87h81vdtv2.fsf@linaro.org> <1579604990.qzk2f3181l.astroid@bobo.none>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH] Implement qemu_thread_yield for posix,
 use it in mttcg to handle EXCP_YIELD
In-reply-to: <1579604990.qzk2f3181l.astroid@bobo.none>
Date: Tue, 21 Jan 2020 14:37:59 +0000
Message-ID: <87ftg827ug.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Nicholas Piggin <npiggin@gmail.com> writes:

> Alex Benn=C3=A9e's on December 20, 2019 11:11 pm:
>>
>> Nicholas Piggin <npiggin@gmail.com> writes:
>>
>>> This is a bit of proof of concept in case mttcg becomes more important
>>> yield could be handled like this. You can have by accident or deliberat=
ely
>>> force vCPUs onto the same physical CPU and cause inversion issues when =
the
>>> lock holder was preempted by the waiter. This is lightly tested but not
>>> to the point of measuring performance difference.
>>
>> Sorry I'm so late replying.
>
> That's fine if you'll also forgive me :)
>
>> Really this comes down to what EXCP_YIELD semantics are meant to mean.
>> For ARM it's a hint operation because we also have WFE which should halt
>> until there is some sort of change of state. In those cases exiting the
>> main-loop and sitting in wait_for_io should be the correct response. If
>> a vCPU is suspended waiting on the halt condition doesn't it have the
>> same effect?
>
> For powerpc H_CONFER, the vCPU does not want to wait for ever, but just
> give up a some time slice on the physical CPU and allow other vCPUs to
> run. But it's not necessary that one does run (if they are all sleeping,
> the hypervisor must prevent deadlock). How would you wait on such a
> conditon?

Isn't H_CONFER a hypercall rather than instruction though? In QEMU's TCG
emulation case I would expect it just to exit to the (guest) hypervisor
which then schedules the next (guest) vCPU. It shouldn't be something
QEMU has to deal with.

If you are running QEMU as a KVM monitor this is still outside of it's
scope as all the scheduling shenanigans are dealt with inside the
kernel.

From QEMU's TCG point of view we want to concern ourselves with what the
real hardware would do - which I think in this case is drop to the
hypervisor and let it sort it out.

--
Alex Benn=C3=A9e

