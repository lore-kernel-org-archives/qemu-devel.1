Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6117C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 07:31:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A352086D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 07:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A352086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52414 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1habFd-0004iT-Ry
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 03:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37084)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1habEN-0003rB-EO
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 03:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1habEM-0003Ih-GV
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 03:30:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60666)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1habEM-0002zU-B9
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 03:30:06 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2570D7FDFA;
 Tue, 11 Jun 2019 07:29:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B7A5A1001B36;
 Tue, 11 Jun 2019 07:29:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 48C5211386A0; Tue, 11 Jun 2019 09:29:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <CAFEAcA_-DptTwe7dkbZ171HJ+DtXCAOKt08pja=4-QbQKJSEvQ@mail.gmail.com>
 <CAFEAcA9MOWkMGAyV_efH+FRBErJgM_9gwX+kutqSzH_0ou58Dg@mail.gmail.com>
Date: Tue, 11 Jun 2019 09:29:38 +0200
In-Reply-To: <CAFEAcA9MOWkMGAyV_efH+FRBErJgM_9gwX+kutqSzH_0ou58Dg@mail.gmail.com>
 (Peter Maydell's message of "Fri, 7 Jun 2019 18:37:40 +0100")
Message-ID: <877e9stw9p.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 11 Jun 2019 07:29:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Sketch of a transition of QEMU docs to Sphinx
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
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 21 May 2019 at 19:56, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> Currently we have a vague plan that we should migrate our
>> documentation away from Texinfo to using Sphinx, plus some isolated
>> bits of documentation already in .rst format. This email is an attempt
>> to sketch out a transition plan for getting us from where we are today
>> to where (I think) we want to be.
>
> Since nobody seemed to disagree particularly with this sketch,

I don't think rST is an improvement over Texinfo.  As Paolo said, it's
the Perl of ASCII-based markups.  But I (reluctantly) agree with Paolo
that our current mix of Texinfo, rST, Markdown, and ad hoc markup is
worse than consistent use of one markup system, even if it's an
ill-conceived one like rST.

March of progress, I guess.

[...]

