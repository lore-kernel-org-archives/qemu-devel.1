Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7D9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:30:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B46DB206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2fp8BD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46DB206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrIy2-0006M6-18
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 06:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jrIxJ-0005qL-Au
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:30:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39497
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jrIxH-0002ei-Q9
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593772202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/xMIGW63u6Kj5b7X+ihs1IwuKkxfaGD/+Nn7yph+eCY=;
 b=V2fp8BD11EcjIYPai/VPGibgoT3bpCucpPV1URX+yWXH6etwtUWZWUhgEYZ6FpQG0Uub8U
 1VfeL1oha5BT6AAmaCyf/sSLZUjhopDNWmbhyVfGhtN88C1hzHPqCLuDWOIfdmosGeMEWz
 ItM/UBvGDozgvSe04H4KLdxSpl+A3Ts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-cc4XLhNbMIaaH6PBwYO5sg-1; Fri, 03 Jul 2020 06:30:01 -0400
X-MC-Unique: cc4XLhNbMIaaH6PBwYO5sg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D719107ACF2;
 Fri,  3 Jul 2020 10:30:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E5172DE71;
 Fri,  3 Jul 2020 10:29:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D036416E16; Fri,  3 Jul 2020 12:29:54 +0200 (CEST)
Date: Fri, 3 Jul 2020 12:29:54 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PULL 00/10] Modules 20200702 patches
Message-ID: <20200703102954.eia6qg556z7vfedp@sirius.home.kraxel.org>
References: <20200702122048.27798-1-kraxel@redhat.com>
 <81e43374-25c7-5361-0ca3-04b26c0f4826@suse.de>
MIME-Version: 1.0
In-Reply-To: <81e43374-25c7-5361-0ca3-04b26c0f4826@suse.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 03, 2020 at 11:14:27AM +0200, Claudio Fontana wrote:
> Hello Gerd,
> 
> I think in general the idea to make it easier to modularize things is great,

> is this thought for devices only, or could I rework my changes to
> support modularizing per-target AccelClass types and all the related
> code on top of your design?

It should help for any QOM object (see patch 10/10 for a chardev).

With AccelClass being per-target modules most likely we'll need
something better for 4/10 though.

take care,
  Gerd


