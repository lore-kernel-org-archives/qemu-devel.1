Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B703AC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:23:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF9E2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF9E2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cornelia-huck.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyyBB-0006HK-JA
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 08:23:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <conny@cornelia-huck.de>) id 1iyu17-0002zQ-6z
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <conny@cornelia-huck.de>) id 1iyu16-0004ZN-2b
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:57:09 -0500
Received: from mout2.freenet.de ([2001:748:100:40::2:4]:39204)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <conny@cornelia-huck.de>)
 id 1iyu15-0004Gx-T2
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:57:08 -0500
Received: from [195.4.92.165] (helo=mjail2.freenet.de)
 by mout2.freenet.de with esmtpa (ID conny@cornelia-huck.de) (port 25) (Exim
 4.92 #3) id 1iyu10-0006eI-FY; Tue, 04 Feb 2020 09:57:02 +0100
Received: from [::1] (port=43918 helo=mjail2.freenet.de)
 by mjail2.freenet.de with esmtpa (ID conny@cornelia-huck.de) (Exim 4.92 #3)
 id 1iyu10-0002R1-Ec; Tue, 04 Feb 2020 09:57:02 +0100
Received: from sub4.freenet.de ([195.4.92.123]:35552)
 by mjail2.freenet.de with esmtpa (ID conny@cornelia-huck.de) (Exim 4.92 #3)
 id 1iytyB-0001In-79; Tue, 04 Feb 2020 09:54:07 +0100
Received: from pd9f5ffa0.dip0.t-ipconnect.de ([217.245.255.160]:47350
 helo=gondolin)
 by sub4.freenet.de with esmtpsa (ID conny@cornelia-huck.de)
 (TLSv1.2:ECDHE-RSA-CHACHA20-POLY1305:256) (port 465) (Exim 4.92 #3)
 id 1iytyB-00005d-3Q; Tue, 04 Feb 2020 09:54:07 +0100
Date: Tue, 4 Feb 2020 09:54:03 +0100
From: Cornelia Huck <conny@cornelia-huck.de>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: VW ELF loader
Message-ID: <20200204095403.04d9dd29.conny@cornelia-huck.de>
In-Reply-To: <d13eea1d-7942-47e0-6189-a66ce9639db4@redhat.com>
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
 <d13eea1d-7942-47e0-6189-a66ce9639db4@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originated-At: 217.245.255.160!47350
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:748:100:40::2:4
X-Mailman-Approved-At: Tue, 04 Feb 2020 08:22:47 -0500
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel <qemu-devel@nongnu.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 4 Feb 2020 07:16:46 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 04/02/2020 00.26, Paolo Bonzini wrote:
> > 
> > 
> > Il mar 4 feb 2020, 00:20 Alexey Kardashevskiy <aik@ozlabs.ru
> > <mailto:aik@ozlabs.ru>> ha scritto:
> > 
> >     Speaking seriously, what would I put into the guest?
> > 
> > Only things that would be considered drivers. Ignore the partitions
> > issue for now so that you can just pass the device tree services to QEMU
> > with hypercalls.
> > 
> >     Netboot's dhcp/tftp/ip/ipv6 client? It is going to be another SLOF,
> >     smaller but adhoc with only a couple of people knowing it.
> > 
> > 
> > You can generalize and reuse the s390 code. All you have to write is the
> > PCI scan and virtio-pci setup.  
> 
> Well, for netbooting, the s390-ccw bios uses the libnet code from SLOF,
> so re-using this for a slim netboot client on ppc64 would certainly be
> feasible (especially since there are also already virtio drivers in SLOF
> that are written in C), but I think it is not very future proof. The
> libnet from SLOF only supports UDP, and no TCP. So for advanced boot
> scenarios like booting from HTTP or even HTTPS, you need something else
> (i.e. maybe grub is the better option, indeed).

That makes me wonder what that means for s390: We're inheriting
libnet's limitations, but we don't have grub -- do we need to come up
with something different? Or improve libnet?

