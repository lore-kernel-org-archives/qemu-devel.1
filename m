Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFF3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 06:54:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5681220866
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 06:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OP1t3JvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5681220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3wGV-0005sZ-ID
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 02:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k3wFk-0005Nb-6X
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 02:53:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35203
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k3wFg-0008VS-8l
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 02:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596783194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K5YUUw/Y8frE6RtaO8hv102FnXk8FRAMwERnySE0WCk=;
 b=OP1t3JvQ6yoBCOebwH4Bz9lHSgq12f+1jTrWDJshQpwOXsgFZk3weDx+3W5YrRDYHOVDfc
 Pm6ctWTH+csg2eWyr1jE63pTFCHAT3EmC2xluWH+qJ+7OBtjelXMQuwLJwvj0M2vPFlXWa
 sILbOnFDNlrX3y+KQwv/Wv/NksABuCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-e70qtIknPkOkaclifv-BkA-1; Fri, 07 Aug 2020 02:53:10 -0400
X-MC-Unique: e70qtIknPkOkaclifv-BkA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4416800404;
 Fri,  7 Aug 2020 06:53:09 +0000 (UTC)
Received: from gondolin (ovpn-112-214.ams2.redhat.com [10.36.112.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4EF787A6D;
 Fri,  7 Aug 2020 06:53:04 +0000 (UTC)
Date: Fri, 7 Aug 2020 08:53:02 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
Message-ID: <20200807085302.7d7616df.cohuck@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On Thu,  6 Aug 2020 21:13:56 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> This the more or less final version of the Meson conversion.  Due to
> the sheer size of the series you have been CCed only on the cover
> letter.
> 
> The series reaches the point where Makefile.target and unnest-vars
> can be removed, and all builds become non-recursive.  I have also
> converted parts of the testsuite, notably qtest since it is needed
> for fuzzing.  What's left for _after_ the merge is: 1) unit tests;
> 2) moving the rest of installation to meson (for which I have patches);
> 3) moving feature detection from configure to meson.
> 
> Things I still haven't tested:
> - fuzzing
> - non-x86/Linux builds

So, I was planning to give it a go on s390, but I cannot even build it
on x86 (fails configure):

Build started at 2020-08-07T08:43:43.873638
Main binary: /usr/bin/python3
Build Options: -Doptimization=2 -Ddebug=true -Dwerror=true -Dstrip=true -Db_pie=true -Db_coverage=false -Dsdl=auto -Dsdl_image=auto -Dvnc=enabled -Dvnc_sasl=auto -Dvnc_jpeg=auto -Dvnc_png=auto -Dprefix=/usr/local -Dbindir=/usr/local/bin -Ddatadir=/usr/local/share -Dincludedir=/usr/local/include -Dlibdir=/usr/local/lib -Dlibexecdir=/usr/local/libexec -Dlocalstatedir=/usr/local/var -Dmandir=/usr/local/share/man -Dsysconfdir=/usr/local/etc
Python system: Linux
The Meson build system
Version: 0.52.0
Source dir: /home/cohuck/git/qemu
Build dir: /home/cohuck/git/qemu/build
Build type: native build

meson.build:438:22: ERROR: Key must be a string.
  config_target_h += {target: configure_file(output: target + '-config-target.h',
                      ^
(Fedora 31, version from your github branch)

Is there anything special I need to install beyond meson?

> - static builds
> - Docker and VM builds
> 
> Things I have checked:
> - x86 builds
> - modules
> - "make install"
> - internal slirp/dtc/capstone.
> 
> It should be more or less bisectable.  I have not tried building
> _all_ steps, but I have tried both before and after each major one.
> 
> Build system rebuild rules seem to work reliably.
> 
> After a week or quite intense rebasing, my impression is more or less
> the same as last December: Meson looks more daunting, but it is actually
> much nicer to work with.
> 
> The diffstat so far is not very favorable, but remember that:
> 
> 1) the series leaves quite a few nearly-obsolete bits in configure,
> Makefile and rules.mak (over 200 lines only in the makefiles).
> 
> 2) configure test conversion will be where meson really shines.  I
> included a couple examples just to show
> 
>     meson: convert VNC and dependent libraries to meson
>        4 files changed, 44 insertions(+), 134 deletions(-)
> 
>     meson: move SDL and SDL-image detection to meson
>        5 files changed, 30 insertions(+), 144 deletions(-)
> 
>     meson: replace create-config with meson configure_file
>        6 files changed, 80 insertions(+), 168 deletions(-)
> 
> 3) the idea behind using Makefile generators is to have stable
> code written in a high-level language instead of Makefile magic
> that tends to grow by accretion.  So even though ninjatool is
> large at 1000 lines of Python, it can already be considered mature
> or even "done".  It had only ~15 lines changed since the last post,
> and whenever debugging meson.build issues looking at build.ninja has
> always (literally!) been enough.
> 
> Available on git://github.com/bonzini/qemu branch meson-poc-next.


