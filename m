Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F384AC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 14:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C30205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 14:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VM4W883o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C30205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBgHR-00061Q-Vm
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 10:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1jBgGf-0005F2-6b
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1jBgGe-0007QR-4u
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:54:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27945
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1jBgGe-0007Ow-1G
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583852039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z2M2WV2Pj9ziGqEgBxJxP3f0n9bWbDBnsy/0DGzajiM=;
 b=VM4W883omRTccBxIbDgj98gwgQ/Ft+0V7MIGHeBtRUTnzr1CBYTDuQ0+UnUms3RCZ1pYUg
 8rpB5aCVSXTHTlEMhM2jK2rYmCAE75LpJOj6JfqBy8sm4tAoo4bgS8egJI3rtC1TGc8lNL
 9Wl9588JfKCZO/RtfCPkiZPDZxyMVs0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-oBpVNgr8PRGjq_rGn6R3XA-1; Tue, 10 Mar 2020 10:53:55 -0400
X-MC-Unique: oBpVNgr8PRGjq_rGn6R3XA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B543E107ACC7;
 Tue, 10 Mar 2020 14:53:53 +0000 (UTC)
Received: from paraplu.localdomain (unknown [10.36.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F26DF73874;
 Tue, 10 Mar 2020 14:53:50 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 8C88D3E04B8; Tue, 10 Mar 2020 15:53:49 +0100 (CET)
Date: Tue, 10 Mar 2020 15:53:49 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 4/4] qemu-img: Deprecate use of -b without -F
Message-ID: <20200310145349.GF22884@paraplu>
References: <20200306225121.3199279-1-eblake@redhat.com>
 <20200306225121.3199279-5-eblake@redhat.com>
 <20200309153119.GA20640@paraplu>
 <11ba06c9-fa1e-3168-0322-1859040b655e@redhat.com>
 <20200310094723.GC22884@paraplu>
 <2fd580c2-4b94-4430-1072-ef04bbd2da60@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2fd580c2-4b94-4430-1072-ef04bbd2da60@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, qemu-block@nongnu.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 07:15:29AM -0500, Eric Blake wrote:
> On 3/10/20 4:47 AM, Kashyap Chamarthy wrote:
=20
[...]

> > <digression>
> >=20
> > Ah, didn't realize the inconsistency of 'convert' lacking the '-F'
> > shorthand ... which reminds me, there are at least _three_ ways that I
> > know of, to specify backing file format with 'create':
> >=20
> >      $ qemu-img create -f qcow2 -o 'backing_file=3D./base.raw,backing_f=
mt=3Draw' ./overlay1.qcow2
> >      $ qemu-img create -f qcow2 -b ./base.raw -o backing_fmt=3Draw over=
lay1.qcow2
> >      $ qemu-img create -f qcow2 -b ./base.raw -F raw ./overlay1.qcow2
> >=20
> > I'm wondering about the consistency of having all the above three
> > supported for other operations too.  Now I at least know 'convert' lack=
s
> > the "-F".
>=20
> The -o forms (backing_file=3D and backing_fmt=3D) always work.  Various c=
ommands
> then have additional shorthand: -b/-F for create, -B for convert.  You're
> right that we aren't very consistent, but I'm reluctant to change the
> inconsistencies in this patch=20

Oh, I wasn't implying to tackle the inconsistency as part of this
patch, or series.  Hence the 'digression' :-)  Was just wondering out
loud.

> (at one point in the past, we tried to get rid
> of the shorthand and force all users to go through -o, but that broke too
> many clients that were depending on the undocumented shorthand, so we
> documented the existing shorthand instead).

Fair enough; let's not touch these things for now.

--=20
/kashyap


