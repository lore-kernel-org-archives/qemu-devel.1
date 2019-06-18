Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C098C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 23:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F0E20863
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 23:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F0E20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34130 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdNeA-0006J3-Vm
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 19:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36179)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brogers@suse.com>) id 1hdNdg-0005pS-IZ
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 19:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brogers@suse.com>) id 1hdNdf-0005fh-Hz
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 19:35:44 -0400
Received: from prv-mh.provo.novell.com ([137.65.248.74]:51850)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brogers@suse.com>) id 1hdNdf-0005bO-67
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 19:35:43 -0400
Received: from INET-PRV-MTA by prv-mh.provo.novell.com
 with Novell_GroupWise; Tue, 18 Jun 2019 17:35:37 -0600
Message-Id: <5D0975BE02000048000A1D94@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.1 
Date: Tue, 18 Jun 2019 17:37:34 -0600
From: "Bruce Rogers" <brogers@suse.com>
To: <peter.maydell@linaro.org>,<qemu-devel@nongnu.org>,
 <jsnow@redhat.com>
References: <5D096A9302000048000A1D8C@prv-mh.provo.novell.com>
Mime-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 137.65.248.74
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] Recent python-sphinx errors out building doc
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

(Resent with correct address for John)

I build recent upstream qemu in the openSUSE Build Service, and for
the Factory repository there, python-sphinx was recently updated to
version 2.1.1. This caused the build to fail as follows:
/home/abuild/rpmbuild/BUILD/qemu-4.0.50/docs/interop/bitmaps.rst:202:Could =
not lex literal_block as "json". Highlighting skipped.

The python-sphinx tools is called with warnings are treated as errors
it looks like. I don't know much at all about this tool, and hopefully
 someone knows what to fix here. If you want to give me a pointer
on what needs to change, I could give a go at doing a fix however.

Thanks,

Bruce


