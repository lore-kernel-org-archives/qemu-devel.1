Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93CBC4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 08:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18BCA20708
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 08:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKfDWN+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BCA20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNXoS-0007EH-2j
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 04:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kNXnS-0006md-Fv
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 04:49:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43191)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kNXnP-0008PK-Vm
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 04:49:10 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601455747;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hPxT6E93VgCd6qQbASEMijI0SFcW/mi8pKBGt8gjUnw=;
 b=GKfDWN+sVoEgKfNRIP9DWLSfkogITJ03oVAguEE5oEyzSKrNi+837MznVaYDpemfIvXyLI
 jvQig/RItoFm7DzLBAHXQvzjWCbwKyIfg+dnXFp08L2g4dvcSfiFi9psxU3GSe/7v8S82I
 4aHRLFVbigSDDsh8W6X9kHo6Afz8HpI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-0YGlpm5GM8KMBKYupTanWg-1; Wed, 30 Sep 2020 04:49:05 -0400
X-MC-Unique: 0YGlpm5GM8KMBKYupTanWg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 799671868417
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 08:49:04 +0000 (UTC)
Received: from redhat.com (ovpn-114-69.ams2.redhat.com [10.36.114.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78E694149;
 Wed, 30 Sep 2020 08:49:03 +0000 (UTC)
Date: Wed, 30 Sep 2020 09:49:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Subject: Re: Some comments on using qemu-storage-daemon
Message-ID: <20200930084900.GB2264779@redhat.com>
References: <20200930084058.GA29698@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200930084058.GA29698@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 30, 2020 at 09:40:59AM +0100, Richard W.M. Jones wrote:
> I understand that QSD is at an early stage of development and I'm sure
> you have plans to fix these things.  Nevertheless here are my comments
> after trying to add an interop test with libnbd.
> 
> (1) Documentation!  (Or complete lack of it ...)  I had to ask Kevin
> how to construct the command line because several things were not
> obvious.  In particular the --blockdev parameters only make sense if
> you're already used to constructing blockdev parameters (and these
> are, separately, not well-documented).  And you have to supply the
> parameters in a particular order on the command line, else it doesn't
> work.
> 
> (2) There seems to be no --pid-file option, so there's no way of
> knowing when the server is ready to accept connections, except to
> start QSD and then "sleep for a bit".

It supports QMP via the normal chardev framework, so you can pre-create
a UNIX listener socket and pass in the pre-opened FD. The parent just
sends the QMP handshake, and waits until it gets EOF (exited during
startup) or gets the QMP response (successfully running).

> 
> (3) Seems to be no support for either serving requests over
> stdin/stdout (qemu-nbd also lacks this, but it's common for other NBD
> servers); or for systemd socket activation (qemu-nbd supports this).
> 
> (4) Some parameter names changed between 5.1 and upstream.  I
> understand that you're still finalizing the command line, so this
> isn't a problem in itself, but others who try to use QSD will need to
> be aware of it.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


