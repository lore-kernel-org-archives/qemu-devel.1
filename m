Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A6FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D2E8206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DX+ctkby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2E8206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZCtQ-0000vy-IC
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 08:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZCsp-0000Pk-5w
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:22:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25882
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZCsn-00039q-TM
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589458956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x0rsh90ZzB8LPOPrDVxCYb2x4X2SOlXQjkQ/OssCXJs=;
 b=DX+ctkbynkPf8TGtCf0juDahnVvOUJyoZNctm4BdVeelpDxodVIlVRdy1Fs2Cwzr5QJz8J
 7xEn9bLB6UhJ15KKECK3kzzDEUeP9oXK3Ff2NtbALkmMNqSl4iGbV9RXxzCjjneUQNfaWh
 xKbseDhnB2wWE66pGPJrpDlqKgll5OA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-Av6Tl4yaMXGtdBP6dUWAAQ-1; Thu, 14 May 2020 08:22:32 -0400
X-MC-Unique: Av6Tl4yaMXGtdBP6dUWAAQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20FFB800053;
 Thu, 14 May 2020 12:22:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com
 [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD8595D9E8;
 Thu, 14 May 2020 12:22:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B001A17444; Thu, 14 May 2020 14:22:23 +0200 (CEST)
Date: Thu, 14 May 2020 14:22:23 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Paul Zimmerman <pauldzim@gmail.com>
Subject: Re: [PATCH v5 0/7] dwc-hsotg (aka dwc2) USB host controller emulation
Message-ID: <20200514122223.hyffhhvjkearqgao@sirius.home.kraxel.org>
References: <20200512064900.28554-1-pauldzim@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200512064900.28554-1-pauldzim@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 11, 2020 at 11:48:53PM -0700, Paul Zimmerman wrote:
> Gerd, Peter, what do you think about accepting this patch series? The
> only possibly disruptive patch is #5, which modifies the dev-storage.c
> code a bit, the rest is all new code which shouldn't affect anything
> else. Felippe Mathieu-Daudé has done quite a bit of review of the
> patches, and has said he thinks it could be accepted now.

Looks all sane and passes basic tests, good.

Will send pull req with this series (no other usb bits pending atm)
in a moment.

thanks,
  Gerd


