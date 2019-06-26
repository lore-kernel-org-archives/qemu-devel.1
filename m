Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B9FC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 00:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6043320883
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 00:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6043320883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfw8C-00074u-HZ
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 20:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51317)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Colin.Xu@intel.com>) id 1hfw78-0006Lp-1I
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 20:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Colin.Xu@intel.com>) id 1hfw77-0001S2-07
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 20:48:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:40372)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Colin.Xu@intel.com>) id 1hfw76-0000uJ-L8
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 20:48:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Jun 2019 17:48:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,418,1557212400"; d="scan'208";a="164175816"
Received: from coxu-arch-shz.sh.intel.com (HELO [10.239.160.21])
 ([10.239.160.21])
 by orsmga003.jf.intel.com with ESMTP; 25 Jun 2019 17:48:16 -0700
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, berrange@redhat.com, kraxel@redhat.com
References: <20190625032142.13854-1-colin.xu@intel.com>
 <429635c3-8775-ed6d-e45b-6803a8847b88@redhat.com>
From: Colin Xu <Colin.Xu@intel.com>
Message-ID: <8813889d-d924-dea4-5df7-05adc0c4c2bc@intel.com>
Date: Wed, 26 Jun 2019 08:48:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <429635c3-8775-ed6d-e45b-6803a8847b88@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
Subject: Re: [Qemu-devel] [PATCH] ui: Correct icon install path
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
Reply-To: Colin.Xu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019-06-25 18:43, Philippe Mathieu-Daudé wrote:
> Hi Colin,
>
> On 6/25/19 5:21 AM, Colin Xu wrote:
>> The double slash in path will fail the installation on MINGW/MSYS.
>>
>> Fixes: a8260d387638 (ui: install logo icons to $prefix/share/icons)
>>
>> Signed-off-by: Colin Xu <colin.xu@intel.com>
>> ---
>>   Makefile | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index cfb18f152544..562205be290c 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -875,19 +875,19 @@ ifneq ($(DESCS),)
>>   	done
>>   endif
>>   	for s in $(ICON_SIZES); do \
>> -		mkdir -p "$(DESTDIR)/$(qemu_icondir)/hicolor/$${s}/apps"; \
>> +		mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/$${s}/apps"; \
>>   		$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu_$${s}.png \
>> -			"$(DESTDIR)/$(qemu_icondir)/hicolor/$${s}/apps/qemu.png"; \
>> +			"$(DESTDIR)$(qemu_icondir)/hicolor/$${s}/apps/qemu.png"; \
>>   	done; \
>> -	mkdir -p "$(DESTDIR)/$(qemu_icondir)/hicolor/32x32/apps"; \
>> +	mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/32x32/apps"; \
>>   	$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu_32x32.bmp \
>> -		"$(DESTDIR)/$(qemu_icondir)/hicolor/32x32/apps/qemu.bmp"; \
>> -	mkdir -p "$(DESTDIR)/$(qemu_icondir)/hicolor/scalable/apps"; \
>> +		"$(DESTDIR)$(qemu_icondir)/hicolor/32x32/apps/qemu.bmp"; \
>> +	mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/scalable/apps"; \
>>   	$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu.svg \
>> -		"$(DESTDIR)/$(qemu_icondir)/hicolor/scalable/apps/qemu.svg"
>> -	mkdir -p "$(DESTDIR)/$(qemu_desktopdir)"
>> +		"$(DESTDIR)$(qemu_icondir)/hicolor/scalable/apps/qemu.svg"
>> +	mkdir -p "$(DESTDIR)$(qemu_desktopdir)"
>>   	$(INSTALL_DATA) $(SRC_PATH)/ui/qemu.desktop \
>> -		"$(DESTDIR)/$(qemu_desktopdir)/qemu.desktop"
>> +		"$(DESTDIR)$(qemu_desktopdir)/qemu.desktop"
>>   ifdef CONFIG_GTK
>>   	$(MAKE) -C po $@
>>   endif
>>
> I'm not sure about this. Did you test it on a POSIX system?
>
> Maybe we should escape an eventual trailing '/' in datadir and DESTDIR?

Hi Philippe,
Yes, tested. Actually the other DIR referened in the Makefile only use $(DESTDIR)$(bindir)
, $(DESTDIR)$(qemu_docdir), etc. So I guess the inconsistencie should be fixed.

Best Regards,
Colin Xu


