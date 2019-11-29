Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FCFC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE22208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqfTzxz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE22208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaeeX-00057x-A5
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 06:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iaeEE-0002uV-4c
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:14:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iae8Z-0004TA-Po
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:08:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59635
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iae8X-0004Ma-Rv
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575025713;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LxSef1PAAW03qzn4WbldbjIXYhIratEIt61sjrr2+js=;
 b=gqfTzxz0KHzJinkHEN42me6qNPIf4w9NXJdtL3VlMIeGLf8K1mnSRGOnSMxC26bUogPFie
 /fkFrxoaoVPuXlIHJjkHmZYVMK1i4hs0ZB9IM9NEYeXgYx9+5eAdOM6hAgsfOuPAzCC+xp
 PPOSqCYb7BBELRB8zQGyDaQNr3nHKRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-1Y0-HZuvPhi-pW21l3rAJg-1; Fri, 29 Nov 2019 06:08:29 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41480107ACC4;
 Fri, 29 Nov 2019 11:08:28 +0000 (UTC)
Received: from redhat.com (ovpn-112-31.ams2.redhat.com [10.36.112.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2266010013A7;
 Fri, 29 Nov 2019 11:08:22 +0000 (UTC)
Date: Fri, 29 Nov 2019 11:08:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 00/15] s390x: Protected Virtualization support
Message-ID: <20191129110820.GF2260471@redhat.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20191120114334.2287-1-frankja@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 1Y0-HZuvPhi-pW21l3rAJg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 06:43:19AM -0500, Janosch Frank wrote:
> Most of the QEMU changes for PV are related to the new IPL type with
> subcodes 8 - 10 and the execution of the necessary Ultravisor calls to
> IPL secure guests. Note that we can only boot into secure mode from
> normal mode, i.e. stfle 161 is not active in secure mode.
>=20
> The other changes related to data gathering for emulation and
> disabling addressing checks in secure mode, as well as CPU resets.
>=20
> While working on this I sprinkled in some cleanups, as we sometimes
> significantly increase line count of some functions and they got
> unreadable.

Can you give some guidance on how management applications including
libvirt & layers above (oVirt, OpenStack, etc) would/should use this
feature ?  What new command line / monitor calls are needed, and
what feature restrictions are there on its use ?

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


