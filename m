Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6A0C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:49:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF032080C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5fOgvOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF032080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVBgS-0004CG-0k
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 06:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVBfa-0003ao-1Z
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:48:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kVBfX-0000MZ-Sr
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603277314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EP0zm6wg0wV1qgGLkFJ0ieEECxTVLKe9kgdr3XbICg8=;
 b=c5fOgvOsGz9N74tjP8A7B1Gg132zB7kO5sjw1zc3X6xdswJjcVJoI2jhMLf454MPbz8PR3
 9PY8euYP0G14kY7bjHMIam1ntv1I99i3X4v1BqrbrqBpjOLIQP+RWzXT8vCjuL2Gy5d5XV
 ol/3f+ORg68elI9hXO5Lej5UkIjJEX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-2xhvh3BzPDi-S-eZjNfH1g-1; Wed, 21 Oct 2020 06:48:31 -0400
X-MC-Unique: 2xhvh3BzPDi-S-eZjNfH1g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 015F9106C0F7;
 Wed, 21 Oct 2020 10:48:29 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-112-150.ams2.redhat.com [10.36.112.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C96E710013C1;
 Wed, 21 Oct 2020 10:48:27 +0000 (UTC)
Date: Wed, 21 Oct 2020 12:48:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Subject: Re: Plans to bring QMP 'x-blockdev-reopen' out of experimental?
Message-ID: <20201021104826.GA8958@merkur.fritz.box>
References: <20201006091001.GA64583@paraplu>
 <w51mu0ifbuf.fsf@maestria.local.igalia.com>
 <w51k0vmf9k3.fsf@maestria.local.igalia.com>
 <20201020082333.GB4452@merkur.fritz.box>
 <w51mu0hm7vc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
In-Reply-To: <w51mu0hm7vc.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 20.10.2020 um 13:53 hat Alberto Garcia geschrieben:
> On Tue 20 Oct 2020 10:23:33 AM CEST, Kevin Wolf wrote:
> >> >    https://lists.gnu.org/archive/html/qemu-block/2020-02/msg00601.html
> >> 
> >> I forgot to add, we still don't support changing bs->file with this
> >> command, so I guess that would be one blocker?
> >> 
> >> There's no other way of inserting filter nodes, or is there?
> >
> > Not that I'm aware of.
> >
> > So yes, changing bs->file is the one thing I had in mind for
> > implementing before we mark it stable.
> 
> Note that you can still open a new bs with a different bs->file and
> replace the original one (as long as the original one is the backing
> file of an existing bs, that is :)).

You can't open the same image twice, so this won't always work.

> > I'm not entirely sure if we should make some restrictions or allow
> > arbitrary changes. If it's only about filters, we could check that the
> > node returned by bdrv_skip_filters() stays the same. This would be
> > almost certainly safe (if the chain is not frozen, of course).
> >
> > If people want to dynamically insert non-filters (maybe quorum?), it
> > might be more restrictive than necessary, though.
> 
> You mean replacing bs->file with a Quorum node? Quorum itself does not
> use bs->file, it has the 'children' attribute.

Yes, replaying bs->file with a Quorum node that has the old bs->file as
one of its children. Or removing a Quorum node so that one of it's
children replaces it.

But this is probably not a very important use case, so I think the
restriction is not a problem. Lifting restrictions later is easier than
adding new ones.

Kevin


