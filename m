Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E570C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44072208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44072208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhxSC-0000Y3-CI
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 10:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50387)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dinechin@redhat.com>) id 1hhwzO-0006C7-MS
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1hhwzN-000617-IB
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:09:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1hhwzN-0005zg-Bu
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:09:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7654830872EB
 for <qemu-devel@nongnu.org>; Mon,  1 Jul 2019 14:09:00 +0000 (UTC)
Received: from ptitpuce (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E56565ED5D
 for <qemu-devel@nongnu.org>; Mon,  1 Jul 2019 14:08:59 +0000 (UTC)
References: <20190607135653.6ece685d@titan.knownspace>
 <8676232e-917d-44e2-1149-b25f26698a73@vivier.eu>
 <92053c9c-e7bf-76cb-9399-987f4ab31bfb@vivier.eu>
 <20190626113742.6bcd8a26@titan.knownspace>
User-agent: mu4e 1.3.2; emacs 26.2
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
In-reply-to: <20190626113742.6bcd8a26@titan.knownspace>
Date: Mon, 01 Jul 2019 16:08:55 +0200
Message-ID: <m1ftnphmo8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 01 Jul 2019 14:09:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-trivial] Fix cacheline size retrieval on
 FreeBSD/PowerPC(64)
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Justin Hibbits writes:

> On Wed, 26 Jun 2019 18:16:36 +0200
> Laurent Vivier <laurent@vivier.eu> wrote:
>
>> Le 26/06/2019 =C3=A0 18:14, Laurent Vivier a =C3=A9crit :
>> > Le 07/06/2019 =C3=A0 20:56, Justin Hibbits a =C3=A9crit :
>> >> The attached very trivial patch fixes a startup bug that prevents
>> >> at least Qemu 3.1 and later from working on FreeBSD/powerpc64.
>> >>
>> >> - Justin
>> >>
>> >
>> > Please don't send a patch in attachment but inlined in the message
>> > (you may use "git send-email" for that).
>> >
>> > This patch fixes "util: add cacheinfo" that has changed the type
>> > from unsigned to long.
>> >
>> > You can add the following line in the commit message:
>> >
>> > Fixes: b255b2c8a548 ("util: add cacheinfo")
>> >
>> > Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>> >
>>
>> CC: author of b255b2c8a548 ("util: add cacheinfo")
>>
>> Thanks,
>> Laurent
>
> Hi Laurent,
>
> Sorry.  I had never used git send-email before, so wasn't comfortable
> with it.  I just updated the commit message with your feedback and used
> git send-email to submit the patch.  I hope everything went well.

FWIW, there is also a handy git-publish script that is worth looking at.
It deals with multiple iterations of a patch and other niceties.

https://github.com/stefanha/git-publish

>
> Thanks for your feedback.
>
> - Justin


--
Cheers,
Christophe de Dinechin (IRC c3d)

