Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362F9C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 21:22:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0494E222DD
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 21:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRIeQAtO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0494E222DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWoU3-0008Kp-NL
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 16:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iWoP3-00026A-T6
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:17:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iWoOz-000805-SI
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:17:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33790
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iWoOz-0007zb-Mh
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574111861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=amk6rxLyaAB8a++vwdkJvdNbx85Yp5ACkAA4d8gdI0o=;
 b=aRIeQAtOhovdOvfOl/fIgxhuod6uF/garogpv/TtIyUSiY9JmTHRlCeVL4W6Dcu0GEo+6r
 5jD+3QwJZRPMHThFEHFyM8UOsRoTfWUGSB+/YyYLf7eRGdzD1IWbNnl//EJxrZhsA2eFjM
 HcZPxTIQHTCou5NE99M3VqVQR3t015k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-FL8IEw15OPKyzANkyljneA-1; Mon, 18 Nov 2019 16:17:37 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41E1A100FE67;
 Mon, 18 Nov 2019 21:17:36 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2B121CD;
 Mon, 18 Nov 2019 21:17:29 +0000 (UTC)
Subject: Re: [PATCH-for-4.2 v3 2/3] hw/mips/gt64xxx: Remove dynamic field
 width from trace events
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191118210458.11959-1-philmd@redhat.com>
 <20191118210458.11959-3-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <43305839-1edc-715e-26b1-a767b644df09@redhat.com>
Date: Mon, 18 Nov 2019 15:17:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191118210458.11959-3-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: FL8IEw15OPKyzANkyljneA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/18/19 3:04 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Since not all trace backends support dynamic field width in
> format (dtrace via stap does not), replace by a static field
> width instead.
>=20
> We previously passed to the trace API 'width << 1' as the number
> of hex characters to display (the dynamic field width). We don't
> need this anymore. Instead, display the size of bytes accessed.
>=20
> Reported-by: Eric Blake <eblake@redhat.com>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1844817
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Fixes: ab6bff424f

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


