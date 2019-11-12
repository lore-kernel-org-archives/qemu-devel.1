Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9F3C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5021321925
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5021321925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUT4k-0004FA-6i
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 05:07:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iUT2V-0001uP-V4
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:04:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iUT2T-0002K4-TV
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:04:47 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:34485)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iUT2N-0002Hp-2b; Tue, 12 Nov 2019 05:04:39 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MRSZX-1iIjTQ31E5-00NSzd; Tue, 12 Nov 2019 11:04:33 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] Trivial branch patches
Date: Tue, 12 Nov 2019 11:04:24 +0100
Message-Id: <20191112100429.11957-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:E3n67UlpV8+o3nG/EliqTYbwJXoT9B5xLa7CaVIaASPHaeYxsM9
 QWPuQYF6cNPbl95TyNXk6b9pSQjJswTKugLdy3OdqRsEr+am0O8sqPZ9ohi5FfAE7LqCB7k
 yhqWVnD0JhFMDrnh6VJ6gxWvuExJEgwV+ayWcWVxUAK4MR0BsgH2a65KIl3GCeeUxPIYxYK
 EIax6t6YkR8AyP3Wi1zKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/UMi8JzXMuA=:YmsufvCZXGBUV+sV8KcFHc
 PFUNmpWkNBvLiQdvAqPrWzTU5aniLzrXcgWZEBCqnxlh1vTPZ1G3Mp+3KMOBlktccElg+n8O8
 6jT2LNyrOZuYcDUvljQRB3kanBih1oxBMP44Gysbs+TIwWDydpsFYNUJeZ7t76TynhPmVdZRa
 GQ6GbyduM1B2yUYU8uo7mZYUQ3yzTVl6wASr9twDTQY5Cu5FMdySiQdHNCDzhv+VA0wXMhrA/
 +xYBz5U/RQfXRj2t/XCTqbtVQqbRjfqdIdWG3Xrb0qbPjgpaF1/sAg8tOEowmiVGcZmo36y3O
 //bZ+6fDeSOkwjpDFjiJVlV+olq0D7HSZGRfVQi9CvQSiiegchfDh+QHcbUfy9v9syViabg2R
 2K8w41Ap78Ol/2eraE4YGS9OVdpokZdDxGNRILIAlredrkvHtVQeRXyC1HR+7RujGUrJJC7MD
 aMRjScUETd4Oam0Zm5p131CFcKYucGNsGADj2nKVGKQXtcSpjGBLmBUxz1DbuLC5suySujKls
 nf7k01jJQjej472wpTtnlarmjaycco1QzYcbAjM4l62b4ongM5p3ES80NY8hcfKBlt+zPggNm
 WvNpURloEKZHt8clMW41XOEC4GnvWlzsUgQS6CMi8Ufrxy9SNoN0txHR7WZs+03OHvb/jcRH/
 1v7ilvLWZOeeWmVrhxXJNHIVQbYxDZaSEEpG7NHcSscJggLVwy+MXO0FX4FbwzTz3SgEr9cb0
 sGePax99HIgEzkAeZlJVAeMbZJR+PNC1sMuFLXwQJnDqpFwCR7eQw+IfJuEB2ulaPKq/q4Vrn
 d+Zkq72tb8fBRTKlnzgv5vfSN2iNZB6qwGS76OCmwQOrOmhpLQOTwx9zjhWat0HOEyr/RirU7
 vyD+TSiggxUUvNaXMaEZXmdSxjGPDltbpt5EVn6Sw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.74
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 9f2ce35dfa4ea4a31dbb765dd02bed2500891887:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20191111' into staging (2019-11-11 16:54:16 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/trivial-branch-pull-request

for you to fetch changes up to 5c62979ed5f75976ae215098566ebd93dfe4e22a:

  ivshmem-server: Terminate also on SIGINT (2019-11-12 10:37:20 +0100)

----------------------------------------------------------------
Trivial fixes (20191112)
ivshmem-server, error messages (numa, qom) and
Makefile (bios-microvm) fixes

----------------------------------------------------------------

Bruce Rogers (1):
  Makefile: install bios-microvm like other binary blobs

Greg Kurz (2):
  qom: Fix error message in object_class_property_add()
  numa: Add missing \n to error message

Jan Kiszka (2):
  ivshmem-server: Clean up shmem on shutdown
  ivshmem-server: Terminate also on SIGINT

 Makefile                                |  2 +-
 contrib/ivshmem-server/ivshmem-server.c |  6 ++++++
 contrib/ivshmem-server/main.c           |  5 +++--
 hw/core/numa.c                          |  2 +-
 qom/object.c                            | 10 ++++------
 5 files changed, 15 insertions(+), 10 deletions(-)

-- 
2.21.0


