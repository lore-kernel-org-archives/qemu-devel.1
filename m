Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B232C33CA8
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 09:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E90132080D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 09:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gXgB9L/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90132080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqvne-0002yH-21
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 04:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <abologna@redhat.com>) id 1iqvn2-0002Aw-I0
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 04:13:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <abologna@redhat.com>) id 1iqvn1-0007cj-Dd
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 04:13:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44803
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <abologna@redhat.com>) id 1iqvn1-0007aB-8S
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 04:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578906818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kmkZrw+shUYufRgfuk5ZrNVQicZjuDFrWGQ0h/nELHM=;
 b=gXgB9L/4aOA2aj2ADdDQSgwXrAW5pQ91g7MeHBhnkIqYOZAqya7Nj7Xp3qHpWGiGQCKWfp
 b00I3KAk+5hueQiZh2GC9GI9ztXQVXz5wCkfwrcPuyumcl5b1wtm3ntAcIto3AY9KHJvjT
 KwwpAkBTynGVpKw+8zNqecUSq+aBBBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-_K5jABSXOiSPkf-Y2QjJzg-1; Mon, 13 Jan 2020 04:13:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 431EE1005502;
 Mon, 13 Jan 2020 09:13:33 +0000 (UTC)
Received: from kinshicho.usersys.redhat.com (unknown [10.43.2.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C0D5350A8F;
 Mon, 13 Jan 2020 09:13:29 +0000 (UTC)
Message-ID: <1a8f9121a3cb85d415ff1c67a5379a717ad2b8e0.camel@redhat.com>
Subject: Re: [RFC PATCH qemu] spapr: Kill SLOF
From: Andrea Bolognani <abologna@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Daniel Henrique Barboza
 <danielhb413@gmail.com>, qemu-devel@nongnu.org
Date: Mon, 13 Jan 2020 10:13:27 +0100
In-Reply-To: <5ed92e2a-4b9f-8092-cb67-8d94c3891e20@ozlabs.ru>
References: <20200103074404.30853-1-aik@ozlabs.ru>
 <3cf3e733-199a-61ba-7aaa-05e9546cd4d9@ozlabs.ru>
 <dd98618f-01c6-850f-ac00-454a2f798508@gmail.com>
 <81f1f752-3ada-2c8d-38b7-1344c7633e14@ozlabs.ru>
 <e3299f0688127627de96eb2db1f127bf94df9085.camel@redhat.com>
 <5ed92e2a-4b9f-8092-cb67-8d94c3891e20@ozlabs.ru>
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: _K5jABSXOiSPkf-Y2QjJzg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Fabiano Rosas <farosas@linux.ibm.com>, Sam Bobroff <sbobroff@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@ozlabs.org>, qemu-ppc@nongnu.org,
 Leonardo Augusto =?ISO-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>,
 Leonardo Bras <leonardo@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-01-08 at 13:34 +1100, Alexey Kardashevskiy wrote:
> On 07/01/2020 20:39, Andrea Bolognani wrote:
> > On Tue, 2020-01-07 at 12:55 +1100, Alexey Kardashevskiy wrote:
> > > Petitboot kernel+initramdisk almost replaces SLOF + GRUB.
> > 
> > Is this necessarily a good thing?
> 
> The bare metal host and the powernv machine in QEMU do not use grub,
> they use petitboot which parses all grub configs and supports quite a lot.

How well does the distro integration work? Eg. if I change something
in /etc/default/grub and then run grub2-mkconfig, can I expect my
changes to be picked up? In which scenarios will that *not* work?

> Using Linux for a boot loader is not powerpc-only thing really, some
> folks do this too (forgot who, just heard this at the KVM forum).

While other options are available and some architectures use
something else entirely, GRUB is the de-facto standard across most
of the non-obscure architectures.

I guess the question is whether it's more important to be consistent
within the architecture or across them. I think the latter might be
preferable, especially when we consider what I think is the most
common scenario, that is, someone who's used to having GRUB on their
x86 machine running a ppc64 guest on the cloud. The more skills they
can automatically transfer over, the better.

> > Personally I quite like the fact
> > that I can use the same bootloader across x86, ppc64 and aarch64.
> 
> I am not suggesting removing SLOF soon

Perhaps the patch subject shouldn't be "kill SLOF" then? ;)

-- 
Andrea Bolognani / Red Hat / Virtualization


