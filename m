Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23E3C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A8B525229
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="amsSr5aV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8B525229
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSMhs-0004k1-7z
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 11:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kSMgt-0003jM-0i
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:58:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kSMgo-0006rH-IW
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602604692;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hmV2zkNR/uPsLVS9+fqIr0hpTWhnAiVnNJK9RA3h9YU=;
 b=amsSr5aVSSh7AaBBHwpzKyNF4XKri9MW6Ra++sd4O6ZK1WuTZGSOiBdCC01rxrax36K9Im
 eEJWL3C5o9r6a45Z76QLTj/yKHy9Wn1eZRxgXcWe4m74iaC8jNpJ4Ex7hUEPlfdChMuBqi
 OjogFro1lCD0slokp6AfRJ55BAwCvKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-s7oL4tXmNm-YDGfn6cdDyg-1; Tue, 13 Oct 2020 11:58:03 -0400
X-MC-Unique: s7oL4tXmNm-YDGfn6cdDyg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D49118A8220;
 Tue, 13 Oct 2020 15:58:02 +0000 (UTC)
Received: from redhat.com (ovpn-114-78.ams2.redhat.com [10.36.114.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 807A619C59;
 Tue, 13 Oct 2020 15:58:00 +0000 (UTC)
Date: Tue, 13 Oct 2020 16:57:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Joelle van Dyne <j@getutm.app>
Subject: Re: [PATCH 04/10] meson: option to build as shared library
Message-ID: <20201013155757.GR70612@redhat.com>
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-5-j@getutm.app>
 <20201013075104.GA70612@redhat.com>
 <e27acf2-4dbe-4674-78cc-67aa7b505c54@eik.bme.hu>
 <20201013144625.GP70612@redhat.com>
 <CA+E+eSBu_LOnQ=B+N7vm3H2zkBxey8z_T1V0JpSU8rZND6GRYQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+E+eSBu_LOnQ=B+N7vm3H2zkBxey8z_T1V0JpSU8rZND6GRYQ@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 13, 2020 at 08:16:46AM -0700, Joelle van Dyne wrote:
> I will start a separate conversation of UTM's license compatibility.
> 
> Regarding the patch, would some sort of warning message in configure
> (if building as a shared library) regarding the license be wise? Or
> would it pollute the output logs?

I think there's also a more fundamental question of whether this is
a concept we actually want to support at all.

IIUC, this shared library just exposes a "qemu_main" method which
the external app has to jump into. IOW, the "char **argv" parameter
to qemu_main becomes the ELF library ABI.  Declaring this a shared
library interface is a non-negligible commitment for QEMU maintainers,
especially given that there is alot about QMEU's command line parsing
that maintainers do not like and wish to change.

There is a further question about whether we want to commit to an
architectural model where  fork() is not something we can use. A
significant area of development for QEMU right now is around the
modularization of the device model such that QEMU is no longer a
single process, but rather a collection of processes, each proc
responsible for some specific hardware emulation. Thus far all the
device modularization stuff is strictly optional, but we have the
freedom to make it mandatory and use it transparently behind the
scenes. If we declare this shared library model supported in order
to avoid use of fork, then we're restricting our future options
wrt device modularization.

So including the license issue, that's three major questionmarks
around desirability of supporting use of QEMU as a shared library.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


