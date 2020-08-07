Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9BDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:31:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C97BF221E2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODzX4i5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97BF221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k43PH-0003dt-TO
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 10:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k43Nj-0002f6-8A
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 10:30:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44850
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k43Nf-0005Li-1J
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 10:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596810597;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=nkW96s1s4k4p2cckjuK2qbJto9rFazm+LYKzYWtwHzk=;
 b=ODzX4i5BQJ1aGK4g7CHFSFSSXrBWkoi8R6xdjfA59QcodVy3G62xx5/FXDZwuPanYk+tYR
 lbz6fMguIY3kklubQhkRF4PkBSicTm/tHOUrroJ1VeohHooS1LUcb6UPCPpzAiiXVlddmI
 pVA/y8Rsk6OXzDhzP5cV9raffr/N0hI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-9Ll0HyxvOkScbnJpgLa2pA-1; Fri, 07 Aug 2020 10:29:48 -0400
X-MC-Unique: 9Ll0HyxvOkScbnJpgLa2pA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9F46100A614;
 Fri,  7 Aug 2020 14:29:47 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27567100238C;
 Fri,  7 Aug 2020 14:29:41 +0000 (UTC)
Date: Fri, 7 Aug 2020 15:29:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
Message-ID: <20200807142939.GK120942@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:11:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, jsnow@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 06, 2020 at 09:13:56PM +0200, Paolo Bonzini wrote:
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


> Available on git://github.com/bonzini/qemu branch meson-poc-next.

I built with ../configure --target-list=x86_64-softmmu on current
git master (e1d322c40524d2c544d1fcd37b267d106d16d328) and on
meson-poc-next (4877fbc31ecc2dd9705036628b0e53b1b2414045) and compared
the binaries.

I'm using Fedora 31 with Meson 0.55.0


-help output has changed in the version string

< QEMU emulator version 5.0.93 (v5.1.0-rc3)
---
> QEMU emulator version 5.0.93


New binaries have lost a bunch of libraries they previously linked
to. This isn't neccessarily a bug, if the old make code was incorrectly
adding too many libraries.

>>>>qemu-system-x86_64<<<<
< libibumad.so.3
< libxenguest.so.4.12
< libxml2.so.2

>>>>qemu-bridge-helper<<<<
< libdl.so.2
< libffi.so.6
< libgcc_s.so.1
< libgmp.so.10
< libgnutls.so.30
< libgthread-2.0.so.0
< libhogweed.so.5
< libidn2.so.0
< libm.so.6
< libnettle.so.7
< libp11-kit.so.0
< librt.so.1
< libstdc++.so.6
< libtasn1.so.6
< libunistring.so.2
< libutil.so.1
< libz.so.1

>>>>qemu-edid<<<<
< libcap-ng.so.0
< libdl.so.2
< libffi.so.6
< libgcc_s.so.1
< libgmp.so.10
< libgnutls.so.30
< libgthread-2.0.so.0
< libhogweed.so.5
< libidn2.so.0
< libnettle.so.7
< libp11-kit.so.0
< librt.so.1
< libstdc++.so.6
< libtasn1.so.6
< libunistring.so.2
< libutil.so.1
< libz.so.1

>>>>qemu-io<<<<
< libgthread-2.0.so.0
< liblzma.so.5
< libutil.so.1
< libxml2.so.2

>>>>qemu-nbd<<<<
< libgthread-2.0.so.0
< liblzma.so.5
< libutil.so.1
< libxml2.so.2

>>>>qemu-pr-helper<<<<
< libgthread-2.0.so.0
< libstdc++.so.6
< libutil.so.1
< libz.so.1


Comparing 'make install', I see some differences:

< /vroot/usr/local/bin/elf2dmp
< /vroot/usr/local/bin/qemu-edid
< /vroot/usr/local/bin/qemu-ga
< /vroot/usr/local/bin/qemu-storage-daemon

> /vroot/usr/local/bin/qemu-pr-helper

< /vroot/usr/local/libexec/qemu-pr-helper
< /vroot/usr/local/libexec/vhost-user-gpu
< /vroot/usr/local/libexec/virtfs-proxy-helper
< /vroot/usr/local/libexec/virtiofsd

< /vroot/usr/local/share/locale/sv/LC_MESSAGES/qemu.mo


Some documentation files have moved - gaining a bogus extra directory
component, and others are missing...


> /vroot/usr/local/share/doc/qemu/devel/devel/atomics.html
> /vroot/usr/local/share/doc/qemu/devel/devel/bitops.html
> /vroot/usr/local/share/doc/qemu/devel/devel/.buildinfo
> /vroot/usr/local/share/doc/qemu/devel/devel/clocks.html
> /vroot/usr/local/share/doc/qemu/devel/devel/decodetree.html
> /vroot/usr/local/share/doc/qemu/devel/devel/genindex.html
> /vroot/usr/local/share/doc/qemu/devel/devel/index.html
> /vroot/usr/local/share/doc/qemu/devel/devel/kconfig.html
> /vroot/usr/local/share/doc/qemu/devel/devel/loads-stores.html
> /vroot/usr/local/share/doc/qemu/devel/devel/memory.html
> /vroot/usr/local/share/doc/qemu/devel/devel/migration.html
> /vroot/usr/local/share/doc/qemu/devel/devel/multi-thread-tcg.html
> /vroot/usr/local/share/doc/qemu/devel/devel/objects.inv
> /vroot/usr/local/share/doc/qemu/devel/devel/reset.html
> /vroot/usr/local/share/doc/qemu/devel/devel/s390-dasd-ipl.html
> /vroot/usr/local/share/doc/qemu/devel/devel/search.html
> /vroot/usr/local/share/doc/qemu/devel/devel/searchindex.js
> /vroot/usr/local/share/doc/qemu/devel/devel/secure-coding-practices.html
> /vroot/usr/local/share/doc/qemu/devel/devel/stable-process.html
> /vroot/usr/local/share/doc/qemu/devel/devel/_static/alabaster.css
> /vroot/usr/local/share/doc/qemu/devel/devel/_static/basic.css
> /vroot/usr/local/share/doc/qemu/devel/devel/_static/custom.css
> /vroot/usr/local/share/doc/qemu/devel/devel/_static/doctools.js
> /vroot/usr/local/share/doc/qemu/devel/devel/_static/documentation_options.js
> /vroot/usr/local/share/doc/qemu/devel/devel/_static/file.png
> /vroot/usr/local/share/doc/qemu/devel/devel/_static/jquery-3.2.1.js
> /vroot/usr/local/share/doc/qemu/devel/devel/_static/jquery.js
> /vroot/usr/local/share/doc/qemu/devel/devel/_static/language_data.js
> /vroot/usr/local/share/doc/qemu/devel/devel/_static/minus.png
> /vroot/usr/local/share/doc/qemu/devel/devel/_static/plus.png
> /vroot/usr/local/share/doc/qemu/devel/devel/_static/pygments.css
> /vroot/usr/local/share/doc/qemu/devel/devel/_static/searchtools.js
> /vroot/usr/local/share/doc/qemu/devel/devel/_static/underscore-1.3.1.js
> /vroot/usr/local/share/doc/qemu/devel/devel/_static/underscore.js
> /vroot/usr/local/share/doc/qemu/devel/devel/tcg.html
> /vroot/usr/local/share/doc/qemu/devel/devel/tcg-icount.html
> /vroot/usr/local/share/doc/qemu/devel/devel/tcg-plugins.html
> /vroot/usr/local/share/doc/qemu/devel/devel/testing.html
< /vroot/usr/local/share/doc/qemu/interop/bitmaps.html
< /vroot/usr/local/share/doc/qemu/interop/.buildinfo
< /vroot/usr/local/share/doc/qemu/interop/dbus.html
< /vroot/usr/local/share/doc/qemu/interop/dbus-vmstate.html
< /vroot/usr/local/share/doc/qemu/interop/genindex.html
< /vroot/usr/local/share/doc/qemu/interop/index.html
< /vroot/usr/local/share/doc/qemu/interop/live-block-operations.html
< /vroot/usr/local/share/doc/qemu/interop/objects.inv
< /vroot/usr/local/share/doc/qemu/interop/pr-helper.html
< /vroot/usr/local/share/doc/qemu/interop/qemu-ga.html
> /vroot/usr/local/share/doc/qemu/interop/interop/bitmaps.html
> /vroot/usr/local/share/doc/qemu/interop/interop/.buildinfo
> /vroot/usr/local/share/doc/qemu/interop/interop/dbus.html
> /vroot/usr/local/share/doc/qemu/interop/interop/dbus-vmstate.html
> /vroot/usr/local/share/doc/qemu/interop/interop/genindex.html
> /vroot/usr/local/share/doc/qemu/interop/interop/index.html
> /vroot/usr/local/share/doc/qemu/interop/interop/live-block-operations.html
> /vroot/usr/local/share/doc/qemu/interop/interop/objects.inv
> /vroot/usr/local/share/doc/qemu/interop/interop/pr-helper.html
> /vroot/usr/local/share/doc/qemu/interop/interop/qemu-ga.html
> /vroot/usr/local/share/doc/qemu/interop/interop/search.html
> /vroot/usr/local/share/doc/qemu/interop/interop/searchindex.js
> /vroot/usr/local/share/doc/qemu/interop/interop/_static/alabaster.css
> /vroot/usr/local/share/doc/qemu/interop/interop/_static/basic.css
> /vroot/usr/local/share/doc/qemu/interop/interop/_static/custom.css
> /vroot/usr/local/share/doc/qemu/interop/interop/_static/doctools.js
> /vroot/usr/local/share/doc/qemu/interop/interop/_static/documentation_options.js
> /vroot/usr/local/share/doc/qemu/interop/interop/_static/file.png
> /vroot/usr/local/share/doc/qemu/interop/interop/_static/jquery-3.2.1.js
> /vroot/usr/local/share/doc/qemu/interop/interop/_static/jquery.js
> /vroot/usr/local/share/doc/qemu/interop/interop/_static/language_data.js
> /vroot/usr/local/share/doc/qemu/interop/interop/_static/minus.png
> /vroot/usr/local/share/doc/qemu/interop/interop/_static/plus.png
> /vroot/usr/local/share/doc/qemu/interop/interop/_static/pygments.css
> /vroot/usr/local/share/doc/qemu/interop/interop/_static/searchtools.js
> /vroot/usr/local/share/doc/qemu/interop/interop/_static/underscore-1.3.1.js
> /vroot/usr/local/share/doc/qemu/interop/interop/_static/underscore.js
> /vroot/usr/local/share/doc/qemu/interop/interop/vhost-user-gpu.html
> /vroot/usr/local/share/doc/qemu/interop/interop/vhost-user.html
> /vroot/usr/local/share/doc/qemu/interop/interop/vhost-vdpa.html
> /vroot/usr/local/share/doc/qemu/interop/qemu-ga-ref.info
> /vroot/usr/local/share/doc/qemu/interop/qemu-qmp-ref.info
< /vroot/usr/local/share/doc/qemu/interop/search.html
< /vroot/usr/local/share/doc/qemu/interop/searchindex.js
< /vroot/usr/local/share/doc/qemu/interop/_static/alabaster.css
< /vroot/usr/local/share/doc/qemu/interop/_static/basic.css
< /vroot/usr/local/share/doc/qemu/interop/_static/custom.css
< /vroot/usr/local/share/doc/qemu/interop/_static/doctools.js
< /vroot/usr/local/share/doc/qemu/interop/_static/documentation_options.js
< /vroot/usr/local/share/doc/qemu/interop/_static/file.png
< /vroot/usr/local/share/doc/qemu/interop/_static/jquery-3.2.1.js
< /vroot/usr/local/share/doc/qemu/interop/_static/jquery.js
< /vroot/usr/local/share/doc/qemu/interop/_static/language_data.js
< /vroot/usr/local/share/doc/qemu/interop/_static/minus.png
< /vroot/usr/local/share/doc/qemu/interop/_static/plus.png
< /vroot/usr/local/share/doc/qemu/interop/_static/pygments.css
< /vroot/usr/local/share/doc/qemu/interop/_static/searchtools.js
< /vroot/usr/local/share/doc/qemu/interop/_static/underscore-1.3.1.js
< /vroot/usr/local/share/doc/qemu/interop/_static/underscore.js
< /vroot/usr/local/share/doc/qemu/interop/vhost-user-gpu.html
< /vroot/usr/local/share/doc/qemu/interop/vhost-user.html
< /vroot/usr/local/share/doc/qemu/interop/vhost-vdpa.html
< /vroot/usr/local/share/doc/qemu/specs/acpi_hest_ghes.html
< /vroot/usr/local/share/doc/qemu/specs/acpi_hw_reduced_hotplug.html
< /vroot/usr/local/share/doc/qemu/specs/.buildinfo
< /vroot/usr/local/share/doc/qemu/specs/genindex.html
< /vroot/usr/local/share/doc/qemu/specs/index.html
< /vroot/usr/local/share/doc/qemu/specs/objects.inv
< /vroot/usr/local/share/doc/qemu/specs/ppc-spapr-xive.html
< /vroot/usr/local/share/doc/qemu/specs/ppc-xive.html
< /vroot/usr/local/share/doc/qemu/specs/search.html
< /vroot/usr/local/share/doc/qemu/specs/searchindex.js
< /vroot/usr/local/share/doc/qemu/specs/_static/alabaster.css
< /vroot/usr/local/share/doc/qemu/specs/_static/basic.css
< /vroot/usr/local/share/doc/qemu/specs/_static/custom.css
< /vroot/usr/local/share/doc/qemu/specs/_static/doctools.js
< /vroot/usr/local/share/doc/qemu/specs/_static/documentation_options.js
< /vroot/usr/local/share/doc/qemu/specs/_static/file.png
< /vroot/usr/local/share/doc/qemu/specs/_static/jquery-3.2.1.js
< /vroot/usr/local/share/doc/qemu/specs/_static/jquery.js
< /vroot/usr/local/share/doc/qemu/specs/_static/language_data.js
< /vroot/usr/local/share/doc/qemu/specs/_static/minus.png
< /vroot/usr/local/share/doc/qemu/specs/_static/plus.png
< /vroot/usr/local/share/doc/qemu/specs/_static/pygments.css
< /vroot/usr/local/share/doc/qemu/specs/_static/searchtools.js
< /vroot/usr/local/share/doc/qemu/specs/_static/underscore-1.3.1.js
< /vroot/usr/local/share/doc/qemu/specs/_static/underscore.js
< /vroot/usr/local/share/doc/qemu/specs/tpm.html
< /vroot/usr/local/share/doc/qemu/system/arm/aspeed.html
< /vroot/usr/local/share/doc/qemu/system/arm/collie.html
< /vroot/usr/local/share/doc/qemu/system/arm/cpu-features.html
< /vroot/usr/local/share/doc/qemu/system/arm/digic.html
< /vroot/usr/local/share/doc/qemu/system/arm/gumstix.html
< /vroot/usr/local/share/doc/qemu/system/arm/integratorcp.html
< /vroot/usr/local/share/doc/qemu/system/arm/mps2.html
< /vroot/usr/local/share/doc/qemu/system/arm/musca.html
< /vroot/usr/local/share/doc/qemu/system/arm/musicpal.html
< /vroot/usr/local/share/doc/qemu/system/arm/nseries.html
< /vroot/usr/local/share/doc/qemu/system/arm/orangepi.html
< /vroot/usr/local/share/doc/qemu/system/arm/palm.html
< /vroot/usr/local/share/doc/qemu/system/arm/realview.html
< /vroot/usr/local/share/doc/qemu/system/arm/stellaris.html
< /vroot/usr/local/share/doc/qemu/system/arm/sx1.html
< /vroot/usr/local/share/doc/qemu/system/arm/versatile.html
< /vroot/usr/local/share/doc/qemu/system/arm/vexpress.html
< /vroot/usr/local/share/doc/qemu/system/arm/virt.html
< /vroot/usr/local/share/doc/qemu/system/arm/xscale.html
< /vroot/usr/local/share/doc/qemu/system/.buildinfo
< /vroot/usr/local/share/doc/qemu/system/build-platforms.html
< /vroot/usr/local/share/doc/qemu/system/deprecated.html
< /vroot/usr/local/share/doc/qemu/system/gdb.html
< /vroot/usr/local/share/doc/qemu/system/genindex.html
< /vroot/usr/local/share/doc/qemu/system/images.html
< /vroot/usr/local/share/doc/qemu/system/index.html
< /vroot/usr/local/share/doc/qemu/system/invocation.html
< /vroot/usr/local/share/doc/qemu/system/ivshmem.html
< /vroot/usr/local/share/doc/qemu/system/keys.html
< /vroot/usr/local/share/doc/qemu/system/license.html
< /vroot/usr/local/share/doc/qemu/system/linuxboot.html
< /vroot/usr/local/share/doc/qemu/system/managed-startup.html
< /vroot/usr/local/share/doc/qemu/system/monitor.html
< /vroot/usr/local/share/doc/qemu/system/mux-chardev.html
< /vroot/usr/local/share/doc/qemu/system/net.html
< /vroot/usr/local/share/doc/qemu/system/objects.inv
< /vroot/usr/local/share/doc/qemu/system/qemu-block-drivers.html
< /vroot/usr/local/share/doc/qemu/system/qemu-cpu-models.html
< /vroot/usr/local/share/doc/qemu/system/qemu-manpage.html
< /vroot/usr/local/share/doc/qemu/system/quickstart.html
< /vroot/usr/local/share/doc/qemu/system/s390x/3270.html
< /vroot/usr/local/share/doc/qemu/system/s390x/css.html
< /vroot/usr/local/share/doc/qemu/system/s390x/protvirt.html
< /vroot/usr/local/share/doc/qemu/system/s390x/vfio-ap.html
< /vroot/usr/local/share/doc/qemu/system/s390x/vfio-ccw.html
< /vroot/usr/local/share/doc/qemu/system/search.html
< /vroot/usr/local/share/doc/qemu/system/searchindex.js
< /vroot/usr/local/share/doc/qemu/system/security.html
< /vroot/usr/local/share/doc/qemu/system/_static/alabaster.css
< /vroot/usr/local/share/doc/qemu/system/_static/basic.css
< /vroot/usr/local/share/doc/qemu/system/_static/custom.css
< /vroot/usr/local/share/doc/qemu/system/_static/doctools.js
< /vroot/usr/local/share/doc/qemu/system/_static/documentation_options.js
< /vroot/usr/local/share/doc/qemu/system/_static/file.png
< /vroot/usr/local/share/doc/qemu/system/_static/jquery-3.2.1.js
< /vroot/usr/local/share/doc/qemu/system/_static/jquery.js
< /vroot/usr/local/share/doc/qemu/system/_static/language_data.js
< /vroot/usr/local/share/doc/qemu/system/_static/minus.png
< /vroot/usr/local/share/doc/qemu/system/_static/plus.png
< /vroot/usr/local/share/doc/qemu/system/_static/pygments.css
< /vroot/usr/local/share/doc/qemu/system/_static/searchtools.js
< /vroot/usr/local/share/doc/qemu/system/_static/underscore-1.3.1.js
< /vroot/usr/local/share/doc/qemu/system/_static/underscore.js
< /vroot/usr/local/share/doc/qemu/system/target-arm.html
< /vroot/usr/local/share/doc/qemu/system/target-avr.html
< /vroot/usr/local/share/doc/qemu/system/target-i386.html
< /vroot/usr/local/share/doc/qemu/system/target-m68k.html
< /vroot/usr/local/share/doc/qemu/system/target-mips.html
< /vroot/usr/local/share/doc/qemu/system/target-ppc.html
< /vroot/usr/local/share/doc/qemu/system/target-rx.html
< /vroot/usr/local/share/doc/qemu/system/target-s390x.html
< /vroot/usr/local/share/doc/qemu/system/targets.html
< /vroot/usr/local/share/doc/qemu/system/target-sparc64.html
< /vroot/usr/local/share/doc/qemu/system/target-sparc.html
< /vroot/usr/local/share/doc/qemu/system/target-xtensa.html
< /vroot/usr/local/share/doc/qemu/system/tls.html
< /vroot/usr/local/share/doc/qemu/system/usb.html
< /vroot/usr/local/share/doc/qemu/system/vnc-security.html
< /vroot/usr/local/share/doc/qemu/tools/.buildinfo
< /vroot/usr/local/share/doc/qemu/tools/genindex.html
< /vroot/usr/local/share/doc/qemu/tools/index.html
< /vroot/usr/local/share/doc/qemu/tools/objects.inv
< /vroot/usr/local/share/doc/qemu/tools/qemu-img.html
< /vroot/usr/local/share/doc/qemu/tools/qemu-nbd.html
< /vroot/usr/local/share/doc/qemu/tools/qemu-trace-stap.html
< /vroot/usr/local/share/doc/qemu/tools/search.html
< /vroot/usr/local/share/doc/qemu/tools/searchindex.js
< /vroot/usr/local/share/doc/qemu/tools/_static/alabaster.css
< /vroot/usr/local/share/doc/qemu/tools/_static/basic.css
< /vroot/usr/local/share/doc/qemu/tools/_static/custom.css
< /vroot/usr/local/share/doc/qemu/tools/_static/doctools.js
< /vroot/usr/local/share/doc/qemu/tools/_static/documentation_options.js
< /vroot/usr/local/share/doc/qemu/tools/_static/file.png
< /vroot/usr/local/share/doc/qemu/tools/_static/jquery-3.2.1.js
< /vroot/usr/local/share/doc/qemu/tools/_static/jquery.js
< /vroot/usr/local/share/doc/qemu/tools/_static/language_data.js
< /vroot/usr/local/share/doc/qemu/tools/_static/minus.png
< /vroot/usr/local/share/doc/qemu/tools/_static/plus.png
< /vroot/usr/local/share/doc/qemu/tools/_static/pygments.css
< /vroot/usr/local/share/doc/qemu/tools/_static/searchtools.js
< /vroot/usr/local/share/doc/qemu/tools/_static/underscore-1.3.1.js
< /vroot/usr/local/share/doc/qemu/tools/_static/underscore.js
< /vroot/usr/local/share/doc/qemu/tools/virtfs-proxy-helper.html
< /vroot/usr/local/share/doc/qemu/tools/virtiofsd.html
< /vroot/usr/local/share/doc/qemu/user/.buildinfo
< /vroot/usr/local/share/doc/qemu/user/genindex.html
< /vroot/usr/local/share/doc/qemu/user/index.html
< /vroot/usr/local/share/doc/qemu/user/main.html
< /vroot/usr/local/share/doc/qemu/user/objects.inv
< /vroot/usr/local/share/doc/qemu/user/search.html
< /vroot/usr/local/share/doc/qemu/user/searchindex.js
< /vroot/usr/local/share/doc/qemu/user/_static/alabaster.css
< /vroot/usr/local/share/doc/qemu/user/_static/basic.css
< /vroot/usr/local/share/doc/qemu/user/_static/custom.css
< /vroot/usr/local/share/doc/qemu/user/_static/doctools.js
< /vroot/usr/local/share/doc/qemu/user/_static/documentation_options.js
< /vroot/usr/local/share/doc/qemu/user/_static/file.png
< /vroot/usr/local/share/doc/qemu/user/_static/jquery-3.2.1.js
< /vroot/usr/local/share/doc/qemu/user/_static/jquery.js
< /vroot/usr/local/share/doc/qemu/user/_static/language_data.js
< /vroot/usr/local/share/doc/qemu/user/_static/minus.png
< /vroot/usr/local/share/doc/qemu/user/_static/plus.png
< /vroot/usr/local/share/doc/qemu/user/_static/pygments.css
< /vroot/usr/local/share/doc/qemu/user/_static/searchtools.js
< /vroot/usr/local/share/doc/qemu/user/_static/underscore-1.3.1.js
< /vroot/usr/local/share/doc/qemu/user/_static/underscore.js
> /vroot/usr/local/share/doc/qemu/specs/specs/acpi_hest_ghes.html
> /vroot/usr/local/share/doc/qemu/specs/specs/acpi_hw_reduced_hotplug.html
> /vroot/usr/local/share/doc/qemu/specs/specs/.buildinfo
> /vroot/usr/local/share/doc/qemu/specs/specs/genindex.html
> /vroot/usr/local/share/doc/qemu/specs/specs/index.html
> /vroot/usr/local/share/doc/qemu/specs/specs/objects.inv
> /vroot/usr/local/share/doc/qemu/specs/specs/ppc-spapr-xive.html
> /vroot/usr/local/share/doc/qemu/specs/specs/ppc-xive.html
> /vroot/usr/local/share/doc/qemu/specs/specs/search.html
> /vroot/usr/local/share/doc/qemu/specs/specs/searchindex.js
> /vroot/usr/local/share/doc/qemu/specs/specs/_static/alabaster.css
> /vroot/usr/local/share/doc/qemu/specs/specs/_static/basic.css
> /vroot/usr/local/share/doc/qemu/specs/specs/_static/custom.css
> /vroot/usr/local/share/doc/qemu/specs/specs/_static/doctools.js
> /vroot/usr/local/share/doc/qemu/specs/specs/_static/documentation_options.js
> /vroot/usr/local/share/doc/qemu/specs/specs/_static/file.png
> /vroot/usr/local/share/doc/qemu/specs/specs/_static/jquery-3.2.1.js
> /vroot/usr/local/share/doc/qemu/specs/specs/_static/jquery.js
> /vroot/usr/local/share/doc/qemu/specs/specs/_static/language_data.js
> /vroot/usr/local/share/doc/qemu/specs/specs/_static/minus.png
> /vroot/usr/local/share/doc/qemu/specs/specs/_static/plus.png
> /vroot/usr/local/share/doc/qemu/specs/specs/_static/pygments.css
> /vroot/usr/local/share/doc/qemu/specs/specs/_static/searchtools.js
> /vroot/usr/local/share/doc/qemu/specs/specs/_static/underscore-1.3.1.js
> /vroot/usr/local/share/doc/qemu/specs/specs/_static/underscore.js
> /vroot/usr/local/share/doc/qemu/specs/specs/tpm.html
> /vroot/usr/local/share/doc/qemu/system/system/arm/aspeed.html
> /vroot/usr/local/share/doc/qemu/system/system/arm/collie.html
> /vroot/usr/local/share/doc/qemu/system/system/arm/cpu-features.html
> /vroot/usr/local/share/doc/qemu/system/system/arm/digic.html
> /vroot/usr/local/share/doc/qemu/system/system/arm/gumstix.html
> /vroot/usr/local/share/doc/qemu/system/system/arm/integratorcp.html
> /vroot/usr/local/share/doc/qemu/system/system/arm/mps2.html
> /vroot/usr/local/share/doc/qemu/system/system/arm/musca.html
> /vroot/usr/local/share/doc/qemu/system/system/arm/musicpal.html
> /vroot/usr/local/share/doc/qemu/system/system/arm/nseries.html
> /vroot/usr/local/share/doc/qemu/system/system/arm/orangepi.html
> /vroot/usr/local/share/doc/qemu/system/system/arm/palm.html
> /vroot/usr/local/share/doc/qemu/system/system/arm/realview.html
> /vroot/usr/local/share/doc/qemu/system/system/arm/stellaris.html
> /vroot/usr/local/share/doc/qemu/system/system/arm/sx1.html
> /vroot/usr/local/share/doc/qemu/system/system/arm/versatile.html
> /vroot/usr/local/share/doc/qemu/system/system/arm/vexpress.html
> /vroot/usr/local/share/doc/qemu/system/system/arm/virt.html
> /vroot/usr/local/share/doc/qemu/system/system/arm/xscale.html
> /vroot/usr/local/share/doc/qemu/system/system/.buildinfo
> /vroot/usr/local/share/doc/qemu/system/system/build-platforms.html
> /vroot/usr/local/share/doc/qemu/system/system/deprecated.html
> /vroot/usr/local/share/doc/qemu/system/system/gdb.html
> /vroot/usr/local/share/doc/qemu/system/system/genindex.html
> /vroot/usr/local/share/doc/qemu/system/system/images.html
> /vroot/usr/local/share/doc/qemu/system/system/index.html
> /vroot/usr/local/share/doc/qemu/system/system/invocation.html
> /vroot/usr/local/share/doc/qemu/system/system/ivshmem.html
> /vroot/usr/local/share/doc/qemu/system/system/keys.html
> /vroot/usr/local/share/doc/qemu/system/system/license.html
> /vroot/usr/local/share/doc/qemu/system/system/linuxboot.html
> /vroot/usr/local/share/doc/qemu/system/system/managed-startup.html
> /vroot/usr/local/share/doc/qemu/system/system/monitor.html
> /vroot/usr/local/share/doc/qemu/system/system/mux-chardev.html
> /vroot/usr/local/share/doc/qemu/system/system/net.html
> /vroot/usr/local/share/doc/qemu/system/system/objects.inv
> /vroot/usr/local/share/doc/qemu/system/system/qemu-block-drivers.html
> /vroot/usr/local/share/doc/qemu/system/system/qemu-cpu-models.html
> /vroot/usr/local/share/doc/qemu/system/system/qemu-manpage.html
> /vroot/usr/local/share/doc/qemu/system/system/quickstart.html
> /vroot/usr/local/share/doc/qemu/system/system/s390x/3270.html
> /vroot/usr/local/share/doc/qemu/system/system/s390x/css.html
> /vroot/usr/local/share/doc/qemu/system/system/s390x/protvirt.html
> /vroot/usr/local/share/doc/qemu/system/system/s390x/vfio-ap.html
> /vroot/usr/local/share/doc/qemu/system/system/s390x/vfio-ccw.html
> /vroot/usr/local/share/doc/qemu/system/system/search.html
> /vroot/usr/local/share/doc/qemu/system/system/searchindex.js
> /vroot/usr/local/share/doc/qemu/system/system/security.html
> /vroot/usr/local/share/doc/qemu/system/system/_static/alabaster.css
> /vroot/usr/local/share/doc/qemu/system/system/_static/basic.css
> /vroot/usr/local/share/doc/qemu/system/system/_static/custom.css
> /vroot/usr/local/share/doc/qemu/system/system/_static/doctools.js
> /vroot/usr/local/share/doc/qemu/system/system/_static/documentation_options.js
> /vroot/usr/local/share/doc/qemu/system/system/_static/file.png
> /vroot/usr/local/share/doc/qemu/system/system/_static/jquery-3.2.1.js
> /vroot/usr/local/share/doc/qemu/system/system/_static/jquery.js
> /vroot/usr/local/share/doc/qemu/system/system/_static/language_data.js
> /vroot/usr/local/share/doc/qemu/system/system/_static/minus.png
> /vroot/usr/local/share/doc/qemu/system/system/_static/plus.png
> /vroot/usr/local/share/doc/qemu/system/system/_static/pygments.css
> /vroot/usr/local/share/doc/qemu/system/system/_static/searchtools.js
> /vroot/usr/local/share/doc/qemu/system/system/_static/underscore-1.3.1.js
> /vroot/usr/local/share/doc/qemu/system/system/_static/underscore.js
> /vroot/usr/local/share/doc/qemu/system/system/target-arm.html
> /vroot/usr/local/share/doc/qemu/system/system/target-avr.html
> /vroot/usr/local/share/doc/qemu/system/system/target-i386.html
> /vroot/usr/local/share/doc/qemu/system/system/target-m68k.html
> /vroot/usr/local/share/doc/qemu/system/system/target-mips.html
> /vroot/usr/local/share/doc/qemu/system/system/target-ppc.html
> /vroot/usr/local/share/doc/qemu/system/system/target-rx.html
> /vroot/usr/local/share/doc/qemu/system/system/target-s390x.html
> /vroot/usr/local/share/doc/qemu/system/system/targets.html
> /vroot/usr/local/share/doc/qemu/system/system/target-sparc64.html
> /vroot/usr/local/share/doc/qemu/system/system/target-sparc.html
> /vroot/usr/local/share/doc/qemu/system/system/target-xtensa.html
> /vroot/usr/local/share/doc/qemu/system/system/tls.html
> /vroot/usr/local/share/doc/qemu/system/system/usb.html
> /vroot/usr/local/share/doc/qemu/system/system/vnc-security.html
> /vroot/usr/local/share/doc/qemu/tools/tools/.buildinfo
> /vroot/usr/local/share/doc/qemu/tools/tools/genindex.html
> /vroot/usr/local/share/doc/qemu/tools/tools/index.html
> /vroot/usr/local/share/doc/qemu/tools/tools/objects.inv
> /vroot/usr/local/share/doc/qemu/tools/tools/qemu-img.html
> /vroot/usr/local/share/doc/qemu/tools/tools/qemu-nbd.html
> /vroot/usr/local/share/doc/qemu/tools/tools/qemu-trace-stap.html
> /vroot/usr/local/share/doc/qemu/tools/tools/search.html
> /vroot/usr/local/share/doc/qemu/tools/tools/searchindex.js
> /vroot/usr/local/share/doc/qemu/tools/tools/_static/alabaster.css
> /vroot/usr/local/share/doc/qemu/tools/tools/_static/basic.css
> /vroot/usr/local/share/doc/qemu/tools/tools/_static/custom.css
> /vroot/usr/local/share/doc/qemu/tools/tools/_static/doctools.js
> /vroot/usr/local/share/doc/qemu/tools/tools/_static/documentation_options.js
> /vroot/usr/local/share/doc/qemu/tools/tools/_static/file.png
> /vroot/usr/local/share/doc/qemu/tools/tools/_static/jquery-3.2.1.js
> /vroot/usr/local/share/doc/qemu/tools/tools/_static/jquery.js
> /vroot/usr/local/share/doc/qemu/tools/tools/_static/language_data.js
> /vroot/usr/local/share/doc/qemu/tools/tools/_static/minus.png
> /vroot/usr/local/share/doc/qemu/tools/tools/_static/plus.png
> /vroot/usr/local/share/doc/qemu/tools/tools/_static/pygments.css
> /vroot/usr/local/share/doc/qemu/tools/tools/_static/searchtools.js
> /vroot/usr/local/share/doc/qemu/tools/tools/_static/underscore-1.3.1.js
> /vroot/usr/local/share/doc/qemu/tools/tools/_static/underscore.js
> /vroot/usr/local/share/doc/qemu/tools/tools/virtfs-proxy-helper.html
> /vroot/usr/local/share/doc/qemu/tools/tools/virtiofsd.html
> /vroot/usr/local/share/doc/qemu/user/user/.buildinfo
> /vroot/usr/local/share/doc/qemu/user/user/genindex.html
> /vroot/usr/local/share/doc/qemu/user/user/index.html
> /vroot/usr/local/share/doc/qemu/user/user/main.html
> /vroot/usr/local/share/doc/qemu/user/user/objects.inv
> /vroot/usr/local/share/doc/qemu/user/user/search.html
> /vroot/usr/local/share/doc/qemu/user/user/searchindex.js
> /vroot/usr/local/share/doc/qemu/user/user/_static/alabaster.css
> /vroot/usr/local/share/doc/qemu/user/user/_static/basic.css
> /vroot/usr/local/share/doc/qemu/user/user/_static/custom.css
> /vroot/usr/local/share/doc/qemu/user/user/_static/doctools.js
> /vroot/usr/local/share/doc/qemu/user/user/_static/documentation_options.js
> /vroot/usr/local/share/doc/qemu/user/user/_static/file.png
> /vroot/usr/local/share/doc/qemu/user/user/_static/jquery-3.2.1.js
> /vroot/usr/local/share/doc/qemu/user/user/_static/jquery.js
> /vroot/usr/local/share/doc/qemu/user/user/_static/language_data.js
> /vroot/usr/local/share/doc/qemu/user/user/_static/minus.png
> /vroot/usr/local/share/doc/qemu/user/user/_static/plus.png
> /vroot/usr/local/share/doc/qemu/user/user/_static/pygments.css
> /vroot/usr/local/share/doc/qemu/user/user/_static/searchtools.js
> /vroot/usr/local/share/doc/qemu/user/user/_static/underscore-1.3.1.js
> /vroot/usr/local/share/doc/qemu/user/user/_static/underscore.js





Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


