Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA5DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5367720748
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjCN5GbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5367720748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gE1-000236-JW
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k7gD7-000110-Gf
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:34:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40753
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k7gD5-0005bn-RU
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597674842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8gI7uy6WFfrmbWMdH2Yt9la+IPoK6/n1z03Pd/JKyc=;
 b=IjCN5GbSrgi02wlUqtq+IL9XscTFER9NoWdPaFZcnFN6SnHI95AloRbdXWXGOeS5g9sHsc
 TOC8NK8cbJlEqTBFSUmOWqT9wgUhxXr645bwnda6GAkIg1zTjYM9Yh81X0DDJZttv0wQIu
 PVipq0bT6DkEozlqmBCHx2G5ulk9250=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-cL3DSvNoOu2qvOglvbfdBA-1; Mon, 17 Aug 2020 10:34:01 -0400
X-MC-Unique: cL3DSvNoOu2qvOglvbfdBA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38F5281F001
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 14:34:00 +0000 (UTC)
Received: from gondolin (ovpn-112-230.ams2.redhat.com [10.36.112.230])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 723135C3E1;
 Mon, 17 Aug 2020 14:33:59 +0000 (UTC)
Date: Mon, 17 Aug 2020 16:33:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 000/150] Meson integration for 5.2
Message-ID: <20200817163356.1b6e5281.cohuck@redhat.com>
In-Reply-To: <1b77c48c-108f-c603-33cf-f8d0f6b1b2b5@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
 <20200817142617.0ab2b9f3.cohuck@redhat.com>
 <1b77c48c-108f-c603-33cf-f8d0f6b1b2b5@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:03:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Aug 2020 15:57:19 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 17/08/20 14:26, Cornelia Huck wrote:
> > 
> > The bad news: The build on the s390x system with Fedora 30 (yes, I
> > know) seems to be lacking various devices. The output of
> > 'qemu-system-s390x -device ?' misses all of the
> > -transitional/-non-transitional varieties for virtio-pci devices, as
> > well as some of the vhost-user devices, and, rather bizarrely, the
> > gen15* and some of the z14 cpu models (this is on a z12, so it's not
> > that all 'newer' models are missing, and I don't think the system we
> > build on should influence the generation of models, even with an older
> > compiler). I checked the output from 'qemu-system-x86_64 -device ?',
> > and it is missing the -transitional/-non-transitional virtio-pci
> > devices as well (did not check if anything else is missing as well).  
> 
> Whoa, that's weird.  I'll take a look, thanks.

Actually, that was just a case of invoking the wrong binary... things
work just fine if I use the correct one, sorry about the noise.

> 
> Paolo
> 
> > The builds on the F31 (x86) and F32 (s390x, with -Werror disabled)
> > systems are fine.  
> 


