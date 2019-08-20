Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF27C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 09:16:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0A2216F4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 09:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0A2216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i00FL-0000Tf-RF
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 05:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1i00EL-0008LA-DG
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 05:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1i00EK-0004VY-Fr
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 05:15:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43520)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>)
 id 1i00EH-0004Ox-UA; Tue, 20 Aug 2019 05:15:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8A5BC1065B0C;
 Tue, 20 Aug 2019 09:15:00 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 89B7A7E35;
 Tue, 20 Aug 2019 09:14:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
In-Reply-To: <20190820083904.GA23352@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
 =?utf-8?Q?rang=C3=A9=22's?=
 message of "Tue, 20 Aug 2019 09:39:04 +0100")
References: <20190820082459.2101-1-quintela@redhat.com>
 <20190820082459.2101-2-quintela@redhat.com>
 <20190820083904.GA23352@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Tue, 20 Aug 2019 11:14:50 +0200
Message-ID: <877e782o6t.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Tue, 20 Aug 2019 09:15:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/5] socket: Add backlog parameter to
 socket_listen
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Tue, Aug 20, 2019 at 10:24:55AM +0200, Juan Quintela wrote:
>> Current parameter was always one.  We continue with that value for now
>> in all callers.
>>=20
>> Signed-off-by: Juan Quintela <quintela@redhat.com>

>> @@ -309,7 +311,8 @@ static int inet_listen_saddr(InetSocketAddress *sadd=
r,
>>                      goto listen_failed;
>>                  }
>>              } else {
>> -                if (!listen(slisten, 1)) {
>> +                trace_inet_listen_saddr(num);
>
> It is a bit odd to only have the trace event for inet sockets. I'd
> prefer it in the caller for all sockets, with just "socket_listen"
> name.

Ok. will change.

This is the one that I needed, I just changed an error_report() to a
trace O:-)

