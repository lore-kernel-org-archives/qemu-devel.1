Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83088C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:13:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A5A20867
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UxNKhS1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A5A20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaiot-0000zm-G3
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 12:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaigs-0001qq-MB
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:04:50 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:33603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaigq-00072x-0F
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:04:49 -0500
Received: by mail-ed1-x533.google.com with SMTP id v4so2317132edi.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 09:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mQyCua0h3UomvintUsOTYbWQgEYfCyzV14qDkLAEeNA=;
 b=UxNKhS1RhrXkHgPCxTXm/19Xoyh9GqLOilYPoKEiBEiDNA6VLGHxF934dRZgOjZ0pZ
 8N2ZE41NNQe/WpFJTKb673XCwcoHZQl2wfw7pBP637rqxh2Jn9apwZdqpvyae7XF8KAr
 ajBKifoqcouWcHeRJALdHfpdLyCnKTsRviZYgC6kTTDWjiKF6YNp4nAeczpwLJjLNi7v
 VfKRqJvWxBlFAZ90Nn7A3gpoSZeZIhjesB5IKxVN1iMX45nTZdtYmWMFZ3JCrXkodMBZ
 j437iXuG8+rlH3gwhbhkKTwkrCy35sLtvmCFDi4ti2nOsB+4Dib4P5Uf3neL6K3hCrOi
 KoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mQyCua0h3UomvintUsOTYbWQgEYfCyzV14qDkLAEeNA=;
 b=ue7YI+dyMGmCnA5Iy3GDuq4P09OHyPmPnRAfGR0A4oxx8NmZ1/iKNuV1DTpB9dc9jU
 fT6Nyi27o1jRjAsl4IT6w5fZ69rlCrs7hGtfxymqtFsfNsj/5bdPfv0efM5Ixl1kNPI3
 IgEzEf7WpaYvUUPR3hKF5FkNmheYcVmRZBniuSG12tAx4x4B7OZycYvOk/ouFyetOrJc
 K9CGEG3QAKLnR/BW8RqoOQZBnTDmHpTnMJMWkJ/TOk+uOoJUfebwuQR6CjdAKqidwjBw
 /pqAolqGXNmtCn9j8cknFZ0L0BoF+eemcdnw31hhjsPoPdsx1hvO4n73C/rgQNp37YsI
 OfEw==
X-Gm-Message-State: AOAM530Ifzjmgg7VljkqBrdhPJ27LpaE68RamxqHGqp6XIVzqMUpzlcX
 PZR5IbcVv68MmIiyt8pCszrNvPibV//WQCbqW+IERw==
X-Google-Smtp-Source: ABdhPJyPKqLZnsA72dLd5a6WF92gjoABPZyGFi7x9ihzDRRy6UG8+3W/Hh5o193nqFZkMQutzFIWy9Y0DFWdewMNSng=
X-Received: by 2002:aa7:df82:: with SMTP id b2mr3442630edy.251.1604595885917; 
 Thu, 05 Nov 2020 09:04:45 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+F1CJ7KpB8C6-_+Gdh6twqjjRMweERUapw4tfjKyMqa6AM0w@mail.gmail.com>
 <CAFEAcA86UyXfir3JA3E2vuJNZBGOhbxzvomemaCLg6uwOB3c8Q@mail.gmail.com>
 <20201105163605.GX47859@linux.fritz.box>
In-Reply-To: <20201105163605.GX47859@linux.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Nov 2020 17:04:34 +0000
Message-ID: <CAFEAcA_ff6bRythvzJWs0McUSz3=2=1=hV9wX_BTv00jPfSHsw@mail.gmail.com>
Subject: Re: Documents not in sphinx toctree
To: Jens Freimann <jfreimann@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 QEMU <qemu-devel@nongnu.org>, Sergio Lopez <slp@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Nov 2020 at 16:36, Jens Freimann <jfreimann@redhat.com> wrote:
>
> On Thu, Nov 05, 2020 at 04:19:00PM +0000, Peter Maydell wrote:
> >On Thu, 5 Nov 2020 at 16:14, Marc-Andr=C3=A9 Lureau
> ><marcandre.lureau@gmail.com> wrote:
> >> By running sphinx over the docs/ directory (like readthedocs.org presu=
mably does), it finds a couple of rst documents that are not referenced:
> >> - cpu-hotplug.rst
> >> - microvm.rst
> >> - pr-manager.rst
> >> - virtio-net-failover.rst
>
> Given the current structure of the content in
> https://qemu.readthedocs.io/en/latest/,
> would adding this as a new bullet in "QEMU System Emulation User=E2=80=99=
s
> Guide" be the right thing to do?

Adding which?

For cpu-hotplug.rst:
 I guess the system manual. The document has a bit of a
 "tutorial" feel which doesn't entirely fit the rest of the
 manuals.

For microvm.rst:
 docs/system/target-i386.rst should be split into
 documentation for each of the machine models separately
 (as a list of links to docs in docs/system/i386/, similar
 to the structure of target-arm.rst and docs/system/arm/).
 Then microvm.rst can go into docs/system/i386.

For pr-manager.rst:
 The parts that are documenting the qemu-pr-helper invocation
 should turn into a docs/tools/ manpage for it.
 The other parts should go in the system manual I guess.

For virtio-net-failover.rst:
 Should go under the "Network emulation" part of the system
 manual, I think.

thanks
-- PMM

