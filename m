Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C955C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4F4F221FB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KMzVozKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F4F221FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxtz-0003pN-Kc
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxZB-0001aQ-6e
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:45:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56015)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxZ1-0001jO-Pv
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604414734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9XHS5xw+S8Xnjo9m6UNFvWbrLnAokWia4b9a4Mpzrm8=;
 b=KMzVozKjsvmzjnfpXs7vIZePNhgQN7OWwneS4W++MIOMQvVChwbja8FfTNYQ+y4NStL1lJ
 hsKIl/cNvpDOmbbXRdGLVnvRv6MFfDwXQox/DUThHdOAgHQ5Ntiqu3DVyQMVcn1UnsB07L
 5wQNbutXsEcuutIGYLMnv9oxmpHckKI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-2P21BnpmPZ2OXhx1BS71lw-1; Tue, 03 Nov 2020 09:45:32 -0500
X-MC-Unique: 2P21BnpmPZ2OXhx1BS71lw-1
Received: by mail-wr1-f71.google.com with SMTP id h11so4945112wrq.20
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:45:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9XHS5xw+S8Xnjo9m6UNFvWbrLnAokWia4b9a4Mpzrm8=;
 b=acZ977UXttN2TFYFHNn6Mk7oI6vcwE/0DgH3wFyFN6mWoz0zrvUoy+4THKZCO6rlnT
 0Lx9ZeDwSA4z2XasqG3rBDNZB8JjUZfammFUyxbfxihX+QwBWdM7hEkUFwNQlbCzpEWc
 XFwMGZLkIpUDPPLv34S4TxEcjPRhGlTJ7g3D2wICVuJTNDzqoF5tXhii6oSATNwjuECW
 eFg7U7PooFURMU6lNqFnDRRwPNI+7+YkOo3xgp7A94ix1ReJyhzraYIPVnp+Gv+xSDhu
 lQhYVeUTI0KaKWPbgIoD/sHwLHv+AlLUiadXF0cdgcYlBEl0DCmUYU+cojBl6v9N2fJ+
 UFfg==
X-Gm-Message-State: AOAM531JyHLbOy0l9FK8+m/jJHl+yl/0lGSHxBZnl41yhlhiuliWhQcN
 /WzV4U8TFC7rQOV9L6dATLLT5u6MXo0AxHKJGg3PyMEGAu1t7fRW88t9uvCdzCZ4m7u8Rt34EEo
 NQ3u9L85XvMAxoMs=
X-Received: by 2002:a1c:b487:: with SMTP id d129mr134339wmf.38.1604414731083; 
 Tue, 03 Nov 2020 06:45:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+rxsNDy8qqsiNEoaFXx0DuKEL0Nz79Sn4cp8vCwjK+bF/Sjuwrx+TWZJgW9Yw+WBtIz/7Ag==
X-Received: by 2002:a1c:b487:: with SMTP id d129mr134326wmf.38.1604414730952; 
 Tue, 03 Nov 2020 06:45:30 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id r10sm3210255wmg.16.2020.11.03.06.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 06:45:29 -0800 (PST)
Date: Tue, 3 Nov 2020 09:45:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] Revert "vhost-blk: set features before setting inflight
 feature"
Message-ID: <20201103094509-mutt-send-email-mst@kernel.org>
References: <20201102165709.232180-1-stefanha@redhat.com>
 <DM6PR11MB37234EA5646AF3693B66E7C180110@DM6PR11MB3723.namprd11.prod.outlook.com>
 <20201103144130.GA253848@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201103144130.GA253848@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "Yu, Jin" <jin.yu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 03, 2020 at 02:41:30PM +0000, Stefan Hajnoczi wrote:
> On Tue, Nov 03, 2020 at 05:11:18AM +0000, Yu, Jin wrote:
> > 	I have sent a version 2 and it should fix this issue.
> 
> Great, thanks! Michael can review and consider it for merge instead of
> this patch.
> 
> Stefan

It's not instead, it's on top of your revert.

-- 
MST


