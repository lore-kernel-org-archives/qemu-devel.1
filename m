Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C66C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 16:44:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 723A320733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 16:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itYOC9V7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723A320733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1CAg-00059F-MT
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 11:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j1C9j-0004kG-TJ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:43:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j1C9g-0007Qu-DU
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:43:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41080
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j1C9f-0007OB-1s
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581353006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AM7B0Mtol/E2dEv15T+Ep54eeeVU+IJuZZu2dHWLnEU=;
 b=itYOC9V7hcyjQ5snBtgWEkv38tqVFZccpKmP8OUdxohtx4K9ohNO2SIrKiYkV4w1N6qVE2
 vMHR2GwwgQumx8C5gkS3z1D2fc/H01xys9GZdjzf27BA1q7v7xRW/ef5633bkniA1i+X5u
 X0s6jYQVFdJ8xJa27Ev1KjyUR4KqljA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-Tb86p9tmN0ODDJxJrt_fZg-1; Mon, 10 Feb 2020 11:43:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1BB010054E3;
 Mon, 10 Feb 2020 16:43:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-243.ams2.redhat.com
 [10.36.117.243])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8119A5C1D4;
 Mon, 10 Feb 2020 16:43:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1227011385C9; Mon, 10 Feb 2020 17:43:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Summary of Re: Making QEMU easier for management tools and
 applications
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <875zgm2vqv.fsf@dusky.pond.sub.org>
 <CAJSP0QWCn_vv2Vs-UWc9nPHjdBQq9KMkiQ7D91+RwHM_okTzZw@mail.gmail.com>
Date: Mon, 10 Feb 2020 17:43:13 +0100
In-Reply-To: <CAJSP0QWCn_vv2Vs-UWc9nPHjdBQq9KMkiQ7D91+RwHM_okTzZw@mail.gmail.com>
 (Stefan Hajnoczi's message of "Mon, 10 Feb 2020 10:56:55 +0000")
Message-ID: <87ftfio0ke.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Tb86p9tmN0ODDJxJrt_fZg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Tue, Feb 4, 2020 at 3:54 PM Markus Armbruster <armbru@redhat.com> wrot=
e:
>> =3D Ways to provide machine-friendly initial configuration =3D
>>
>> Two ways to provide machine-friendly initial configuration on par with
>> QMP have been proposed:
>>
>> 1. Extend QMP
>>
>>    Machines use the CLI only to configure a QMP socket.  The remainder
>>    of the CLI becomes human-only, with much relaxed compatibility rules.
>>
>> 2. QAPIfy the CLI
>>
>>    Provide a machine-friendly CLI based on QAPI and JSON.  The current
>>    CLI becomes human-only, with much relaxed compatibility rules.
>
> Do we keep the existing CLI around in both cases?  I'm concerned that
> we're still following the HMP/QMP approach, which has left QEMU with
> the legacy HMP monitor that we still haven't removed.

The "HMP is legacy" idea is relatively recent.

I think having separate interfaces for humans and machines makes sense,
we just need to give both the attention and care they need and deserve.

I think a human-friendly monitor is has its use, but it should ideally
be done differently than we do HMP now.

Likewise, human-friendly initial configuration should exist, but it
should ideally be done differently than we do HMP now.

> I'm in favor of simplifying QEMU at the expense of an incompatible CLI
> change in QEMU 6.0.

I'm convinced the current CLI needs cleanup badly, and that means
incompatible change.  The question is how and when to change it.

Here's how I'd like us to do it:

1. Create machine-friendly initial configuration interface separate from
   the existing CLI

   Doesn't mean it cannot be a CLI.

2. Develop it step by step to feature parity with existing CLI

   If we identify misfeatures we don't want anymore, we should
   immediately deprecate them in the existing CLI instead.

2. Transition machine users to this new interface

3. Declare the existing CLI to be like HMP: for humans, may change
   incompatibly

4. Clean up existing CLI step by step to wrap around the
   machine-friendly interface

   Whatever we deprecated in step 2 goes to the bit bucket instead.

   I'm open to replacing the existing CLI by a separate wrapper process
   instead.

   Capability to translate to the machine-friendly interface is
   desirable, so human users can easily transition to the
   machine-friendly interface when they run into a need to automate.

The risk is of course that we fail at step 4 and remain stuck with the
CLI mess we've made.

> A project like this could prototype incompatible CLI changes in a
> separate git tree.  If it achieves the desired unification (CLI, QMP,
> configuration file) and simplification (less code, legacy removal)
> then it can be merged for an upcoming QEMU major release.

That's effectively a really long-lived feature branch.  Painful.  If it
it what it takes, we do it.  I hope the process I just sketched permits
more incremental development.

We can explore conflict-free in qemu-storage-daemon.


