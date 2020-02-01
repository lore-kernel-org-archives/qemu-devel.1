Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4ABC33C9E
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 07:26:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D44FB206A2
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 07:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wh8eiArk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44FB206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixnAH-0005ZO-27
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 02:26:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ixn9Z-0004x8-Ja
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 02:25:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ixn9Y-0005yf-6z
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 02:25:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44659
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ixn9Y-0005xa-3s
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 02:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580541915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=mMNYxAV5CG/ARfV6xAKMqud7g77Jb1E5Cf2j6OXeYfE=;
 b=Wh8eiArk6hsgnw8wNj2BJk9m8kdBJtznPywWUSv+jj6jprkpT7dtF3kEB6AbDfiQXnFT6I
 EEoR0xfVBIB84vtkhr6OR+Sqeh+56RogTeDFTdvEOMvtN0NVwOG5MKpQm0FcqYKhEPNgWS
 +j9MqCcfWbsgAcsDYLJriFfY7bfe+lk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-y33cWfMFOmKILflVs6_WkQ-1; Sat, 01 Feb 2020 02:25:02 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B27F218A6EC1;
 Sat,  1 Feb 2020 07:25:00 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-33.ams2.redhat.com [10.36.116.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 62442CFC1;
 Sat,  1 Feb 2020 07:24:53 +0000 (UTC)
Subject: Re: [PATCH 2/2] tests/acceptance/integratorcp: Verify Tux is
 displayed on framebuffer
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200131211102.29612-1-f4bug@amsat.org>
 <20200131211102.29612-3-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <31738ee9-1c2f-0c30-8651-a05e01b7914d@redhat.com>
Date: Sat, 1 Feb 2020 08:24:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200131211102.29612-3-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: y33cWfMFOmKILflVs6_WkQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/01/2020 22.11, Philippe Mathieu-Daud=C3=A9 wrote:
> Add a test that verifies the Tux logo is displayed on the framebuffer.
>=20
> We simply follow the OpenCV "Template Matching with Multiple Objects"
> tutorial, replacing Lionel Messi by Tux:
> https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_matching.html

What a cool idea :-)

If you like, there are some more images with Tux in the QEMU advent
calendar 2018 which you could use for testing the framebuffer:

 https://www.qemu-advent-calendar.org/2018/download/day13.tar.xz
 https://www.qemu-advent-calendar.org/2018/download/day15.tar.xz
 https://www.qemu-advent-calendar.org/2018/download/day16.tar.xz
 https://www.qemu-advent-calendar.org/2018/download/day19.tar.xz

These two use a slightly different tux:

 https://www.qemu-advent-calendar.org/2018/download/day09.tar.xz
 https://www.qemu-advent-calendar.org/2018/download/day11.tar.xz

And day 22 (MIPS64) and 23 (SPARC64) use a framebuffer, too, but they
seem to be broken with the current version from the git master branch.

 Thomas


