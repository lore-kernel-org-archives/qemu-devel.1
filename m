Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1031C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 13:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53A0206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 13:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53A0206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxAq0-000620-0w
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 09:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58107)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hxAmr-00075l-5V
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 09:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hxAmq-0000JS-6O
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 09:55:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47802)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hxAmq-0000IY-1M
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 09:55:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 23EAD81DF7;
 Mon, 12 Aug 2019 13:54:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E610219C70;
 Mon, 12 Aug 2019 13:54:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 641BC1136444; Mon, 12 Aug 2019 15:54:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20190812052359.30071-1-armbru@redhat.com>
 <20190812052359.30071-29-armbru@redhat.com>
 <87h86mofw3.fsf@linaro.org>
Date: Mon, 12 Aug 2019 15:54:54 +0200
In-Reply-To: <87h86mofw3.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Mon, 12 Aug 2019 11:08:12 +0100")
Message-ID: <87o90utro1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 12 Aug 2019 13:54:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 28/29] sysemu: Move the
 VMChangeStateEntry typedef to qemu/typedefs.h
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> In my "build everything" tree, changing sysemu/sysemu.h triggers a
>> recompile of some 1800 out of 6600 objects (not counting tests and
>> objects that don't depend on qemu/osdep.h, down from 5400 due to the
>> previous commit).
>>
>> Several headers include sysemu/sysemu.h just to get typedef
>> VMChangeStateEntry.  Move it from sysemu/sysemu.h to qemu/typedefs.h.
>> Spell its structure tag the same while there.  Drop the now
>> superfluous includes of sysemu/sysemu.h from headers.
>
> You should probably mention you also fix the struct definition to meet
> our coding style. Otherwise:

I did: "Spell its structure tag the same while there."  Would you like
to suggest a better wording?

> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Thanks!

