Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84278C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 08:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA802080A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 08:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmYjYnVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA802080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV9eo-0005rb-E9
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 04:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kV9dV-0005MN-ST
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 04:38:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kV9dT-0002sj-9W
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 04:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603269496;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+JMNT0BBbV4Y03FucdQxUJ/APlImO+CagJfl/uIS4zA=;
 b=NmYjYnVlglQ8R3HVRAsr0FfmAxrw/uuZB1WUwHHrPotj6ECSqR0Y4IhrLECS4L7/RTkCSf
 0DLo7t7Ragli7qHU0hFNXONyvbgaYXsMqC6/kBNXPMOzGC/s0mjUmstM5h3kkMWIapPptP
 GCkw8ZDedcZ8gvliYz/B3mMk6XUhN8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-eRC015bXPDmRpxdXKHVBPQ-1; Wed, 21 Oct 2020 04:38:11 -0400
X-MC-Unique: eRC015bXPDmRpxdXKHVBPQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEA8180790F
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 08:38:10 +0000 (UTC)
Received: from redhat.com (ovpn-114-86.ams2.redhat.com [10.36.114.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AAF65C1BB;
 Wed, 21 Oct 2020 08:38:06 +0000 (UTC)
Date: Wed, 21 Oct 2020 09:38:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] os: deprecate the -enable-fips option and QEMU's FIPS
 enforcement
Message-ID: <20201021083803.GC412988@redhat.com>
References: <20201020162211.401204-1-berrange@redhat.com>
 <f97dc04a-0cc4-3ba0-ea5e-b185cd0958a7@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f97dc04a-0cc4-3ba0-ea5e-b185cd0958a7@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
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
Cc: libvir-list@redhat.com, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 20, 2020 at 07:22:03PM +0200, Paolo Bonzini wrote:
> On 20/10/20 18:22, Daniel P. Berrangé wrote:
> > @@ -153,6 +153,9 @@ int os_parse_cmd_args(int index, const char *optarg)
> >          break;
> >  #if defined(CONFIG_LINUX)
> >      case QEMU_OPTION_enablefips:
> > +        warn_report("-enable-fips is deprecated, please build QEMU with "
> > +                    "the `libgcrypt` library as the cryptography provider "
> > +                    "to enable FIPS compliance");
> >          fips_set_state(true);
> >          break;
> >  #endif
> 
> Should you also remove fips_set_state(true) and make fips_get_state()
> return the contents of /proc/sys/crypto/fips_enabled, so that VNC
> password authentication is disabled?

I did think about doing that, but decided that since my intention is
to delete all trace of fips_get_state / fips_set_state at the end of
the deprecation period, that it'd be saner just to leave the semantics
unchanged during the deprecation period.

Deprecation notices shouldn't really be associated with changes in
functionality at time they are introduced.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


