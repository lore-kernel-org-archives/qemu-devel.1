Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDD7C388F9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:00:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCBEF2085B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUoMZu90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBEF2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX7jj-00040V-ML
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kX7aU-0001NU-Uf
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57429)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kX7aR-0004h5-3q
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603738278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7/Lh4jTkutGtglW4BtG+vAxEysiPodyDNiL9ZMmiGHk=;
 b=dUoMZu90TkqEhYewB5faQhPX5fNNOKQVK1eN0Udas5pMmg3V9e9aiBmkRoEwnIsYntcm7v
 FwLmUI5DCgiVd3AGGFp8+WGUY33q84uHShxOAtKwUteliYQ2+evaCVsXKHxEEyPQxvR8mT
 2ep2P9mW56fwOPdwyMIhKPrXmwMBBTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-_F7AQczCOQK562HlGefVUg-1; Mon, 26 Oct 2020 14:51:15 -0400
X-MC-Unique: _F7AQczCOQK562HlGefVUg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0DFE64080;
 Mon, 26 Oct 2020 18:51:14 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-104.ams2.redhat.com [10.36.112.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A66760C13;
 Mon, 26 Oct 2020 18:51:13 +0000 (UTC)
Subject: Re: [PATCH v2 2/9] configure: cross-compiling without cross_prefix
To: Paolo Bonzini <pbonzini@redhat.com>, Joelle van Dyne <j@getutm.app>
References: <20201019013928.72770-1-j@getutm.app>
 <20201019013928.72770-3-j@getutm.app>
 <9a68e856-cb97-bf44-eef6-52d7cbca9884@redhat.com>
 <ec63904c-f0d2-b37b-9f9f-8f2109f1335a@redhat.com>
 <1f92b68-6d6c-d125-c034-7cbe414b198e@eik.bme.hu>
 <CA+E+eSCjkYf-6GYbJUQ=gpmQHH2zAH3g1JN+-2kjy2rUnwk3fA@mail.gmail.com>
 <d27c852c-b982-9b58-fbff-1bfc3d075e94@redhat.com>
 <0a7b6404-55db-ec3f-2b56-1d695f840475@redhat.com>
 <CA+E+eSBgVCsfOC0Huo3wJuyBOyCvU+97usH_YFdUAEQsbe-S3Q@mail.gmail.com>
 <77ef9338-de8c-82a8-7ca0-f8d708f8d1da@redhat.com>
 <CA+E+eSBedWZL2hw_RKCSLn2bxomhdbTvYd9YSatX5RnGB5r-KQ@mail.gmail.com>
 <1bf42269-3373-1f7b-1741-d1357d426af4@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7bf6b1d7-413e-e992-cc55-c04cbcb31ec7@redhat.com>
Date: Mon, 26 Oct 2020 19:51:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1bf42269-3373-1f7b-1741-d1357d426af4@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/10/2020 17.15, Paolo Bonzini wrote:
> On 26/10/20 16:33, Joelle van Dyne wrote:
>> Just to be clear, you're in favor of removing the
>> --enable-cross-compile option? I can do that if others agree but I'm
>> not sure what the downside of adding this extra option is?
> 
> For me the downside is that it's not clear that --cross-prefix=foo-
> implies --enable-cross-compile.

I agree with Paolo ... two options sound rather confusing to me than just
having one option. And the amount of options of the configure script is too
big already anyway, so I'd recommend to drop --enable-cross-compile.

 Thomas


