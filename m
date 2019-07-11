Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EB1C74A4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 10:00:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E052C20645
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 10:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E052C20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlVs9-00076G-Rg
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 06:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53912)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hlVrf-0006gv-BT
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:59:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hlVre-0003EY-1k
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:59:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55562)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hlVrd-0003AB-Px
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:59:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8D63E3082E42;
 Thu, 11 Jul 2019 09:59:43 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26A2C194B3;
 Thu, 11 Jul 2019 09:59:41 +0000 (UTC)
Date: Thu, 11 Jul 2019 10:59:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Message-ID: <20190711095938.GG3971@work-vm>
References: <20190710202219.25939-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710202219.25939-1-brijesh.singh@amd.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 11 Jul 2019 09:59:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 00/13] Add SEV guest live migration
 support
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Lendacky,
 Thomas" <Thomas.Lendacky@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Singh, Brijesh (brijesh.singh@amd.com) wrote:
> AMD SEV encrypts the memory of VMs and because this encryption is done using
> an address tweak, the hypervisor will not be able to simply copy ciphertext
> between machines to migrate a VM. Instead the AMD SEV Key Management API
> provides a set of functions which the hypervisor can use to package a
> guest encrypted pages for migration, while maintaining the confidentiality
> provided by AMD SEV.
> 
> The patch series add the support required in Qemu to perform the SEV
> guest live migration. Before initiating the live migration a user
> should use newly added 'migrate-set-sev-info' command to pass the
> target machines certificate chain. See the docs/amd-memory-encryption.txt
> for further details.

Note the two patchew errors:
  a) Mostly formatting; 80 char lines, /* comments etc - you should
     check your patches using scripts/checkpatch.pl  to get rid of that
     lot.

  b) There are some build errors on non-x86 softmmu builds.

Dave

> The patch series depends on kernel patches available here:
> https://marc.info/?l=kvm&m=156278967226011&w=2
> 
> The complete tree with patch is available at:
> https://github.com/codomania/qemu/tree/sev-migration-v2
> 
> Changes since v1:
>  - use the dirty log sync APIs to also sync the page encryption bitmap
>    when SEV is active.
> 
> Brijesh Singh (13):
>   linux-headers: update kernel header to include SEV migration commands
>   kvm: introduce high-level API to support encrypted page migration
>   migration/ram: add support to send encrypted pages
>   kvm: add support to sync the page encryption state bitmap
>   doc: update AMD SEV API spec web link
>   doc: update AMD SEV to include Live migration flow
>   target/i386: sev: do not create launch context for an incoming guest
>   misc.json: add migrate-set-sev-info command
>   target/i386: sev: add support to encrypt the outgoing page
>   target/i386: sev: add support to load incoming encrypted page
>   kvm: introduce high-level API to migrate the page encryption bitmap
>   migration: add support to migrate page encryption bitmap
>   target/i386: sev: remove migration blocker
> 
>  accel/kvm/kvm-all.c            | 108 ++++++++
>  accel/kvm/sev-stub.c           |  22 ++
>  accel/stubs/kvm-stub.c         |  22 ++
>  docs/amd-memory-encryption.txt |  44 +++-
>  include/exec/ram_addr.h        | 161 +++++++++++-
>  include/exec/ramlist.h         |   3 +-
>  include/sysemu/kvm.h           |  25 ++
>  include/sysemu/sev.h           |   6 +
>  linux-headers/linux/kvm.h      |  53 ++++
>  migration/ram.c                |  91 ++++++-
>  qapi/misc-target.json          |  18 ++
>  target/i386/monitor.c          |  10 +
>  target/i386/sev-stub.c         |   5 +
>  target/i386/sev.c              | 455 +++++++++++++++++++++++++++++++--
>  target/i386/sev_i386.h         |  11 +-
>  target/i386/trace-events       |   8 +
>  16 files changed, 1016 insertions(+), 26 deletions(-)
> 
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

