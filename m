Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BC9C33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:33:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E50320661
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E50320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cornelia-huck.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izH3c-0000Kp-8M
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 04:33:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <conny@cornelia-huck.de>) id 1izH1n-0007oI-7r
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:31:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <conny@cornelia-huck.de>) id 1izH1m-0006je-2m
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:31:23 -0500
Received: from mout0.freenet.de ([2001:748:100:40::2:2]:40496)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <conny@cornelia-huck.de>)
 id 1izH1l-000699-Ql
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:31:21 -0500
Received: from [195.4.92.163] (helo=mjail0.freenet.de)
 by mout0.freenet.de with esmtpa (ID conny@cornelia-huck.de) (port 25) (Exim
 4.92 #3) id 1izH1Z-0004Vk-Fh; Wed, 05 Feb 2020 10:31:09 +0100
Received: from [::1] (port=49648 helo=mjail0.freenet.de)
 by mjail0.freenet.de with esmtpa (ID conny@cornelia-huck.de) (Exim 4.92 #3)
 id 1izH1Z-0000Yh-En; Wed, 05 Feb 2020 10:31:09 +0100
Received: from sub8.freenet.de ([195.4.92.127]:49762)
 by mjail0.freenet.de with esmtpa (ID conny@cornelia-huck.de) (Exim 4.92 #3)
 id 1izGz5-0006SZ-Qc; Wed, 05 Feb 2020 10:28:35 +0100
Received: from nat-pool-str-t.redhat.com ([149.14.88.106]:16022 helo=gondolin)
 by sub8.freenet.de with esmtpsa (ID conny@cornelia-huck.de)
 (TLSv1.2:ECDHE-RSA-CHACHA20-POLY1305:256) (port 465) (Exim 4.92 #3)
 id 1izGz5-0000o6-OU; Wed, 05 Feb 2020 10:28:35 +0100
Date: Wed, 5 Feb 2020 10:28:30 +0100
From: Cornelia Huck <conny@cornelia-huck.de>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: VW ELF loader
Message-ID: <20200205102830.15cb9706.conny@cornelia-huck.de>
In-Reply-To: <20200205060634.GI60221@umbus.fritz.box>
References: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
 <e3ee4b4d-1b24-2900-4304-05fa521a9b47@redhat.com>
 <20200203012842.GD52446@umbus.fritz.box>
 <ec81cca1-d5fb-3f1e-b433-3328d81a117e@redhat.com>
 <de7e4d34-eb63-904c-3475-7feee154c72c@ozlabs.ru>
 <8420784f-b4c7-9864-8534-b94dbc5f74ff@redhat.com>
 <d63ba962-ffbb-9f27-34fb-657188e90194@ozlabs.ru>
 <CABgObfYwtrh_uy8zFmg2qDjK6iynniN6=jJ9_MKfNxXUaOkPKw@mail.gmail.com>
 <71d1cc16-f07d-481d-096b-17ee326157bb@ozlabs.ru>
 <CABgObfa4tUVBbpBtoY3JFSF8-0mRVxgGbzQokc+JrJGPagwPaQ@mail.gmail.com>
 <20200205060634.GI60221@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originated-At: 149.14.88.106!16022
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:748:100:40::2:2
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
Cc: Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 qemu-devel <qemu-devel@nongnu.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Feb 2020 17:06:34 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Feb 04, 2020 at 12:26:32AM +0100, Paolo Bonzini wrote:

> > You can generalize and reuse the s390 code. All you have to write is the
> > PCI scan and virtio-pci setup.  
> 
> If we assume virtio only.  In any case it sounds like the s390 code is
> actually based on the SLOF code anyway.

Only the netboot part. Device discovery/setup etc. had been written
from scratch, but I'm not sure how much reusable infrastructure remains
once you strip all the s390x-specific stuff.

