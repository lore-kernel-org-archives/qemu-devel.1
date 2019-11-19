Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC599C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 09:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A72D220721
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 09:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VsfHeuE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72D220721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWzjc-00079j-SV
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 04:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWziq-0006Ra-DK
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:22:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWzip-0000U9-7N
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:22:56 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38814)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWzip-0000Sh-1P
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:22:55 -0500
Received: by mail-oi1-x243.google.com with SMTP id a14so18253906oid.5
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 01:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=INYAegvOpUBaRi4FPo8ZjEkeL6wUMxLwNO+KgbJ3gXI=;
 b=VsfHeuE31igtz93uXRDmrvmMnS71H+vpMVh8IK0xyWmTnznO6kkulBxLVAoN7g5Nqt
 DqVdjIrJbtDiVKxcU78RAdsRH5eJXPBk/bCvPuqzKt0oAFl35BvIQF8DtTvgkefBfpR5
 ytpmOxCGPbqGWY2Vko/zgKGYlOUI/Jgmq57R+/vOVHYgW+/It1jH69aVHzd9RhNdCs9w
 2ombuNddE0U0SbGdDHw8x/By69YowzZvOmVA/QVF270+On+PvB4Hs6bStgpKFBRWXftx
 qJ74YyoBq2dWFByPTsKdvNriJBrvvhkKaElKFjlkARpeIJXkHfk8j829D6EJ95N9yTe3
 d7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=INYAegvOpUBaRi4FPo8ZjEkeL6wUMxLwNO+KgbJ3gXI=;
 b=DFR6iOYqsS8L9RTKdOfu0qvU7d9WYdoS8r9HRHmtSKVq+cvkts+GD0v3JP0LtSsLnA
 SBjB/K0dwgIXq8Afw3RA8ysGRinwtm9nzY+u46ls66PJrPjQRv2lFpEBljyp3YwH7yCV
 Gk/CXFSFqPAJ+Ji0N0YfXPAIuMwCfx/bl1vVfH2hZVtHq1YLLeBlH/NmN7lQhfiNpuaE
 VnorwbCzFC+3uFoa4nzwVSzP9WJyc9UFSGtdnqjjVAGteJXLIskLo6XqVQK/4v5xLDnf
 MQWhY1zs56h5ELcs6dOPDWKfwKRubIgomsjxDsrtsEITMCFpqtxPoNno3DylbAXTyJfW
 7K3w==
X-Gm-Message-State: APjAAAW/zz+7f8Y/G+yPCAVQKVv6BAYSAt03q7moJOlrGvJrWSgmM5Mu
 ONb1SAaMHq/cpEB/TE58NRopYz+vqwFgXr+ZAVMsaQ==
X-Google-Smtp-Source: APXvYqzHBQQ6NtVrgBUqRoknC4LDQfFlsz2kVDCS8PP/yzobSSG44vqgR5pUZL2rAvyFafIVKnEqqHEFjXbBVWZgbb4=
X-Received: by 2002:aca:cf12:: with SMTP id f18mr3076287oig.48.1574155373787; 
 Tue, 19 Nov 2019 01:22:53 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA-mD3-Zg2JunGpMqbcaT1qboCenhqEFytZD0FmFcL2i9Q@mail.gmail.com>
 <5dd613c0-6d9e-b943-b64d-7ba1791cbefe@redhat.com>
 <CAFEAcA-4r53vM-K24WYr1OFSOufhZ7hDHeZBhnywyaJ0gpMO1g@mail.gmail.com>
 <20191108191057.GZ3812@habkost.net>
 <CAFEAcA_No5oAFtULbAOrPDeQE18HHgc0agXbs4m2AGZ+gK_ReQ@mail.gmail.com>
 <66c64c6d-b7c0-2cb1-2b29-4fdd9b369714@redhat.com>
 <CAFEAcA-Q7H9sZjN-PcMMDHQU41yN1RdXhNY5KqMh7E6xh0yjgA@mail.gmail.com>
 <3aa1d025-20a3-e813-2fe6-35518efedf2f@redhat.com>
 <20191118184906.GB3812@habkost.net>
 <CAFEAcA_iTX2TKh20DB9ZMtDLuPm=OvoyP==KRhfVh99BqDnrzA@mail.gmail.com>
 <20191118220417.GF3812@habkost.net>
In-Reply-To: <20191118220417.GF3812@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Nov 2019 09:22:42 +0000
Message-ID: <CAFEAcA8XoyeAfHuKe0AEvecCzo748Yk1VD1+VD=C3ACZdfzwsw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] s390x/cpumodel: Introduce "best" model variants
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Michael Mueller <mimu@linux.ibm.com>,
 Jiri Denemark <jdenemar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 Nov 2019 at 22:04, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Mon, Nov 18, 2019 at 09:19:55PM +0000, Peter Maydell wrote:
> > Why should it matter whether a feature is enabled
> > or disabled by default in the CPU type? It ought to be probeable
> > by QMP either way (ie there is a difference between
> > "this CPU has this feature switch and it is on by default",
> > "this CPU has this feature switch and it is off by default"
> > and "this CPU does not have this feature switch at all",
> > and presumably libvirt needs to distinguish them).
>
> Its use case is neither "this CPU has this feature switch" or for
> "it is on|off by default".  We use it to probe for "this feature
> can be enabled in this host hardware+kernel+QEMU combination".

OK. Well, the answer to that depends on the name of the CPU,
in general. So you can't use a fake CPU name to try to answer
the question.

> In other words, in x86 and s390x "max" is just a reserved name
> for the query-cpu-model-expansion command arguments in s390x and
> x86.  The fact that it is visible to users can be considered a
> bug, and we can fix that.

I think 'max' is useful to users, and we've provided it to users,
so removing it again would be a compatibility break. I'm not
entirely sure where we go from here...

> If you still don't like how query-cpu-model-expansion works, we
> can also discuss that.  But I'm not sure it would be a good use
> of our (and libvirt developers') time.

I don't hugely care about query-cpu-model-expansion. I
just don't want it to have bad effects on the semantics
of user-facing stuff like x- properties.

thanks
-- PMM

