Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649E3C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 08:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A80820714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 08:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQHoQa+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A80820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Qvk-0007vN-8i
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 03:30:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1j1Qv5-0007K3-82
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1j1Qv4-0006vx-1p
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:29:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33164
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1j1Qv3-0006sG-UM
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581409760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=8rwBji8h9ert1ke/aOtSyfUEF8j840NogUFSSqU6jc4=;
 b=WQHoQa+VTcbir2XqyW3mbuBplgVh+qpn1n4vwC6WT6ck8lJGEHeFRsAzoStVVjQoiLxJHc
 dCVw25Cn5y5XoDdVvNQawsFjXtw+GCQB7a/UxdUma1fldzIHGwQv0kbSJR+OcpPfCDQICW
 wGRQdRc4vHk2wqvOnMjhTrF/aghjOQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-bqjXuorgMA-aZDVqmPM_Qg-1; Tue, 11 Feb 2020 03:29:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95CA61857340
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 08:29:17 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-131.ams2.redhat.com [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E31CD5DA2C;
 Tue, 11 Feb 2020 08:29:11 +0000 (UTC)
Subject: Re: [PATCH] gitlab-ci.yml: Add .gitlab-ci.d directory for GitLab
 specific files
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200211065022.11134-1-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b9f2c90f-2c2f-501f-dbf6-d14a15a3a059@redhat.com>
Date: Tue, 11 Feb 2020 09:29:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200211065022.11134-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: bqjXuorgMA-aZDVqmPM_Qg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Laszlo Ersek <lersek@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/02/2020 07.50, Philippe Mathieu-Daud=C3=A9 wrote:
> As we plan to let maintainers managing their own GitLab CI jobs,
> add a single directory to contain all the new files (to keep the
> root directory cleaner).

The title and description is a little bit confusing, since the directory
is already there and you just move the YML file into it... so I'd
suggest to rather talk about moving that file instead of adding the
directory.

With the patch description updated:
Acked-by: Thomas Huth <thuth@redhat.com>


