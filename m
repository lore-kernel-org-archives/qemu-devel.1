Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0F1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE771208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uuDHPJj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE771208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Rft-0000we-82
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 05:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k1RaW-0003lB-TU
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 05:44:28 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36635)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k1RaU-0005Ib-SL
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 05:44:28 -0400
Received: by mail-wr1-x441.google.com with SMTP id 88so27373365wrh.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 02:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qeGSqd0GTYjIeTcFeJsppsJXVYqxgxNSujPajAXMAZQ=;
 b=uuDHPJj8K/EdZfvTBT9GDRAwoHKD0JGaGVYOuONLJEUNuILuWhidQ72nVlZIoKTpgS
 zw8EyQNC8iRSE0WkjqhkLYpOzhPbqxFXRhMkYfchxi6JsdsAeWQqUZG99p0Ycv0O6wM0
 h3AhdTQwBHkyYu/XH5avtDr1RhrG3WZvUbc8yao7cbPkWsXKK0styimeGmIwNJRss9iw
 APRqc0vbG4naw+Qyb1zBIX03ysoJAj8R3HI8JD8tAKl9inmwnRhY7F2G8bcFah3A+9Fq
 AEQBma1lF8TxFaQW/DCGEE+MjbC19lUCr9solTKMKMFAY9lJCGHsdjUR+JIstY5elG5a
 s5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qeGSqd0GTYjIeTcFeJsppsJXVYqxgxNSujPajAXMAZQ=;
 b=fUaQk5J/gvxH0T+Y862Y9JxXIC18XEyfuoKU0Xhm5pZ35fU32H77wepm9PGBLiL2sy
 UME3k9Y4UTIpbcyOBXngUeAVzDSiCv/k8ggwbXl+8ph6V3AOPSJCPltdZVHACUSWpjLA
 44EmaAXjktnvzh1fCjI+IgCXWd47Be3oO7KleNg1fr4zHW0RKgmWk+7WiclA1wVK+27E
 MGyKfOmh5XGUp+FTw5F5BVrrRLPuKwP2f+23jrYt02DiHprfII3b+tjpavL4guZu1oJG
 OOD7mbvK5Jko8bmE6yA5EF+zoWaZFrWjlShuBJpnM+IlqGeHNBrNtsWvRt26+AkMx1Iq
 AXvw==
X-Gm-Message-State: AOAM533JfzVJuo3PuusxM6URgiOmrCLHmrhUVbF8y/c6VuqGyfpIId8r
 2tVhGQaOySOJndvxirrT5Udz4Q==
X-Google-Smtp-Source: ABdhPJwRzYf3LOotOv5byeanboWaa/RoBi2VSBgsebRrKHhJq/lH69uKLseMutQIAdhdAzWJn0mXKw==
X-Received: by 2002:adf:f007:: with SMTP id j7mr2557483wro.195.1596188664554; 
 Fri, 31 Jul 2020 02:44:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z127sm12738114wme.44.2020.07.31.02.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2020 02:44:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 90DCB1FF7E;
 Fri, 31 Jul 2020 10:44:22 +0100 (BST)
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-13-git-send-email-steven.sistare@oracle.com>
 <87r1stdjes.fsf@linaro.org>
 <b18f2181-902b-a091-9711-93d49ab8aec8@oracle.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 12/32] vl: pause option
In-reply-to: <b18f2181-902b-a091-9711-93d49ab8aec8@oracle.com>
Date: Fri, 31 Jul 2020 10:44:22 +0100
Message-ID: <87tuxo2f49.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Steven Sistare <steven.sistare@oracle.com> writes:

> On 7/30/2020 1:03 PM, Alex Benn=C3=A9e wrote:
>>=20
>> Steve Sistare <steven.sistare@oracle.com> writes:
>>=20
>>> Provide the -pause command-line parameter and the QEMU_PAUSE environment
>>> variable to briefly pause QEMU in main and allow a developer to attach =
gdb.
>>> Useful when the developer does not invoke QEMU directly, such as when u=
sing
>>> libvirt.
>>=20
>> How does this differ from -S?
>
> The -S flag runs qemu to the main loop but does not start the guest.  Lot=
s of code
> that you may need to debug runs before you get there.

Right - so this is for attaching a debugger to QEMU itself, not using
the gdbstub? Why isn't this a problem the calling entity can solve by
the way it invoked QEMU?

We have similar sort of solutions for debugging our testcases:

  https://wiki.qemu.org/Features/QTest#Using_debugging_tools_under_the_test=
_harness

I still think:

>>> +DEF("pause", HAS_ARG, QEMU_OPTION_pause, \
>>> +    "-pause secs    Pause for secs seconds on entry to main.\n", QEMU_=
ARCH_ALL)
>>> +
>>> +SRST
>>> +``--pause secs``
>>> +    Pause for a number of seconds on entry to main.  Useful for attach=
ing
>>> +    a debugger after QEMU has been launched by some other entity.
>>> +ERST
>>> +
>>=20
>> It seems like having an option to race with the debugger is just asking
>> for trouble.

this make the option problematic.

--=20
Alex Benn=C3=A9e

