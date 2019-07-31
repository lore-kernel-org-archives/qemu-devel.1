Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE0CC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 06:38:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B53206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 06:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B53206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsiFO-0002ev-LU
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 02:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35036)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hsiEw-0002BY-8I
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 02:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hsiEu-0003OL-7p
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 02:37:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45876)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hsiEu-00035h-1r
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 02:37:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D43783083391;
 Wed, 31 Jul 2019 06:37:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-51.ams2.redhat.com
 [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 89EAE5D6A7;
 Wed, 31 Jul 2019 06:37:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 09C0B1138619; Wed, 31 Jul 2019 08:37:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-24-armbru@redhat.com>
 <20190729194414.GG4313@habkost.net>
 <87d0hreqh3.fsf_-_@dusky.pond.sub.org>
 <8bea0201-f796-d682-22e6-069985b45523@redhat.com>
 <0eb2518f-147c-2b47-f48c-3af26bf5d264@redhat.com>
Date: Wed, 31 Jul 2019 08:37:26 +0200
In-Reply-To: <0eb2518f-147c-2b47-f48c-3af26bf5d264@redhat.com> (Paolo
 Bonzini's message of "Tue, 30 Jul 2019 15:28:57 +0200")
Message-ID: <87zhku90bd.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 31 Jul 2019 06:37:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] When to use qemu/typedefs.h
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 30/07/19 15:15, Eric Blake wrote:
>>> We occasionally give up and use types directly rather than their typedef
>>> names, flouting the coding style.  This patch does.  Trades messing with
>>> qemu/typedefs.h for having to write 'struct' a few times.
>
> I think Markus made the right call here.  Using "struct Foo;" in headers
> is a null price to pay if all you need is declaring a pointer-typed
> field or parameter.

Eduardo posted a patch to HACKING to clarify this non-usage of typedef
is okay.

Should we continue to mandate typedef names elsewhere?  It adds
cognitive load: you have to decide where to put the typedef, and when
not to use it.

>                      Of course this doesn't apply if you have to embed a
> struct directly, but then qemu/typedefs.h wouldn't help either.

Yes, and if this leads to an inclusion cycle, I strongly suspect "fat"
headers: since you can't embed something in itself, the cycle must
involve different things, all bunched together in the same header.

> In general unless you're adding a new subsystem, qemu/typedefs.h should
> only decrease in size, never increase.

This series grows it some.  I'll try to avoid that for v2.

>                                         (And there are certainly many
> cases where typedefs.h are not needed, but cleaning that up is
> understandably not high on the todo list).

On the other hand, low-hanging fruit.

