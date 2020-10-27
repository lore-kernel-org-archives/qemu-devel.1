Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E342C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:30:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D0722202
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONnTntST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D0722202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQvO-0006GS-Ry
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 11:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kXQjg-0000Va-6X
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 11:18:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kXQjd-0007su-VD
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 11:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603811885;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cB7E5b4IQB/QOh23CGARQGUODEGfGg1h2j73RSnsPO0=;
 b=ONnTntSTzM6cY7q/u8TYVXlc1uFbBbFWl41G6ZszMxdMiWItLxBpKOvdq9F7yp97MEoVFf
 5eFlW8Eru81ep339SsBWbe165ZpAIpvJU4u2My5mz/UQ1VSg5WMKAf8IntQsk4JEJiZBeV
 qEpMvkbDzJXTsPNJwtfoBMvsNJLPmDY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-E_UlmW6nNN-M1Z8Uwwc1Tw-1; Tue, 27 Oct 2020 11:17:53 -0400
X-MC-Unique: E_UlmW6nNN-M1Z8Uwwc1Tw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38021108E1B0;
 Tue, 27 Oct 2020 15:17:52 +0000 (UTC)
Received: from redhat.com (ovpn-115-46.ams2.redhat.com [10.36.115.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BEBC45D9E8;
 Tue, 27 Oct 2020 15:17:47 +0000 (UTC)
Date: Tue, 27 Oct 2020 15:17:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Daniele Buono <dbuono@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/6] configure: add option to enable LTO
Message-ID: <20201027151744.GF529052@redhat.com>
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
 <20201023200645.1055-4-dbuono@linux.vnet.ibm.com>
 <7aa00aba-ff8c-252a-899a-45ef4db7cc6e@redhat.com>
 <20201026155006.GE496050@redhat.com>
 <756e6060-394f-fe4a-47f2-2601b6e54a45@linux.vnet.ibm.com>
MIME-Version: 1.0
In-Reply-To: <756e6060-394f-fe4a-47f2-2601b6e54a45@linux.vnet.ibm.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 27, 2020 at 10:57:14AM -0400, Daniele Buono wrote:
> In terms of ar and linker, if you don't have the right mix it will just
> stop at link time with an error.
> 
> In terms of using gcc the errors may be a bit more subtle, similar to
> what Daniel mentioned. Succesfully compiling but then showing issues at
> runtime or in the test suite.
> 
> I'm using ubuntu 18.04 and the stock compiler (based on gcc 7.5) issues
> a bunch of warnings but compile succesfully with LTO.
> However, the tcg binary for sparc64 is broken. System-wide emulation
> stops in OpenFirmware with an exception. User emulation triggers a
> segmentation fault in some of the test cases. If I compile QEMU with
> --enable-debug the tests magically work.
> 
> I briefly tested with gcc-9 and that seemed to work ok, buy your mileage
> may vary

This why we shouldn't artificially block use of LTO with GCC in
the configure script. It blocks completely legitimate usage of
LTO with GCC versions where it works.

The user can detect if their version of GCC is broken by running the
test suite during their build process, which is best practice already,
and actually testing the result.

> 
> On 10/26/2020 11:50 AM, Daniel P. Berrangé wrote:
> > On Mon, Oct 26, 2020 at 10:51:43AM +0100, Paolo Bonzini wrote:
> > > On 23/10/20 22:06, Daniele Buono wrote:
> > > > This patch allows to compile QEMU with link-time optimization (LTO).
> > > > Compilation with LTO is handled directly by meson. This patch adds checks
> > > > in configure to make sure the toolchain supports LTO.
> > > > 
> > > > Currently, allow LTO only with clang, since I have found a couple of issues
> > > > with gcc-based LTO.
> > > > 
> > > > In case fuzzing is enabled, automatically switch to llvm's linker (lld).
> > > > The standard bfd linker has a bug where function wrapping (used by the fuzz*
> > > > targets) is used in conjunction with LTO.
> > > > 
> > > > Tested with all major versions of clang from 6 to 12
> > > > 
> > > > Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
> > > 
> > > What are the problems like if you have GCC or you ar/linker are not up
> > > to the job?  I wouldn't mind omitting the tests since this has to be
> > > enabled explicitly by the user.
> > 
> > We temporarily disabled LTO in Fedora rawhide due to GCC bugs causing
> > wierd test suite asserts. Those were pre-release versions of GCC/binutils
> > though. I've just tested again and LTO works correctly, so I've enabled
> > LTO once again.
> > 
> > Regards,
> > Daniel
> > 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


