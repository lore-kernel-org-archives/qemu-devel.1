Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9500C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:13:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B542A20870
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vhm2mzBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B542A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrPFZ-0002Fs-02
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jrP1l-0005e3-1k
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:59:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56036
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jrP1i-0007LX-Cr
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593795540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUYk77T9Xe378bEJJNF2ZyekN7ZafAoXoY+Bm9W14N8=;
 b=Vhm2mzBmmcGLPbExCaeKIMeAm1lXZwivO32NIu5bRnrm6gljCwTSLUQCwAXN7UgLManbAB
 tJcC75+1DOvWHQE9U0aXUM4CO2PYciV43ybViQSrfH+IlE/rj0I8wDYiYQHbHLC+r50ozB
 M6OcrD1+04RT+ylFmgAqx3IHtFByIEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-fSsCxR-jOy-lwGom1qj9tQ-1; Fri, 03 Jul 2020 12:58:56 -0400
X-MC-Unique: fSsCxR-jOy-lwGom1qj9tQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3FA318FE898
 for <qemu-devel@nongnu.org>; Fri,  3 Jul 2020 16:58:52 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-238.ams2.redhat.com
 [10.36.114.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D867D709E1;
 Fri,  3 Jul 2020 16:58:45 +0000 (UTC)
Subject: Re: [RFC PATCH] MAINTAINERS: Cover the firmware JSON schema
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200703161453.8406-1-philmd@redhat.com>
 <20200703161858.GO2213227@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d3b8e3f2-c565-a38e-8af6-87fd579e9045@redhat.com>
Date: Fri, 3 Jul 2020 18:58:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200703161858.GO2213227@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kashyap Chamarthy <kchamart@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/03/20 18:18, Daniel P. Berrangé wrote:
> On Fri, Jul 03, 2020 at 06:14:53PM +0200, Philippe Mathieu-Daudé wrote:
>> Add an entry to cover firmware.json (see commit 3a0adfc9bf:
>> schema that describes the different uses and properties of
>> virtual machine firmware).
>> Cc the libvirt maintainers if it ever changes.
>>
>> Cc: Laszlo Ersek <lersek@redhat.com>
>> Cc: Daniel P. Berrange <berrange@redhat.com>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Kashyap Chamarthy <kchamart@redhat.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Suggested-by: Laszlo Ersek <lersek@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> Based on a comment from Laszlo:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg604925.html
>>
>> I don't think Laszlo should be the sole maintainer, not sure
>> who else should be listed. Gerd and Kashyap? :)
>> Can we add it 'maintained' without specific maintainer?
>> ---
>>  MAINTAINERS | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index dec252f38b..57c90201df 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2601,6 +2601,12 @@ F: include/hw/i2c/smbus_master.h
>>  F: include/hw/i2c/smbus_slave.h
>>  F: include/hw/i2c/smbus_eeprom.h
>>  
>> +Firmware schema specifications
>> +M: Laszlo Ersek <lersek@redhat.com>
>> +R: libvir-list@redhat.com
> 
> FWIW, I don't think libvirt needs to review this. Our firmware handling
> code doesn't really care what specific files exist - it just follows the
> declared logic to pick amongst whatever exists.

I request that

- Phil be listed please as another maintainer (so there are two people
that can send pull requests, if a 3rd person needs to patch this file
for whatever reason),

- Dan be listed please *at least* as an "R" person; the business logic
written up under the @Firmware element, and lots of the initial review
comments (in particular the suggestion to mention specific QEMU command
line switches in the schema), had come from him.

If Dan is willing to be an "M", then we can collapse both of my above
requests into one, and Phil wouldn't have to be listed (Dan could both
review suggested changes and submit pull requests). However, I'm raising
this only as a technical possibility; what really matters to me is that
Dan be CC'd on suggested changes, and that someone other than me can
submit PRs if necessary.

Thanks!
Laszlo


