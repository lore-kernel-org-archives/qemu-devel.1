Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DF0C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3916520857
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8p1ScAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3916520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo3vF-0001LC-Gy
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 07:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jo3uO-0008D9-Dx
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 07:49:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33166
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jo3uL-0007bI-JI
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 07:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592999376;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Iku4983sLkodUENet20qUppGd9Wn78nkwDvq/I9LUFM=;
 b=X8p1ScAB/e6QtNDSTTcof62P8mq3WWA5qhoHAUrepAT1d4WInoKwoos8PlJTEU2osmxILM
 Z1r8GgYhgyx1v2RBZafLrVIjJkZssMjqiZ/Qdrffchq+FN1szwrTvEIz8iQIujb/L/7Hk6
 aO15VIKZjNNT3rKr6tKSMfrpi1+udwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-GOiTGZcyMYSzrAnM41XXSA-1; Wed, 24 Jun 2020 07:49:27 -0400
X-MC-Unique: GOiTGZcyMYSzrAnM41XXSA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C9688015F0;
 Wed, 24 Jun 2020 11:49:26 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A5E3E5C240;
 Wed, 24 Jun 2020 11:49:18 +0000 (UTC)
Date: Wed, 24 Jun 2020 12:49:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Szymon Lukasz <noh4hss@gmail.com>
Subject: Re: [PATCH v2 0/6] virtio-console: notify about the terminal size
Message-ID: <20200624114915.GH774096@redhat.com>
References: <20200624112640.82673-1-noh4hss@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200624112640.82673-1-noh4hss@gmail.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: lvivier@redhat.com, mst@redhat.com, amit@kernel.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 24, 2020 at 01:26:34PM +0200, Szymon Lukasz wrote:
> Also there is a problem with the virtio spec and Linux Kernel
> implementation, the order of fields in virtio_console_resize struct
> differs between the kernel and the spec. I do not know if there is any
> implementation of the virtio-console driver that handles resize messages
> and uses a different order than Linux.

Well this is a bit of a mess :-(

The main virtio_console_config struct has cols, then rows.

The Linux impl of resizing appears to have arrived in 2010, and created
a new struct with rows, then cols.

commit 8345adbf96fc1bde7d9846aadbe5af9b2ae90882
Author: Amit Shah <amit.shah@redhat.com>
Date:   Thu May 6 02:05:09 2010 +0530

    virtio: console: Accept console size along with resize control message
    
    The VIRTIO_CONSOLE_RESIZE control message sent to us by the host now
    contains the new {rows, cols} values for the console. This ensures each
    console port gets its own size, and we don't depend on the config-space
    rows and cols values at all now.
    
    Signed-off-by: Amit Shah <amit.shah@redhat.com>
    CC: Christian Borntraeger <borntraeger@de.ibm.com>
    CC: linuxppc-dev@ozlabs.org
    CC: Kusanagi Kouichi <slash@ac.auone-net.jp>
    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>


The virtio spec documenting this came 4 years later in 2014 and documented
the resize struct with cols, then rows, which differs from Linux impl,
but matches ordering of the main virtio_console_config:

commit 908cfaa782e950d6656d947599d7a6c9fb16cad1
Author: rusty <rusty@0c8fb4dd-22a2-4bb5-bc14-6c75a5f43652>
Date:   Wed Feb 12 03:15:57 2014 +0000

    Feedback #6: Applied
    
    As per minutes:
            https://lists.oasis-open.org/archives/virtio/201402/msg00121.html
    
    Signed-off-by: Rusty Russell <rusty@au1.ibm.com>
    
    git-svn-id: https://tools.oasis-open.org/version-control/svn/virtio@237 0c8fb4dd-22a2-4bb5-bc14-6c75a5f43652

I can understand why it is desirable for the resize struct to match
the order of the initial config struct.  I'm guessing it just wasn't
realized that the Linux impl was inverted for resize

The FreeBSD impl of virtio-console doesn't do resize:

  https://github.com/freebsd/freebsd/blob/master/sys/dev/virtio/console/virtio_console.c#L874

Not sure what other impls are going to be around, but I feel like
Linux is going to be the most commonly deployed by orders of magnitude.

So I'd say QEMU should match Linux, and the spec should be fixed.


Have you reported this bug to the virtio spec people directly yet ?

I don't see an issue open at

  https://github.com/oasis-tcs/virtio-spec/issues/

so I think one should be filed there

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


