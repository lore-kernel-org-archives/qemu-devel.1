Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04C0C606CF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 22:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD602216C4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 22:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD602216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkc5C-0003Pp-CU
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 18:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49294)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hkc4M-0002tR-Au
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 18:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hkc4K-0006KM-CR
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 18:25:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64353)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hkc4I-0006Jj-Iu
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 18:25:07 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8A5DB30C1322
 for <qemu-devel@nongnu.org>; Mon,  8 Jul 2019 22:25:03 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B09B1001B36;
 Mon,  8 Jul 2019 22:25:02 +0000 (UTC)
Date: Mon, 8 Jul 2019 19:25:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190708222501.GY5198@habkost.net>
References: <20190702215726.23661-1-ehabkost@redhat.com>
 <20190703154723.7327-1-imammedo@redhat.com>
 <20190703193702.GA5198@habkost.net>
 <20190704093322.04d78d48@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704093322.04d78d48@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 08 Jul 2019 22:25:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] tests: numa-test: use -numa memdev
 option instead of legacy 'mem' option
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 04, 2019 at 09:33:22AM +0200, Igor Mammedov wrote:
> On Wed, 3 Jul 2019 16:37:02 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> > [...]
> > > +    TestData data = { .ram_size = 128 };
> > >  
> > > -    if (strcmp(arch, "aarch64") == 0) {
> > > -        args = "-machine virt";
> > > +    if (!strcmp(arch, "aarch64")) {
> > > +        data.args = "-machine virt";
> > > +    } else if (!strcmp(arch, "ppc64")) {
> > > +        data.ram_size = 512;  
> > 
> > Wouldn't it be simpler to always use "-m 512M" and the same node
> > sizes?
> it would, but it might make some CI instances start failing more
> often where it used to work before. So I picked side of being
> conservative and not to hog memory unless it's necessary.

I don't understand.  Why would "-m 512M" make some CI instances
start failing more often?

-- 
Eduardo

