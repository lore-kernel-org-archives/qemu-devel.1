Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEC0C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:11:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 958AD21D79
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUnGGU+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958AD21D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvKiJ-0004bt-Mu
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 09:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jvKhe-0003ze-SP
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:10:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46799
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jvKhc-0005bX-3U
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594732230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FKRvD68ipKohwE5zewGkEezEMPP9hlme5Xedm2n5j0g=;
 b=PUnGGU+FN0Zo/FQajOTNc0TeMZYX/7WxjDpFqG57GRJunNjitJbF2HoHHE+eALrUNaHIif
 EskScp3X61TTroh1+4ryJ7Gab2gDTi6YAEfGnLe5hE2whZnQ7aB8meGWqHDqpIUovXCo89
 YnZpokdcwu+U2CfZTVYPbnpPKwJWlK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-Xv0ibhBONlG11mZAcGqnCA-1; Tue, 14 Jul 2020 09:10:26 -0400
X-MC-Unique: Xv0ibhBONlG11mZAcGqnCA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28D778014D7;
 Tue, 14 Jul 2020 13:10:25 +0000 (UTC)
Received: from kaapi (unknown [10.33.36.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 12D4510013C1;
 Tue, 14 Jul 2020 13:10:13 +0000 (UTC)
Date: Tue, 14 Jul 2020 18:40:11 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: introduce cve or security quotient field
In-Reply-To: <20200714064921-mutt-send-email-mst@kernel.org>
Message-ID: <nycvar.YSQ.7.78.906.2007141723140.6870@xnncv>
References: <20200714083631.888605-1-ppandit@redhat.com>
 <20200714083631.888605-2-ppandit@redhat.com>
 <CAFEAcA9QWLmi1fGuPW93GXFKV2KCwNs6Xp3U9MU2r4wtendzhg@mail.gmail.com>
 <20200714095233.GC25187@redhat.com>
 <20200714060916-mutt-send-email-mst@kernel.org>
 <CAFEAcA_ca4JN655GW=eGyjrjDmiv0EktaZZ7RMghO5rBwm9tGQ@mail.gmail.com>
 <20200714064921-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hello all,

Thank you so much for the comments and inptus, I appreciate it.

+-- On Tue, 14 Jul 2020, Michael S. Tsirkin wrote --+
| On Tue, Jul 14, 2020 at 11:22:28AM +0100, Peter Maydell wrote:
| > On Tue, 14 Jul 2020 at 11:12, Michael S. Tsirkin <mst@redhat.com> wrote:
| > > And for people who want to build QEMU with lots of functionality (like
| > > Fedora does), I think a -security flag would be a useful addition.
| > > We can then tell security researchers "only a high security issue
| > > if it reproduces with -security=high, only a security issue
| > > if it reproduces with -security=low".
| > 
| > I think a -security option would also be useful to users -- it makes it 
| > easier for them to check "is this configuration using something that I 
| > didn't realize was not intended to be secure". For me, something useful 
| > for our users is much more compelling than "this might make security 
| > researchers' lives a bit easier".

* General consensus seems to be that MAINTAINERS file is not best suited for 
  such security related annotation.

* We generally ask researchers if the issue is reproducible with 
  '-enable-kvm', so it excludes TCG use cases.


| -security level
| 	Set minimal required security level of QEMU.
| 
| 	high: block use of QEMU functionality which is intended to be secure against
| 	malicious guests.

   secure -> insecure, I think?

| 	low: allow use of all QEMU functionality, best effort security
| 		against malicious guests.
| 
| Default would be -security low.
| 
| Does this look reasonable?
| 
| Just a correction to what I wrote: I no longer think it's reasonable to
| classify the severity of a security issue automatically. E.g. a qemu
| crash in virtio code is a high severity security issue if it triggers
| with platform_iommu=on since it is then driver from guest userspace, and
| low severity one without since then it's driven from a guest driver.
| 
| So I think we can add something like this to security.rst and to
| the wiki:
| 
| 	only a security issue if it
| 	reproduces with -security high, a regular bug if it only reproduces with
| 	-security low
| 
| Prasad?

IIUC:

 * QEMU would abort(3), if a user attempts to start QEMU with insecure options 
   like say -virtfs OR -fda fat:floopy OR -netdev user OR -device tulip ?  

 * One way could be to abort(3) at options parsing stage, if 'security' flag 
   is set to high(1) and continue further if it is low(0).

 * ie. for each option we'd need do define if it is safe or not?

Does that seem right? OR do we maintain a run time list of features/options 
deemed to be safe? Either way, we need to define some place, which QEMU 
functions/devices/backends etc. are safe.


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


