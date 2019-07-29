Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D154AC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 11:12:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD3C206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 11:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD3C206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs3aJ-0000sL-Tu
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 07:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47277)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hs3Zs-0000Qb-3t
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 07:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hs3Zr-0001UD-55
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 07:12:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51348)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hs3Zr-0001Sw-0C
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 07:12:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 96E613084025;
 Mon, 29 Jul 2019 11:12:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-51.ams2.redhat.com
 [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B82555C21A;
 Mon, 29 Jul 2019 11:12:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3BA311138619; Mon, 29 Jul 2019 13:12:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
 <1562775267-1222-5-git-send-email-pbonzini@redhat.com>
 <87d0ie58cj.fsf@dusky.pond.sub.org>
 <78c3bba3-3e85-682b-b4ce-fc4809add90e@redhat.com>
 <87sgqsx7zp.fsf@dusky.pond.sub.org>
 <0b209125-4277-2836-e27b-a9c13f43f294@redhat.com>
 <CAFEAcA8J5AsEC+p3vAQ0H1emN-GS3T5GSj579tS=qC76WjkTVQ@mail.gmail.com>
 <87ftmptiyq.fsf@dusky.pond.sub.org>
 <41165962-2d61-697f-d17a-d5fa7516e8cc@redhat.com>
 <CAFEAcA-Egqpz3MwC2Kk-h_iCP4U74rYh66Nb2oaK5rdjD=7JMQ@mail.gmail.com>
 <aa4801a9-ad0f-a6b8-e167-1fc5f4e6925e@redhat.com>
 <CAFEAcA9X=F2=XP97pf171LJ0PiKHTPNNtKZSqJ8g06CmqWmzUA@mail.gmail.com>
 <e20ab776-602e-5555-6320-218d0b9b4f50@redhat.com>
Date: Mon, 29 Jul 2019 13:12:19 +0200
In-Reply-To: <e20ab776-602e-5555-6320-218d0b9b4f50@redhat.com> (Paolo
 Bonzini's message of "Mon, 29 Jul 2019 11:36:32 +0200")
Message-ID: <87a7cxrt64.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 29 Jul 2019 11:12:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/8] convert libqemuutil to meson
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 29/07/19 11:32, Peter Maydell wrote:
>>> The NetBSD thing could be worked around with a static library but
>>> instead those -D options could be added as global C++ flags:
>>>
>>>     __STDC_LIMIT_MACROS and __STDC_CONSTANT_MACROS are a workaround to
>>>     allow C++ programs to use stdint.h macros specified in the C99
>>>     standard that aren't in the C++ standard.
>>>
>>> Likewise, the -Wno-sign-compare probably should be added to all files
>>> for GCC <=4.6, but in fact we don't support anymore GCC 4.6 so it can go
>>> away.
>>
>> I think it's an indication that the mechanism in general is
>> useful. Switching to a new build system worries me if we
>> already find that it is lacking flexibility we're using with
>> our current build system -- it suggests that there's likely
>> to be missing stuff we're going to run into in future as well...
>
> I agree that the mechanism in general is useful and it's worth thinking
> twice about the consequences of not having it (see the CET example).
> However, in both of these cases it seems to me that the per-file CFLAGS
> were used when they should have not.

We have uses of per-file flags that could and maybe even should be
per-some-other-thing (static library, program, global).  Perhaps a
pre-conversion sweep to clean that up would help see us whatever remains
more clearly.

