Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63460C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29CAB207CD
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgq8rRkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CAB207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyCbm-0001Ac-En
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 07:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jyCbB-0000iM-PG
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:07:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34985
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jyCb6-0005fX-Ay
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595416059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rksh30iv9+EPbcT4t79rxqr8BOhB+IxAHwI5Eolj0+I=;
 b=bgq8rRkXfhqWTIucEx1uBJsg4AFA0SvFibu3HQqoaxip6Z4toJUOzZ/Vnez7jY6UyUxlfI
 mpQwNYEr+GOR59oBP8BEXSJJJWffYrQaGHhfcLzTwKHlClorwvQWz9f+dBe5r9ehgXq3ab
 V84ZTm6ecfC1uL/OIxhHfqLVRbNxO9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-22IRLiXQPyOxFJl2f_DsxA-1; Wed, 22 Jul 2020 07:07:37 -0400
X-MC-Unique: 22IRLiXQPyOxFJl2f_DsxA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9913C107B835
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 11:07:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0618F78551;
 Wed, 22 Jul 2020 11:07:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1F1909D9F; Wed, 22 Jul 2020 13:07:28 +0200 (CEST)
Date: Wed, 22 Jul 2020 13:07:28 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH v5 02/10] object: qom module support
Message-ID: <20200722110728.f6qn4yv4bqtmhais@sirius.home.kraxel.org>
References: <20200624131045.14512-1-kraxel@redhat.com>
 <20200624131045.14512-3-kraxel@redhat.com>
 <lyzh7sgehp.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <lyzh7sgehp.fsf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:34:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > +ObjectClass *module_object_class_by_name(const char *typename)
> 
> Re-reading this, it occurred to me that typename is a keyword in C++.
> 
> I don't know if we want to make it a rule to not use C++ keywords just in
> case we would some day compile that code with a C++ compiler.

If we want do this we have to touch lots of places anyway, using
typename as variable is pretty common in qom code ...

take care,
  Gerd


