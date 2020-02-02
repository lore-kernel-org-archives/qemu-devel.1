Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9C4C35240
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 09:11:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7956D206D3
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 09:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="btUND1jL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7956D206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyBHg-0005mm-LL
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 04:11:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iyBGs-0005En-Mw
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 04:10:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iyBGp-0002Bi-WC
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 04:10:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57509
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iyBGo-00027e-Th
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 04:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580634621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=JDFgdSxuU1zhl3Yu3AeiBJvofocJBVNl/Rt8b0B5ks8=;
 b=btUND1jLjkNGyOvjQraIYXQxvRI5RiQnmVEEltlSs0OLyoKtexylbJAQofJ73ieA6sjIaN
 f+D1QYasZ8t/ZJRv06it6hbNjZ6TfYRXIH9zXYS/P/6T4yC7CCZWBznKjyFzE2cB4jHgYN
 bskp9ei/GWyQ8O40WMLkT9aAa+I2Mg0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-logs4XklOaiz7nUMAEoQpw-1; Sun, 02 Feb 2020 04:10:17 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D7EA1851FC1;
 Sun,  2 Feb 2020 09:10:16 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-47.ams2.redhat.com [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E036E100164D;
 Sun,  2 Feb 2020 09:10:14 +0000 (UTC)
Subject: Re: [PATCH] tests: Silent various warnings with pseries
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
References: <158059697130.1820292.7823434132030453110.stgit@bahia.lan>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b0d7c809-956d-98d9-80ce-1c633d666ec0@redhat.com>
Date: Sun, 2 Feb 2020 10:10:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <158059697130.1820292.7823434132030453110.stgit@bahia.lan>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: logs4XklOaiz7nUMAEoQpw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/02/2020 23.46, Greg Kurz wrote:
> Some default features of the pseries machine are only available with
> KVM. Warnings are printed when the pseries machine is used with another
> accelerator:
> 
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-ccf-assist=on
> qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
> Interrupts(FWNMI) not supported in TCG
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-ccf-assist=on
> qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
> Interrupts(FWNMI) not supported in TCG
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-ccf-assist=on
> qemu-system-ppc64: warning: Firmware Assisted Non-Maskable
> Interrupts(FWNMI) not supported in TCG
> 
> This is annoying for CI since it usually runs without KVM. We already
> disable features that emit similar warnings thanks to properties of the
> pseries machine, but this is open-coded in various places. Consolidate
> the set of properties in a single place. Extend it to silent the above
> warnings. And use it in the various tests that start pseries machines.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---

Reviewed-by: Thomas Huth <thuth@redhat.com>


