Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01495C388F9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3273F20874
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 09:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VY2O/6oA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3273F20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWynO-0004LI-3X
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 05:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kWymN-0003YL-06
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 05:27:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kWymK-000062-Cd
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 05:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603704418;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkXeyfW8Ot+OAGIKucUQ0E3V55HwNgXzH2KnR07Ng3M=;
 b=VY2O/6oAvOFvpWUwYUxMfraFF50ezv+Di4FuxiwefoHVzBN24gtDMd20mbQxxb445aLylW
 Ow861Eh5dhw9DP4ej48IfdvOX89gRhLicrZEfPIIoJdm3ANgAVWc4HLhYKIQ9W/jlReRZA
 cD+T3T19k1LSzoGaoSrwVz7bJjUsk3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-fIdYcKrcOgK4xMUBL7H1Tw-1; Mon, 26 Oct 2020 05:26:52 -0400
X-MC-Unique: fIdYcKrcOgK4xMUBL7H1Tw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1D8E1084C84;
 Mon, 26 Oct 2020 09:26:51 +0000 (UTC)
Received: from redhat.com (ovpn-114-185.ams2.redhat.com [10.36.114.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1000E60C07;
 Mon, 26 Oct 2020 09:26:49 +0000 (UTC)
Date: Mon, 26 Oct 2020 09:26:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 0/6] Add support for Control-Flow Integrity
Message-ID: <20201026092647.GC496050@redhat.com>
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
 <947e698f-a582-956d-5b42-1dee6442f15d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <947e698f-a582-956d-5b42-1dee6442f15d@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Daniele Buono <dbuono@linux.vnet.ibm.com>,
 Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 23, 2020 at 03:33:31PM -0500, Eric Blake wrote:
> On 10/23/20 3:06 PM, Daniele Buono wrote:
> > v2: Several months (and structural changes in QEMU) have passed since v1.
> > While the spirit of the patch is similar, the implementation is changed
> > in multiple points, and should address most if not all the comments
> > received in v1.
> 
> > 5) Most of the logic to enable CFI goes in the configure, since it's
> > just a matter of checking for dependencies and incompatible options.
> > However, I had to disable CFI checks for a few TCG functions.
> > This can only be done through a blacklist file. I added a file in the
> > root of QEMU, called cfi-blacklist.txt for such purpose. I am open to
> > suggestions on where the file should go, and I am willing to become the
> > maintainer of it, if deemed necessary.
> 
> In the meantime, we have commits like:
> 
> commit b199c682f1f0aaee22b2170a5fb885250057eec2
> Author: Philippe Mathieu-Daudé <philmd@redhat.com>
> Date:   Thu Sep 10 09:01:31 2020 +0200
> 
>     target/i386/kvm: Rename host_tsx_blacklisted() as host_tsx_broken()
> 
>     In order to use inclusive terminology, rename host_tsx_blacklisted()
>     as host_tsx_broken().
> 
> which may help you in coming up with a more appropriate name for the new
> file.

Something like  cfi-exclude-list.txt or cfi-skip-list.txt seems reasonable


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


