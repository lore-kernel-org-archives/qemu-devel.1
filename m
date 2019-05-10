Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D712FC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AABD02175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AABD02175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44782 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP76b-0000G4-UY
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:06:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hP754-0006WZ-Nk
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hP753-0006Cf-MW
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:05:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hP752-00067S-Jk; Fri, 10 May 2019 11:05:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9AD33002619;
	Fri, 10 May 2019 15:04:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CF2C16684B;
	Fri, 10 May 2019 15:04:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 53E4A11385E4; Fri, 10 May 2019 17:04:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190502185835.15185-1-laurent@vivier.eu>
	<CAFEAcA9-hAU5dxUmSWtbvrPEXE-nCP1uLvLbOby-_EXZ27o+8g@mail.gmail.com>
	<87sgtv4wjo.fsf@zen.linaroharston> <87imulaude.fsf@dusky.pond.sub.org>
	<87tve53sy7.fsf@zen.linaroharston> <87zhnw58pa.fsf@dusky.pond.sub.org>
	<CAFEAcA-s0UYr0VW3ccG07r=BiGCVtDHkRb6yW0X_ev-zAkOxvw@mail.gmail.com>
Date: Fri, 10 May 2019 17:04:42 +0200
In-Reply-To: <CAFEAcA-s0UYr0VW3ccG07r=BiGCVtDHkRb6yW0X_ev-zAkOxvw@mail.gmail.com>
	(Peter Maydell's message of "Thu, 9 May 2019 09:53:20 +0100")
Message-ID: <87o94amjud.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Fri, 10 May 2019 15:04:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 00/13] Trivial branch patches
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
Cc: Laurent Vivier <lvivier@redhat.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
	QEMU Trivial <qemu-trivial@nongnu.org>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>, Fabien Chouteau <chouteau@adacore.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 9 May 2019 at 09:32, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>> > I couldn't replicate the bug with access to my s390 account so I think
>> > it might be existing build artefact related which is odd.
>>
>> Any ideas on how to debug this further?
>
> It's consistently failed for me both times I've tried
> to merge the pullreq, on both s390 and ppc (which is
> doing a straightforward 'git merge, then do an incremental
> build out-of-tree'). Alex has access to the s390 box,
> and there's a ppc box in the gcc compile farm...

I tried to reproduce on a ppc64 box in the gcc compile farm, no dice.  I
double-checked config-host.h has #define HOST_WORDS_BIGENDIAN 1.

Clutching at straws...  you say you tried "an incremental build
out-of-tree".  I also built out-of-tree, but it wasn't incremental.
Could you try a non-incremental build just to exclude the possibility
something wonky in your build tree is breaking "make check" for you?

