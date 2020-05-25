Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B3CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 12:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD7492073B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 12:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JgOCApKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7492073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdCZU-00032Z-Le
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 08:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jdCYR-0002PP-JJ
 for qemu-devel@nongnu.org; Mon, 25 May 2020 08:50:07 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34216)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jdCYP-00070B-KR
 for qemu-devel@nongnu.org; Mon, 25 May 2020 08:50:07 -0400
Received: by mail-oi1-x241.google.com with SMTP id w4so15954534oia.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 05:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CAKnaon9zo5ntl1jqDwL6CfW5kbbWJSVcRaKtg/ySyQ=;
 b=JgOCApKuQ5Qaj0/XqM0V/D84RhyKhBf7DLvj6tsHdM/fnqM9CJ+3uXAQVlOkNXIHkq
 UucoJllB61JiWiCxPoLuWb5b6WYHCTLEWb9RC3T8Oflh91hB5ERh/qruo9Sm8lUvJLyb
 +87yrqRKF0ppOYAqcgHdeG+xk6IMo2kKgJzKhXf532HTn/uV5FbTwWaVLrivMSAWxx3u
 14NFUvotzAG0fnDHXIx1bDc7jY5TVocbEa9K96f7nVO9wUsBIkYvmeaIbVqOsYZIhaII
 EzPnw1Bq/unZ/IMib1pefn01JL7F17thlk8jQyIgUfSeXC9s9o3/vW4L99F30gt0YGrk
 002w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CAKnaon9zo5ntl1jqDwL6CfW5kbbWJSVcRaKtg/ySyQ=;
 b=bISZnbld7VwtTekXMaZq3QmfGghTqrr3crSsQIkDSmsITljZ/4x/uXBPoJIT1QzaP/
 /aXNpSSQ1PY/UZKP/CxK/PuWsx3ZBwpSOL1CkDIA9LzQ64SBlBzqd3JQTYZH0Jpa3Drl
 mFko6mSPYuoYZytFQVy2/6TWuudzKhHyA1lCbXkUZmt+5JelakcoQmnXkNWDi/OVujV+
 s7kT4CeQ3WuSfDFa/miriPed7kMrkQtjHJjPWkKVKKC6kUm+d4XkD6idMqiESe/a8Scg
 KlhQCBWElODWchflW5/xEobTxm/UlqYfwoNDRhiBALaf/Q9AcHPnbRV6Ynol78mzwWfl
 LFTA==
X-Gm-Message-State: AOAM530aMoZx+mf3WBTykimo32H6d1UffnzTl/nanWsAGsViCAUsm1js
 Ge2YuFx2ExbfrnSwvSBgXVMwxzKVjQP/UtX5HN7xCw==
X-Google-Smtp-Source: ABdhPJxICd3yeJM0o34ti6DtZPaFkJWsdh5mhSpWroQt1WTYKu5dhefC/IA47UbR8xK2JZl60cAXyweoPU/E8FYpoPY=
X-Received: by 2002:aca:ed16:: with SMTP id l22mr10530103oih.146.1590411004556; 
 Mon, 25 May 2020 05:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-7-armbru@redhat.com>
 <CAFEAcA9UampZxo-4Z=6+LKkC9HLrdGYT5AcLyiGVYvgU5VE+cA@mail.gmail.com>
 <878shgh8be.fsf@dusky.pond.sub.org>
 <3ebe626e-0373-0eee-6a54-27a88d656122@redhat.com>
In-Reply-To: <3ebe626e-0373-0eee-6a54-27a88d656122@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 May 2020 13:49:53 +0100
Message-ID: <CAFEAcA_ddMMCJm+ykRdBxW5BpyMQHbZLAELr=fAGfs3H4TYXyw@mail.gmail.com>
Subject: Re: [PATCH 06/24] armv7m: Bury unwanted "ARM,bitband-memory" devices
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 25 May 2020 at 13:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 25/05/20 07:50, Markus Armbruster wrote:
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >
> >> On Mon, 18 May 2020 at 06:04, Markus Armbruster <armbru@redhat.com> wrote:
> >>> These devices are optional, and enabled by property "enable-bitband".
> >>> armv7m_instance_init() creates them unconditionally, because the
> >>> property has not been set then.  armv7m_realize() realizes them only
> >>> when the property is true.  Works, although it leaves unrealized
> >>> devices hanging around in the QOM composition tree.  Affects machines
> >>> microbit, mps2-an505, mps2-an521, musca-a, and musca-b1.
> >>>
> >>> Bury the unwanted devices by making armv7m_realize() unparent them.
> >>> Visible in "info qom-tree"; here's the change for microbit:
> >>
> >> What does "bury" mean here? To me it implies "they still
> >> exist but we've stuck them in a hole somewhere and covered
> >> them up", but the qom-tree delta suggests we've actually
> >> really deleted them?
> >
> > We really delete them now.
> >
> > "They've been lying dead in the streets; give them a decent burial".
> >
> > Would you like me to s/Bury/Delete/?
>
> "Bury unwanted" -> "Dispose of unused"?

Yeah, delete or dispose of would be clearer I think.

thanks
-- PMM

