Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E535C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:40:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1AEC21D43
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rq9w9rIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AEC21D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFySg-0004NU-Oz
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 07:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFyRu-0003vH-9z
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:39:38 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFyRs-00089g-9z
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:39:37 -0400
Received: by mail-wr1-x444.google.com with SMTP id s12so2554581wrw.11
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 04:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=l+DtWWjZWzZ4rANHFRdvuqGHRW3YjbEUrZ8NpXkHAWk=;
 b=Rq9w9rItA4DyTPgV0NSjNL2koQ5/xNOpSL2saxYn0O8ybSbdiX2jAciXfwX06e4g6t
 toXeEGqcAVNZI8d0YnLmltrSp3wcgcYEcf/OBFs3NIXPvukMwfOGE/AoYVPmIf1m+dQM
 qlHi2hBQDAqEz7Pn84lqCAYXKUNJHb7wlqQHJol+sburJZkU6cnouRBOq2ZaUZf54Fgz
 cb6Guaovo7afmAlQrUSbn/YWJMcDqAIM0YZEwzY9NNAMOJhE5KB/nrQrkunKEHTcD+M7
 2CH/5zIq2gC8GiA4l3+LjHul+CL8/5PAUPmWWzi2d9fnGNSsSTPcX44MzLOje3CK9IE9
 xWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=l+DtWWjZWzZ4rANHFRdvuqGHRW3YjbEUrZ8NpXkHAWk=;
 b=YZRsstZs1+cyEIRnZdctPxsQh/nVP+SG6iV8iS/FPRKBfCpoSM4OiNmQeg7Z5EGPwn
 ZD0G8s2ix/Q1vbT2TBiFiRDdLsRnAIG1Ly7THoXUNt0RcAbvYTF7WrL5ltc/CphyYi0x
 jI39w20AjpnDkOTF5j2PVWasROTQcBVwQFYnN+LQDfLb2NrjCmqH14pSCl3wewQh54M8
 LfTo4RmBf+B901x+anDwcHlOIrnoDN8YkR6/xnTSK5nDUpkuLZLPItGsxBXYQA/XBiDn
 aGvAsNCDBxVcssK6J/TFb8CmrnrR/BIPREXsOGfjRCHAGixz6qMdJ4TRux8rHZOdXZ6L
 OiAg==
X-Gm-Message-State: AOAM532qkNmndVKz4LjyMeYaEK6YWqZGPmzOcXE+s+xDsy4BOkHNTG9y
 nuOmV6BTX3RNqo1UgzuOJL9d0A==
X-Google-Smtp-Source: ABdhPJzuDbLr0zrpWs0sOeIBO8azUwi6N0r4LTH+H1SQ+QkMzVsnp5Ms8yYBCqxKVDjj2/JSdKPlhg==
X-Received: by 2002:a5d:60c6:: with SMTP id x6mr3558917wrt.26.1599651574481;
 Wed, 09 Sep 2020 04:39:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a85sm3735091wmd.26.2020.09.09.04.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 04:39:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 772111FF7E;
 Wed,  9 Sep 2020 12:39:32 +0100 (BST)
References: <20200903105614.17772-1-cfontana@suse.de>
 <13e066b4-03dd-e8f6-4420-25e25e404c72@suse.de>
 <CABgObfZBARDX=tFb03xEnSVMGAiG8TPn4TAKUpGEi=_iRChmWA@mail.gmail.com>
 <7e518674-b2a4-d6fb-f9f0-20a19765b995@suse.de>
 <74e99c7f-5eb0-f34a-e2a2-c2b590027e7a@redhat.com>
 <83904d39-5b27-d6da-f648-408931d69f63@suse.de>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v7 00/16] QEMU cpus.c refactoring part2
In-reply-to: <83904d39-5b27-d6da-f648-408931d69f63@suse.de>
Date: Wed, 09 Sep 2020 12:39:32 +0100
Message-ID: <87lfhjp4az.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Claudio Fontana <cfontana@suse.de> writes:

> On 9/8/20 2:14 PM, Paolo Bonzini wrote:
>> On 08/09/20 13:58, Claudio Fontana wrote:
>>> Thanks Paolo,
>>>
>>> if it can help I try to keep a rebased functioning version at
>>>
>>> https://github.com/hw-claudio/qemu.git "cpus-refactoring"
>>>
>>> some of the CI complains about:
>>>
>>> check: qemu-img not found
>>> Makefile.mtest:1229: recipe for target 'check-block' failed
>>=20
>> This will be fixed by the next pull request (the issue appears with
>> --enable-system --disable-tools builds).
>>=20
>> Paolo
>>=20
>
> Generating qemu-version.h with a meson_exe.py custom command
> make: *** No rule to make target 'check-softfloat'.  Stop.
> make: *** Waiting for unfinished jobs....
> fatal: No names found, cannot describe anything.
>
> Probably an instance of the same problem right?

Yes - I treat check-softfloat as a unit test so it's not dependent on
the type of build you are actually doing.

  Subject: [PATCH  v2 00/10] testing and misc updates
  Date: Wed,  9 Sep 2020 12:27:31 +0100
  Message-Id: <20200909112742.25730-1-alex.bennee@linaro.org>

I think gets all CI back to green.

>
> I got this from travis-ci.org
>
> GCC check-softfloat (user)


--=20
Alex Benn=C3=A9e

