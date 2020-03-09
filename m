Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C999BC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:52:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97358208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OxSjscx1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97358208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBJlg-0000Uo-NZ
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 10:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jBJi8-00043x-0Q
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jBJi7-0000Br-1n
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:48:51 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41556)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jBJi6-0000Az-Ri
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:48:50 -0400
Received: by mail-wr1-x443.google.com with SMTP id v4so11547607wrs.8
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 07:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=9KQyVLMP2rWBD3L3Q5N3RsBNyz1wOU3TYRnGw6z72bE=;
 b=OxSjscx1ycU0Z/ejCpw6jk8TBcS65ArP70hz27c8STANiTSqpcX5a3T1pqy80kp6po
 xzb+kNLB7/6lWDvstizGgzIV7WmFEqSe+SIB7STlJ7vQfKHpOyoNSuiU+X0H0KUq2L2u
 DiI7c8abOxsp4nlDJKRr0lFr3KOk4NT40ngcKMcodx1VGoYyRGiUjRxNxkHj69xmwd4m
 /z/SS1XPH74eYgxgvdEhZO08XtYyV9LB6RcpSlhv+7w6vZtOid8JLmkWhbXl9A1ej9R9
 ZHEhxKhkhHgqautMcXLtsL9bka+u2BYDsjKxFrMHeybgSSAFpm6Qii5FVad18gvJ/IXz
 eDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=9KQyVLMP2rWBD3L3Q5N3RsBNyz1wOU3TYRnGw6z72bE=;
 b=jkEKORtsCdkLdQ3ekZayGTRGjZLN4Hk2lqkeTHQ1g7vZBnzY7GKuyEdHstghgvhCrJ
 8eWuxVFMiIQOJxvllqGOXDfta20KrIKwvemWi4Vmj3gOy8gArgJC6Mb9dF4eBrZrcMAJ
 a5NTZCHOb7k+w6T/j3uCxFrUoxEt5vphdUqeAT5d6HcVzZUr8kWmh72hebwUjqfdWrTZ
 I/8uHqKPGGAe5J2oRnwt0vkGYqr2ppxmGIQtxFip0kBZKLpUcFwdEAqeIG9W0T0qgiAu
 +5IKWOSEKHjxeCNTUUIJSVaj1SOTXMdW5MPXgw33EpkJtX6OM4FjCTrguGX2KmSEip0/
 SQ8A==
X-Gm-Message-State: ANhLgQ2Icy9unqRKnIjkySOszo5rnjaWn3DOYuXzOOsyvqWBD9akVAXC
 BqSGY4uzyWujICDk1vCaBaj3Fk+19aM=
X-Google-Smtp-Source: ADFU+vuvs3lem4fQE73SyhDLXbtUd/kHXb9uyxfGB7aFHQTM0LRhpdbI3xrlu2vdVWXNvoQA63WYHg==
X-Received: by 2002:a5d:498a:: with SMTP id r10mr5182271wrq.278.1583765329182; 
 Mon, 09 Mar 2020 07:48:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c124sm9535091wma.10.2020.03.09.07.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 07:48:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 23DBD1FF7E;
 Mon,  9 Mar 2020 14:48:47 +0000 (GMT)
References: <20200221002559.6768-1-changbin.du@gmail.com>
 <20200309104322.u6ktpdl5yjdfcvqa@mail.google.com>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v2] gdbstub: Fix single-step issue by confirming
 'vContSupported+' feature to gdb
In-reply-to: <20200309104322.u6ktpdl5yjdfcvqa@mail.google.com>
Date: Mon, 09 Mar 2020 14:48:47 +0000
Message-ID: <874kuxk2i8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Changbin Du <changbin.du@gmail.com> writes:

> hello, is this patch ready to merge now? Thanks!
>
> On Fri, Feb 21, 2020 at 08:25:59AM +0800, Changbin Du wrote:
>> Recently when debugging an arm32 system on qemu, I found sometimes the
>> single-step command (stepi) is not working. This can be reproduced by
>> below steps:
>>  1) start qemu-system-arm -s -S .. and wait for gdb connection.
>>  2) start gdb and connect to qemu. In my case, gdb gets a wrong value
>>     (0x60) for PC, which is an another bug.
>>  3) After connected, type 'stepi' and expect it will stop at next ins.
>>=20
>> But, it has never stopped. This because:
>>  1) We doesn't report =E2=80=98vContSupported=E2=80=99 feature to gdb ex=
plicitly and gdb
>>     think we do not support it. In this case, gdb use a software breakpo=
int
>>     to emulate single-step.
>>  2) Since gdb gets a wrong initial value of PC, then gdb inserts a
>>     breakpoint to wrong place (PC+4).

OK I was initially confused because I couldn't replicate the failure
with the aarch64 tests. With or without the vContSupported reply I saw
the exact same set of messages go between gdbstub and gdb.

However I did replicate with:

  ./arm-softmmu/qemu-system-arm -monitor none -display none \
     -chardev file,path=3Dtest-armv6m-undef.out,id=3Doutput \
     -semihosting -M microbit \
     -kernel tests/tcg/arm-softmmu/test-armv6m-undef \
     -s -S -d trace:gdbstub\* -D gdbstub.dump

So I have applied it to me tree.

--=20
Alex Benn=C3=A9e

