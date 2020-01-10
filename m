Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623D1C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 12:15:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E2F42072A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 12:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qWi9kdpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2F42072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iptCR-0008Tq-7n
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 07:15:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iptBW-00077C-KO
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 07:14:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iptBV-00085B-9d
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 07:14:38 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:36223)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iptBV-0007wz-0S
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 07:14:37 -0500
Received: by mail-wr1-x430.google.com with SMTP id z3so1608762wru.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 04:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:subject:in-reply-to:date:message-id
 :mime-version:content-transfer-encoding;
 bh=iVoWEeOPJYlBVs2PS/vrGYvRIj8LmXHd8VwGxf+PwbM=;
 b=qWi9kdpgvXUY6VeIFgkpPCv+YYgYg/CWnQzsigPant4JGAzhmXTsYcO07lmx7HEhM9
 vZ27JXbn+VJ3xd1WpAFwbGRIBpNL4faX3+Ao9wb+1BHf4orMlOCp1kQIeSHZ+JDNe4EO
 buMlMfbzMXi1dRY8Kfvp+l5VWX41D0ucTfLnpMRBmj12eSNdXNqBsOROTX0uNTCATco9
 qZCACTFOKcEvxVjn6598ytYsOLLn4a1RyeuW9uDSyapF+UtJkUksNHu0XguMOAoT+tBa
 sadNzyxDY67HP68VBP2bzsLv2EBOqHLwvcC1V0iBExZ7JmrmJGpal/Ukl947cDHMRvgX
 d18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=iVoWEeOPJYlBVs2PS/vrGYvRIj8LmXHd8VwGxf+PwbM=;
 b=sK8VwQbW9wUPKkmR49UzE9nj3LDn8W4Fs7Zt5v07srMp8hJWI14oXZcfMW+4XeOgmJ
 +EoyChJMldheX2rk0XQWqDmmcbEwwGmXy5NJ4xt/5dXOfZLj9imS2mCvei6Faow6V+o+
 rS1G6Rjn+jBltSEEENyKZ8gP85HIlT8Ng2sn6C1QXbc4IJA502+0DQ8w75rZNwc/gLSu
 m0fNSAyvXrGI29xvG1ioZbmr4y1YFxXbIBv+3BIYaOXaE8ZDy9SWNw3hMnUnvvKjoakH
 MsTktGmpKSQ6QAhW6fNAkFDBcKuzp6ADPQ9v+wK3ubFZmP7+Uku2UE8kJ8Ss9M2onyfe
 3sBg==
X-Gm-Message-State: APjAAAWpprJY4t7DKtytOu+ZzU59QNLppZtsdXJBqiRM1MhSh3Pqgc73
 jGV1lBfyS8T3B97n4xBzXm1syd2oX4Y=
X-Google-Smtp-Source: APXvYqyKFT6aMa8wfeYT+ZQmygT1f8uuR6cO8+KEbvNOsPhG7wyLJq/YzX5Egm3618GVH57HNckXOA==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr3185106wrj.261.1578658474480; 
 Fri, 10 Jan 2020 04:14:34 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c9sm1970706wmc.47.2020.01.10.04.14.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2020 04:14:33 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5AB821FF87
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 12:14:32 +0000 (GMT)
References: <MW2PR2101MB1035A21608E50D68EE1CF890D63C0@MW2PR2101MB1035.namprd21.prod.outlook.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: plugin order of registration and order of callback
In-reply-to: <MW2PR2101MB1035A21608E50D68EE1CF890D63C0@MW2PR2101MB1035.namprd21.prod.outlook.com>
Date: Fri, 10 Jan 2020 12:14:32 +0000
Message-ID: <87eew7ik47.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Henry <robhenry@microsoft.com> writes:

> The documentation on the new plugin capabilities of qemu is silent
> about the order call back registration should be done, and is also
> silent on the order in which call backs are fired.

Call-back order is based on the events themselves not the order of
registration. The only real order constraint is instruction
instrumentation has to be done from a translation call-back as that is
the point you can query what instructions are being processed.

But you are right the documentation is silent on the details because you
shouldn't need to know about the internals of TCG for the
instrumentation to work. We can certainly make this clearer in the docs
though.

> Case in point: The callback registered by
> qemu_plugin_register_vcpu_mem_cb is called after the call back
> registered by qemu_plugin_register_vcpu_insn_exec_cb, regardless of
> the order of registration.

With that in mind we should say instruction callbacks are always before
the instruction executes. The reason being is some instructions can
fault and exit the run loop so any instrumentation inserted afterwards
will never execute.

Internally instruction instrumentation is done on instruction boundaries
while memory instrumentation is done on individual TCG operations (of
which several can be involved in an instruction). However plugins
shouldn't rely on this knowledge as we want to be free to change TCG
internals.

> However, I'd like to have the insn_exec_cb called after the mem_cb so
> that I can save the mem information to be consumed by the insn
> callback.

This is what udata is for. Create a shared structure for the instruction
information and pass it to both the mem and insn callback functions.
However not all instructions will generate mem callbacks and you will
also want to ensure you track the cpu_index in -smp > 1 tests so you
don't confuse data for the same instruction on multiple cores.

You may not even need to install the callback for the instruction if you
store the information you need at instrumentation time. It's hard to
know without some more background on what you are trying to do.

--=20
Alex Benn=C3=A9e

