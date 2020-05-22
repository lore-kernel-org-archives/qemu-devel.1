Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FF6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 10:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E1B2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 10:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="utOtM65o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E1B2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc4tg-0000wJ-4Q
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 06:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jc4t0-0000WO-Fs
 for qemu-devel@nongnu.org; Fri, 22 May 2020 06:26:42 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:40248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jc4sz-0006GO-Lx
 for qemu-devel@nongnu.org; Fri, 22 May 2020 06:26:42 -0400
Received: by mail-ej1-x62d.google.com with SMTP id d7so12403389eja.7
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 03:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=r4K1EvN+/OBNlaavxClNGCpI9fPSlMCYlOXGEEZpvWA=;
 b=utOtM65o03rJyJWJGzRHDOPNCMuHNbDZx84R1UQYVeUJdXpqyI2npAk2dglguMbX7k
 9xagl8YxfpqS8V5BsfxOqHYn37JcAv25cT0Gf2rejn/Uj6AaqIBWcJn9K9mevGKtVJ3y
 vREwDuhQe0cyN17AZUO2jkm/HYWWkvJBoI8ZKMBe1mXsU0LgzCcy5rrK4XD5b12TPyM+
 TClyHnC92ZMEekLhSQo7Gw9s7IXUURLf3tJ2L3l1ZF71tpk87LJgd5Bodt7InvSO5ZZH
 KF3lACVQt5WPfIREphupPAsBdMOmkMO1WzmZ1sk3TQmzzHscNK/wYDnGBu/ToWiC0Iia
 u1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=r4K1EvN+/OBNlaavxClNGCpI9fPSlMCYlOXGEEZpvWA=;
 b=sTnIjsQeahfoOsfzRpLtbu7Uwh2Ap3n4aSxpFHA1uu/IaYmA/jPY5DA91Y0SNuNn1U
 9z6nuC2ioh7CT2d0d5OuJwTv2L1i7qX37xDD8uUc/9PIf+ykRTDm3RhULS1GgHP/cwND
 kzM5uWGLanErwTbsTdx/wyNfXwWgOGe5pSGKsxtD1Q21W/y3FWOEbwrc2KqYe2GbiUz6
 +Son2+Fc+pnvpU/Sk6VOXgjeGuUv5diucvruVGvnOS426JXrRdRwPDT+NJzfDdNlM+sH
 7VyBOF9CXbIZc0iQcliPi5o/Or8CRZxOlaq190XIPqdE2/P/bqNY7+af3Mw9j0KaFTJ0
 EFLg==
X-Gm-Message-State: AOAM532f8DNcn+R2MQylxy99zcRTyajolaoa70B03Bfs1EaJJfNwhx0R
 MvvcjCuN+AHydTYqS+VDJaKA5g==
X-Google-Smtp-Source: ABdhPJxOWyHFJgvNQ4U81dRPaRwMN+PpaE1qRjGLQv4rolR5w94VXPxmQTHfjsJR/uopMBFEhx7qng==
X-Received: by 2002:a17:906:dbef:: with SMTP id
 yd15mr7250673ejb.5.1590143199851; 
 Fri, 22 May 2020 03:26:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b15sm6825819edj.37.2020.05.22.03.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 03:26:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5BC961FF7E;
 Fri, 22 May 2020 11:26:37 +0100 (BST)
References: <20200521185407.25311-1-cfontana@suse.de>
 <20200521185407.25311-2-cfontana@suse.de>
 <1934989075.27890087.1590127622669.JavaMail.zimbra@redhat.com>
 <e64d5b81-8759-15ca-2486-dcc8ed10edc0@suse.de>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC 1/3] cpu-throttle: new module, extracted from cpus.c
In-reply-to: <e64d5b81-8759-15ca-2486-dcc8ed10edc0@suse.de>
Date: Fri, 22 May 2020 11:26:37 +0100
Message-ID: <87r1vce04i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 "open list:X86 HAXM CPUs" <haxm-team@intel.com>, Colin Xu <colin.xu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wenchao Wang <wenchao.wang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Claudio Fontana <cfontana@suse.de> writes:

> On 5/22/20 8:07 AM, Thomas Huth wrote:
>>> From: "Claudio Fontana" <cfontana@suse.de>
>>> Sent: Thursday, May 21, 2020 8:54:05 PM
>>>
>>> this is a first step in the refactoring of cpus.c.
>>=20
>> Could you maybe extend the commit message in the next version a little b=
it? ... say something about *what* you are moving to a separate file (and m=
aybe why it is ok to move it), etc.?
>>=20
>>  Thanks,
>>   Thomas
>>=20
>>=20
>
> Hello Thomas,
>
> thanks for taking a look, I will add an explanatory message.
>
> I was thinking something along the lines of:
>
> "
> move the vcpu throttling functionality into its own module.
> It contains the controls to adjust and inspect vcpu throttling settings, =
start (set) and stop
> vcpu throttling, and the throttling function itself that is run periodica=
lly on vcpus
> to make them take a nap.
> Execution of the throttling function on all vcpus is triggered by a timer,
> registered at module initialization.
>
> No functionality change.
> "

Is vcpu throttling a TCG only feature?

--=20
Alex Benn=C3=A9e

