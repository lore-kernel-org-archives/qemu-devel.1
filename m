Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887D1C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E778520759
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQVhUpQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E778520759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNe8d-00009Y-RA
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNe7b-0007RF-Vr
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 11:34:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNe7Z-0007zq-4m
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 11:34:23 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601480059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GaxBUhpeQWJOmbZy+nQBPpF+NHsTmA0oFPmpf8cup2I=;
 b=PQVhUpQ8+/ZpfNNBXL7GJ9jF9L4Y9ewZ3+yEtQ60bWdyv2Xu2aN9uApLWVUaBYnGjZmb83
 rm2dQpJDzlAVwXpelc8Q+K5sWOrafxksBQbIxrMy4Dwlpzm8HKFKhQvPlTU1Z/gKto6sdZ
 SBUGSBPujAW/gK3YIrNW6t7zdOVlzH8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-BmnxxYtaNa2PiKXcuhry1A-1; Wed, 30 Sep 2020 11:34:17 -0400
X-MC-Unique: BmnxxYtaNa2PiKXcuhry1A-1
Received: by mail-wm1-f69.google.com with SMTP id a7so764703wmc.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 08:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GaxBUhpeQWJOmbZy+nQBPpF+NHsTmA0oFPmpf8cup2I=;
 b=QkUdiVTUFejMxzxJE3lcf8B3s56Hw7FRrDzqZTEi0X9K6XiUdupYAjN1fxA1jKHrQr
 K0ljKsmGRIOThXCxc6zvtWE/GOTBNJuO4s2XA/N9pvm+XuRcm9nAHIzExL93bTTpZhhX
 8KYtt1CPTwIz7jdnX5V0XQLRXGL1rzKxoXcd3LNbcpGOU4GReXd9+uQfk7fmo+nbnP6R
 AJNVBGPyXf6fXVoCf3OMEAPaQtvO3BHtysPiFocd9x3TuhXJTJS27SYdtY8KWTXFxJh/
 7bdPTjeb6PtixT1Kg9vY6JSMozgaavpiEBbn4/bZIImf+/0L/aIZMmdR8Ql58kv2hCrK
 FeNg==
X-Gm-Message-State: AOAM533KsGV0ijiJW4iEz3hF2KQIw9gGW+FQyTIoDJ/TtDM/ANS2bKkw
 eh8jcW5sWjiw2dFZ3lQ4EYjVNg8NAcSeQNvG5Rl2aEWjgSqReWn0DGdODIdBNJAd8nduK3feZc0
 ysha2ZJaBxZjLSBQ=
X-Received: by 2002:adf:e6c2:: with SMTP id y2mr4016239wrm.117.1601480056737; 
 Wed, 30 Sep 2020 08:34:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvH/9Vkape21q/KMroSRDKSgTEggrTUtwkkKEAHZPZ1Ou+S5Zh2bgY7GNwFMU20Rwv/g843Q==
X-Received: by 2002:adf:e6c2:: with SMTP id y2mr4016213wrm.117.1601480056544; 
 Wed, 30 Sep 2020 08:34:16 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id e1sm3816141wrp.49.2020.09.30.08.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 08:34:15 -0700 (PDT)
Date: Wed, 30 Sep 2020 11:34:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Outline for VHOST_USER_PROTOCOL_F_VDPA
Message-ID: <20200930113129-mutt-send-email-mst@kernel.org>
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
> > Architecturally, I think we can have 3 processes:
> > 
> > 
> > VMM -- guest device emulation -- host backend
> > 
> > 
> > to me this looks like increasing our defence in depth strength,
> > as opposed to just shifting things around ...
> 
> Cool idea.
> 
> Performance will be hard because there is separation between the guest
> device emulation and the host backend.

Absolutely. As a tradeoff we could put some data path things in the backend,
e.g. for virtio it is practical to have control path in emulation layer,
data path in the backend.

-- 
MST


