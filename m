Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3157C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:36:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90D882072F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjiVRLx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D882072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjLV6-0006MH-Rc
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 07:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jjLTy-0005jQ-2D
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 07:34:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27010
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jjLTx-0008EX-9I
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 07:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591875292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2EgSaukMPDqu0A68Ka1hpSO9cIqoDZTymdK2c5WlzfM=;
 b=JjiVRLx/pwGtmPzm2+QJDridTkZUXkJZJ05N3TmLoKT0uBFw+COs0yEoDQ+z4/GRn9je2e
 DxjMXapuRjygpcn9BqaTWvicmpT+T6uy6MwmNosH9sH60K85qcMIDc0SWODd171Co7qeJJ
 CWZx2rYGOxL7ea+c64reJ0MqD1vSXYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-XO-Qpd3FNfCgxn-MvxNOlA-1; Thu, 11 Jun 2020 07:34:50 -0400
X-MC-Unique: XO-Qpd3FNfCgxn-MvxNOlA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCA37107ACF2;
 Thu, 11 Jun 2020 11:34:49 +0000 (UTC)
Received: from localhost (unknown [10.40.208.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02C3E8FF76;
 Thu, 11 Jun 2020 11:34:38 +0000 (UTC)
Date: Thu, 11 Jun 2020 13:34:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v7 0/9] acpi: i386 tweaks
Message-ID: <20200611133433.75996d47@redhat.com>
In-Reply-To: <20200610155346.qwqwxr6v22xi4wn5@sirius.home.kraxel.org>
References: <20200610094131.13346-1-kraxel@redhat.com>
 <20200610134002.6461b40a@redhat.com>
 <20200610105405-mutt-send-email-mst@kernel.org>
 <20200610155346.qwqwxr6v22xi4wn5@sirius.home.kraxel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1B?= =?UTF-8?B?bmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 10 Jun 2020 17:53:46 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Wed, Jun 10, 2020 at 10:54:26AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jun 10, 2020 at 01:40:02PM +0200, Igor Mammedov wrote:  
> > > On Wed, 10 Jun 2020 11:41:22 +0200
> > > Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >   
> > > > First batch of microvm patches, some generic acpi stuff.
> > > > Split the acpi-build.c monster, specifically split the
> > > > pc and q35 and pci bits into a separate file which we
> > > > can skip building at some point in the future.
> > > >   
> > > It looks like series is missing patch to whitelist changed ACPI tables in
> > > bios-table-test.  
> > 
> > Right. Does it pass make check?  
> 
> No, but after 'git cherry-pick 9b20a3365d73dad4ad144eab9c5827dbbb2e9f21' it does.
> 
> > > Do we already have test case for microvm in bios-table-test,
> > > if not it's probably time to add it.  
> > 
> > Separately :)  
> 
> Especially as this series is just preparing cleanups and doesn't
> actually add acpi support to microvm yet.
> 
> But, yes, adding a testcase sounds useful.
Sorry for confusion, I didn't mean to do it within this series

> 
> take care,
>   Gerd
> 


