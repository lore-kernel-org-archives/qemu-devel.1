Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D2DC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:28:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D672074D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VySroB7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D672074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFcjT-0002Re-8b
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 08:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFcWi-0007hT-Al
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:15:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31843
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFcWf-00066z-W5
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599567301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LHXnECLpQUPbq4VZeLei9kmTCX7j6fAgBS9JcREl62g=;
 b=VySroB7uEXnrDst5xZYiUGyvC+e5fNdxc3H9NMRA0xWq7fzTSjtgUNxb1UoLrPCMew7s1+
 nCaVg9vtaB0J/bO46Y4c5QVNF21VbIFoht+NoWvXLFqXZFDAQxvETerHf4tGUkH5+lon4A
 xlGwkHmU6YVoDJpuPiYofxtPN4a7TRw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-8EU8RR1GMfGR393hwzVXxw-1; Tue, 08 Sep 2020 08:14:57 -0400
X-MC-Unique: 8EU8RR1GMfGR393hwzVXxw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB3D4AF200
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 12:14:56 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-122.ams2.redhat.com
 [10.36.112.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD37B838A6;
 Tue,  8 Sep 2020 12:14:52 +0000 (UTC)
Subject: Re: [PATCH 10/10] tests: acpi: update "virt/SSDT.memhp" for
 edk2-stable202008
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>
References: <20200908072939.30178-1-lersek@redhat.com>
 <20200908072939.30178-11-lersek@redhat.com>
 <843298f0-049f-b67d-8497-39bd2f00ab11@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <7db07be3-23d2-2fb4-e96a-ff60b106e0ae@redhat.com>
Date: Tue, 8 Sep 2020 14:14:51 +0200
MIME-Version: 1.0
In-Reply-To: <843298f0-049f-b67d-8497-39bd2f00ab11@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 01:08:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/08/20 10:27, Philippe Mathieu-Daudé wrote:
> On 9/8/20 9:29 AM, Laszlo Ersek wrote:
>> The NVDIMM_ACPI_MEM_ADDR dword in "virt/SSDT.memhp" needs an update due to
>> the firmware now allocating NVDIMM_DSM_MEM_FILE at a lower address.
>>
>>>          }
>>>      }
>>>
>>> -    Name (MEMA, 0x43DD0000)
>>> +    Name (MEMA, 0x43D10000)
>>>  }
>>>
>
> What about also adding (with adapted SHA1):
>
> This reverts commit 120219eef8a ('tests: acpi: tolerate
> "virt/SSDT.memhp" mismatch temporarily').

It's not a revert. The payload for this commit was generated in
accordance with the instructions in "tests/qtest/bios-tables-test.c",
namely:

>  * 5. From build directory, run:
>  *      $(SRC_PATH)/tests/data/acpi/rebuild-expected-aml.sh
>  * 6. Now commit any changes to the expected binary, include diff from step 4
>  *    in commit log.

In particular, "rebuild-expected-aml.sh" empties
"bios-tables-test-allowed-diff.h" automatically (I didn't have to modify
it manually).

Plus the commit contains the actual binary blob update (which is not a
revert either).

See also a similar patch from Igor (please note the
"bios-tables-test-allowed-diff.h" hunk in it, and the fact that the
commit message does not mention a "revert"):

  [PATCH v5 10/10] tests: acpi: update acpi blobs with new AML
  http://mid.mail-archive.com/20200907112348.530921-11-imammedo@redhat.com

Thanks!
Laszlo

>
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Ref: https://bugs.launchpad.net/qemu/+bug/1852196
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> ---
>>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>>  tests/data/acpi/virt/SSDT.memhp             | Bin 736 -> 736 bytes
>>  2 files changed, 1 deletion(-)
>>
>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
>> index e569098abddc..dfb8523c8bf4 100644
>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>> @@ -1,2 +1 @@
>>  /* List of comma-separated changed AML files to ignore */
>> -"tests/data/acpi/virt/SSDT.memhp",
>> diff --git a/tests/data/acpi/virt/SSDT.memhp b/tests/data/acpi/virt/SSDT.memhp
>> index db61d6733284..375d7b6fc85a 100644
>> Binary files a/tests/data/acpi/virt/SSDT.memhp and b/tests/data/acpi/virt/SSDT.memhp differ
>>
>


