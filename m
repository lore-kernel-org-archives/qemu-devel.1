Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6656C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 17:00:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B118C208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 17:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ymdmVnah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B118C208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60549 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQEJb-0003dy-Oq
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 13:00:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQEI8-0002sZ-AI
	for qemu-devel@nongnu.org; Mon, 13 May 2019 12:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQEI7-0002tM-2J
	for qemu-devel@nongnu.org; Mon, 13 May 2019 12:59:08 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hQEI6-0002sq-TV
	for qemu-devel@nongnu.org; Mon, 13 May 2019 12:59:06 -0400
Received: by mail-ot1-x343.google.com with SMTP id g8so12430459otl.8
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 09:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=tDNwIVxaQwtlasZZGSTnGm1NI68CaR4A7Mugb6KO2ro=;
	b=ymdmVnahJOlQbquus6pO1gbiuILzyw3i0yC0HkrCPHrM7B/gR9vGUlZ7mWqtnHXqn7
	dOra8AttVvhQXvzy3DfZozx0ybXsBALvuHWnir3Nii9LchuT2AT3/eYvBqMeJuzGqq33
	+SYoo+VwVPnnMbHTFJg45sXsAyr3MG3zOG5d1AhUUdrLhtupy3/mpy6deUqRK+Y2Mcik
	ngMfVurjjNXVtVEK5T4YWwkvV/FUGNM4uDV78mxmhoorovqxmQwV3MeH9a7w2+JXEQ5y
	Dwf/8Z4VF3KlWkj4Z+oeAxeW/Rni8ZBvqVQqthGKohZole7UwN+vjyrWSyp3YCs8x1Be
	W6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=tDNwIVxaQwtlasZZGSTnGm1NI68CaR4A7Mugb6KO2ro=;
	b=nrDTsV9Rhi/2GvexXa4qpouf+9etGERt1Yw/twDrsSxPX30+ELO4K9vhG4mewKsHAi
	0CHrJkc/clwrfWs/B9+fEHg6P+qoWM5cOxtCRphEo+UnDZejXb9OWg2jf6NgzEXBA407
	2RFIdCyfenD7wdbfj7aCbYL3ccabd1Ag8zjWhaORy2nrJZP08H57EgKeLieWvD2CSG4u
	SJwd9seNfCXE0JHLkpWoQiXSq9JXhdiE+yxtb/t1Hw6fmd+A7SurjHuXcSXL0tmm9l1C
	9PnWXIbyRHDUdBh8u4CIioCUc3Q7lPiwjoWN4UF/HMpLdbMol0YdC1KfyHDCl5ohF6Kb
	vF/A==
X-Gm-Message-State: APjAAAUeT1RS4iufy1cbYbmFTbeqQAIX7NlUbtvluzqs3DXLlSex3ZrJ
	1Z5b+62luE1QoL1p3eNuGu99cXkgeFaLA6EWza+2mw==
X-Google-Smtp-Source: APXvYqzD8uHXoQ4IZWfe/JP4m5/8x5VnwHUtY9rrZF26yG2MAeX6jfQJ1UdRxoCoOWty2SyZ300Hx0MPhjFRgvThi+U=
X-Received: by 2002:a9d:2002:: with SMTP id n2mr14186478ota.363.1557766745995; 
	Mon, 13 May 2019 09:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190513081844.26699-5-armbru@redhat.com>
	<mhng-5f5db13d-9ab7-414b-8979-4e119c319f78@palmer-si-x1e>
In-Reply-To: <mhng-5f5db13d-9ab7-414b-8979-4e119c319f78@palmer-si-x1e>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 May 2019 17:58:55 +0100
Message-ID: <CAFEAcA-qpxBS0HxD4xoEhGAjVTzHZC9e6TsSyb25C2HY2HseTw@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL 4/9] linux-user/nios2 linux-user/riscv:
 Clean up header guards
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Markus Armbruster <armbru@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 May 2019 at 17:56, Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Mon, 13 May 2019 01:18:39 PDT (-0700), armbru@redhat.com wrote:
> > Reuse of the same guard symbol in multiple headers is okay as long as
> > they cannot be included together.  scripts/clean-header-guards.pl
> > can't tell, so it warns.
> >
> > Since we can avoid guard symbol reuse easily, do so: use guard symbol
> > ${target^^}_${fname^^} for linux-user/$target/$fname, just like we did
> > in commit a9c94277f0..3500385697.
> >
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > Message-Id: <20190315145123.28030-4-armbru@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>
> I'm assuming this is going in through someone else's tree, so I'm not goi=
ng to
> pick it up into mine.

The subject line says "PULL" rather than "PATCH", so it is
already going into master (indeed I just applied it).
In general there's not much point in commenting on
patches in pull requests on the lists except for "this
has a problem, please don't apply it" feedback. (In that
case you should reply to the cover letter, because I won't
necessarily see replies to individual patches in the pull
before I apply the pull.)

thanks
-- PMM

