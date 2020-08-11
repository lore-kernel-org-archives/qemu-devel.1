Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56C2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A754A20756
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWZYTGHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A754A20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Qnk-0005Fn-Uz
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 05:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k5Qn3-0004dk-5Y
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 05:41:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58104
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k5Qn1-00028v-9C
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 05:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597138910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TaKQxY8TQqbT5SVWnDDejuMC0cUCrIZGLbPG5AfUGgY=;
 b=fWZYTGHgetCl0iGDgM7zJgplCNHVysP57FUmoanRvd+fe+ydwXz6fJBVCn1Tua4ItiLUjj
 CVbMvnj/NEg1miZEg9y+8t5pLZzH7E+z8TiXudqTbXG8RUYS6ZWLR+WfQn0udK0w9jIMa5
 AxD1hRUOseRkHREuql9pmyXLcdUUbeM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-6qc68VRwMs-voRxcJwgq6w-1; Tue, 11 Aug 2020 05:41:48 -0400
X-MC-Unique: 6qc68VRwMs-voRxcJwgq6w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1355C101C8A6;
 Tue, 11 Aug 2020 09:41:47 +0000 (UTC)
Received: from gondolin (ovpn-113-33.ams2.redhat.com [10.36.113.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0E375D9FC;
 Tue, 11 Aug 2020 09:41:41 +0000 (UTC)
Date: Tue, 11 Aug 2020 11:41:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 000/147] Meson integration for 5.2
Message-ID: <20200811114139.336ac1f8.cohuck@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 04:41:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, berrange@redhat.com,
 alex.bennee@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, alxndr@bu.edu, stefanha@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Aug 2020 19:06:38 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> This version is substantially less "draft-like", and the diffstat
> is actually quite large with Thursday's draft.
>=20
> The changes are as follows:
> - updated oss-fuzz build script
> - various cases fixed that broke depending on present/absent dependencies
> - all build scripts handle --python correctly
> - git submodules properly updated before running meson
> - no warnings from Meson master (will be 0.56.0), one from upcoming 0.55.=
1
> - installation matches current build system
> - fixes for virtio-vga broken merge
> - includes updated s390-ccw patch from Thomas
> - less noisy "make check"
> - tested with GitLab CI, BSD VM builds and various Docker builds
> - input-keymap files properly regenerated
>=20
> Of our supported build platforms, only Mac OS and non-x86 hosts are
> still untested.  But I guess this might finally count as a v1.
>=20
> This is available from https://gitlab.com/bonzini/qemu.git branch
> meson-poc-next.

Trying this branch, configure is already unhappy on Fedora 31:

funcs: do_compiler do_cc compile_object main
lines: 92 124 2341 0
cc -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -=
Wstrict-prototypes -Wredundant-decls -Wundef -Wwrite-strings -Wmissing-prot=
otypes -fno-strict-aliasing -fno-common -fwrapv -Wold-style-declaration -Wo=
ld-style-definition -Wtype-limits -Wformat-security -Wformat-y2k -Winit-sel=
f -Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels -Wexpan=
sion-to-defined -Wno-missing-include-dirs -Wno-shift-negative-value -Wno-ps=
abi -Wno-missing-braces -c -o config-temp/qemu-conf.o config-temp/qemu-conf=
.c
cc1: warning: =E2=80=98-Wformat-y2k=E2=80=99 ignored without =E2=80=98-Wfor=
mat=E2=80=99 [-Wformat-y2k]
cc1: warning: =E2=80=98-Wformat-security=E2=80=99 ignored without =E2=80=98=
-Wformat=E2=80=99 [-Wformat-security]
cc -Werror -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_=
SOURCE -Wstrict-prototypes -Wredundant-decls -Wundef -Wwrite-strings -Wmiss=
ing-prototypes -fno-strict-aliasing -fno-common -fwrapv -Wold-style-declara=
tion -Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2k -W=
init-self -Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels=
 -Wexpansion-to-defined -Wno-missing-include-dirs -Wno-shift-negative-value=
 -Wno-psabi -Wno-missing-braces -c -o config-temp/qemu-conf.o config-temp/q=
emu-conf.c
cc1: error: =E2=80=98-Wformat-y2k=E2=80=99 ignored without =E2=80=98-Wforma=
t=E2=80=99 [-Werror=3Dformat-y2k]
cc1: error: =E2=80=98-Wformat-security=E2=80=99 ignored without =E2=80=98-W=
format=E2=80=99 [-Werror=3Dformat-security]
cc1: all warnings being treated as errors

gcc --version says
gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2)

If I disable -Werror, the build succeeds.


