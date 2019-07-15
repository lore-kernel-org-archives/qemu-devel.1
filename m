Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE83AC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 864AB212F5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864AB212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1h0-0005Ic-LY
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 10:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57720)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hn1gq-0004uI-Oi
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hn1gp-0003of-Ja
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:10:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50044)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hn1gp-0003oH-DN
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:10:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 96B5F30C257C;
 Mon, 15 Jul 2019 14:10:50 +0000 (UTC)
Received: from redhat.com (ovpn-117-250.ams2.redhat.com [10.36.117.250])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EEDC1001B02;
 Mon, 15 Jul 2019 14:10:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
In-Reply-To: <CAFEAcA_9tVQht7bp9_yrFEhQ74ye6LBNjEYK_nftCWsKMrOohw@mail.gmail.com>
 (Peter Maydell's message of "Mon, 15 Jul 2019 14:48:42 +0100")
References: <20190712143207.4214-1-quintela@redhat.com>
 <CAFEAcA-ydNS072OH7CyGNq2+sESgonW-8QSJdNYJq6zW-rYjUQ@mail.gmail.com>
 <CAFEAcA9ncjtGdc8CZOJBDBRtzEU8oL7YicVg5PtyiiO2O4z51w@mail.gmail.com>
 <87zhlf76pk.fsf@trasno.org>
 <CAFEAcA_9tVQht7bp9_yrFEhQ74ye6LBNjEYK_nftCWsKMrOohw@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Mon, 15 Jul 2019 16:10:44 +0200
Message-ID: <87pnmb75i3.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 15 Jul 2019 14:10:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 00/19] Migration patches
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On Mon, 15 Jul 2019 at 14:44, Juan Quintela <quintela@redhat.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> wrote:
>> > On Fri, 12 Jul 2019 at 17:33, Peter Maydell <peter.maydell@linaro.org> wrote:
>> >> Still fails on aarch32 host, I'm afraid:
>>
>> Hi
>>
>> dropping the multifd test patch from now.  For "some" reason, having a
>> packed struct and 32bits is getting ugly, not sure yet _why_.
>
> IMHO 'packed' structs are usually a bad idea. They have a bunch
> of behaviours you may not be expecting (for instance they're
> also not naturally aligned, and arrays of them won't be the
> size you expect).

I can't get everything happy O:-)
For the multifd initial packet, I used to have that I wrote the fields
by hand.  Then danp asked that I used a packed struct, and converted the
values inside it.  So ..... Imposible to have everybody happy.

Anyways, the struct is packed, both sides are i386 32bits, and it should
be exactly the same, but it appears that there is where your valgrind
problems appear.  Still investigating _where_ the problem is.  What is
even weirder is that there is no error at all on 64bits.

Thanks, Juan.

PS.  BTW, did you launched by hand the guests with valgrind, or there is
     a trick that I am missing for launching a qtest with valgrind?

