Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0716C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 10:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C37C21D7A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 10:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5wAbdW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C37C21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFxon-0003If-DJ
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 06:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFxnz-0002jz-53
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 06:58:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24527
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFxnw-0001XR-69
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 06:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599649098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Eg1QqiLFgyGWwSYeg8eXa3YZksOtDe2TIFRYiTs9tQ=;
 b=U5wAbdW+lyCXpzQ/1H+M85t77dlE154NWXq33QmbwJ8MA8BbDunY9npi81GomZGaYT6Uh9
 2RxP+PZ/x2n1HPETFfJp6V887Tyva4I3bb5LMGna15yux92qpKvfDGuxeYW3mQ9UYsXhy3
 iamBstelDGPdHmzaN0SSWLmKd5e29gQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-PJSzgWLRN4u29i4PgS8XKw-1; Wed, 09 Sep 2020 06:58:15 -0400
X-MC-Unique: PJSzgWLRN4u29i4PgS8XKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36FCC1006705;
 Wed,  9 Sep 2020 10:58:14 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-82.ams2.redhat.com
 [10.36.114.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB8DD838C2;
 Wed,  9 Sep 2020 10:58:08 +0000 (UTC)
Subject: Re: [PATCH 0/5] Add support for loading SMBIOS OEM strings from a file
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
References: <20200908165438.1008942-1-berrange@redhat.com>
 <d3c345b6-c2db-ef61-2ac0-afc0f9f737c2@redhat.com>
 <20200909095035.GO1011023@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <adff2db5-1345-0c05-4c22-f9f8223c8614@redhat.com>
Date: Wed, 9 Sep 2020 12:58:07 +0200
MIME-Version: 1.0
In-Reply-To: <20200909095035.GO1011023@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.002
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/09/20 11:50, Daniel P. Berrangé wrote:
> On Wed, Sep 09, 2020 at 11:44:40AM +0200, Laszlo Ersek wrote:
>> On 09/08/20 18:54, Daniel P. Berrangé wrote:
>>> I previously added support for SMBIOS OEM strings tables but only
>>> allowed for data to be passed inline. Potential users indicated they
>>> wanted to pass some quite large data blobs which is inconvenient todo
>>> inline. Thus I'm adding support for passing the data from a file.
>>>
>>> In testing this I discovered the hard way that on x86 we're limited to
>>> using the SMBIOS 2.1 entry point currently. This has a maximum size of
>>> 0xffff, and if you exceed this all sorts of wierd behaviour happens.
>>>
>>> QEMU forces SMBIOS 2.1 on x86 because the default SeaBIOS firmware
>>> does not support SMBIOS 3.0. The EDK2 firmware supports SMBIOS 3.0 and
>>> QEMU defaults to this on the ARM virt machine type.
>>>
>>> This series adds support for checking the SMBIOS 2.1 limits to protect
>>> users from impossible to diagnose problems.
>>>
>>> There is also a fix needed to SeaBIOS which fails to check for
>>> integer overflow when it appends the type 0 table.
>>>
>>>   https://mail.coreboot.org/hyperkitty/list/seabios@seabios.org/thread/3EMIOY6YS6MG5UQN3JJJS2A3DJZOVFR6/
>>>
>>> IIUC, SMBIOS 3.0 should onlky be limited by what you can fit into RAM,
>>> but in testing, EDK2 appears to hang shortly after the SMBIOS 3.0 data
>>> size exceeds 128 KB. I've not spotted an obvious flaw in EDK2 or QEMU,
>>> nor do I attempt to enforce a limit in QEMU for SMBIOS 3.0.
> 
> snip
> 
>> So we're exceeding "__brk_limit".
>>
>> ... I'm quite getting out of my league here, but "__brk_limit" seems to
>> be controlled by "brk_reservation" in "arch/x86/kernel/vmlinux.lds.S"...
>> and ultimately through the RESERVE_BRK() macro:
>>
>> [arch/x86/include/asm/setup.h]
>>
>>> /*
>>>  * Reserve space in the brk section.  The name must be unique within
>>>  * the file, and somewhat descriptive.  The size is in bytes.  Must be
>>>  * used at file scope.
>>>  *
>>>  * (This uses a temp function to wrap the asm so we can pass it the
>>>  * size parameter; otherwise we wouldn't be able to.  We can't use a
>>>  * "section" attribute on a normal variable because it always ends up
>>>  * being @progbits, which ends up allocating space in the vmlinux
>>>  * executable.)
>>>  */
>>> #define RESERVE_BRK(name,sz)                                            \
>>
>> OK, so let's see RESERVE_BRK() invocations... The relevant match is
>> likely the one below:
>>
>>> arch/x86/kernel/setup.c:RESERVE_BRK(dmi_alloc, 65536);
>>
>> ... Then see kernel commits:
>>
>> - 6de6cb442e76 ("x86: use brk allocation for DMI", 2009-03-14)
>>
>> - 796216a57fe4 ("x86: allow extend_brk users to reserve brk space",
>> 2009-03-14)
>>
>> - e808bae2407a ("x86: Do not reserve brk for DMI if it's not going to be
>> used", 2010-02-25)
>>
>> Commit 796216a57fe4 is helpful:
>>
>>>     Add RESERVE_BRK(name, size) macro to reserve space in the brk
>>>     area.  This should be a conservative (ie, larger) estimate of
>>>     how much space might possibly be required from the brk area.
>>>     Any unused space will be freed, so there's no real downside
>>>     on making the reservation too large (within limits).
>>
>> So it seems like the 64K limit could be increased, but still
>> - it requires guest kernels to be rebuilt,
>> - it doesn't seem suitable for passing MBs of data (on x86 anyway).
> 
> Yeah, this feels like we're just venturing into a bad part of town.
> Simplest is probably to just document that applications should never
> expect more than 64kb of total SMBIOS data to be viable regardless
> of the SMBIOS entry point.

Sounds OK to me personally.

In your experience, would that limit satisfy (for example) the CoreOS /
Ignition use case?

> Given this, I'm thinking it might be overkill to even both with
> supporting SMBIOS 3.0 for x86, unless it offers some other compelling
> benefit over SMBIOS 2.1 that you know of ?

I think the 32-bit entry point is sufficient for x86.

If memory serves, we only started to care about the 64-bit entry point
for aarch64. See for example

https://github.com/tianocore/edk2/commit/ca6d61b22658

x86 always has RAM under 4GB though.

Thanks
Laszlo

Thanks
Laszlo


