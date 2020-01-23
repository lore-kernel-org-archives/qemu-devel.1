Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4664FC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 05:17:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E580A24125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 05:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHwWCm+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E580A24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuUrb-0002PF-0G
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 00:17:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iuUnM-0007HB-0K
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:12:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iuUnK-0008SI-OZ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:12:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23960
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iuUnK-0008Ri-LC
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579756361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=fg2jtxpN4Qksvf9/SF9bK1iVyvXX/ZUc5etQ3gY4ngQ=;
 b=HHwWCm+qKAF/Ol5Dk51RW6xn0o7uY+rS3rDFb0DZZOq7S1mWkxrYqTI/z8IK6a4peq8R7d
 egOjtfYtavrSh2wcg+bR+qL4kYETQ0Q+rhwp6Z324aYbcKeHTunsLrqeM0sA+tiSxtlNLK
 lseamBPtYTd5uFnHDgRg4UuiuVYiYZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-Xc8KB1Y5NJuxMYxL2T_Kig-1; Thu, 23 Jan 2020 00:12:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76144190B2A2;
 Thu, 23 Jan 2020 05:12:36 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FCF05C28C;
 Thu, 23 Jan 2020 05:12:34 +0000 (UTC)
Subject: Re: [PATCH rc1 00/24] target/avr merger
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200123000307.11541-1-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <bdcf69f2-a88a-6484-8321-f8b6a9977763@redhat.com>
Date: Thu, 23 Jan 2020 06:12:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200123000307.11541-1-richard.henderson@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Xc8KB1Y5NJuxMYxL2T_Kig-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: S.E.Harris@kent.ac.uk, me@xcancerberox.com.ar, dovgaluk@ispras.ru,
 imammedo@redhat.com, mrolnik@gmail.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/01/2020 01.02, Richard Henderson wrote:
> This is a merger of Michael's v41 of the base avr architecture,
> and v4 of Phil's arduino target boards.  Call this release, or
> merge, candidate 1.
> 
> Has all commentary been addressed?  How much more, if anything,
> does anyone require before allowing normal development in tree?

I just had a quick look at the series. Apart from some few nits, it
looks fine to me, so I think it's fine to merge it now.

 Thomas


