Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCDEC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432CE21019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432CE21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37655 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTonW-0003Jm-FB
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:34:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTolZ-0001nY-SE
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTolY-0004iU-Vd
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:32:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hTolY-0004i9-QG
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:32:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 103042E97CD;
	Thu, 23 May 2019 14:32:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C1F18795B4;
	Thu, 23 May 2019 14:32:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 294221138648; Thu, 23 May 2019 16:32:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190514171545.24961-1-peter.maydell@linaro.org>
	<878sv7yn6t.fsf@dusky.pond.sub.org>
	<CAFEAcA9O4YUFa1X+TqJLGD2M3mPXwhv3WwL2thOk-aeezEaoaQ@mail.gmail.com>
	<f972c27e-de17-2d96-04d9-bec421c78384@greensocs.com>
	<87imu3swp2.fsf@dusky.pond.sub.org>
	<CAFEAcA_LFdwYX0Lp8Z=ecgJKC18F7i51nUjOT7YY+CQBaH_tTg@mail.gmail.com>
	<87ef4pisja.fsf@dusky.pond.sub.org>
	<CAFEAcA-8CZT2-sNBDEJdKv7PB-b1usNgbqo0O9QofYApvR-=pQ@mail.gmail.com>
	<874l5lnzjd.fsf@dusky.pond.sub.org>
	<CAFEAcA98zZ60fAWgu4s9aCdKjafNtZsCt8ieEfTWYdZx5D2aGw@mail.gmail.com>
Date: Thu, 23 May 2019 16:32:07 +0200
In-Reply-To: <CAFEAcA98zZ60fAWgu4s9aCdKjafNtZsCt8ieEfTWYdZx5D2aGw@mail.gmail.com>
	(Peter Maydell's message of "Thu, 23 May 2019 13:12:57 +0100")
Message-ID: <87h89ljl7c.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Thu, 23 May 2019 14:32:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] hw/core/bus.c: Only the main system bus can
 have no parent
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 23 May 2019 at 13:09, Markus Armbruster <armbru@redhat.com> wrote:
>> Registering qbus_reset_all_fn() in main() is kind of ugly, but it works.
>> There's a comment pointing out it's ugly.  Right now it's a TODO
>> comment, which maybe expresses more hope for cleanup than there really
>> is.  I'd leave it alone anyway.
>
> ...so after this long thread, are we at a conclusion?
> I think my view is that the patch-as-sent needs to be
> revised to also fix bus_unparent() but is otherwise OK.

Yup.  You can add my
Reviewed-by: Markus Armbruster <armbru@redhat.com>
to it then

