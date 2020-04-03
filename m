Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA00AC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:06:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 885D2206F8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tcUIogvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885D2206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKHL9-0002Cu-NE
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 04:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jKHJw-0000bS-1P
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jKHJu-0006zj-Vj
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:04:55 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35390)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jKHJu-0006xb-QM; Fri, 03 Apr 2020 04:04:54 -0400
Received: by mail-pl1-x644.google.com with SMTP id c12so2420922plz.2;
 Fri, 03 Apr 2020 01:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=lEpqq3JA9iuwDGTpovSHin12JFafCJybb5KoETxs7js=;
 b=tcUIogvKcP3LFEwi+5YQHwsNJ0NxWFp53B4A/4bIGLEIb/QAUm3uQaaD7ZHMwCFsVp
 Y7jfUuEBmTds67EDbanBBJzHxGcnGwSHuj+sEKRufWPNo6TM3VEIjrPQN3/gSxR98Syd
 GeDJbDndH1jVJaJ0OI9TijV8GtAutyl6c56yjl0RR4Hz0zRDLhnE9wvh7Low3p0WHeBL
 ZmcHyrVfZrP1/ODoc5qLX7kLFmhHkgnLJjgDVVdcZztNi0YqHZVbnza9AQ4xamEDVmpt
 9uepZjFt1m2HVxnBntjAgHpuwaV8vhtKrT5qSFdOdhfjdKP9WcyeA3fZOHs18ZlZDOjn
 bJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=lEpqq3JA9iuwDGTpovSHin12JFafCJybb5KoETxs7js=;
 b=Kcm55IwIA9bxk+enSwvVWq0lmZL0cxDr5kXPLgqWNoNKtjRALM8odf5gxH4l4z7n0d
 ZbjsabVXXTjD4niKf28doAQrvf87W4j2vSvHg9zoLjofH6wc8LcIlJugKreA85WrYXST
 PlQMGN3zto3zbAtdoMXDuRpDodsoxh+nphM1pigiQPM77qmm3xcw6gZFs40j+4zmPTuT
 nV6HSd6zaLfL5J9y5pOxX0jVkCebOvJtO9odXcDVpWBZdLsWVW8GjSjcnC14N/NqxZGo
 B2bQgzTAZowbOzwfJE9gZvvNHt10if+Mie86hfaNHCKGOt2DKnpeKKZbH5dG7lc9m1jS
 1qyQ==
X-Gm-Message-State: AGi0PuYhwgURsuqPYatQ5DXkHCEy2xja9sWcGU0aq3ctUKohpa09Qpyt
 epTnX8UCRufocuERArLJl8U=
X-Google-Smtp-Source: APiQypLvXwg5YhXveFNIP1UanSYTUE8nCeZhG+ZnjwaaHlfxnRIvQEQINpizuuFYqbQ7te17aB5I8Q==
X-Received: by 2002:a17:902:a416:: with SMTP id
 p22mr6924998plq.57.1585901093796; 
 Fri, 03 Apr 2020 01:04:53 -0700 (PDT)
Received: from localhost (60-241-117-97.tpgi.com.au. [60.241.117.97])
 by smtp.gmail.com with ESMTPSA id q71sm5361364pfc.92.2020.04.03.01.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 01:04:53 -0700 (PDT)
Date: Fri, 03 Apr 2020 18:04:47 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/5] nmi: add MCE class for implementing machine check
 injection commands
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200325144147.221875-1-npiggin@gmail.com>
 <20200325144147.221875-4-npiggin@gmail.com>
 <20200331002203.GB47772@umbus.fritz.box>
In-Reply-To: <20200331002203.GB47772@umbus.fritz.box>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1585900632.k0ft0cc80l.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org, =?iso-8859-1?q?C=E9dric?= Le Goater <clg@fr.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Gibson's on March 31, 2020 10:22 am:
> On Thu, Mar 26, 2020 at 12:41:45AM +1000, Nicholas Piggin wrote:
>> Like commit 9cb805fd26 ("cpus: Define callback for QEMU "nmi" command")
>> this implements a machine check injection command framework and defines
>> a monitor command for ppc.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>=20
> So, AFAICT, both x86 and ppc have something called an MCE, and while
> I'm guessing they're somewhat related, they don't work quite the same
> way - different information provided to the handler and so forth.
>=20
> I think it's reasonable to overload the "mce" HMP command based on
> target for the different types.  However, I think calling the
> interface classes which are specific to the ppc type just "mce" could
> be pretty confusing.

Okay. So, convert i386 first?

> In addition, I think this is adding an HMP command to inject the event
> without any corresponding way of injecting via QMP.  I believe that's
> frowned upon.

I attempted that but didn't get too far. I guess it's more of a
special test than a management function (nmi has valid uses in=20
administering a machine), so maybe we can get an exemption. One issue
is different QMP command for powerpc vs x86.

I think error injection as a general concept might be valid there, but
the better interface for that level would be higher up, e.g, not
specifying register settings but rather "simulate uncorrected memory
error on this byte".

Do you think that is reasonable reason to avoid adding QMP for this
nasty low level thing?

Thanks,
Nick

=

