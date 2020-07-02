Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A46C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 07:56:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1206520B80
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 07:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IIpctXVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1206520B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqu4y-0002oq-C4
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 03:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqu3c-0001Ne-6P
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 03:54:56 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54631)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqu3Z-00051G-5I
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 03:54:55 -0400
Received: by mail-wm1-x342.google.com with SMTP id o8so25652212wmh.4
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 00:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=BDTFmWjJV65K2o4tymhzZOCvZCDj1mi7p6b26+CDzZ8=;
 b=IIpctXVmNj+Sz7oKDPO+JQea4AvYOBsnpSZpNMTcMezDlYImbpN9hxqCThopgF6R08
 d8BH7wR3FNSUCM5gfgMV1OA2KvpMeJtVwJHa3bOIx5ZozGxifsSHqcWw7g9feYgfF0pZ
 tvWbVYzxI1RnJegl0bNV8mRRX7NvdJZQL+LyhvT9Oqat+DZ9YkWghJsj9IjuI+hdihVu
 /YWnTAMjdvo0jblSCpW68KBTtEXObr7eH4YPyYMiRRYx+KjIylS9fzdxkp3btrYcSOwA
 7nvy3+9frjU0LAG5vj/vjwVHSrFWy3bBzMX/hSui1ewk1mB+IJtzhreNEkA9gjHHmRS1
 xpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=BDTFmWjJV65K2o4tymhzZOCvZCDj1mi7p6b26+CDzZ8=;
 b=sYOkjWeHyTU+K77FZXCnswW3sZeD0UUIcR88bfQsp5yFnAYEpM0O+9pkRE8TDeZgDj
 edkHMhG9oQa0Mw3jOwddyACrONv10zPlQoBUSVTOpgXJCVO/DDfmBu6P4jsVO+7n4UD9
 cjzfUqmGjm2dzXzy5vm9Yd2ChNpoeOtJblR8+Mwel5iuWEgncN2/FQL48H9C6VOGrbG8
 8UJOl5x5AkYvrsyWQoC0soEFtTG7A02DD/2V/C9/GjnHWG6g/Rb6oWPvMZI01m6BSoHE
 3KfR0oFa8+whXehcOgsWXIARnS64qHsbspv9FI5qEG6Xr8sPhj/9xuqrMKwyeV+HPsUB
 d4vQ==
X-Gm-Message-State: AOAM530bQz5o3COijWxtm9uuvxnny1ed0D5dkf0z70pKdx/k5QnLuTGY
 PNGA0IgWGi56yImrx8tfG2i+Rg==
X-Google-Smtp-Source: ABdhPJydMmChxg0ScHOVmbTaNKubtBsourIhh6fp18imSmnEkNT9UuYoj863RTXCs4XeTL5XBgZDwg==
X-Received: by 2002:a1c:6a03:: with SMTP id f3mr10346188wmc.58.1593676491534; 
 Thu, 02 Jul 2020 00:54:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u65sm9571534wmg.5.2020.07.02.00.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 00:54:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 63F4E1FF7E;
 Thu,  2 Jul 2020 08:54:49 +0100 (BST)
References: <20200701200848.26746-1-agraf@csgraf.de>
 <CAFEAcA9S5v0LHMNc4fu9JGUzecbg8DsogZuCEv_aGNqVxRAcDQ@mail.gmail.com>
 <60440cb5-bd18-2928-afcf-974766222dd7@csgraf.de>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alexander Graf <agraf@csgraf.de>
Subject: Re: [PATCH] target/arm: Treat unknown SMC calls as NOP
In-reply-to: <60440cb5-bd18-2928-afcf-974766222dd7@csgraf.de>
Date: Thu, 02 Jul 2020 08:54:49 +0100
Message-ID: <878sg2qrli.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alexander Graf <agraf@csgraf.de> writes:

> On 01.07.20 22:47, Peter Maydell wrote:
>> On Wed, 1 Jul 2020 at 21:08, Alexander Graf <agraf@csgraf.de> wrote:
>>> We currently treat unknown SMC calls as UNDEF. This behavior is differe=
nt
>>> from KVM, which treats them as NOP.
>>>
>>> Unfortunately, the UNDEF exception breaks running Windows for ARM in QE=
MU,
>>> as that probes an OEM SMCCC call on boot, but does not expect to receive
>>> an UNDEF exception as response.
>>>
>>> So instead, let's follow the KVM path and ignore SMC calls that we don't
>>> handle. This fixes booting the Windows 10 for ARM preview in TCG for me.
>>>
>>> Signed-off-by: Alexander Graf <agraf@csgraf.de>
>>> +    if (cs->exception_index =3D=3D EXCP_SMC &&
>>> +        !arm_feature(env, ARM_FEATURE_EL3) &&
>>> +        cpu->psci_conduit !=3D QEMU_PSCI_CONDUIT_SMC) {
>> This condition says: "we got an SMC, and this CPU doesn't
>> have EL3, and we're not imitating real EL3 firmware".
>
>
> I like to think of it as "This CPU exposes an environment that looks
> like KVM, so it implements HVC calls (EL2) and is responsible for
> handling SMC calls as well.

That is a very KVM centric view of the world ;-)

I thought the aim was always to behave as the real processor would.

> The main difference between the two semantics is that in yours, you
> don't have EL3. In mine, there is an EL3, but it's virtualized by the
> same layer that implements EL2.

If you boot up with secure firmware + EL2 aware KVM kernel I assume
everything behaves as expected?

>
>
>> The architecturally correct behaviour here (since we don't
>> implement nested-virt yet, which might allow it to trap
>> to guest EL2) is to UNDEF, as far as I can see from a quick
>> look at the AArch64.CheckForSMCUndefOrTrap().
>>
>> I'm not sure why KVM makes these NOP; if I'm right about the
>> architectural behaviour then making them NOP would be a KVM bug.
>>
>> If Windows makes an SMC call on boot that seems like a guest
>> bug: it would crash on a real CPU without EL2/EL3 as well.
>
>
> I don't think there can be a real SBBR compatible CPU without EL2/EL3,
> because PSCI is a base requirement. That means either SMC calls succeed
> (Windows running in EL2) or SMC calls are trapped into EL2 and it's up
> to the hypervisor to decide what to do with them.
>
>
>>
>>       *  Conduit SMC, valid call  Trap to EL2         PSCI Call
>>       *  Conduit SMC, inval call  Trap to EL2         Undef insn
>> -     *  Conduit not SMC          Undef insn          Undef insn
>> +     *  Conduit not SMC          nop                 nop
>>
>> The line in this table that your commit message says you're
>> fixing is "Conduit SMC, inval call"; the line your code
>> change affects is "Conduit not SMC", which is not the same
>> thing. (I'd have to look at the PSCI spec to see what it
>> requires for SMCs that aren't valid PSCI calls.)
>
>
> The patch fixes the default environment, which is "Conduit HVC, PSCI
> over HVC implemented by QEMU". If the patch description wasn't clear,
> I'm happy to reword it :).
>
>
> Alex


--=20
Alex Benn=C3=A9e

