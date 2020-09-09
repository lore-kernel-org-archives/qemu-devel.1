Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7EEC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB9C207DE
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TV3ecIFt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB9C207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFxzk-0002Th-Lh
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 07:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFxys-0001i9-ED
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:09:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33320
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFxyq-00040T-Fi
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599649775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0BctuzXjG/iPYA/Qjk6qE7TaosnByqoYjgyXev2ZMC0=;
 b=TV3ecIFtaFnR58uyOaynxknTZD9HI53D38pp8LzsXva3/UluNbG0sO5Ivlr/+9fC9uM/13
 EOULMfKSVAH1CEDu0mK1v3CN7E2LUR4WCUf0esUpeDBpIIEpa5ZG88mc95ASjfAXsAjRa+
 tu4NimrDLjIC7y5+SspAgs8b9x8QMx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108--O3UC7LsOg6QdInEch68Wg-1; Wed, 09 Sep 2020 07:09:29 -0400
X-MC-Unique: -O3UC7LsOg6QdInEch68Wg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55D3485C705;
 Wed,  9 Sep 2020 11:09:28 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-82.ams2.redhat.com
 [10.36.114.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 930885C1C2;
 Wed,  9 Sep 2020 11:09:27 +0000 (UTC)
Subject: Re: [PATCH RESEND] manual: escape backslashes in "parsed-literal"
 blocks
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>
References: <20200908172111.19072-1-lersek@redhat.com>
 <3c2d2a59-b556-180d-5a74-5fe74d46ccd2@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f4289f81-1927-33a3-333b-eee552f02632@redhat.com>
Date: Wed, 9 Sep 2020 13:09:25 +0200
MIME-Version: 1.0
In-Reply-To: <3c2d2a59-b556-180d-5a74-5fe74d46ccd2@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:13:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/08/20 20:14, Philippe Mathieu-Daudé wrote:
> On 9/8/20 7:21 PM, Laszlo Ersek wrote:
>> According to
>> <https://docutils.sourceforge.io/docs/ref/rst/directives.html#parsed-literal>,
>> "inline markup is recognized and there is no protection from parsing.
>> Backslash-escapes may be necessary to prevent unintended parsing".
>>
>> The qemu(1) manual page (formatted with Sphinx 2.2.2) has several overlong
>> lines on my system. A stand-alone backslash at EOL serves as line
>> continuation in a "parsed-literal" block. Therefore, escape the
>> backslashes that we want to appear as such in the formatted documentation.
>>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> ---
>>
>> Notes:
>>     Resending with Peter's email address in the Cc: tag fixed. Sorry!
>>
>>  docs/system/device-url-syntax.rst.inc |   8 +-
>>  qemu-options.hx                       | 108 ++++++++++----------
>>  2 files changed, 58 insertions(+), 58 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 

Thanks for the quick check!
Laszlo


