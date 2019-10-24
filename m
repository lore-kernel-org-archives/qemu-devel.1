Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E574CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D7DC20679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpLbaYlu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D7DC20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbT1-0008LQ-KC
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iNZqU-000825-HF
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:55:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iNZqT-0007DY-0V
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:55:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53937
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iNZpj-0006j2-FO
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571910906;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ipL+a8nv7TsJveOMGJRYhqKbPaCkqKk5prdys7g//og=;
 b=MpLbaYlujgX2xlD/MbpnhwWUyZ2CGmoCKh7jM5SRdc0CfHshzHhKzXY3MhUeuY6gMfcjhU
 rfnHHG1dBMmC8vlq0DCteiPf5w2vJvoCMwDAyWqM1AoV33S/0a5YmVJaPUYyLPwkGIka/y
 ffH++P7fG0TtCBacs79Yxt6VJNVsVV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-r7f80xdyNMm27t41ooYJjg-1; Thu, 24 Oct 2019 05:55:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39DA9476;
 Thu, 24 Oct 2019 09:55:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D1B0B5D6D0;
 Thu, 24 Oct 2019 09:54:59 +0000 (UTC)
Date: Thu, 24 Oct 2019 10:54:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v13 01/12] util/cutils: Add qemu_strtotime_ps()
Message-ID: <20191024095457.GD3700@redhat.com>
References: <20191020111125.27659-1-tao3.xu@intel.com>
 <20191020111125.27659-2-tao3.xu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20191020111125.27659-2-tao3.xu@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: r7f80xdyNMm27t41ooYJjg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: ehabkost@redhat.com, jingqi.liu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 20, 2019 at 07:11:14PM +0800, Tao Xu wrote:
> To convert strings with time suffixes to numbers, support time unit are
> "ps" for picosecond, "ns" for nanosecond, "us" for microsecond, "ms"
> for millisecond or "s" for second.
>=20
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>=20
> No changes in v13.
> ---
>  include/qemu/cutils.h |  1 +
>  util/cutils.c         | 82 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+)

This really ought to have an addition to the unit tests to validating
the parsing, both success and error scenarios, so that we're clear on
exactly what strings are accepted & rejected.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


