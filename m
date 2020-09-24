Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AF3C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:49:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57DE2396E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFPWU2X+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57DE2396E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLOoM-0006kN-RU
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kLOnn-0006Ha-Au
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 06:48:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59046)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kLOnk-0000MF-6z
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 06:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600944515;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=022RZ7NELwvKgQZ0eZkr/MiqcEMFpkPaWVqn44IUulE=;
 b=iFPWU2X+sJWwThbBDeFtqARoy5oYVbcqGjSKLS5qKQQQZxQaBHHVi9vwVtSmNyLDOnnzt9
 Qqf6g/fkpcaj31SLyUZQgWXKugTnu2aUt9IsmmUzBODOjEot+C1tcFC4w7RfLBiORRQSNH
 jBZcQrc5SAHflku8o0CuRBsKb2L/Ko0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-Y2-ZWP5RO4C8MgEREeOEYA-1; Thu, 24 Sep 2020 06:48:33 -0400
X-MC-Unique: Y2-ZWP5RO4C8MgEREeOEYA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 620991074652;
 Thu, 24 Sep 2020 10:48:32 +0000 (UTC)
Received: from redhat.com (ovpn-115-25.ams2.redhat.com [10.36.115.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E13955764;
 Thu, 24 Sep 2020 10:48:28 +0000 (UTC)
Date: Thu, 24 Sep 2020 11:48:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: srange crash in virtio-gpu
Message-ID: <20200924104825.GD2097005@redhat.com>
References: <7e21dd39-f251-e883-1a8e-788fc5d85ea0@de.ibm.com>
MIME-Version: 1.0
In-Reply-To: <7e21dd39-f251-e883-1a8e-788fc5d85ea0@de.ibm.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 12:35:06PM +0200, Christian Borntraeger wrote:
> Gerd,
> 
> with current master build via a slightly fixed up fedora spec file I do get a crash in virtio-gpu
> when libvirt queries the qemu. 
> I can trigger that also via command line
> 
> $ /usr/bin/qemu-system-s390x -device virtio-gpu-pci,help
> qemu-system-s390x: -device virtio-gpu-pci,help: missing object type 'virtio-gpu-device'
> Aborted (core dumped)
> $ /usr/bin/qemu-system-s390x -device virtio-gpu-ccw,help
> qemu-system-s390x: -device virtio-gpu-ccw,help: missing object type 'virtio-gpu-device'
> Aborted (core dumped)
> 
> Since I cannot reproduce the same when I build it without the spec file this must
> be something configuration specific.

The Fedora spec builds using  --enable-modules, and the error message
shows that you don't have the .so for virtio-gpu on disk.

> The call trace is:
> 
> (gdb) bt
> #0  0x000003ff9e349026 in raise () at /lib64/libc.so.6
> #1  0x000003ff9e32b162 in abort () at /lib64/libc.so.6
> #2  0x000002aa274abfca in object_initialize (data=<optimized out>, size=<optimized out>, typename=0x2aa2754904e "virtio-gpu-device") at ../qom/object.c:531

This abort is evil though

We need this to get into the "Device '<blah>' not found"  code path
to report a nice error.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


