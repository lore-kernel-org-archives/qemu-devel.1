Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85769C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 09:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C08206BA
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 09:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C08206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32950 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEsGM-0003Aa-4L
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 05:14:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1hEsFZ-0002rp-3k
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 05:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1hEsFX-0003Wi-Ha
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 05:13:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1hEsFX-0003WA-89
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 05:13:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A695A307D861;
	Fri, 12 Apr 2019 09:13:29 +0000 (UTC)
Received: from beluga.usersys.redhat.com (unknown [10.43.2.166])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B0955C207;
	Fri, 12 Apr 2019 09:13:28 +0000 (UTC)
Date: Fri, 12 Apr 2019 11:13:26 +0200
From: Erik Skultety <eskultet@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190412091326.GE16137@beluga.usersys.redhat.com>
References: <20190411175931.29235-1-brijesh.singh@amd.com>
	<61c415de-ac47-9818-2b06-b9e46445833f@redhat.com>
	<7d449ae2-6762-97c2-4930-358f34f3ef4b@amd.com>
	<869394fb-7b3d-cc01-7329-e931a260e73c@redhat.com>
	<20190412081912.GC16137@beluga.usersys.redhat.com>
	<77338015-015c-aaef-d522-11cabbba4214@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <77338015-015c-aaef-d522-11cabbba4214@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Fri, 12 Apr 2019 09:13:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] target/i386: sev: add 'sev-max-guests'
 field to 'query-sev-capabilities'
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laszlo Ersek <lersek@redhat.com>, "Singh, Brijesh" <brijesh.singh@amd.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412091326.2-B2N3gtXFs-3YC3fPLZGdAuUR6eXaTnbeCFvdtvoks@z>

On Fri, Apr 12, 2019 at 10:26:45AM +0200, Paolo Bonzini wrote:
> On 12/04/19 10:19, Erik Skultety wrote:
> >> Since this field is not specific to guest configuration, I don't think
> >> it belongs in query-sev-capabilities; QEMU does not care about >1 guest.
> > Neither pdh nor cert-chain are specific to the guest config.
>
> Sort of, they are required to start a guest, aren't they?  But the

Unless you're interested in the measurement, aka attestation, I don't think
those are required in any way.

Erik

> number of guests is irrelevant.
>
> > I see why this
> > should be better suited for query-sev, the same goes for libvirt - I think we
> > shouldn't have gone with reporting the SEV platform caps in domain capabilities,
> > we should have IMHO report it both in the host capabilities (platform specific
> > stuff) and in domain capabilities to indicate that both libvirt and QEMU
> > support the SEV feature. Having said that, we have a precedent which I think
> > we might be better off with following rather than splitting the information
> > among multiple commands.
>
> For Libvirt, sure.  But I think this doesn't belong in QEMU at all.
> Libvirt should just use CPUID.
>
> Paolo

