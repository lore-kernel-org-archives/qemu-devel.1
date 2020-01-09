Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38E4C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2AEB206ED
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yj1c6vtD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2AEB206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipXHO-0006YN-PG
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:51:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ipXFD-0003rM-6i
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ipXFC-0000wV-6E
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:48:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55055
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ipXFB-0000su-US
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578574137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=UCgSIMVNTO3EqtDd16rfvCysaLygnrRJGeCmMICs+t0=;
 b=Yj1c6vtD8XPjQA0Xg6xAzMhnX65RldsmpncpSaNRZx8Ffrfda3y0mRCtFQasydWNZIaLHq
 XbmHHJkxfd5QbixfbC/VofywpbrhIXeguWSyUk+S793U5nGFAS3YUg8jq6kmDQ2wqYM8XV
 1rQYC74bEObAkVebZ5pGsxnjDbn1HQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-qcDPQQQbME2W6BqkeuoX1Q-1; Thu, 09 Jan 2020 07:48:55 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19BA61902EA0
 for <qemu-devel@nongnu.org>; Thu,  9 Jan 2020 12:48:55 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-32.ams2.redhat.com [10.36.117.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F7365C241;
 Thu,  9 Jan 2020 12:48:54 +0000 (UTC)
Subject: Re: [PATCH] docs: stop documenting the e1000 NIC model as the default
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200109122913.3413914-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <933b100a-1ead-2f10-6540-8ba773fc81e7@redhat.com>
Date: Thu, 9 Jan 2020 13:48:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200109122913.3413914-1-berrange@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: qcDPQQQbME2W6BqkeuoX1Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/01/2020 13.29, Daniel P. Berrang=C3=A9 wrote:
> The default NIC model for QEMU varies per machine type, and is liable to
> change across machine type versions. Documenting e1000 NIC as the
> default for PC/i386 is thus misleading to users at best. In particular
> the PC q35 machine type switched to use e1000e, but only in machine
> type versions after 2.11.
>=20
> Rather than try to explain which NIC model is used for each machine
> type version, remove mention of e1000 as the default, and steer users
> towards always specifying their desired model.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qemu-options.hx | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


