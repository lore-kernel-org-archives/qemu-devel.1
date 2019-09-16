Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E7EC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2906C2184D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2906C2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tAy-0002c6-Kb
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i9sib-0006gE-T9
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i9siY-0003rZ-Ug
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:15:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46220)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i9siY-0003r3-MN
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:15:06 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F0B576412B
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 15:15:04 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id s14so281924qkg.12
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 08:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Tceh2RHmy2WfOQ/l+TlDGdrqX+BRBbDYCPaAhMYr1h8=;
 b=IvuXRBG2WxqI2bbemSXuT5fnnF/Efdp1Jg/GuJMzobZZ6jMLyABhSS3xnmlLPr3lXM
 nG1LG9HyRkoiIShTdL4Fz5X8BoE30/PLYLIkHa9nM3sglqE7s+FrLjTQW83/i2WTTQTc
 Xy0z9zY0BK6zlXAcjCx7d/u04ObCw9R/5WR0/NBnjh5BeWWf1HvWcTyeMDuiCoawqQ8V
 6O9hs9nZ2chyIIm1tVvS0prI79gomgIFaO+Q3t2L6qow0ppEcZ9k2ZvxQqSlHKPS0bwZ
 O6BtocUQc9YZicZfZvJcvkVPJ/3WeW0wQjocwJIBmFVZ+CLh97WAigss6w/B/1u/nq1e
 6kHg==
X-Gm-Message-State: APjAAAWN8MODBSoavVHSBFM/Ims173OabTtL8vH2qby0XtDMe7WVfZLa
 t1YjNCe0I60UDOJFJ/HO1j65K/sy674zYLqsmpH/c5iqPhGPrDwcNyfGi1unDPnRl2rP0HHJmFq
 oYuDGl7eEIYTJqy8=
X-Received: by 2002:ac8:4742:: with SMTP id k2mr86172qtp.268.1568646904299;
 Mon, 16 Sep 2019 08:15:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwiBbeN5Nq3U4FolTBHLeJ/spoexYDgmPXhCpEKcf5cNpWwz/mmt/T+e9X4kXxypG5hr9Wr5Q==
X-Received: by 2002:ac8:4742:: with SMTP id k2mr86141qtp.268.1568646904053;
 Mon, 16 Sep 2019 08:15:04 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id q5sm21595393qte.38.2019.09.16.08.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 08:15:02 -0700 (PDT)
Date: Mon, 16 Sep 2019 11:14:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: peter.maydell@linaro.org, yu.c.zhang@linux.intel.com,
 ehabkost@redhat.com, imammedo@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, stefanha@redhat.com,
 crosthwaite.peter@gmail.com, richard.henderson@linaro.org,
 xiaoguangrong.eric@gmail.com
Message-ID: <20190916111435-mutt-send-email-mst@kernel.org>
References: <20181218085249-mutt-send-email-mst@kernel.org>
 <20181219091017.GA35378@tiger-server>
 <20181219105555-mutt-send-email-mst@kernel.org>
 <20181220030312.GA70591@tiger-server>
 <20181219223700-mutt-send-email-mst@kernel.org>
 <20181220053739.GB70591@tiger-server>
 <20181220090435-mutt-send-email-mst@kernel.org>
 <20181221031817.GA77135@tiger-server>
 <20181221112902-mutt-send-email-mst@kernel.org>
 <20181224081142.GA6477@tiger-server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181224081142.GA6477@tiger-server>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH V7 6/6] hostmem-file: add 'sync' option
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 24, 2018 at 04:11:43PM +0800, Yi Zhang wrote:
> On 2018-12-21 at 11:36:07 -0500, Michael S. Tsirkin wrote:
> > On Fri, Dec 21, 2018 at 11:18:18AM +0800, Yi Zhang wrote:
> > > On 2018-12-20 at 09:06:41 -0500, Michael S. Tsirkin wrote:
> > > > On Thu, Dec 20, 2018 at 01:37:40PM +0800, Yi Zhang wrote:
> > > > > On 2018-12-19 at 22:42:07 -0500, Michael S. Tsirkin wrote:
> > > > > > On Thu, Dec 20, 2018 at 11:03:12AM +0800, Yi Zhang wrote:
> > > > > > > On 2018-12-19 at 10:59:10 -0500, Michael S. Tsirkin wrote:
> > > > > > > > On Wed, Dec 19, 2018 at 05:10:18PM +0800, Yi Zhang wrote:
> > > > > > > > > > > +
> > > > > > > > > > > + - 'sync' option of memory-backend-file is not 'off', and
> > > > > > > > > > > +
> > > > > > > > > > > + - 'share' option of memory-backend-file is 'on'.
> > > > > > > > > > > +
> > > > > > > > > > > + - 'pmem' option of memory-backend-file is 'on'
> > > > > > > > > > > +
> > > > > > > > > > 
> > > > > > > > > > Wait isn't this what pmem was supposed to do?
> > > > > > > > > > Doesn't it mean "persistent memory"?
> > > > > > > > > pmem is a option for memory-backend-file, user should know the backend
> > > > > > > > > is in host persistent memory, with this flags on, while there is a host crash
> > > > > > > > > or a power failures.
> > > > > > > > > 
> > > > > > > > > [1] Qemu will take necessary operations to guarantee the persistence.
> > > > > > > > > https://patchwork.ozlabs.org/cover/944749/ 
> > > > > > > > > 
> > > > > > > > > [2] Host kernel also take opretions to consistent filesystem metadata.
> > > > > > > > > Add MAP_SYNC flags.
> > > > > > > > 
> > > > > > > > OK so I'm a user. Can you educate me please?  
> > > > > > > We suppose an administrator should know it, what is the back-end region coming from,
> > > > > > > is it persistent? what is the font-end device is? a volatile dimm or an
> > > > > > > nonvolatile dimm? then they can choice put the pmem=on[off] and sync=on[off].
> > > > > > > If he didn't, we encourage that don't set these 2 flags.
> > > > > > > 
> > > > > > > > When should MAP_SYNC not
> > > > > > > > be set? Are there any disadvantages (e.g.  performance?)?
> > > > > > > Not only the performance, sometimes like the front-end device is an
> > > > > > > volatile ram, we don't wanna set such option although the backend is a
> > > > > > > novolatile memory, if power lose, all of thing should lose in this ram.
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > I am not sure how does above answer the questions. If I don't know,
> > > > > > neither will the hypothetical administrator. Looks like a better
> > > > > > interface is needed to make the choice on behalf of the user.
> > > > > > 
> > > > > By default, we have already ignore the 2 flags, unless the administrator
> > > > > know how to make that use. By-now, seems we don't have a better way to detect what
> > > > > memory-backend-file is, a persistent memory or not.
> > > > 
> > > > In that case how about an interface where user tells QEMU "this backend
> > > > is in persistent memory"?
> > > 
> > > Actually, [pmem=on] already did this, we can get the backend memory type from:
> > > 
> > > file_memory_backend_get_pmem(),
> > > 
> > > That is already being used in the memory_region_init_ram_from_file. that
> > > is why I reuse the RAM_PMEM to identify the region coming from a
> > > persitent memory? correct me if something I misunderstood? 
> > 
> > Right and thus my question: why not set SYNC unconditionally with pmem=on?
> A case is that we set pmem but don't wanna sync in a /dev/dax backend,
> which is direct mapping to physical nvdimm device without filesystem aware,
> SYNC is useless in this condition.

Does it hurt though?

> > 
> > > 
> > > > 
> > > > 
> > > > 
> > > > > > 
> > > > > > > > 
> > > > > > > > -- 
> > > > > > > > MST
> > > > > > > > 
> > > > > > 
> > > > 
> > 

