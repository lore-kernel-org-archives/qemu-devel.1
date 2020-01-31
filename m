Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B72C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:40:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62174206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKUoEvHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62174206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixZLl-0003LU-Kr
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:40:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ixZKr-0002Py-A5
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 11:40:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ixZKp-0006y2-4v
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 11:40:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57488
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ixZKp-0006uT-17
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 11:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580488798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YTKCW9A1XjkaJuiQ+b1hP8fO/RMlvJydbbrweXjA77Y=;
 b=BKUoEvHRczwrVWj2A+rHHX1GtM+C0+wKHAKgUkDO34fHUc3gbje15gvK/ZeHw4zxxOc012
 pNlrl0QlIkB2pIfHgkIRDrauqhKuEyx7sbVd+NatHeCHFczPa2m/GI0MSUJgvF2I0Zgc97
 NIWPPENaB2rI9aPeX7oDPvwNk6AQckw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-eMe9zTZcPHCTnEYHePv6Ig-1; Fri, 31 Jan 2020 11:39:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE28D1085987;
 Fri, 31 Jan 2020 16:39:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D557060BE1;
 Fri, 31 Jan 2020 16:39:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 51B0E1138404; Fri, 31 Jan 2020 17:39:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Improving QOM documentation [Was: Re: Making QEMU easier for
 management tools and applications]
References: <20200108104306.GC5057@dhcp-200-226.str.redhat.com>
 <97F153BD-FB8A-46C7-90D0-9E894B9E0292@redhat.com>
 <20200108133842.GE5057@dhcp-200-226.str.redhat.com>
 <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200115121953.GJ93923@redhat.com>
 <874kwwvmuv.fsf@dusky.pond.sub.org> <20200130210902.GA25927@paraplu>
 <87y2toi29o.fsf@dusky.pond.sub.org>
 <CAFEAcA-545QS9mnM6hwa6TxUpw_pDQ3Pa8tkf4qtzWS1Zi_fxQ@mail.gmail.com>
 <CABgObfaB=wHXyJbQR163bZdFHhWdCc4D8sWRHzte019_hSTuhA@mail.gmail.com>
Date: Fri, 31 Jan 2020 17:39:25 +0100
In-Reply-To: <CABgObfaB=wHXyJbQR163bZdFHhWdCc4D8sWRHzte019_hSTuhA@mail.gmail.com>
 (Paolo Bonzini's message of "Fri, 31 Jan 2020 12:02:05 +0100")
Message-ID: <8736bveg1u.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: eMe9zTZcPHCTnEYHePv6Ig-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> Il ven 31 gen 2020, 11:36 Peter Maydell <peter.maydell@linaro.org> ha
> scritto:
>
>> On Fri, 31 Jan 2020 at 06:11, Markus Armbruster <armbru@redhat.com> wrot=
e:
>> > Beware, personal opinion.
>> >
>> > When you put documentation next to the code it documents (which you
>> > absolutely should, because it's your only realistic chance to keep the
>> > two in sync), then extracting API comments is useful, because it
>> > collects them in one place.
>> >
>> > It's of next to no use to me when the comments are all in the same pla=
ce
>> > already, namely the header.
>>
>
> The advantage of putting them in the header is that you have them all in
> one place (inline functions and structs must be in the header). In practi=
ce
> that balances for me the disadvantage of having some comments far from th=
e
> code they document, which increases the risk of bitrot especially for
> comments such as "called with lock X held".

With suitable doc generation from source, we can have them next to the
code *and* all in one place, namely the generated interface docs.

>> I definitely agree that the overview/introduction/conventions
>> side of things is where we'd benefit most if somebody wanted
>> to try to tackle that. We could roll
>> https://wiki.qemu.org/Documentation/QOMConventions
>> into that if we had a better place to put that info.
>>
>
> I am travelling this weekend so I might try to do some kind of thread
> summary and brain dump in the wiki. I'll leave to Kashyap to do the rST
> conversion and patch submission. ;-)

That would be awesome!


