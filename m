Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76D9C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 05:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 930B12166E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 05:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930B12166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkj4Z-0006OY-U4
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 01:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53715)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hkj47-0005xw-Fs
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 01:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hkj46-0000FZ-Ix
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 01:53:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57462)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hkj46-0000FD-Bf
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 01:53:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8BB9299DD9
 for <qemu-devel@nongnu.org>; Tue,  9 Jul 2019 05:53:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F340F7FCD6;
 Tue,  9 Jul 2019 05:53:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8707B1138648; Tue,  9 Jul 2019 07:53:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
References: <20190703172501.GI23082@redhat.com>
 <20190704102457.GE1609@stefanha-x1.localdomain>
 <20190704102837.GA24190@redhat.com>
 <20190705080717.GD10995@stefanha-x1.localdomain>
 <8470a203-430b-1814-b2ef-6adf3fa739a6@redhat.com>
 <87d0iok4ai.fsf@dusky.pond.sub.org>
 <c4997dee-932c-eb57-23b9-4b51e8856f91@redhat.com>
 <874l3zhktx.fsf@dusky.pond.sub.org> <20190708093400.GB3082@redhat.com>
 <e396d430-1e6e-2e0b-454b-5c4208756742@redhat.com>
 <20190708103804.GG3082@redhat.com>
Date: Tue, 09 Jul 2019 07:53:15 +0200
In-Reply-To: <20190708103804.GG3082@redhat.com> ("Daniel P. =?utf-8?Q?Berr?=
 =?utf-8?Q?ang=C3=A9=22's?=
 message of "Mon, 8 Jul 2019 11:38:04 +0100")
Message-ID: <87r26zah4k.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 09 Jul 2019 05:53:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH-for-4.2] tracing: Allow to tune tracing
 options via the environment
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Jul 08, 2019 at 12:27:12PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
[...]
>> Anyway, to stop bikeshedding this thread, can you add few lines about
>> why not use getenv() in the HACKING?
>
> I don't actually think the getenv thing is a security issue in any case.
> If there was a security problem exploitable via getenv, then the bug would
> lie in the application invoking QEMU for not ensuring the ENV contents
> were safe before exec'ing QEMU.

Correct.

>                                 Libvirt is paranoid by default and scrubs
> QEMU's env only keeping a specific sanitized whitelist for exactly these
> reasons.

Must have for running programs with different privileges.

Corrollary: a program that does not use getenv() at all is slightly
harder to misuse with different privileges.  Irrelevant in practice,
because libraries use getenv(), starting with ld.so.

