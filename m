Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F63C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:25:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11CFA222C8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BL+7PZ+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CFA222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUmxX-0003bt-1b
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 04:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kUmvo-0001TI-29
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:23:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kUmvk-00058m-2W
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603182219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QjCHYclfxOWWJch4YnbpBToy20b0bWpeJXcs26hEtqk=;
 b=BL+7PZ+mZ/sNaktxPWQ3TAFm01LUOV+dMBKkF6fotJ0c7oY/weyex9qlVT3wiB7n1e+Ars
 q3kdR/SrKFksObGIgeQOjvwF8J/Hah9Rc0GhX9jUifaIZnVIbqRiy8CU87Ya+H+7N/Ts1x
 3xEZI07hX1ywJ0XPudpcr7LR8wqk9ZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-kEjXXAKUOruHzKVyDkaqpQ-1; Tue, 20 Oct 2020 04:23:37 -0400
X-MC-Unique: kEjXXAKUOruHzKVyDkaqpQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A2CE8049D3;
 Tue, 20 Oct 2020 08:23:36 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-112-88.ams2.redhat.com [10.36.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5995F5B4A3;
 Tue, 20 Oct 2020 08:23:35 +0000 (UTC)
Date: Tue, 20 Oct 2020 10:23:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Subject: Re: Plans to bring QMP 'x-blockdev-reopen' out of experimental?
Message-ID: <20201020082333.GB4452@merkur.fritz.box>
References: <20201006091001.GA64583@paraplu>
 <w51mu0ifbuf.fsf@maestria.local.igalia.com>
 <w51k0vmf9k3.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
In-Reply-To: <w51k0vmf9k3.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 19.10.2020 um 18:46 hat Alberto Garcia geschrieben:
> On Mon 19 Oct 2020 05:56:56 PM CEST, Alberto Garcia wrote:
> > And this one in particular:
> >
> >    https://lists.gnu.org/archive/html/qemu-block/2020-02/msg00601.html
> 
> I forgot to add, we still don't support changing bs->file with this
> command, so I guess that would be one blocker?
> 
> There's no other way of inserting filter nodes, or is there?

Not that I'm aware of.

So yes, changing bs->file is the one thing I had in mind for
implementing before we mark it stable.

I'm not entirely sure if we should make some restrictions or allow
arbitrary changes. If it's only about filters, we could check that the
node returned by bdrv_skip_filters() stays the same. This would be
almost certainly safe (if the chain is not frozen, of course).

If people want to dynamically insert non-filters (maybe quorum?), it
might be more restrictive than necessary, though.

Other cases like inserting a qcow2 file in the chain where the old child
becomes the backing file of the newly inserted node should in theory
already be covered by blockdev-snapshot.

Kevin


