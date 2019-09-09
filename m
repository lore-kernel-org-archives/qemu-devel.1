Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C08C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 11:48:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E84218DE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 11:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E84218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7I9z-0006he-0W
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 07:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i7I8z-0006GF-EX
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 07:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i7I8x-0003z3-4G
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 07:47:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42708)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i7I8w-0003xw-VF
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 07:47:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6225D3172D87;
 Mon,  9 Sep 2019 11:47:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B41D23CCE;
 Mon,  9 Sep 2019 11:47:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 296CA1165361; Mon,  9 Sep 2019 13:47:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <21182000.2zn5IIMESL@silver> <20190902173432.20f2637b@bahia.lan>
 <2734436.Mu773bgsdE@silver> <87r24xqjoz.fsf@fsf.org>
 <CAFEAcA8yfdJk74rybVCdc0gJDoAHO99LWHwvGVfh6CgueH6cfA@mail.gmail.com>
Date: Mon, 09 Sep 2019 13:47:34 +0200
In-Reply-To: <CAFEAcA8yfdJk74rybVCdc0gJDoAHO99LWHwvGVfh6CgueH6cfA@mail.gmail.com>
 (Peter Maydell's message of "Wed, 4 Sep 2019 15:30:16 +0100")
Message-ID: <87o8ztk7xl.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 09 Sep 2019 11:47:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] DMARC/DKIM and qemu-devel list settings
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
 Stefan Hajnoczi <stefanha@gmail.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, antonios.motakis@huawei.com,
 Ian Kelling <iank@fsf.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 3 Sep 2019 at 20:11, Ian Kelling <iank@fsf.org> wrote:
>> I don't know who has the Qemu-devel list admin password, but whoever has
>> it can adopt the unmodified message fix by changing
>> dmarc_moderation_action to Accept here:
>> https://lists.nongnu.org/mailman/admin/qemu-devel/privacy/sender and
>> remove subject_prefix here
>> https://lists.nongnu.org/mailman/admin/qemu-devel/general
>
> I'm one of the list admins, at least for the main qemu-devel
> list; some of the sublists have different admins (and
> perhaps different settings -- there's no way to conveniently
> say "manage all 5 of these lists with the same policies,
> so it's easy for them to get out of sync, deliberately
> or accidentally).
>
> I have been considering whether we change how we're handling
> the DMARC problem for the list. I picked munge-the-email
> initially because I think we didn't really understand the
> consequences in terms of patchmail, and also because there
> was a group of subscribers who complained that they liked
> the [qemu-devel] tag, used it for filtering email, etc.
> I think overall my opinion has shifted to thinking that
> the downsides of munge-the-email are too great and we should
> indeed switch to not modifying the message at all.

Yes, please.

