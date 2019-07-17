Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5097C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 05:52:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E80B208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 05:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGknuMyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E80B208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hncrT-0004Ks-5G
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 01:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53557)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hncrH-0003qo-Of
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 01:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hncrG-0004SN-OA
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 01:52:07 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45057)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hncrG-0004Rf-GH; Wed, 17 Jul 2019 01:52:06 -0400
Received: by mail-pl1-x644.google.com with SMTP id y8so11341133plr.12;
 Tue, 16 Jul 2019 22:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=dyii7OzM9BEAQWAHGWXgY3eBnqGqjuUvvPm9UTOyZUU=;
 b=kGknuMydzu7b0sYF3N8EWkl50T2ZaW4XURYaAxdDWhxgIxGtB7nBaXk6QBQL60Wjuj
 GRhPgr//G+gNspvAzgZ5QVlhB44i28+o6gUvuuCtXY6BBcwRMF/kShnFXHaKEs/vPIjN
 2XrGkf2iLFkLedbm4rhYVSKYO5nas8Yol1jcEaHCz11Cko6pxZGhWxoGCDD6ti32kR+L
 2ZHphgQLRhEpsy+Z5LSovqsLW645FuyNVLrbRvctkAGwgTc66WwdlCqGMUOSeMuCgqOz
 RM5R/WN1xl/UMGAYMrdpmH17U7E/Q1Hs0+zzbhi4f9gNWASAFQs6ZxpXp4y/r3C+GLNF
 KmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=dyii7OzM9BEAQWAHGWXgY3eBnqGqjuUvvPm9UTOyZUU=;
 b=VwMSDn2qViKTVqq4VRMrZ2eB9rh2jR4MuGnkYza+42OSHd0WHyZYhzpWiBwuyypF3o
 Ysh9mIicrwESTO8rZJoxWLUR3ozh1Jh7JcsC33XB4sKPI8Eed93xyIsDBrIOvJ+i/QvV
 lbtoEjhsy1VyUtMHCYJiUztFaYmoI3aij2NDGAnsoE8D8Zyd/s3OvEW1mA6mluA0+8vz
 n+/udd+tGC3FCfGSZURQXKBP0SOOXiC+OxImwNIJ/0ZAVSKh3W7HKn7piYamtr7OFOHB
 ZwLP0XYJ63aD3W5WdAr9PEmXEjx+ksxk9d9LuRb6EEyRF+ZiE3PE/Pu0VivfZ8rfaWGp
 /2Vg==
X-Gm-Message-State: APjAAAVufvy1B1H9o2sCkaO1W+F0ukn/9XTzdZn797XSiKf4kF6/5Pr0
 dceAP7efFj4noe+QxA/18go=
X-Google-Smtp-Source: APXvYqzZ/jRNSGANBqVzekjXbjSQ1O2nj14Mw9KW3i6DFPx+ULE0HvN9MbVwLzFiFQDFmwrMB9blMw==
X-Received: by 2002:a17:902:8d97:: with SMTP id
 v23mr39846796plo.157.1563342725023; 
 Tue, 16 Jul 2019 22:52:05 -0700 (PDT)
Received: from localhost ([203.220.8.141])
 by smtp.gmail.com with ESMTPSA id g4sm30254347pfo.93.2019.07.16.22.52.03
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 16 Jul 2019 22:52:04 -0700 (PDT)
Date: Wed, 17 Jul 2019 15:51:58 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190716024726.17864-1-npiggin@gmail.com>
 <20190716024726.17864-2-npiggin@gmail.com>
 <20190716073433.GC7525@umbus.fritz.box>
 <1563269012.r4tmfz9h7z.astroid@bobo.none>
 <20190717015115.GA9123@umbus.fritz.box>
In-Reply-To: <20190717015115.GA9123@umbus.fritz.box>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1563342619.r5pqecq8gt.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v4 1/5] spapr: Implement dispatch counter
 and prod bit on tcg
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Gibson's on July 17, 2019 11:51 am:
> On Tue, Jul 16, 2019 at 07:27:22PM +1000, Nicholas Piggin wrote:
>> David Gibson's on July 16, 2019 5:34 pm:
>> > On Tue, Jul 16, 2019 at 12:47:22PM +1000, Nicholas Piggin wrote:
>> >> Implement cpu_exec_enter/exit on ppc which calls into new methods of
>> >> the same name in PPCVirtualHypervisorClass. These are used by spapr
>> >> to implement these splpar elements, used in subsequent changes.
>> >>=20
>> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> >> ---
>> >>  hw/ppc/spapr.c                  | 25 +++++++++++++++++++++++++
>> >>  hw/ppc/spapr_cpu_core.c         |  5 ++++-
>> >>  hw/ppc/spapr_hcall.c            |  5 -----
>> >>  include/hw/ppc/spapr.h          |  7 +++++++
>> >>  include/hw/ppc/spapr_cpu_core.h |  2 ++
>> >>  target/ppc/cpu.h                |  2 ++
>> >>  target/ppc/translate_init.inc.c | 25 +++++++++++++++++++++++++
>> >>  7 files changed, 65 insertions(+), 6 deletions(-)
>> >=20
>> > Mostly LGTM.  Please do address the style issues that the bot
>> > reported.
>>=20
>> Will do.
>>=20
>> > In addition, do the dispatch_counter and prod values need to be
>> > migrated?
>>=20
>> I was thinking no, it should be just a blip. But could the guest
>> be reading the dispatch counter in the vpa for some other reason?
>> There are other (unimplemented) dispatch statistics in there AFAIKS.
>> Linux doesn't, but others might.
>=20
> Right, I guess it's a question of whether a guest would get confused
> if the dispatch count suddenly resets.

Linux wouldn't AFAIKS, but...

>> And what about KVM, does any of the VPA data get migrated for=20
>> KVM guests?
>=20
> Well, the stuff that's actually written into the VPA is implicitly
> migrated, since it's part of guest memory.

Yeah I just sent a patch which uses the VPA directly, so it matches
KVM and should get migrated.

Thanks,
Nick
=

