Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75ED5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A8A206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1VEQEgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A8A206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnN5D-0008U1-Ft
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 10:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jnN3o-0007NT-5q
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:04:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50032
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jnN3l-0000m6-NC
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592834667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bs0vz6JqUf4xH2IP0vle9j4+vLkvczrIR2L7a94oQhY=;
 b=W1VEQEgmGVk5q56XVeaZSq1HSR0WX6P7828yjHjFDcrxNJWO7On0Vc+w9qNfsXfo0OLmA0
 nuaQIHSdKTeagm3Bftoj/6M7AzV1vHfQDRUgdWs9c6czZTi1viAuP3qkMFp0aMj2hTHP32
 YXAf9vsZTbZV59Xcs3eMalXVRDSwm+w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-luXr9-YgPe6ayi45ymAYFA-1; Mon, 22 Jun 2020 10:04:07 -0400
X-MC-Unique: luXr9-YgPe6ayi45ymAYFA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2BDE801503;
 Mon, 22 Jun 2020 14:04:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE7BC5BAD8;
 Mon, 22 Jun 2020 14:03:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 934FA17477; Mon, 22 Jun 2020 16:03:54 +0200 (CEST)
Date: Mon, 22 Jun 2020 16:03:54 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 11/19] audio: deprecate -soundhw pcspk
Message-ID: <20200622140354.cin36ds36nwn2khu@sirius.home.kraxel.org>
References: <20200622112914.30454-1-kraxel@redhat.com>
 <20200622112914.30454-12-kraxel@redhat.com>
 <47fe0fd8-ab19-b35d-0808-d9a83201c530@redhat.com>
 <4df07eb8-0352-3976-67a2-d49a4fb482da@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4df07eb8-0352-3976-67a2-d49a4fb482da@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 libvir-list@redhat.com, qemu-devel@nongnu.org,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, qemu-ppc@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 22, 2020 at 03:22:05PM +0200, Paolo Bonzini wrote:
> On 22/06/20 14:59, Thomas Huth wrote:
> >> +static int pcspk_audio_init_soundhw(ISABus *bus)
> >> +{
> >> +    PCSpkState *s = pcspk_state;
> >> +
> >> +    warn_report("'-soundhw pcspk' is deprecated, "
> >> +                "please set a backend using '-global isa-pcspk.audiodev=<name>' instead");
> >> +    return pcspk_audio_init(s);
> >> +}
> > While "-soundhw pcspk" is quite easy to use for the average user, I
> > think the "-global" options will be quite hard to figure out, especially
> > once this deprecation message got removed again when -soundhw has been
> > deleted. Could you maybe add a description how to configure the
> > pc-speaker to docs/system/target-i386-desc.rst.inc, too?
> 
> -nic is an example of how a single option can work great for both
> built-in and custom devices, and perhaps we could design something like
> that for audio.  For example you could have
> 
> 	# configure a builtin or default audio device
> 	# and an ALSA audiodev
> 	-sound alsa
> 
> 	# configure an external audio device and a PA audiodev
> 	# options other than "model" go to audiodev
> 	-sound pa,model=sb16,fixed-settings=off
> 
> For more information: https://www.qemu.org/2018/05/31/nic-parameter/
> 
> I think we can go ahead with the deprecation, but -global and -device
> are probably not good enough a replacement for actual removal.

-global is temporary, see patch 19/19 (guess I should reorder the series
and squash 19/19 to fix that confusion).

The plan is to have audio work simliar to block.  -audiodev creates a
backend (like -blockdev).  Properties are used to reference them.
Device properties in most cases, machine properties for builtin devices
(i.e. pcspk works like pflash then).

take care,
  Gerd


