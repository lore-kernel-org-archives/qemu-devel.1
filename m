Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD25C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485DC206B5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHpakraT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485DC206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3yo2-0003Mu-HR
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k3ynO-0002lL-4T
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:36:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36419
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k3ynM-0003Va-IH
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596792971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x25/IX41xbXr+cTiGe/H5FuuN5m9rQJP4K0sl6evZiU=;
 b=RHpakraTyGxil5Q3p4JE1K6TNkh27ovYHSbfJhStaj5mWqFGSSsuxsMYtUvik4KbSRc/T3
 so7mfX6WiFctIeY7IsdpxFmzrQWBijIx6iSxz1HZ2OoKoQu7MreZ8KWfoH9ECsJtKP0zV0
 c6fK7HNRw8qtKdu5WIgmZVFCxcf+MJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-PxXz1ReVMOmzHtmFv4NsgQ-1; Fri, 07 Aug 2020 05:36:09 -0400
X-MC-Unique: PxXz1ReVMOmzHtmFv4NsgQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B932280BCAC;
 Fri,  7 Aug 2020 09:36:08 +0000 (UTC)
Received: from gondolin (ovpn-112-214.ams2.redhat.com [10.36.112.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 669845F7D8;
 Fri,  7 Aug 2020 09:36:00 +0000 (UTC)
Date: Fri, 7 Aug 2020 11:35:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
Message-ID: <20200807113557.178825af.cohuck@redhat.com>
In-Reply-To: <499b18ae-b15d-abbb-faf5-d9bdd5262fa4@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <20200807085302.7d7616df.cohuck@redhat.com>
 <499b18ae-b15d-abbb-faf5-d9bdd5262fa4@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:53:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, alex.bennee@linaro.org,
 stefanha@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Aug 2020 09:59:57 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 07/08/20 08:53, Cornelia Huck wrote:
> > So, I was planning to give it a go on s390, but I cannot even build it
> > on x86 (fails configure):
> > 
> > Build started at 2020-08-07T08:43:43.873638
> > Main binary: /usr/bin/python3
> > Build Options: -Doptimization=2 -Ddebug=true -Dwerror=true -Dstrip=true -Db_pie=true -Db_coverage=false -Dsdl=auto -Dsdl_image=auto -Dvnc=enabled -Dvnc_sasl=auto -Dvnc_jpeg=auto -Dvnc_png=auto -Dprefix=/usr/local -Dbindir=/usr/local/bin -Ddatadir=/usr/local/share -Dincludedir=/usr/local/include -Dlibdir=/usr/local/lib -Dlibexecdir=/usr/local/libexec -Dlocalstatedir=/usr/local/var -Dmandir=/usr/local/share/man -Dsysconfdir=/usr/local/etc
> > Python system: Linux
> > The Meson build system
> > Version: 0.52.0
> > Source dir: /home/cohuck/git/qemu
> > Build dir: /home/cohuck/git/qemu/build
> > Build type: native build
> > 
> > meson.build:438:22: ERROR: Key must be a string.
> >   config_target_h += {target: configure_file(output: target + '-config-target.h',
> >                       ^
> > (Fedora 31, version from your github branch)
> > 
> > Is there anything special I need to install beyond meson?  
> 
> You probably need to do "git submodule init"/"git submodule update" so
> that it picks up the in-tree meson (0.55.0).

Thanks, that is getting me further. I still seem to be holding it wrong
in different places, though...

- on an x86 system, configure fails with:
  ../meson.build:1257:3: ERROR: Key CONFIG_QEMU_PRIVATE_XTS is not in dict
- on an s390x system, it mostly builds, but I end up with a bunch of
  link errors for libblock.fa, where it fails to find various ZSTD_
  symbols

> 
> If you want to test on s390, just testing the boot ROM would be great
> (patch 3).  That one does not need Meson at all; the purpose of the
> patch is just to decouple the boot ROM makefile from rules.mak, which
> allows to drop some of the contents of rules.mak.

I gave it a try; no errors, but then I realized that the image does not
seem to get rebuilt? I'll double check later.


