Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5820C2D0EE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:51:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F082205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="No+fWyJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F082205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIwhc-00073E-KR
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 11:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jIwfg-0004gc-Be
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jIwfe-00084A-PJ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:49:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:50422)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jIwfe-00082x-K6
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585583389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nl3rvreKZ3ibQy4KkFIG6RhjLc6X2haJmssVoGcPPjU=;
 b=No+fWyJFeXxSoNzz+wPeLMBc5fIaSSPX600gE1KDBpFiO20R6sKPEQDfZqTqZ1JLgMrflr
 2Se5+NZAVt5M1sYam1S0zoiL1eE2CYyBa8HrU3LJ22NZHgnMAV2FFnCwxe+LM3WOYFI/52
 C6cVIF25nxLUyW7RU7hqVv8kzyWZoio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-zk6g-NzYMMOeOU8jSH9mWQ-1; Mon, 30 Mar 2020 11:49:46 -0400
X-MC-Unique: zk6g-NzYMMOeOU8jSH9mWQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49D9F18CA240;
 Mon, 30 Mar 2020 15:49:45 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-66.ams2.redhat.com [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A146660BE1;
 Mon, 30 Mar 2020 15:49:43 +0000 (UTC)
Date: Mon, 30 Mar 2020 17:49:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v9 05/14] iotests: add pylintrc file
Message-ID: <20200330154942.GF6139@linux.fritz.box>
References: <20200324232103.4195-1-jsnow@redhat.com>
 <20200324232103.4195-6-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200324232103.4195-6-jsnow@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: ehabkost@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 philmd@redhat.com, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 25.03.2020 um 00:20 hat John Snow geschrieben:
> This allows others to get repeatable results with pylint. If you run
> `pylint iotests.py`, you should see a 100% pass.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

I see you said "should" and not "will", but I still get two warnings:

iotests.py:405:22: W0613: Unused argument 'signum' (unused-argument)
iotests.py:405:30: W0613: Unused argument 'frame' (unused-argument)

Kevin


