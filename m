Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C194C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 20:21:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA88D2199C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 20:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA88D2199C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvSR9-0007SK-VK
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 16:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59787)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvSQo-00073t-7W
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 16:21:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvSQn-0003bX-4s
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 16:21:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52496)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvSQn-0003Z1-03
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 16:21:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2BEED30BCB96;
 Wed,  7 Aug 2019 20:21:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A642D60BE2;
 Wed,  7 Aug 2019 20:21:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 23607113864E; Wed,  7 Aug 2019 22:21:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20190806151435.10740-1-armbru@redhat.com>
 <87blx1hr78.fsf@linaro.org>
Date: Wed, 07 Aug 2019 22:21:04 +0200
In-Reply-To: <87blx1hr78.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Wed, 07 Aug 2019 17:32:11 +0100")
Message-ID: <871rxwrakv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 07 Aug 2019 20:21:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 00/29] Tame a few "touch this,
 recompile the world" headers
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
Cc: "Daniel P . =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> We have quite a few "touch this, recompile the world" headers.  My
>> "build everything" tree has some 6600 objects (not counting tests and
>> objects that don't depend on qemu/osdep.h).  Touching any of 54
>> headers triggers a recompile of more than half of them.
>>
>> This series reduces them to 46.
>
> I think this series is going the right way but there seems to be quite a
> lot of breakage introduced to the cross compiles:
>
>   https://app.shippable.com/github/stsquad/qemu/runs/939/summary/console
>
> I guess there is more subtlety involved when host !=3D target. I'd
> recommend setting up a shippable account:
>
>   https://wiki.qemu.org/Testing/CI/Shippable
>
> You can of course just run:
>
>   make docker-test-build J=3Dn
>
> And watch your machine slowly grind through all the options.

Thanks for the tips.

