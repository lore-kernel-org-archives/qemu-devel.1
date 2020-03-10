Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5DAC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A55352465A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M251AT2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55352465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBcbu-0000oI-Ur
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 06:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1jBcaD-00076z-Rb
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1jBcaC-0002fd-5Q
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:57:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51397
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1jBcaB-0002dN-Tv
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583837875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jr8Vu6v/pBge/0z08JM5B3yDPs5iGKfVAWac49oXhtY=;
 b=M251AT2f3JHqVGstfGxnixxsWp11l1ViW/xXrGHSE/LuUDXK/Mu69kybE8mcAyhG6Lcnn0
 gG+7svvcUZkuPI0TLX7Czd7XOYYQw4l3lo/s6ujJPx+RwUKkQ3xgfBKVAr0mLJLpJ6mTpJ
 YEt3ihxn3x733XMHwdtif7K7Jvq5Dj4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-lCqsECi8O1q-CJLglU6JbA-1; Tue, 10 Mar 2020 06:57:53 -0400
X-MC-Unique: lCqsECi8O1q-CJLglU6JbA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F922805750;
 Tue, 10 Mar 2020 10:57:52 +0000 (UTC)
Received: from paraplu.localdomain (unknown [10.36.118.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B635D92D32;
 Tue, 10 Mar 2020 10:57:48 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 58A373E04B8; Tue, 10 Mar 2020 11:57:46 +0100 (CET)
Date: Tue, 10 Mar 2020 11:57:46 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 4/4] qemu-img: Deprecate use of -b without -F
Message-ID: <20200310105746.GD22884@paraplu>
References: <20200306225121.3199279-1-eblake@redhat.com>
 <20200306225121.3199279-5-eblake@redhat.com>
 <20200309153119.GA20640@paraplu>
 <11ba06c9-fa1e-3168-0322-1859040b655e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <11ba06c9-fa1e-3168-0322-1859040b655e@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, qemu-block@nongnu.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 09, 2020 at 10:42:25AM -0500, Eric Blake wrote:

[...]

> > > +qemu-img backing file without format (since 5.0.0)
> > > +''''''''''''''''''''''''''''''''''''''''''''''''''
> > > +
> > > +The use of ``qemu-img create``, ``qemu-img rebase``, ``qemu-img
> > > +convert``, or ``qemu-img amend`` to create or modify an image that
> > > +depends on a backing file now recommends that an explicit backing
> > > +format be provided.

Also for the `qemu-img amend` case, I'm not clear if the following scenario
ought to throw the warning:

    $> ~/build/qemu/qemu-img info --backing-chain overlay1.qcow2=20
    image: overlay1.qcow2
    file format: qcow2
    virtual size: 4 GiB (4294967296 bytes)
    disk size: 196 KiB
    cluster_size: 65536
    backing file: base.raw
    Format specific information:
        compat: 1.1
        lazy refcounts: false
        refcount bits: 16
        corrupt: false
   =20
    image: base.raw
    file format: raw
    virtual size: 4 GiB (4294967296 bytes)
    disk size: 778 MiB

    $> ~/build/qemu/qemu-img amend -o compat=3Dv3 overlay1.qcow2=20

    $> echo $?
    0

I'm just trying to work out the scenarios where the warnings ought to
show up (for all the four cases: create, rebase, convert, amend).

[...]

--=20
/kashyap


