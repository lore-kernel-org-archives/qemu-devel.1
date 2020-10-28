Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F446C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:02:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56873247B1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4bLdrRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56873247B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXmy3-0001Ss-4h
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kXmvV-0000QS-Ut
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:59:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kXmvT-0003nu-I6
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603897186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UZM4a7OBI8jwLSn81QRzSKNhv+bAaXnXqu+OxMPzNsE=;
 b=f4bLdrRTFYl4+Xn324dHdLIUmSgIcMArgYKVg2EofQQGFbplJgdh7s0WZAE/26KC9fqZhB
 hAjjcLX/5fHem5Hz7hwYpdqjrLlDYYRENFoxFmaBd+Ex+iSJAXho11WMdjl7MOQhCnzdvg
 z1oEC3WfWhe/AHA9stu6Y3dj8BpTnpI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-TXXn091IPHWM9Nx1-ifsnw-1; Wed, 28 Oct 2020 10:59:44 -0400
X-MC-Unique: TXXn091IPHWM9Nx1-ifsnw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 039C2760C8;
 Wed, 28 Oct 2020 14:59:43 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-114-164.ams2.redhat.com [10.36.114.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D97605C1D7;
 Wed, 28 Oct 2020 14:59:38 +0000 (UTC)
Date: Wed, 28 Oct 2020 15:59:37 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/4] qemu-storage-daemon: QAPIfy --chardev the stupid way
Message-ID: <20201028145937.GB7355@merkur.fritz.box>
References: <20201026101005.2940615-1-armbru@redhat.com>
 <d00ef574-b2c4-887c-6a37-79f6cf6eeae0@redhat.com>
 <87a6w63kbw.fsf@dusky.pond.sub.org>
 <20201028114625.GA7355@merkur.fritz.box>
 <53ba80fe-8e4c-88c6-181d-f3b33bf3e9bc@redhat.com>
MIME-Version: 1.0
In-Reply-To: <53ba80fe-8e4c-88c6-181d-f3b33bf3e9bc@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: marcandre.lureau@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.10.2020 um 15:39 hat Paolo Bonzini geschrieben:
> On 28/10/20 12:46, Kevin Wolf wrote:
> > I don't think this is the right thing to do at this point. Making more
> > use of QOM is an orthogonal problem and would only make solving this one
> > harder.
> 
> Making more use of QOM will make this a non-problem.  You'll just use
> object-add and -object and, when you figure out the QOM schema, it will
> just work.

Yes, but figuring out the QOM schema (or rather, what the interface
represented by the schema should look like) is the hard part. It is
exactly the same hard part that we're currently trying to figure out
without also worrying about QOM at the same time.

-object and object-add instead of -chardev and chardev-add change the
spelling, but solve none of these problems.

Kevin


