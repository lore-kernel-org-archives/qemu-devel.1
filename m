Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C07C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:25:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A54B2206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffIbBhUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54B2206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqJ4M-0000V4-SQ
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 12:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqJ3d-0008T0-OY
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 12:24:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35035
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqJ3b-0004H7-FS
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 12:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593534266;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ssEHkAOiH3zJxVsOonKWyfq72w/V4d0OsSU1hKBIoI8=;
 b=ffIbBhUWr6r/+hrrKowYDBu866QMrDZTqlTYMOxjidjjPLcnv4rDoT2wTdpkD8OuPB12Wa
 vi+LwdsFqhY6xkzAzLOVbNfMQn3Crs7ygMeBjeZ1h7NcmUXxzoeVeeLTFW3bhADRbmdXgy
 i79DfYcjgZVkzPVTY8bRJuXRy/RrgbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-MxN4WJMxPKuOecR9c2slCA-1; Tue, 30 Jun 2020 12:24:22 -0400
X-MC-Unique: MxN4WJMxPKuOecR9c2slCA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E2EEEC1A7
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 16:24:21 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C406F7BEA0;
 Tue, 30 Jun 2020 16:24:13 +0000 (UTC)
Date: Tue, 30 Jun 2020 17:24:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v4 3/7] ccid: build smartcard as module
Message-ID: <20200630162410.GB1370404@redhat.com>
References: <20200622135601.12433-1-kraxel@redhat.com>
 <20200622135601.12433-4-kraxel@redhat.com>
 <434be3b8-8ed0-d27b-99c7-e682b0dc4c02@redhat.com>
 <20200623171248.pnq6otnwyvl3apky@sirius.home.kraxel.org>
 <50b9426c-f34d-c3e7-8572-82c4c7d155a1@redhat.com>
 <20200630160751.y52htbwik4ppurlx@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20200630160751.y52htbwik4ppurlx@sirius.home.kraxel.org>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:34:33
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
Cc: dinechin@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 06:07:51PM +0200, Gerd Hoffmann wrote:
> > >>   static const TypeInfo qcrypto_tls_creds_x509_info = {
> > >>       .parent = TYPE_QCRYPTO_TLS_CREDS,
> > >>       .name = TYPE_QCRYPTO_TLS_CREDS_X509,
> > >>       .module_name = "gnu-tls",
> > >>       ...
> > >>   }
> > > 
> > > Not as-is.  You'll need module load hooks in more places then and some
> > > code tweaks to move it from qdev level (loading hw-* module only) to qom
> > > level.
> 
> [ note: v5 of the series does this ]
> 
> > > But, yes, moving the infrastructure to some qom-module.c file might be
> > > useful when modularizing non-device objects.  Do you have any candidates
> > > in mind?
> > 
> > So far I was only thinking of gnutls.
> 
> Looks challenging on a quick glance ...

Yeah, I'm not convinced modularizing that is a good use of time. It is
plumbed in across multiple backends (chardev, migration, block, ui)
and also providing the secure RNG used across QEMU.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


