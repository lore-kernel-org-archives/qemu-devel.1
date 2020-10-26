Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF83C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 06:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B7120735
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 06:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqKf2Psf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B7120735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWviJ-0007uF-Bz
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 02:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWvhb-0007LS-Ad
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 02:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54130)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWvhY-0003Lg-NX
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 02:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603692589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nsbe/MtMsvpi/qkKYhccEqCst1XMdP9JEfH6yeQ1/90=;
 b=QqKf2Psf77sl+cjMHZUC/aDXqN0m5h1XJ39bYBdpOBYMl6hQQ06lLZ4cwaKI1yaqubmBkp
 4gmalrs9OTUuYlgn7ZTiYIXEU6UW2tUnzSuJqxKhVVQPX9VrZK+vX2TY5OAHEk9b8H/rz9
 0BEyXt98AbvaZqbRkwcFSXaRHANGxt0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-QBwcHQvYOhiVvYG_1-xhAQ-1; Mon, 26 Oct 2020 02:09:45 -0400
X-MC-Unique: QBwcHQvYOhiVvYG_1-xhAQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85BBB804B74;
 Mon, 26 Oct 2020 06:09:43 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-104.ams2.redhat.com [10.36.112.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9F1E5D9CD;
 Mon, 26 Oct 2020 06:09:37 +0000 (UTC)
Subject: Re: [PATCH 4/6] tests/acceptance: Introduce tesseract_ocr() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201021105035.2477784-1-f4bug@amsat.org>
 <20201021105035.2477784-5-f4bug@amsat.org>
 <0b31c367-f054-ce03-c1f8-d6fb6cbffc28@redhat.com>
 <3cd8bd76-2115-1317-f852-fb1ffdde544a@redhat.com>
 <87b084e3-8e6e-359d-784d-2f1353522f98@amsat.org>
 <82f65042-abd3-36e0-b384-99dd87298163@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ff6d5b0a-fd01-1f10-a03c-482f0009b030@redhat.com>
Date: Mon, 26 Oct 2020 07:09:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <82f65042-abd3-36e0-b384-99dd87298163@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Cleber Rosa <crosa@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/10/2020 19.40, Philippe Mathieu-Daudé wrote:
> On 10/24/20 9:37 AM, Philippe Mathieu-Daudé wrote:
>> On 10/24/20 8:40 AM, Thomas Huth wrote:
>>> On 24/10/2020 08.35, Thomas Huth wrote:
>>>> On 21/10/2020 12.50, Philippe Mathieu-Daudé wrote:
>>>>> We are going to reuse the tesseract OCR code.
>>>>> Create a new tesseract_ocr() helper and use it.
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>>> ---
>>>>>   tests/acceptance/machine_m68k_nextcube.py | 21 +++++----------------
>>>>>   tests/acceptance/tesseract_utils.py       | 18 ++++++++++++++++++
>>>>>   2 files changed, 23 insertions(+), 16 deletions(-)
> ...
> 
>>>>
>>>> Would it make sense to completely hide the tesseract version handling in
>>>> this new tesseract_utils.py file now, so that the tests themselves do not
>>>> have to worry about this anymore
> 
> The problem is the recognized strings differ between versions,
> see in tests/acceptance/machine_m68k_nextcube.py:
> 
>         lines = tesseract_ocr(screenshot_path, tesseract_version=3)
>         text = '\n'.join(lines)
>         self.assertIn('Backplane', text)
>         self.assertIn('Ethernet address', text)
> 
> and:
> 
>         lines = tesseract_ocr(screenshot_path, tesseract_version=4)
>         text = '\n'.join(lines)
>         self.assertIn('Testing the FPU, SCC', text)
>         self.assertIn('System test failed. Error code', text)
>         self.assertIn('Boot command', text)
>         self.assertIn('Next>', text)

Ah, right, I forgot about that ... well, one more reason to completely
switch to tesseract v4 now ;-)

 Thomas


