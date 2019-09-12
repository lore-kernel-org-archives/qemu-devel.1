Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A0BC49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 06:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 705B7208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 06:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705B7208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8ItF-0000qI-Ah
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 02:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i8Is2-0000Iu-R3
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 02:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i8Is1-0008Ul-O8
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 02:46:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45234)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i8Is1-0008UQ-Gx
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 02:46:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2303018C4260;
 Thu, 12 Sep 2019 06:46:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 336A41001B09;
 Thu, 12 Sep 2019 06:46:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ABDF5113865F; Thu, 12 Sep 2019 08:46:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <87a7cty0tv.fsf@dusky.pond.sub.org> <875zm5yzgq.fsf@linaro.org>
Date: Thu, 12 Sep 2019 08:46:15 +0200
In-Reply-To: <875zm5yzgq.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Fri, 06 Sep 2019 20:52:21 +0100")
Message-ID: <87d0g6dnbc.fsf_-_@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Thu, 12 Sep 2019 06:46:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] TCG plugins and the GPL (was: [PATCH v4 00/54] plugins
 for TCG)
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 aaron@os.amperecomputing.com, cota@braap.org,
 Stefan Hajnoczi <stefanha@redhat.com>, bobby.prani@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Markus Armbruster <armbru@redhat.com> writes:
[...]
>> Please advise why TCG plugins don't undermine the GPL.  Any proposal to
>> add a plugin interface needs to do that.
>
> I'm not sure what we can say about this apart from "ask your lawyer".

I'm not asking for a legal argument, I'm asking for a pragmatic one.

> I'm certainly not proposing we add any sort of language about what
> should and shouldn't be allowed to use the plugin interface. I find it
> hard to see how anyone could argue code written to interface with the
> plugin API couldn't be considered a derived work.

What makes that so?  Is writing a plugin without linking with QEMU code
impractical?

> There are two use cases I have in mind:
>
> The first is FLOSS developers writing interesting tools that can take
> advantage of QEMU's control of the system to do experiments that are
> tricky with other setups (Valgrind is limited to same-arch, Dynamo/Pin
> are user-space only). I want these experiments to be easy to do without
> having to keep hacking and re-hacking QEMU's core code. I would hope
> QEMU developers would up-stream theirs into the QEMU source tree but I
> can imagine academics will have open source code that will only ever sit
> in their paper's repository.

GPL'ed code that's not for upstream is 100% legitimate.

> The other is users who currently maintain hacked up internal copies of
> QEMU as a test bed for whatever piece of silicon they are brewing behind
> closed doors. This code would never be distributed (hence never be a GPL
> issue)

Correct.  We can't force anybody to distribute, and that's only proper.

>        and is generally kept private because it's IP sensitive
> (e.g: experimenting with different cache models). If we can provide an
> interface that allows them to keep their experiments private and
> separate from changes to the core code then maybe apart from making
> their lives a bit easier we will see some non-IP sensitive contributions
> come back to the upstream. I live in hope ;-)

I'm concerned about a third case: imlementing stuff as a plugin so you
can distribute it with a GPL-incompatible license.  Particularly
pernicious when that stuff could be useful upstream.

Are there any technical difficulties that could make distributing a
plugins in binary form impractical?

