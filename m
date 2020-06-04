Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F7BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:45:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42FF7204EF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUTldjbO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FF7204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgmR4-0007JT-Id
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 05:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgmQA-0006R3-Vz
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:44:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60005
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgmQA-0004RZ-5F
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591263861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IxVBeYw7HFz4dIWlcmFVBsRbKrFxt9pfNo0y+YJ0zL4=;
 b=TUTldjbO+Th5Lrm3Yoo3XpktLKouXzRqfm03fSYyGHkXFSf+Kd1hGWfpaPbMt4INrW+hFO
 T5VXYU3g8cCQsDUBoL9SGoW/Fst/qw2/+fwYJm3e2+d4rN0JBicF+ZP9psqqLZVSSGCa43
 w7UApkRpibRzSVFHSElMHsww6E/ym2Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-mOuxCjzqOnyBGj11kCKoOw-1; Thu, 04 Jun 2020 05:44:19 -0400
X-MC-Unique: mOuxCjzqOnyBGj11kCKoOw-1
Received: by mail-wr1-f71.google.com with SMTP id p9so2194730wrx.10
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 02:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IxVBeYw7HFz4dIWlcmFVBsRbKrFxt9pfNo0y+YJ0zL4=;
 b=unvFxoxlh3NioGP6rSJfQpY9KaefRtBnh2Mqr1N8H6YIiZNjzEK+dcDDikKXTil8TB
 p6TuGB3lDHDFKb7+I+C+mloWTOTosHdiSAbsT4PBIicPvH/vROSbQUz8JE+VcxkrZaLw
 NOR6n/DAKzF+0CEnduyRAGZI2Aow565vs8XSu12vk63Xz4jdAUC67tdPVw3f9ohPa93V
 DMxJIZbnSGFJP6+tYYx4pOdHmL50pOANHfq7erRqBvdWX/Qk1llP5FbTBt86Jem0+HIC
 eAoM8VFTI5GWMevT2ViWHH19xc/pK6w4ekJ7fgr6p32n2pUOt9bphk6cr2tazyOoEHpi
 51Pg==
X-Gm-Message-State: AOAM530wKmXS13oLY7aBa7JwyRulb+Uaw6K4iSsBWrxAETPoxsILjKdl
 0/SVx0GOH5eBzKFW3WMJyM5CUHZaZhAPOgn1bzly6nGYhyDsBaWg3E/brQbwOx/KdyhbWvXFja5
 4d8lhlicb9XnvhaQ=
X-Received: by 2002:adf:dc8e:: with SMTP id r14mr3377970wrj.333.1591263858836; 
 Thu, 04 Jun 2020 02:44:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3wSmYEsonV7BOOWst6HGo/vGa5kaR5LGMAesmbPDuVZyUTGaplqB3999hxZy9juNvfGE7mw==
X-Received: by 2002:adf:dc8e:: with SMTP id r14mr3377944wrj.333.1591263858575; 
 Thu, 04 Jun 2020 02:44:18 -0700 (PDT)
Received: from redhat.com ([2a00:a040:185:f65:9a3b:8fff:fed3:ad8d])
 by smtp.gmail.com with ESMTPSA id b201sm6585211wmb.36.2020.06.04.02.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 02:44:18 -0700 (PDT)
Date: Thu, 4 Jun 2020 05:44:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 2/2] pci: ensure configuration access is within bounds
Message-ID: <20200604054323-mutt-send-email-mst@kernel.org>
References: <20200603202251.1199170-1-ppandit@redhat.com>
 <20200603202251.1199170-3-ppandit@redhat.com>
 <alpine.BSF.2.22.395.2006040006520.56892@zero.eik.bme.hu>
 <20200604051400.743ebtvj3qg2uoet@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20200604051400.743ebtvj3qg2uoet@sirius.home.kraxel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Ren Ding <rding@gatech.edu>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 04, 2020 at 07:14:00AM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > > +    assert(address + len <= pci_config_size(d));
> > 
> > Does this allow guest now to crash QEMU?
> 
> Looks like it does (didn't actually try though).
> 
> > I think it was suggested that assert should only be used for cases
> > that can only arise from a programming error and not from values set
> > by the guest.
> 
> Correct.  We do have guest-triggerable asserts in the code base.  They
> are not the end of the world as the guest will only hurt itself.  But
> in general we try to get rid of them instead of adding new ones ...
> 
> Often you can just ignore the illegal guest action (bonus points for
> logging GUEST_ERROR as debugging aid).  Sometimes it is more difficult
> to deal with it (in case the hardware is expected to throw an error irq
> for example).
> 
> take care,
>   Gerd

In this case it's not supposed to be guest triggerable, so I'm inlined
to merge this, but as a separate patch from patch 1,
and commit log need to be clearer that it's defence in depth
not a bugfix.


