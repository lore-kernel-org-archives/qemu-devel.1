Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8F4C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 21:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FAA120673
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 21:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FAA120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44568 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ0Hr-0007jp-CG
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 17:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56525)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hZ0GY-0007JM-QK
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hZ0GX-00070P-N8
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:49:46 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36217)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hZ0GX-0006CE-JH
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:49:45 -0400
Received: by mail-qt1-f194.google.com with SMTP id u12so33357qth.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 14:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RCJgm7x2OIz/MQjpSD+3HZ6DXiiG7muVjcwbl9X2rTw=;
 b=MQQusRvCYsz0oZmepH/6JxKaudpgvddtjbeBvaVMeJEQuuaJGgHtEERr5cvzuVnkLe
 rHwrrVbcxwRhLgNy303IyWJP18dBCX08mKem5Fqpp4H3rEVTYYU+iGRrsWUl3gTwHGTx
 MYkAwlNK+HvmS3ElRt5JsmvXASVQmgX9lQU67bjS1oiZQy0i9U4i4OWVCqQ9AyBVlrjv
 CkDozFwUc6M4v95PoraWBb0NlMLWxdxtgRaVQGVxo57NX2lamjoRuK3gAOq5h2kMX2sg
 MIkbC3Qzjylb5gPy/NVmREDIarz1U2zAjXHt/syR2qdPBPYfG2jNGU9NdqEh0u6hvhfJ
 8Elw==
X-Gm-Message-State: APjAAAWCUKs11R/dW4h7Ki8PHlDDORywxshGBrz9N6KkHMi1eGZQD02c
 iVmXjIkqe04aYKkaG5VObd5kIA==
X-Google-Smtp-Source: APXvYqx1dF98YiYv0lHtl+8TGsA1H7stZECwHECcGGUD9fDLn1/oxeNEfGmzBPG/lPHKSNs09C/z0g==
X-Received: by 2002:ac8:94d:: with SMTP id z13mr14734464qth.137.1559857770957; 
 Thu, 06 Jun 2019 14:49:30 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
 [100.0.197.103])
 by smtp.gmail.com with ESMTPSA id t189sm60850qkd.54.2019.06.06.14.49.29
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 06 Jun 2019 14:49:30 -0700 (PDT)
Date: Thu, 6 Jun 2019 17:49:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laine Stump <laine@redhat.com>
Message-ID: <20190606174136-mutt-send-email-mst@kernel.org>
References: <20190517125820.2885-1-jfreimann@redhat.com>
 <20190520165657.2293c5d7@x1.home>
 <20190521072157.wpb77wlc5mhfcdes@jenstp.localdomain>
 <20190521073511-mutt-send-email-mst@kernel.org>
 <20190521184918.n4nnk6ack3ssp6jv@jenstp.localdomain>
 <d116bc65-0715-2c6a-2616-49f67cd685c8@oracle.com>
 <20190528225039-mutt-send-email-mst@kernel.org>
 <1c5f460e-a3b9-56c1-90f7-b3a5c3d0a0d3@redhat.com>
 <20190603140832-mutt-send-email-mst@kernel.org>
 <1fa683cc-02c6-c674-78ef-db6afa55026a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fa683cc-02c6-c674-78ef-db6afa55026a@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.194
Subject: Re: [Qemu-devel] [PATCH 0/4] add failover feature for assigned
 network devices
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 aadam@redhat.com, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 si-wei liu <si-wei.liu@oracle.com>, Jens Freimann <jfreimann@redhat.com>,
 ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 03, 2019 at 02:18:19PM -0400, Laine Stump wrote:
> On 6/3/19 2:12 PM, Michael S. Tsirkin wrote:
> > On Mon, Jun 03, 2019 at 02:06:47PM -0400, Laine Stump wrote:
> > > On 5/28/19 10:54 PM, Michael S. Tsirkin wrote:
> > > > On Tue, May 28, 2019 at 05:14:22PM -0700, si-wei liu wrote:
> > > > > 
> > > > > 
> > > > > On 5/21/2019 11:49 AM, Jens Freimann wrote:
> > > > > > On Tue, May 21, 2019 at 07:37:19AM -0400, Michael S. Tsirkin wrote:
> > > > > > > On Tue, May 21, 2019 at 09:21:57AM +0200, Jens Freimann wrote:
> > > > > > > > On Mon, May 20, 2019 at 04:56:57PM -0600, Alex Williamson wrote:
> > > 
> > > > > > > Actually is there a list of devices for which this has been tested
> > > > > > > besides mlx5? I think someone said some old intel cards
> > > > > > > don't support this well, we might need to blacklist these ...
> > > > > > 
> > > > > > So far I've tested mlx5 and XL710 which both worked, but I'm
> > > > > > working on testing with more devices. But of course help with testing
> > > > > > is greatly appreciated.
> > > > > 
> > > > > It won't work on Intel ixgbe and Broadcom bnxt_en, which requires toggling
> > > > > the state of tap backing the virtio-net in order to release/reprogram MAC
> > > > > filter. Actually, it's very few NICs that could work with this - even some
> > > > > works by chance the behavior is undefined. Instead of blacklisting it makes
> > > > > more sense to whitelist the NIC that supports it - with some new sysfs
> > > > > attribute claiming the support presumably.
> > > > > 
> > > > > -Siwei
> > > > 
> > > > I agree for many cards we won't know how they behave until we try.  One
> > > > can consider this a bug in Linux that cards don't behave in a consistent
> > > > way.  The best thing to do IMHO would be to write a tool that people can
> > > > run to test the behaviour.
> > > 
> > > Is the "bad behavior" something due to the hardware of the cards, or their
> > > drivers? If it's the latter, then at least initially having a whitelist
> > > would be counterproductive, since it would make it difficult for relative
> > > outsiders to test and report success/failure of various cards.
> > 
> > We can add an "ignore whitelist" flag. Would that address the issue?
> 
> It would be better than requiring a kernel/qemu recompile :-)
> 
> 
> Where would the whilelist live? In qemu or in the kernel? It would be
> problematic to have the whitelist in qemu if kernel driver changes could fix
> a particular card.

So originally I thought:
- add some interface in the kernel to signal new behaviour
- start with a whitelist in qemu
- if not on the whitelist, check the new interface
- if not there, check a "force" flag on the device

But one problem with all of the above is that it's actually
too late. With a broken driver when management sets MAC on the
to-be-primary VF traffic stops being sent to standby.

> Beyond that, what about *always* just issuing some sort of warning rather
> than completely forbidding a card that wasn't whitelisted? (Haven't decided
> if I like that better or not (and it probably doesn't matter, since I'm not
> a "real" user, but I thought I would mention it).

People tend to ignore warnings :)

-- 
MST

