Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6475BC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 11:05:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F1392076C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 11:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqBvgc0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1392076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRZfT-000407-9y
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 07:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jRZdx-0003Ks-Te
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:03:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jRZdw-0001HO-6T
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:03:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58288
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jRZdv-0001Fv-N0
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587639822;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z2OaMG4Jy+q5Z6CPtk92P9yVIyfGJ+gJr6XqZsxDx+0=;
 b=QqBvgc0md+M4xke+ZoY0Sed1gQTwweOfyTBM8KDeBXWalffVj1wcGbEH9rT7EOJ7SUZLQ4
 WFTclMz4rYelGpxfSSvAuaKJfclQH4kXce3hBySUqN1Xc6HLi2nt55aRpkcgRFnqk0vyYS
 7fWwaEXrau8a1bfgwZwqcEVnrBC4Dw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-zWtlS0ShMG6ZEusK_djbSQ-1; Thu, 23 Apr 2020 07:03:30 -0400
X-MC-Unique: zWtlS0ShMG6ZEusK_djbSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C752C18538BE;
 Thu, 23 Apr 2020 11:03:28 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 227D01001DC2;
 Thu, 23 Apr 2020 11:03:25 +0000 (UTC)
Date: Thu, 23 Apr 2020 12:03:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: janine.schneider@fau.de
Subject: Re: Integration of qemu-img
Message-ID: <20200423110321.GB1077680@redhat.com>
References: <00fc01d61256$35f849c0$a1e8dd40$@fau.de>
 <877dyfc1if.fsf@dusky.pond.sub.org>
 <20200422161813.GI47385@stefanha-x1.localdomain>
 <006e01d61958$de787120$9b695360$@fau.de>
 <CAJSP0QVeEZmSps3R8Hg+j=-BZR7_+FeOkm+m12A=gMULosP3Sg@mail.gmail.com>
 <008a01d6195d$78280570$68781050$@fau.de>
MIME-Version: 1.0
In-Reply-To: <008a01d6195d$78280570$68781050$@fau.de>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 02:14:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: 'Stefan Hajnoczi' <stefanha@gmail.com>,
 'qemu-devel' <qemu-devel@nongnu.org>, 'qemu block' <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 23, 2020 at 12:53:48PM +0200, janine.schneider@fau.de wrote:
> Hy again,
>=20
> okay so now we have an easy way out just in case.
> But I still want to build an DLL and/or a shared library for integration
> into the tool. I want the tool to be platform independent and I was
> already able to build qemu-img as cross build with mingw64. Does anybody
> have experience in building a qemu library or tried it already?

It has been discussed in the past, but general wasn't considered a
viable, because any apps using it would have to be strictly licensed
as GPLv2-only. This would prevent the library being used by anything
that includes GPLv3 code, or obviously from closed source apps. This
would seriously restrict how useful any library was.

I would also note that QEMU disk code is not robust against malicously
created disk images. It is possible to create images that inflict
a denial of service in terms of memory and CPU usage. Thus if an
application is handling disk images obtained from untrusted users,
it is desirable for qemu-img to be a separate process, such that
you can put strict resource limits on it as protection against DoS.

> The tool I want to integrate qemu in is published under GPL itself. And
> if I am able to build qemu as library I will share it with the community
> and everybody interested in having it.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


