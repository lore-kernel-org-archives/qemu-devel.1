Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1150C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:04:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68CCD20739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCcHzNk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CCD20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFEW2-00054X-Iw
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 06:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jFEVI-0004et-O6
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jFEVH-0005Ov-IR
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:03:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:43097)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jFEVH-0005OS-Er
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584698627;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MQpNYafVaO/PE+ShzNKwIsN1DV07ezI+aQUk5iEG9L8=;
 b=NCcHzNk5M8FlYz9Kk25vSECzaF3T/CzbZUhtrwq5OtDEiXNw0BHfq8NmeIIBF+AZ61OLMI
 i6YHMevqFKUgIr92fCvNtEowkE0aKx7/CytS0FbKL2gQrf5DfvqqJtlkVBa7ozXiNosy17
 A4SWPssXEcvIxyKH40hcWQ8jDLvIwk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-lyqeC2l8N-ShS5NwXRtqaw-1; Fri, 20 Mar 2020 06:03:30 -0400
X-MC-Unique: lyqeC2l8N-ShS5NwXRtqaw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C2E9800D4E;
 Fri, 20 Mar 2020 10:03:29 +0000 (UTC)
Received: from redhat.com (ovpn-114-3.ams2.redhat.com [10.36.114.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B071A60BFB;
 Fri, 20 Mar 2020 10:03:28 +0000 (UTC)
Date: Fri, 20 Mar 2020 10:03:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: Re: [QUESTION] Getting configure options for a given QEMU executable?
Message-ID: <20200320100325.GB2608355@redhat.com>
References: <CAHiYmc4BaD+Bz3kchga2UCoernvvfq=Zc_wJyti05En-4QAKSA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHiYmc4BaD+Bz3kchga2UCoernvvfq=Zc_wJyti05En-4QAKSA@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 20, 2020 at 07:11:03AM +0100, Aleksandar Markovic wrote:
> Hi,
>=20
> Given a QEMU executable, is there a way to find out the configure options
> it was built with?

No, you need to get the original build logs.

The binary should contain the full build version (ie the QEMU version
and the distro specific package release).

On Fedora we build with the "annobin" plugin, which records some info
about GCC options in the binary, but that's still quite distinct from
any configure args.

> (context: we frequently get bugs involving QEMU built for a particular
> Linux distribution, and knowledge about its configure options would
> certainly be helpful while reproducing and debugging)

For Fedora the logs are all publically available at a predictable URL e.g.

https://kojipkgs.fedoraproject.org/packages/qemu/$VERSION/$RPM-RELEASE/data=
/logs/$ARCH/build.log

so=20

https://kojipkgs.fedoraproject.org/packages/qemu/4.0.0/5.fc31/data/logs/x86=
_64/build.log

Not sure where other distros might store this info. If people have info
for more distros, perhaps we could create a wiki page making a list of
where each distro keeps its biuld logs ?

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


