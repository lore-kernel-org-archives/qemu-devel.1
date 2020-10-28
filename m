Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF918C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E340324687
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jHx2Zwth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E340324687
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXht2-0000Ts-TM
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 05:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kXhrq-00087h-PR
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 05:35:42 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kXhro-0004yT-IW
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 05:35:42 -0400
Received: by mail-wr1-x444.google.com with SMTP id s9so4899248wro.8
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 02:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=H7ja72fsG2KRjgiaDcXgg2Jb6FVep+1I/8n3yg9cM5Q=;
 b=jHx2ZwthHWToEMIbu2q3ZI+gtSrkHDc/GM1h7aeP5Endu19jBB96DT+UE41ruzDB7u
 N4t4Yd9iLpbqkk/g682z1WhHUudPPeRAupsQvWi1CmCXV5seEqE6b58Hc6ooeuyQMNmT
 0CM1u/GbWcGFYTevVKEP+Dw9zH1gjPlvVXCaLZO61sxAmantHwS4Wtq9IjeElHcEqoFG
 DAQTSsQg6bIh+8/0QfKS9GCDfXzqiC/J7nD4VOfEdrxVAXe+Wxp08lMAqYtJiI3mr6en
 7L0Jh1VX0eAZtD02zq1ts3VvUUNQ33U7V1zofsMAKEnQh/cGd+P96GvbzBXxV/Nwa+oF
 rBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=H7ja72fsG2KRjgiaDcXgg2Jb6FVep+1I/8n3yg9cM5Q=;
 b=LlyG8c7iUZUdJzDbUhak8G7M3lwcJNHLqhG2EsXBa0pH1/SRis+YmOkLXScq1aqjmv
 Imdy8MHgE+HUwWT1TgWBx/skLsXFchEprwxNqdf/Z+/t07h1U9d3xDlRO6FeeEMV3wok
 gC7vQ+S+lsBurfV24gF8KfgXItDk7E9oCr2V45nR6FV6h/xoe833LBpo1omlUDpnsn11
 5uUJP+O+sA+kHhomNGvrYF27zb4+xEsBBoCmuo2KWU/oJJP6911XPNMUk3wx5UqlDLAC
 PLcfIeVujLj5oWyW6TkktLtGiPP2vXFa+eC13YlxQWfSo2LDlZkbdhsmJtcsufBeMiOB
 gsxA==
X-Gm-Message-State: AOAM530zhQvgbewggj1aL4fcHVVXG+tDfHqoXaX/1MYFL+VfA1GI3UWR
 XcxQ7Ai3GCAeUDtZsEmVIoi3sw==
X-Google-Smtp-Source: ABdhPJxLL1qFtoUJVbZ4TDg6G7eCu2rX8t6mozLbSibSEnFVDOnL1pD1adubqu8JDoGgQ6kAWKw46A==
X-Received: by 2002:adf:9150:: with SMTP id j74mr8286794wrj.57.1603877738429; 
 Wed, 28 Oct 2020 02:35:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 30sm6233306wrr.35.2020.10.28.02.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 02:35:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 529461FF7E;
 Wed, 28 Oct 2020 09:35:36 +0000 (GMT)
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
 <20201023200645.1055-4-dbuono@linux.vnet.ibm.com>
 <7aa00aba-ff8c-252a-899a-45ef4db7cc6e@redhat.com>
 <20201026155006.GE496050@redhat.com>
 <756e6060-394f-fe4a-47f2-2601b6e54a45@linux.vnet.ibm.com>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniele Buono <dbuono@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/6] configure: add option to enable LTO
In-reply-to: <756e6060-394f-fe4a-47f2-2601b6e54a45@linux.vnet.ibm.com>
Date: Wed, 28 Oct 2020 09:35:36 +0000
Message-ID: <87h7qeelqv.fsf@linaro.org>
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniele Buono <dbuono@linux.vnet.ibm.com> writes:

> In terms of ar and linker, if you don't have the right mix it will just
> stop at link time with an error.
>
> In terms of using gcc the errors may be a bit more subtle, similar to
> what Daniel mentioned. Succesfully compiling but then showing issues at
> runtime or in the test suite.
>
> I'm using ubuntu 18.04 and the stock compiler (based on gcc 7.5) issues
> a bunch of warnings but compile succesfully with LTO.
> However, the tcg binary for sparc64 is broken.

sparc64-linux-user? I think that might be in a bit of a bit rotted state
- we had to disable running check-tcg on it in CI because of instability
so I wouldn't be surprised if messing around with LTO has dug up even
more gremlins.

> System-wide emulation
> stops in OpenFirmware with an exception. User emulation triggers a
> segmentation fault in some of the test cases. If I compile QEMU with
> --enable-debug the tests magically work.

Breakage in both system and linux-user emulation probably points at
something in the instruction decode being broken. Shame we don't have a
working risu setup for sparc64 to give the instruction handling a proper
work out.

>
> I briefly tested with gcc-9 and that seemed to work ok, buy your mileage
> may vary
>
> On 10/26/2020 11:50 AM, Daniel P. Berrang=C3=A9 wrote:
>> On Mon, Oct 26, 2020 at 10:51:43AM +0100, Paolo Bonzini wrote:
>>> On 23/10/20 22:06, Daniele Buono wrote:
>>>> This patch allows to compile QEMU with link-time optimization (LTO).
>>>> Compilation with LTO is handled directly by meson. This patch adds che=
cks
>>>> in configure to make sure the toolchain supports LTO.
>>>>
>>>> Currently, allow LTO only with clang, since I have found a couple of i=
ssues
>>>> with gcc-based LTO.
>>>>
>>>> In case fuzzing is enabled, automatically switch to llvm's linker (lld=
).
>>>> The standard bfd linker has a bug where function wrapping (used by the=
 fuzz*
>>>> targets) is used in conjunction with LTO.
>>>>
>>>> Tested with all major versions of clang from 6 to 12
>>>>
>>>> Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
>>>
>>> What are the problems like if you have GCC or you ar/linker are not up
>>> to the job?  I wouldn't mind omitting the tests since this has to be
>>> enabled explicitly by the user.
>>=20
>> We temporarily disabled LTO in Fedora rawhide due to GCC bugs causing
>> wierd test suite asserts. Those were pre-release versions of GCC/binutils
>> though. I've just tested again and LTO works correctly, so I've enabled
>> LTO once again.
>>=20
>> Regards,
>> Daniel
>>=20


--=20
Alex Benn=C3=A9e

