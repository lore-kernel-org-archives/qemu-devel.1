Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6D5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 21:42:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EBFA20825
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 21:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V/C/JnH6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EBFA20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaQXq-0005HO-IJ
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 16:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kaQVz-0004HF-ED
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 16:40:23 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:32833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kaQVx-0006yH-Gf
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 16:40:23 -0500
Received: by mail-wm1-x344.google.com with SMTP id p19so2747737wmg.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 13:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=StLLJpqFeknYv6++woqTDBbc2ehjvYkSEd25q63vRxc=;
 b=V/C/JnH6hJqfL+7FIWB2Zbeh5ttg7DiuxooMh1UTz+TF+BS7xXmoEQn9AwA+wL1jml
 tH0TnEZJzV95Q2/X/f01OXTZs6fnORZRc8ybAfrgmsVUXcJeGvrXpyPBwP6rAGFSoHA2
 UMFVJ7+Rmi5CWPEA8993rQf3BJJ0GARM/FlAzGZBf9ymC3CcpR6abPcJJwLLfIWJgVKe
 Uf5UsZvpceb+dJ9ziMKLdCGwtbgDY6V71O62b6FQjQb/YFlza9wMn7OuDKs4ee0QC5hg
 PY9xlHxu/6izjobSGTHidzTB3b0CsJL84bfF2+XF3CRRDgyJfe0QJ1BD2hegrVtbcCuU
 rx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=StLLJpqFeknYv6++woqTDBbc2ehjvYkSEd25q63vRxc=;
 b=oRQfEr1yWP7rX1lT6hVIigulmTX/XQmjqzKP2tDRvdXb3PtkN/nL09ZvM5eO7oJv8o
 jb/XYsN3MoJ5iH2yW6wlgo6k8UAHtVvAamz+zuzY7ZnMhlz/0foqPIXqBvNVbXAehN2a
 yTju3NReI3ikDiUiKjyB7OTrq68y+woD+dZ3BYjK5x5OrUEH8wvArzL8+zbDMN0thz2e
 X+NdxC/sH3tKyC605/XpCHmIH4toJOTxokTIsxyAyv0mHG08XiNkMjTYEZFGaMWo9jtz
 mbzXfEjDRF9R1i8XKqSgPbxLfNRMOAUN7+ko5aos1CY/jz12dKK5NpOMUX79NFlpFelX
 2PbQ==
X-Gm-Message-State: AOAM530jpt/yTNAFQIu8eb5lDNvuwo0hYUJMbxi7a7dADKr4lGtOO7Ev
 FqAbk9GwaOroIdNukTGbJhbrH7tT/gu5mA==
X-Google-Smtp-Source: ABdhPJzSCV/Z7ZLtVp3maoq8FvjrgaZRWD3Viz3Vgqc1Opaax2IH+zusirgPuFw8nYRpOcA9MzlEqw==
X-Received: by 2002:a1c:bac1:: with SMTP id k184mr6520906wmf.76.1604526018779; 
 Wed, 04 Nov 2020 13:40:18 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y201sm4351106wmd.27.2020.11.04.13.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 13:40:17 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 603F61FF7E;
 Wed,  4 Nov 2020 21:40:16 +0000 (GMT)
References: <1604332203-435466-1-git-send-email-steven.sistare@oracle.com>
 <d93b83ea-f31d-4e6b-2350-c6d4c9b71448@redhat.com>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH V2] vl: pause option
In-reply-to: <d93b83ea-f31d-4e6b-2350-c6d4c9b71448@redhat.com>
Date: Wed, 04 Nov 2020 21:40:16 +0000
Message-ID: <87imakby2n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Eric Blake <eblake@redhat.com> writes:

> On 11/2/20 9:50 AM, Steve Sistare wrote:
>> Provide the -pause command-line parameter and the QEMU_PAUSE environment
>> variable to pause QEMU during process startup using SIGSTOP and allow a
>> developer to attach a debugger, or observe the process using tools such =
as
>> strace.  Useful when the QEMU has been launched with some other entity, =
such
>> as libvirt.  QEMU_PAUSE is checked in a constructor at the highest prior=
ity,
>> and can be used to debug other constructors.  The -pause option is check=
ed
>> later, during argument processing in main, but is useful if passing an
>> environment variable from a launcher to qemu is awkard.
>>=20
>> Usage: qemu -pause, or QEMU_PAUSE=3D1
>> After attaching a debugger, send SIGCONT to the qemu process to continue.
>
> Changing behavior via a new environment variable is awkward.  What
> happens, for example, if libvirt inherits this variable set, but is not
> aware of its impact to alter how qemu starts up?  Can we get by with
> ONLY a command line option?
>
> Also, how does this option differ from what we already have with qemu
> --preconfig?

In the original discussion:

  Subject: [PATCH V1 12/32] vl: pause option
  Date: Thu, 30 Jul 2020 08:14:16 -0700
  Message-Id: <1596122076-341293-13-git-send-email-steven.sistare@oracle.co=
m>

it seems the idea was to stop qemu as early as possible for debugging
when launched by some other launcher which wasn't modifiable except by
pass through configuration to QEMU's command line.

<snip>

> Isn't it always possible to provide a wrapper qemu process to be invoked
> by whatever third-party management app (like libvirt), where your
> wrapper then starts the real qemu under gdb to begin with, rather than
> having to hack qemu itself to have a special start-up mode?

I agree - this feels like a bit of an over complication as a debug
helper. How many times can a failure to launch by some binary blob not
be debugged by either a gdb follow-fork or a copying of the command line
and running gdb --args?

--=20
Alex Benn=C3=A9e

