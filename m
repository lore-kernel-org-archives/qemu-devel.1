Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5219BC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210E1206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z40doS0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210E1206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKp7-0004hT-4w
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jiKcN-0000Vh-VS
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:27:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38488
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jiKcL-0004Jw-Uf
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591633640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wrE7c/xSxempv4BVDm8bQvg94KyoqhapJadcOuZS/bw=;
 b=Z40doS0uepXRxWOKYhQy0pvA+UEowSOG78vJLzLqlZARElX2xrwqBJVy3btGJ/jYO3qd/U
 eO4Ifz7sHhFRuKIjsVuDkurXTwxTSBlHjxWUs9IVhTTlWfXZ0tCuESgMm81DvzlSnpw4DY
 XLbO9vMARuNkKvF55Tn7U3SY5bikvTc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-dqIqDVx_P3-0pFXavMHSMg-1; Mon, 08 Jun 2020 12:27:18 -0400
X-MC-Unique: dqIqDVx_P3-0pFXavMHSMg-1
Received: by mail-wr1-f69.google.com with SMTP id n6so7390920wrv.6
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wrE7c/xSxempv4BVDm8bQvg94KyoqhapJadcOuZS/bw=;
 b=pO2/HQzkSTG+LYPJ/BYsOy5xqKux4Tr3t1+lDk3d2Il1UWfNwrIDicEJion7e+zxjq
 nLf6CJMA8GVwIQ43+E5G3n7zZEeoOUeTUErV9EZWwbW4OE/TJmPqsNQsKKNjf++diQ13
 I9v34OLDcLMQEXpm3YPbtrMLJl/VSW/LBwizhWtGFMKOe8RKlAmrgeVPjTzAfvDVANPu
 4CqF8nNPnE1qPjStwPPiz1eJlBJU2/qd2P0rDaMla3ild1uUrBWDggS1AQcMXxMFeKZJ
 OvBa9J1RecTOaHepGF4fbZgidEki82lvfOMPPnDn6rvoRDVK7Iua9D8XTTrv977XGsX0
 t/0w==
X-Gm-Message-State: AOAM533j1bKHGQHdZmPrGVWOYBzha0QkQG4dxZtNwOzs3enNcvhkdqFb
 dA0jKvXBX6ndc1Rr2dKaNsHfuPoKFN62loQQaEGWPOL4HBKyQnSPBsIcfhlrvhNgn4BRdGa/XO0
 MyiVWMfykGAYPVdo=
X-Received: by 2002:a1c:4c16:: with SMTP id z22mr156493wmf.17.1591633637913;
 Mon, 08 Jun 2020 09:27:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQJ/8rxmVSLrCqDr4PvuCbeKi7qysAzLeQTGzfxq11ZKtZMvEZFs9G71s+lnDk/mVpE9S3rg==
X-Received: by 2002:a1c:4c16:: with SMTP id z22mr156478wmf.17.1591633637733;
 Mon, 08 Jun 2020 09:27:17 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
 by smtp.gmail.com with ESMTPSA id
 128sm70598wme.39.2020.06.08.09.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:27:17 -0700 (PDT)
Date: Mon, 8 Jun 2020 12:27:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH v25 QEMU 0/3] virtio-balloon: add support for page poison
 and free page reporting
Message-ID: <20200608122656-mutt-send-email-mst@kernel.org>
References: <20200527041212.12700.60627.stgit@localhost.localdomain>
 <CAKgT0Ue4DU9cP7BLCBHEU+kLzZjyZTFj-MqMDranezZVZ0W4pg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKgT0Ue4DU9cP7BLCBHEU+kLzZjyZTFj-MqMDranezZVZ0W4pg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 08, 2020 at 08:37:26AM -0700, Alexander Duyck wrote:
> It's been almost 2 weeks since I submitted this. Just thought I would
> follow up and see if there is any ETA on when this might be applied,
> or if I missed the need to fix something and resubmit.
> 
> Thanks.
> 
> - Alex

Everyone seems happy with so I queued it. Thanks!


