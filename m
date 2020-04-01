Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC000C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 09:09:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4737206CC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 09:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="L1XdySyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4737206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJZNR-0003Vn-Rh
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 05:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1jJZMr-00036O-Aa
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1jJZMq-000429-4s
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:09:01 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:34081)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jJZMp-0003uy-NR
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 05:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=klsu+F2lnlXnYNWR7J8KaAhNrYJbGtok16f/IA73WTs=; b=L1XdySypO7buBWt+ULng8DnzCk
 FsIBy/5xednQ+GI+DzqlYnVRWfawvGbDeDAQ9GAuuf0G6+Zrk5q20Vrum0yri6A2MdA2uy7oNfSyo
 ZrTtjcCeYMr13HTYInHpY6P8cqbBd6E/0+U18JXqxloC3iCcpkMmyBXRhKHiNh4jOF2TJmCeQEsbD
 Q19TTSzi5b08dO87dVokCBHjQ9O32yQqzHZ6TvbeeIG2KyfcazlOa3u8RW2/M7xfyBSlW4kDoRjYw
 Rd1koE0OJVi06kCqQ8KE5FG7RJ+ApkD0Yujqv3KXLKxz+DfdkY0Te6ltuewOAXKMYjonU5C2NTIS6
 eN5tqDDNwFqse80EYpHRKOHkdGkqLY6KMwPxiinaUISIByW9JEnvoToO35DOHQHlqlhHCimtdGrn5
 zln6LTsAvl4fPeHca1HzsiYPgZkrWqHfbMgg0VrFjbAPtcEIuMzLnNTqHLEJjXGRLvtvOJXfoW3G8
 QNIHqE8S/9rYKGSJbZ28urM5fuQJrzL6oQX/AHT5Is132Ec2fB9UKqqCllw254DPAko49bpw8MA4K
 niDLGDjyXbZEFfVxD84hRO+Og++u9cIc0HEGHarlYxrBohs2hZnwqeOb6LjAYOc7B05MJacyeKMhK
 ZFHSGLJFkp1gwJjo3jx7V0rzPaE/HkPKd3+kxZnhE=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] qemu-options.hx: 9p: clarify -virtfs vs. -fsdev
Date: Wed, 01 Apr 2020 11:08:56 +0200
Message-ID: <2456463.xyXBBZaS1u@silver>
In-Reply-To: <20200331181033.01d16aa2.cohuck@redhat.com>
References: <208f1fceffce2feaf7c900b29e326b967dce7762.1585661532.git.qemu_oss@crudebyte.com>
 <87369otsqz.fsf@dusky.pond.sub.org>
 <20200331181033.01d16aa2.cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Dienstag, 31. M=E4rz 2020 18:10:33 CEST Cornelia Huck wrote:
> > >> Huh. This prompted me to try this on s390, and it actually creates a
> > >> virtio-9p-pci device there as well, not a virtio-9p-ccw device. A bit
> > >> surprising; but I don't see 9p used much (if at all) on s390 anyway.
> > >=20
> > > Yeah, "virtio-9p-pci" is currently hard coded in softmmu/vl.c [line
> > > 3352]:
> > > https://github.com/qemu/qemu/blob/17083d6d1e0635371418c26b613a6fa68d3=
92f
> > > 49/softmmu/vl.c#L3352>=20
> > Should it be "virtio-9p" instead?  It's an alias for "virtio-9p-pci",
> > except for s390x, where it's an alias for "virtio-9p-ccw".
>=20
> Seems like a reasonable change (although I'm not sure it matters too
> much).

It would be a minor change it seems, and yes there seems to be a virtio-9p-=
ccw=20
implementation, however as long as nobody complains I leave it untouched fo=
r=20
now. Especially since I have no idea about the s390 architecture, nor testi=
ng=20
it.

Best regards,
Christian Schoenebeck



