Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8885C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:59:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E3E20874
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4rIBm++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E3E20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKLPW-0002Wo-68
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 08:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1kKLOq-0001eF-AJ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:58:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1kKLOo-0005B6-EZ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600693109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nIpvyELZFQynUP/YUP/wCggQpEGNkrJc59dZDh1tdnc=;
 b=L4rIBm++aFNUzKSKSLlI9yP24A8y4MP7QlzBTMUuMI10C9YUP8ASqkpsdJLpVuPw5NODmm
 wZNubPkxdJD7LCBTUWrtrl6fLMOG35XQhIZVai49q2jbj+oZtUNCcGwWIa9V/5RC6/Xp6P
 5mCy35ITN16FuSqenoHpyXa1oChWz78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-Rnuu3OGHMAKB-S-S0dytqg-1; Mon, 21 Sep 2020 08:58:26 -0400
X-MC-Unique: Rnuu3OGHMAKB-S-S0dytqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCAEE8015FA;
 Mon, 21 Sep 2020 12:58:24 +0000 (UTC)
Received: from localhost (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B1D67366D;
 Mon, 21 Sep 2020 12:58:18 +0000 (UTC)
Date: Mon, 21 Sep 2020 13:58:17 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH v5 0/8] Configurable policy for handling deprecated
 interfaces
Message-ID: <20200921125817.GI3888@redhat.com>
References: <20200914084802.4185028-1-armbru@redhat.com>
 <20200921124514.GB27434@redhat.com>
 <20200921125415.GI27515@angien.pipo.sk>
MIME-Version: 1.0
In-Reply-To: <20200921125415.GI27515@angien.pipo.sk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=rjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 mdroth@linux.vnet.ibm.com, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 marcandre.lureau@gmail.com, libguestfs@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 21, 2020 at 02:54:15PM +0200, Peter Krempa wrote:
> On Mon, Sep 21, 2020 at 13:45:14 +0100, Richard W.M. Jones wrote:
> > Some general comments on using the patch:
> > 
> > * For libguestfs I chose to add
> > 
> >   -compat deprecated-input=reject,deprecated-output=hide
> > 
> >   This is only enabled in developer builds of libguestfs when we
> >   are running qemu directly (not via libvirt).  The patch for
> >   this is attached.
> > 
> > * What's the point/difference in having reject vs crash?
> 
> I'll be adding the following documentation for the qemu.conf entry in
> libvirt controling the feature:
> 
> +# The "reject" option is less harsh towards the VMs but some code paths ignore
> +# errors reported by qemu and thus it may not be obvious that a deprecated
> +# command/field was used, thus it's suggested to use the "crash" option instead.

I'm not sure if libguestfs should use reject or crash.  But since most
of the benefit of this is going to be in detecting deprecated CLI
parameters in future, reject should be sufficient for us.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html


