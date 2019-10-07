Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910F8C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 10:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67B9120867
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 10:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B9120867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHQcS-0003sc-Hh
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 06:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iHQao-0002v8-K3
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iHQam-0000Bj-9H
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:50:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49070)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iHQak-0000Az-HX
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 06:50:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ABD49C057F2C;
 Mon,  7 Oct 2019 10:50:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BA6D60606;
 Mon,  7 Oct 2019 10:50:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B77571138648; Mon,  7 Oct 2019 12:49:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] netmap: support git-submodule build otption
References: <874l13qmvb.fsf@dusky.pond.sub.org>
 <20191004130242.27267-1-g.lettieri@iet.unipi.it>
 <CAFEAcA8ut__ruS4yEMT7-qCKu+BFihFwhaNoq7L1cdoqxpXx6g@mail.gmail.com>
Date: Mon, 07 Oct 2019 12:49:58 +0200
In-Reply-To: <CAFEAcA8ut__ruS4yEMT7-qCKu+BFihFwhaNoq7L1cdoqxpXx6g@mail.gmail.com>
 (Peter Maydell's message of "Fri, 4 Oct 2019 14:08:36 +0100")
Message-ID: <87pnj8ltih.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 07 Oct 2019 10:50:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 Luigi Rizzo <rizzo@iet.unipi.it>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

D> On Fri, 4 Oct 2019 at 14:03, Giuseppe Lettieri <g.lettieri@iet.unipi.it> wrote:
>>
>> From: Giuseppe Lettieri <giuseppe.lettieri@unipi.it>
>>
>> With this patch, netmap support can be enabled with
>> the following options to the configure script:
>>
>>   --enable-netmap[=system]
>>
>>         Use the host system netmap installation.
>>         Fail if not found.
>>
>>   --enable-netmap=git
>>
>>         clone the official netmap repository on
>>         github (mostly useful for CI)
>>
>> Signed-off-by: Giuseppe Lettieri <giuseppe.lettieri@unipi.it>
>> ---
>>  .gitmodules |  3 +++
>>  configure   | 64 +++++++++++++++++++++++++++++++++++++++++++++--------
>>  2 files changed, 58 insertions(+), 9 deletions(-)
>>
>> diff --git a/.gitmodules b/.gitmodules
>> index c5c474169d..bf75dbc5e3 100644
>> --- a/.gitmodules
>> +++ b/.gitmodules
>> @@ -58,3 +58,6 @@
>>  [submodule "roms/opensbi"]
>>         path = roms/opensbi
>>         url =   https://git.qemu.org/git/opensbi.git
>> +[submodule "netmap"]
>> +       path = netmap
>> +       url = https://github.com/luigirizzo/netmap.git
>
> Hi; this patch seems to be missing the rationale for why
> we want to do this. New submodules:
>  * should always be on git.qemu.org (we need to mirror them
> in case the original upstream vanishes)
>  * need a strong justification for why they're required
> (ie why we can't just use whatever the system-provided
> version of the library is, or fall back to not providing
> the feature if the library isn't present)
>
> Basically new submodules are a pain so we seek to minimize
> the use of them.

I suggested making it a submodule upthread[*].  Let me try to distill
the conversation into a rationale.  Giuseppe, please correct mistakes.

To make use of QEMU's netmap backend (CONFIG_NETMAP), you have to build
and install netmap software from sources[**].  Which pretty much ensures
developers compile with CONFIG_NETMAP off, and the code rots.

For other dependencies that aren't readily available on common
development hosts (slirp, capstone), we use submodules to avoid such
rot.  If the system provides, we use that, and if it doesn't, we fall
back to the submodule.  This has served us well.

For netmap, falling back to the submodule when the host doesn't provide
tends not to be useful beyond compile-testing.  Because of that, we fall
back only when the user explicitly asks for it by passing
--enable-netmap=git to configure.  CI should do that.



[*] Message-ID: <87blwzho1y.fsf@dusky.pond.sub.org>

[**] FreeBSD hosts may be an exception; I'm not sure.

