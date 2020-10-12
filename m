Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F571C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:11:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 333DA20878
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjmGpIsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333DA20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRzTY-0006dD-1A
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kRzS7-00065m-A1
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:09:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kRzS5-00042e-AP
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602515365;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yGr103FxaWOIRv4yB2NMAoxofztEusg2/zE/S9CriUU=;
 b=UjmGpIsQ5F67sZ1afNgeRRTTe5UDE1JuT+HnMjmEJ9TnrpYiONHaz24gZAKFYePOJ43Nfi
 K7Zf6grRXErto4F6eDps+Hgg0IrF4+lY+6ZBh1O26BVB3cQmP4fpfDtnjsbanuFlrW7+eb
 pgT0RoPIznkVklYfKTsSBhEDf7DBozk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-QMdiwSi_OvWyzojTTu9wrw-1; Mon, 12 Oct 2020 11:09:21 -0400
X-MC-Unique: QMdiwSi_OvWyzojTTu9wrw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CD941015CA1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 15:09:20 +0000 (UTC)
Received: from redhat.com (ovpn-114-0.ams2.redhat.com [10.36.114.0])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 810195C225;
 Mon, 12 Oct 2020 15:09:19 +0000 (UTC)
Date: Mon, 12 Oct 2020 16:09:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] scripts: display how long each test takes to execute
Message-ID: <20201012150916.GJ39408@redhat.com>
References: <20200914110948.1425082-1-berrange@redhat.com>
 <fa7c5d50-cfc5-78c2-edf9-416231322f81@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fa7c5d50-cfc5-78c2-edf9-416231322f81@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 12, 2020 at 05:07:18PM +0200, Thomas Huth wrote:
> On 14/09/2020 13.09, Daniel P. Berrangé wrote:
> > Sometimes under CI tests non-deterministically take longer to execute
> > than expected which can trigger timeouts. It is almost impossible to
> > diagnose this though without seeing execution time for each test case.
> > 
> > With this change, when passing "V=1" to make, we get a duration printed
> > at test completion:
> > 
> > $ make check V=1
> > ...snip...
> > MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))} QTEST_QEMU_IMG=./qemu-img G_TEST_DBUS_DAEMON=/home/berrange/src/virt/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_BINARY=./qemu-system-x86_64 tests/qtest/migration-test --tap -k
> > PASS 1 qtest-x86_64: migration-test /x86_64/migration/deprecated
> > PASS 2 qtest-x86_64: migration-test /x86_64/migration/bad_dest
> > PASS 3 qtest-x86_64: migration-test /x86_64/migration/fd_proto
> > PASS 4 qtest-x86_64: migration-test /x86_64/migration/validate_uuid
> > PASS 5 qtest-x86_64: migration-test /x86_64/migration/validate_uuid_error
> > PASS 6 qtest-x86_64: migration-test /x86_64/migration/validate_uuid_src_not_set
> > PASS 7 qtest-x86_64: migration-test /x86_64/migration/validate_uuid_dst_not_set
> > PASS 8 qtest-x86_64: migration-test /x86_64/migration/auto_converge
> > PASS 9 qtest-x86_64: migration-test /x86_64/migration/postcopy/unix
> > PASS 10 qtest-x86_64: migration-test /x86_64/migration/postcopy/recovery
> > PASS 11 qtest-x86_64: migration-test /x86_64/migration/precopy/unix
> > PASS 12 qtest-x86_64: migration-test /x86_64/migration/precopy/tcp
> > PASS 13 qtest-x86_64: migration-test /x86_64/migration/xbzrle/unix
> > PASS 14 qtest-x86_64: migration-test /x86_64/migration/multifd/tcp/none
> > PASS 15 qtest-x86_64: migration-test /x86_64/migration/multifd/tcp/cancel
> > PASS 16 qtest-x86_64: migration-test /x86_64/migration/multifd/tcp/zlib
> > TIME 28 seconds
> 
> If I run "make check -j8" in parallel, it's quite hard to match the "TIME xx
> seconds" lines with the corresponding tests... so could you please in
> include the test name in the output there?

I wasn't intending to update this given paolo's negative response to
the patch.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


