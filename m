Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AB2C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:40:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B04020759
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgGnev2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B04020759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNeDB-0004nT-Jg
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNe4t-0004tu-Mx
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 11:31:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNe4q-0007g0-0K
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 11:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601479891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zyOfvk8sXmJI1D/oZfvvwbFEHd5zDPcwN6td8xWbw9s=;
 b=PgGnev2uZakeqPcexcXY5Nia6QUG9ESmbiJhfiag1ft2KCtVArCMlA6C6FJHYTQB5dEOPp
 LfOGuRTfrgG9RneU8f/AEqsTJa2zxmC4rKqy82hIlgeSNDW6io8rM0pnepihEpx3Fsss2Q
 68RDOeoWrtDReeOIRfrePL2P7VBxAhY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-RqhdN9jlOA2dak381fnHeg-1; Wed, 30 Sep 2020 11:31:29 -0400
X-MC-Unique: RqhdN9jlOA2dak381fnHeg-1
Received: by mail-wm1-f69.google.com with SMTP id a25so610895wmb.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 08:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zyOfvk8sXmJI1D/oZfvvwbFEHd5zDPcwN6td8xWbw9s=;
 b=OEetIA0r82T3YMndbiZ/j3X5xbEpdbtFnxyJ/djtroEsRI3X2VK4sWFlUKau/gQVAC
 sbwJFw1mVZLNZ4UpbSPGHjnWzm69E3uXn12UHxMMZXt5lyoq4qgTKTuYUhTE5gzT8DPr
 hEcSzIYVu14lKNusX9INHLl7DlTHlMYb50gUb+4xhd0hNzUzlW3VcHw5svU0VP6JRkfe
 h8BYmGxpCr3suVXZThpjwptXilVeTIQQrWo4uQshXurVrhEqqp6ZQT9ad8y7XtLOJPoN
 iSSTPXTjsWPFODMd2zI7eEhGjgIXYKPdewHnXYpEVGuBzy/NA5DtS8cvDBGCAu2F1igX
 idcQ==
X-Gm-Message-State: AOAM532WpeqUwNDYm0EP9AX85pg4NCh9hJcQqyp7LQVamto+uxI7ikF1
 ak7FNcHeNXbhApWichzzEkwPpN1rI/70Cv/aNLRvrQ67opx5ff8s7GT2LDMgQ/Ce4IJFU2xtskY
 3Ly2zBGr/G7rcgA0=
X-Received: by 2002:adf:e8c3:: with SMTP id k3mr3854360wrn.228.1601479887185; 
 Wed, 30 Sep 2020 08:31:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHndTEGfX49EZmnlZu+6q9vVkU3dCesd8WxSoWCU0S2tPGZAzOSw0GXV8L5uHAsjbxwrxLlg==
X-Received: by 2002:adf:e8c3:: with SMTP id k3mr3854339wrn.228.1601479887031; 
 Wed, 30 Sep 2020 08:31:27 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id d6sm3763159wrq.67.2020.09.30.08.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 08:31:25 -0700 (PDT)
Date: Wed, 30 Sep 2020 11:31:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Outline for VHOST_USER_PROTOCOL_F_VDPA
Message-ID: <20200930112918-mutt-send-email-mst@kernel.org>
References: <20200928092537.GA44353@stefanha-x1.localdomain>
 <20200929020114-mutt-send-email-mst@kernel.org>
 <20200929085751.GA181609@stefanha-x1.localdomain>
 <20200929055110-mutt-send-email-mst@kernel.org>
 <20200929183824.GC191675@stefanha-x1.localdomain>
 <20200930034807-mutt-send-email-mst@kernel.org>
 <20200930145752.GB320669@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200930145752.GB320669@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: lulu@redhat.com, tiwei.bie@intel.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, raphael.norwitz@nutanix.com, maxime.coquelin@redhat.com,
 kraxel@redhat.com, Felipe Franciosi <felipe@nutanix.com>,
 marcandre.lureau@redhat.com, Nikos Dragazis <ndragazis@arrikto.com>,
 changpeng.liu@intel.com, Daniele Buono <dbuono@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 30, 2020 at 03:57:52PM +0100, Stefan Hajnoczi wrote:
> IMO "Inflight I/O tracking" is best placed into libvhost-user instead of
> the vhost-user protocol.

Oh I agree qemu does nothing with it. The reason we have it defined in
the spec is to facilitate compatibility across backends.
I have zero confidence in backend developers being able to support
e.g. cross-version migration consistently, and lots of backends
do not use libvhost-user.


