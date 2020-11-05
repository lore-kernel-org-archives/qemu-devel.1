Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83621C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:55:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27E320756
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsKWVYGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27E320756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaenB-0006ct-B7
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 07:55:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaemE-0006Bo-7V
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:54:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaemC-0004Gh-9q
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604580842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E8wb/RDMVQPwkdhysoFLHsAyegi5b52a4N5xwqmjkz4=;
 b=IsKWVYGiQJDcwkfAhGfWnkDaJf8iYiJHjic7zPc+KDg4OnlBO5EzDyjm85guZlctHZvX0K
 +Mws3oPmi9jIwtXI1NL7sX805QMJtUVdxc/DY6lzQzvhXPGRc8Pmfy9RHHiPC7A7D95UVR
 cm66BwX/dq7uSSjPSSXnn9d24EAnY+A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-RYwhSyzdOHuTwOG-GOyGLw-1; Thu, 05 Nov 2020 07:54:01 -0500
X-MC-Unique: RYwhSyzdOHuTwOG-GOyGLw-1
Received: by mail-wm1-f70.google.com with SMTP id c10so580402wmh.6
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 04:54:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=E8wb/RDMVQPwkdhysoFLHsAyegi5b52a4N5xwqmjkz4=;
 b=bxd2/diB2ryu5H4TswVTMWh7LOhWHNIq92Y/n4/PmDXMcnVD8hHi3O9oEObP5hvCGe
 ERu8ZWOl/RKrClGDeFOja3ZKxG5QeAVLKNAY/J/fuaZ6GSUb11XDy/HCygmv11Cy8LCg
 VeZ1KsbHs+ciAgymfET1FPn+Y0lr/eafeW6awspkervRdn8Eap3cjhP1b18l2EP3/5mT
 JMO9ZruRVrQmDVW8N+Tz06K8q+bC+Lsivy+FSWp5ev5bpPWFgg4JByQlBDFqzrZRqRmg
 AtOLUwKGElnlRM79jUROs4w9CwtYp4RWqV5xu5GMRLkej+HpIFCn5yS8+Ci6vcYCflEl
 82lA==
X-Gm-Message-State: AOAM531Zd6sKbUTT+SNyhBsNdb/MvF9tilm+VT6PFmOSVuEblwXK5peY
 pzn5G3y3TPD1sUNuco3UjoXPsqDqawCTncyabLmNvcgW6r2hH3N3n+zWkZafwA3mKHVCQwhN3+B
 +76jAgnB5eZkyUKE=
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr2542890wmc.24.1604580839893; 
 Thu, 05 Nov 2020 04:53:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsRYwxpOdeH4TkqfMStG1AKg79xDuLJxR3kqtNpt8Akn86ROC8QUe/7CcsageNGuOmkBSMoQ==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr2542873wmc.24.1604580839711; 
 Thu, 05 Nov 2020 04:53:59 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id z19sm2417211wmk.12.2020.11.05.04.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 04:53:58 -0800 (PST)
Date: Thu, 5 Nov 2020 07:53:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: VFIO Migration
Message-ID: <20201105075117-mutt-send-email-mst@kernel.org>
References: <20201102111153.GC42093@stefanha-x1.localdomain>
 <20201103121709.GD3566@work-vm>
 <20201103152752.GC253848@stefanha-x1.localdomain>
 <20201103184951.GM3566@work-vm>
 <20201104073636.GB390503@stefanha-x1.localdomain>
 <20201104101423.GB3896@work-vm>
 <20201104164744.GC425016@stefanha-x1.localdomain>
 <20201104173202.GG3896@work-vm>
 <20201105114037.GC462479@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201105114037.GC462479@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: John G Johnson <john.g.johnson@oracle.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 quintela@redhat.com, Jason Wang <jasowang@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 05, 2020 at 11:40:37AM +0000, Stefan Hajnoczi wrote:
> On Wed, Nov 04, 2020 at 05:32:02PM +0000, Dr. David Alan Gilbert wrote:
> > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > Michael replied in another sub-thread wondering if versions are really
> > > necessary since tools do the migration checks. Let's try dropping
> > > versions to simplify things. We can bring them back if needed later.
> > 
> > What does a user facing tool do?  If I say I want one of these NICs
> > and I'm on the latest QEMU machine type, who sets all these parameters?
> 
> The machine type is orthogonal since QEMU doesn't know about every
> possible VFIO device. The device is like a PCI adapter that is added to
> a physical machine aftermarket, it's not part of the base machine's
> specs.

I think at least at the first stage, it is a smart thing to do
to have a list of allowed devices in QEMU. This way we can ask
for a spec of the migration format, include it in qemu
(or a subtree? I don't mind ...) and check it is sane.
And we can be reasonably sure we can make changes
without breaking the world - we will know whom to
contact if we change the protocol.

-- 
MST


