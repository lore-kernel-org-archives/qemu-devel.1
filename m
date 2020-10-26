Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24A6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 06:23:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 116EA22247
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 06:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHks6YDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116EA22247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWvv5-0003mz-7g
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 02:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kWvt1-0002JG-Jx
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 02:21:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kWvsy-0007am-IM
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 02:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603693297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qcLr/nZMiBndu3UWnOQrrrN0PjnEuFQq0jVWTBtdPUU=;
 b=WHks6YDCdof2vg6xF1Iumwgx9GSv9b2BuvIuy+LqoYRNqN5CQBUYOMbRJUv0XGT4yNlNmo
 kbv6rZLUKCUATH1+4De7bLP/v+5JiAVTef4cEmLiCHDFVRc95XzJCejvAs2XSC3PkeumAF
 sjtv8+sHMUZKepGxdGjSZzQIcVwdIW0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-GJZ7WtZbOgG1QAu2M7ZJ9A-1; Mon, 26 Oct 2020 02:21:35 -0400
X-MC-Unique: GJZ7WtZbOgG1QAu2M7ZJ9A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 988D01074649;
 Mon, 26 Oct 2020 06:21:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 602CF60C07;
 Mon, 26 Oct 2020 06:21:34 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 52763204A1; Mon, 26 Oct 2020 07:21:33 +0100 (CET)
Date: Mon, 26 Oct 2020 07:21:33 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH 1/2] virtio-gpu: add virtio-gpu-pci module
Message-ID: <20201026062133.xxuyx3fn34lvunxk@sirius.home.kraxel.org>
References: <20201023064618.21409-1-kraxel@redhat.com>
 <20201023064618.21409-2-kraxel@redhat.com>
 <CAJ+F1CK0A1+vOMZq55guJi9OPg1zyVyRQ_azYA7NNVg5Kx5hDA@mail.gmail.com>
 <20201023110135.lrjq5mqvma4fzavi@sirius.home.kraxel.org>
 <CAJ+F1C+8vorbx8smMzc3=iCPHCinVg__Ck57EjxBHqu_NfjCBA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+8vorbx8smMzc3=iCPHCinVg__Ck57EjxBHqu_NfjCBA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > commit 501093207eb1ed4845e0a65ee1ce7db7b9676e0b
> > Author: Gerd Hoffmann <kraxel@redhat.com>
> > Date:   Wed Sep 23 11:12:17 2020 +0200
> >
> >     module: silence errors for module_load_qom_all().
> >
> Ok, but that could hide real errors, couldn't it?

It should not.  If you explicitly ask for an module and it doesn't load
you'll get an error no matter what.  This only skips the error message
in case loading all qom modules (for '-device help' & friends) was
requested.

> What about the proposal to have a subdir per arch with symlinks?

The modules are not per-arch.  They just depend on pci or vga or usb
being present in core qemu, and some qemu-system-$arch variants don't
have that.

So -- for example -- s390x has no vga support, therefore qxl doesn't
load.  qxl wasn't available before, so nothing fundamental changed.  The
only difference is that you get an additional error message line from
the attempt to load the qxl module.

Why is this a problem?

take care,
  Gerd


