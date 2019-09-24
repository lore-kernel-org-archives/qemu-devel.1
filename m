Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F38C432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 10:09:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD7F5214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 10:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7F5214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iChl1-0006V8-MC
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 06:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iChiq-00059b-Jd
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 06:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iChip-00044X-KS
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 06:07:04 -0400
Received: from 8.mo1.mail-out.ovh.net ([178.33.110.239]:40227)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iChio-00043R-3R
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 06:07:02 -0400
Received: from player687.ha.ovh.net (unknown [10.108.57.53])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 31F1F190F46
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 12:06:56 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id D4356A1F557F;
 Tue, 24 Sep 2019 10:06:49 +0000 (UTC)
Date: Tue, 24 Sep 2019 12:06:47 +0200
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH 0/4] xics: Eliminate unnecessary class
Message-ID: <20190924120647.13600e6b@bahia.lan>
In-Reply-To: <c2efe040-a9f4-8d7f-f1b4-c8ef162c4560@redhat.com>
References: <20190924045952.11412-1-david@gibson.dropbear.id.au>
 <c2efe040-a9f4-8d7f-f1b4-c8ef162c4560@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 16915238728745326883
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedtgddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.110.239
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
Cc: qemu-devel@nongnu.org, gkurz@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Sep 2019 11:47:51 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 9/24/19 6:59 AM, David Gibson wrote:
> > The XICS interrupt controller device used to have separate subtypes
> > for the KVM and non-KVM variant of the device.  That was a bad idea,
> > because it leaked information that should be entirely host-side
> > implementation specific to the kinda-sorta guest visible QOM class
> > names.
> >=20
> > We eliminated the KVM specific class some time ago, but it's left
> > behind a distinction between the TYPE_ICS_BASE abstract class and
> > TYPE_ICS_SIMPLE subtype which no longer serves any purpose.
> >=20
> > This series collapses the two types back into one.
> >=20
> > David Gibson (4):
> >   xics: Eliminate 'reject', 'resend' and 'eoi' class hooks
> >   xics: Merge reset and realize hooks
> >   xics: Rename misleading ics_simple_*() functions
> >   xics: Merge TYPE_ICS_BASE and TYPE_ICS_SIMPLE classes
>=20
> Please remove the qemu_register_reset() call in hw/intc/xics.c,

No. This is needed because the XICS devices don't sit in a bus and
dc->reset doesn't get called by anyone.

> then for the series:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20


