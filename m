Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDC8C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 15:21:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 068B72054F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 15:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GkBidqGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068B72054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT5Z7-0000Ce-4H
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 11:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jT5Xp-0007PY-VZ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jT5Xo-0005jD-92
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:19:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44112
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jT5Xn-0005S9-Pm
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588000778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PMdJ6kxejVfLzN20neEHYh6PaUTbZ7cKMR4lW83qdaA=;
 b=GkBidqGDMWlhY4nBHdMxLwR9OA7ugDdzGZfJuHXJym7oRs8vkWkcOzACRUq68NnofyKPLp
 NUz9GWDM0SKT6Z2J3sPg0+VChcXImiIwmMJh5gSsqMj5wCBJvjbuoL9Fsue0M1EB12xHgE
 r7nPScYlN+ITKe+znJp+eUmkSRe0nv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-glI2CihAM6SSy0z2jHk-XQ-1; Mon, 27 Apr 2020 11:19:36 -0400
X-MC-Unique: glI2CihAM6SSy0z2jHk-XQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABE59107B7C3;
 Mon, 27 Apr 2020 15:19:35 +0000 (UTC)
Received: from localhost (ovpn-112-178.rdu2.redhat.com [10.10.112.178])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A1C060636;
 Mon, 27 Apr 2020 15:19:31 +0000 (UTC)
Date: Mon, 27 Apr 2020 11:19:25 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
Message-ID: <20200427111925.31ca80d6@redhat.com>
In-Reply-To: <48b0d8e6-3b9d-981d-c6a3-bdee5580f701@redhat.com>
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA8Lw94_=kY+Fv-cFW2Tk5RD62EjODjKdGf2-mLdDw7FuQ@mail.gmail.com>
 <1182067639.1655516.1584421185287.JavaMail.zimbra@redhat.com>
 <CAFEAcA-zRw7kzwzXxPmLaUqwOrQLwW9BymOJ34iJOOTCUAf=xg@mail.gmail.com>
 <20200317141257.GA5724@localhost.localdomain>
 <CAFEAcA9W4KXN6dcT0CNyD_mQ3xY5wDmJ7i0wowhaG2XPmyMYng@mail.gmail.com>
 <87sgi49uf6.fsf@dusky.pond.sub.org>
 <CAFEAcA_dcVneQ4Hj61GAkYRCUSMrA=QjwnAXccoBwjUjOE-wSQ@mail.gmail.com>
 <529508877.9650370.1587661453005.JavaMail.zimbra@redhat.com>
 <20200423171322.GJ1077680@redhat.com>
 <69e77a6e-8db8-f617-bfe6-1c8f39ec81b4@redhat.com>
 <20200427011210.745db351@redhat.com>
 <05670290-5ba0-8be0-624b-da1c95f3e820@redhat.com>
 <20200427102835.6f625859@redhat.com>
 <48b0d8e6-3b9d-981d-c6a3-bdee5580f701@redhat.com>
Organization: Red Hat, Inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=crosa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 01:12:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Wainer Moschetta <wmoschet@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Apr 2020 16:41:38 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 4/27/20 4:28 PM, Cleber Rosa wrote:
> >=20
> > What I mean is: would you blame such a developer for *not* having a
> > machine himself/herself that he/she can try to reproduce the
> > failure? And would you consider a "Raspberry Pi 4 Model B" an
> > easily available hardware?
>=20
> My view on this is if someone merged code in mainstream QEMU and=20
> maintains it, and if it is not easy to reproduce the setup (for a bug=20
> reported by a CI script), then it is the responsibility of the=20
> maintainer to resolve it. Either by providing particular access to
> the hardware, or be ready to spend a long debugging session over
> email and multiple time zones.
>=20

Right, the "easy to reproduce" has a lot to with access to hardware,
and a lot to do with access to the same or reproducible setup.  And
yes, if I maintain platform/job "foobar" that was once upgraded to
gating status, has since then fallen behind and doesn't allow users to
easily reproduce it, it all falls unto the maintainer to resolve issues.

I'd even say that people having access to identical hardware could
proactively challenge a given job status as gating if they fail to
reproduce it with the provided documentation/scripts.

> If it is not possible, then this specific code/setup can not claim
> for gating CI, and eventually mainstream isn't the best place for it.
>=20
> >> [...]
>=20

IIUC, we're in agreement. :)

Thanks,
- CLeber.


