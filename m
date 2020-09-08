Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2770C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 21:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623332080C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 21:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpuZ8Loe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623332080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFlBV-0003bo-ET
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 17:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kFlAq-0003C9-Mj
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 17:29:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46562
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kFlAo-0006Tq-Pg
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 17:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599600545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=995nN+g6V3Ch+mLCSwVMQ9iIBGx471RLOLUwsVqA+RI=;
 b=SpuZ8LoeY9Wwet3cqWVkHwPIiyOFN3T97vho0CcgoQ9r+IvllQvwr9gYNUzCFzzx4tpFxS
 qKlY04D14PiO/qZ+DT1ueCZmHqVo8WDJaEOHq/leB0nC9Ea3w7OiuwaOr7n5ZziAuiHU1u
 06A9PTjO3DfT02bnPYHblGYcOAX6ZKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-D4JQXT2cOSOIE_NJuOBoHA-1; Tue, 08 Sep 2020 17:29:04 -0400
X-MC-Unique: D4JQXT2cOSOIE_NJuOBoHA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66AB0802B7E;
 Tue,  8 Sep 2020 21:29:03 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 020CE1002D59;
 Tue,  8 Sep 2020 21:29:02 +0000 (UTC)
Date: Tue, 8 Sep 2020 17:29:02 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/34] QOM boilerplate cleanup (v2)
Message-ID: <20200908212902.GH1618070@habkost.net>
References: <20200908200123.3402311-1-ehabkost@redhat.com>
 <CAFEAcA9WEjne5TfwggVWPuBprkRs-a2-iNc43Xa_jBamaf9t8A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9WEjne5TfwggVWPuBprkRs-a2-iNc43Xa_jBamaf9t8A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 08, 2020 at 09:20:43PM +0100, Peter Maydell wrote:
> On Tue, 8 Sep 2020 at 21:01, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >
> > The following changes since commit b95ba83fc56ebfc4b6869f21db0c757c0c191104:
> >
> >   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.2-20200908' in=
> > to staging (2020-09-08 16:18:48 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
> >
> > for you to fetch changes up to 86f08d9faa5c05bff56c84ead337063e50e7eb4d:
> >
> >   virtio-vga: Use typedef name for instance_size (2020-09-08 15:32:38 -0400)
> >
> > Changes included in v2:
> > * memory: Remove kernel-doc comment marker (Eduardo Habkost)
> >
> > ----------------------------------------------------------------
> > QOM boilerplate cleanup
> >
> > Documentation build fix:
> > * memory: Remove kernel-doc comment marker (Eduardo Habkost)
> >
> > QOM cleanups:
> > * Rename QOM macros for consistency between
> >   TYPE_* and type checking constants (Eduardo Habkost)
> >
> > QOM new macros:
> > * OBJECT_DECLARE_* and OBJECT_DEFINE_* macros (Daniel P. Berrang=C3=A9)
> > * DECLARE_*_CHECKER macros (Eduardo Habkost)
> >
> > Automated QOM boilerplate changes:
> > * Automated changes to use DECLARE_*_CHECKER (Eduardo Habkost
> > * Automated changes to use OBJECT_DECLARE* (Eduardo Habkost)
> 
> Compile failure, Windows:
> 
> In file included from /home/petmay01/qemu-for-merges/include/exec/memory.h:28:0,
>                  from /home/petmay01/qemu-for-merges/include/sysemu/dma.h:13,
>                  from ../../hw/nvram/fw_cfg.c:28:
> /home/petmay01/qemu-for-merges/include/sysemu/accel.h:65:22: error:
> 'ACCEL' redeclared as different kind of symbol
>                       ACCEL, TYPE_ACCEL)
>                       ^
> /home/petmay01/qemu-for-merges/include/qom/object.h:571:5: note: in
> definition of macro 'DECLARE_INSTANCE_CHECKER'
>      OBJ_NAME(const void *obj) \
>      ^
> /home/petmay01/qemu-for-merges/include/sysemu/accel.h:64:1: note: in
> expansion of macro 'DECLARE_OBJ_CHECKERS'
>  DECLARE_OBJ_CHECKERS(AccelState, AccelClass,
>  ^
> In file included from
> /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/windows.h:72:0,
>                  from
> /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/winsock2.h:23,
>                  from
> /home/petmay01/qemu-for-merges/include/sysemu/os-win32.h:29,
>                  from /home/petmay01/qemu-for-merges/include/qemu/osdep.h:119,
>                  from ../../hw/nvram/fw_cfg.c:25:
> /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/winuser.h:1757:5:
> note: previous declaration of 'ACCEL' was here
>    } ACCEL,*LPACCEL;
>      ^
> Compiling C object libcommon.fa.p/hw_misc_aspeed_scu.c.obj

Ouch.  This one will be tricky to fix.  I guess we'll need to
rename the ACCEL QOM type to something ACCEL_OBJECT to avoid
conflicting with the winuser.h symbol.

> 
> 
> Compile failure, Linux, NetBSD, FReeBSD:
> 
> In file included from ../../hw/riscv/sifive_u.c:51:0:
> /home/petmay01/linaro/qemu-for-merges/include/hw/riscv/sifive_u.h:80:5:
> error: ‘SIFIVE_U_PRCI’ redeclared as different kind of symbol
>      SIFIVE_U_PRCI,
>      ^~~~~~~~~~~~~
[...]
> and the similar
> 
> Compiling C object libqemu-riscv32-softmmu.fa.p/hw_riscv_sifive_e.c.o
> In file included from
> /home/petmay01/linaro/qemu-for-merges/include/exec/memory.h:28:0,
>                  from
> /home/petmay01/linaro/qemu-for-merges/include/hw/boards.h:6,
>                  from ../../hw/riscv/sifive_e.c:35:
> /home/petmay01/linaro/qemu-for-merges/include/hw/riscv/sifive_e_prci.h:56:44:
> error: ‘SIFIVE_E_PRCI’ redeclared as different kind of symbol
>  DECLARE_INSTANCE_CHECKER(SiFiveEPRCIState, SIFIVE_E_PRCI,
>                                             ^

I thought I had removed the sifive_* sections from the latest
version of the series (because other sifive_* cleanup patches are
pending), sorry.

I will remove the sifive_* and accel.h hunks from the pull
request.

-- 
Eduardo


