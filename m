Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B808C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3875220715
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C61Qux9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3875220715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j02KF-0004ap-DX
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 07:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j02Iz-0002kT-Ok
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:00:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j02Iy-0002KH-D9
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:00:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37168
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j02Iy-0002I3-8M
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:00:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581076815;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OAzyWK4uOKPR/9c0mh90tocsTwZN6z5D/JwckST0c9Y=;
 b=C61Qux9uzf2OOOsWg01ZwvycUiWwkCIzeoZxa/NTs5p8oGPEQdO5mAmHm2nPKWTvtMFar4
 GZe9h9B/rygpnTOaDPL+UoSyThg+3jBCYVp43tNxKCybXtTMy5+FGxaBdOTkekdACAB5+i
 uDB6h2f23sxIxt/SBRvxnbHy+J5wQ14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-inWcCHkSO5aXlByMalgwow-1; Fri, 07 Feb 2020 06:59:59 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47A881800D42;
 Fri,  7 Feb 2020 11:59:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 733D619756;
 Fri,  7 Feb 2020 11:59:54 +0000 (UTC)
Date: Fri, 7 Feb 2020 11:59:52 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: should we have a new 'tools' manual?
Message-ID: <20200207115952.GB2511885@redhat.com>
References: <CAFEAcA--P9FLM4qBxf23sLuv5Tz4HRgj7ONC7ODxnfZiLph9TA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA--P9FLM4qBxf23sLuv5Tz4HRgj7ONC7ODxnfZiLph9TA@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: inWcCHkSO5aXlByMalgwow-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 07, 2020 at 11:50:37AM +0000, Peter Maydell wrote:
> So far we've been converting docs to Sphinx and assigning them
> to manuals according to the division originally set out by
> Paolo on the wiki: https://wiki.qemu.org/Features/Documentation
>=20
>  * QEMU User-mode Emulation User's Guide (docs/user)
>  * QEMU System Emulation User's Guide (docs/system)
>  * QEMU System Emulation Management and Interoperability Guide (docs/inte=
rop)
>  * QEMU System Emulation Guest Hardware Specifications (docs/specs)
>  * QEMU Developer's Guide (docs/devel, not shipped to end-users)
>=20
> but some of our documentation has always been a bit of an awkward
> fit into this classification:
>  * qemu-img
>  * qemu-nbd
>  * virtfs-proxy-helper
> etc. I've tended to put these things into interop/.
>=20
> The proposal from Dan and David was that we should add a sixth
> top-level manual
>  * QEMU Tools Guide (docs/tools)
>=20
> which would be a more coherent place for these to live.
>=20
> This seems like a good idea to me -- do people agree? What's
> our definition of a "tool", or do we just know one when we see it?
> What in particular should go in tools/ ?

There are essentially two consumers of our docs

  - Sysadmins running / interacting with QEMU
  - Application developers building QEMU mgmt tools

In the sysadmin use case, they'll primarily care about docs describing
the system emulator configuration & usage, and the various tools usage.

The app devs will care about nearly all of our documentation, except for
stuff that is purely QEMU internals.

The downside of mixing tools into the general "interop" doc is that it
makes it harder to find IMHO. Thus having a dedicated "tools" doc will
be a useful grouping for sysadmins to quickly find docs relevant to
daily admin tasks.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


