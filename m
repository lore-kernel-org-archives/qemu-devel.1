Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE33C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 09:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C43820674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 09:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PrJOCP27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C43820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBF6j-00040M-RS
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 05:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jBF5z-0003AX-4t
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 05:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jBF5y-0003E0-2x
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 05:53:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59926
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jBF5x-0003Cr-VF
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 05:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583747589;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kaceeGKnPnTPYN0N7hO6mHuC7f/lCUwl/ClY8BFJ/wQ=;
 b=PrJOCP279Pey8FpWE+htYoGVjD3yAy0U7uozA3FolL17nYnDV5foNpgeG+wJqcW7AfxIYA
 LVuexyLGmsHrmMSU923EKe3MP8GilLx5y74rkQMBIC6RTOJuEhKRqaCnmsrQ3C8cVUgJUw
 bZjObB9ovRyeWuXTEkV9z+2qC+meIC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-aIy12YF0P9qHe2-1Vb3jMA-1; Mon, 09 Mar 2020 05:53:01 -0400
X-MC-Unique: aIy12YF0P9qHe2-1Vb3jMA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D0A58010C7;
 Mon,  9 Mar 2020 09:53:00 +0000 (UTC)
Received: from redhat.com (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B48F1000325;
 Mon,  9 Mar 2020 09:52:57 +0000 (UTC)
Date: Mon, 9 Mar 2020 09:52:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 3/3] tests/docker: Install SASL library to extend code
 coverage on amd64
Message-ID: <20200309095254.GA3033513@redhat.com>
References: <20200307172222.14764-1-philmd@redhat.com>
 <20200307172222.14764-4-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200307172222.14764-4-philmd@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fam Zheng <fam@euphon.net>,
 =?utf-8?B?0JDQu9C10LrRgdC10Lkg0J/QsNCy0LvQvtCy?= <alexey.pawlow@gmail.com>,
 qemu-devel@nongnu.org,
 =?utf-8?B?0JzQtdGC0LvQuNGG0LrQuNC5INCu0YDQuNC5INCS0LjQutGC0L7RgNC+0LI=?=
 =?utf-8?B?0LjRhw==?= <winaes@narod.ru>, Biswapriyo Nath <nathbappai@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Mar 07, 2020 at 06:22:22PM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> Install the SASL library to build the VNC SASL auth protocol code.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/docker/dockerfiles/debian-amd64.docker | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


