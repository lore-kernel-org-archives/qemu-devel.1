Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D5BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAEAC20732
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtkyER/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAEAC20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnMfG-0005IT-Ua
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 09:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jnMeZ-0004mI-BP
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:38:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23948
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jnMeW-0004ad-QT
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592833103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o7m0bKlnhb1HmGN3wCRIRlfMoXPCDwitEJcoJLc0LUs=;
 b=dtkyER/8SR/sRVWBWTyUsx7K5MN+a8Gl+TZ5/q09QjLlqfiLdLr6OFfzHZyrjwNYxcqgV4
 Gww2ZNMl8QDrtIlzZucNcFePkOhwbCPyUcHtYvNTPoQZyWK6Wfwj6DbsfbKOodpVldSXXR
 wYFy4pPVKMMo6H7Ae27jNypq2ZGy/J4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-HVMZ563SNEGQmGIeLiO1Rg-1; Mon, 22 Jun 2020 09:38:21 -0400
X-MC-Unique: HVMZ563SNEGQmGIeLiO1Rg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 373F3872FE0;
 Mon, 22 Jun 2020 13:38:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64D405BAEA;
 Mon, 22 Jun 2020 13:38:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5535417477; Mon, 22 Jun 2020 15:38:13 +0200 (CEST)
Date: Mon, 22 Jun 2020 15:38:13 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 11/19] audio: deprecate -soundhw pcspk
Message-ID: <20200622133813.tzez36fdvgp54jzg@sirius.home.kraxel.org>
References: <20200622112914.30454-1-kraxel@redhat.com>
 <20200622112914.30454-12-kraxel@redhat.com>
 <47fe0fd8-ab19-b35d-0808-d9a83201c530@redhat.com>
MIME-Version: 1.0
In-Reply-To: <47fe0fd8-ab19-b35d-0808-d9a83201c530@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: qemu-ppc@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 libvir-list@redhat.com, qemu-devel@nongnu.org,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 22, 2020 at 02:59:10PM +0200, Thomas Huth wrote:
> On 22/06/2020 13.29, Gerd Hoffmann wrote:
> > Add deprecation message to the audio init function.
> > 
> > Factor out audio initialization and call that from
> > both audio init and realize, so setting audiodev via
> > -global is enough to properly initialize pcspk.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  hw/audio/pcspk.c | 24 +++++++++++++++++++++---
> >  1 file changed, 21 insertions(+), 3 deletions(-)
> [...]
> > +static int pcspk_audio_init_soundhw(ISABus *bus)
> > +{
> > +    PCSpkState *s = pcspk_state;
> > +
> > +    warn_report("'-soundhw pcspk' is deprecated, "
> > +                "please set a backend using '-global isa-pcspk.audiodev=<name>' instead");
> > +    return pcspk_audio_init(s);
> > +}
> 
> While "-soundhw pcspk" is quite easy to use for the average user, I
> think the "-global" options will be quite hard to figure out, especially
> once this deprecation message got removed again when -soundhw has been
> deleted.

See also patch 19/19.

> Could you maybe add a description how to configure the
> pc-speaker to docs/system/target-i386-desc.rst.inc, too?

Makes sense indeed.

take care,
  Gerd


