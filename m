Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C963AC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:05:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7BC206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Acidc4Un"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7BC206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnPp-00080q-6s
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLnIS-0008Mm-9Q
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:57:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32317)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLnIQ-000285-Df
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:57:55 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601038672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rNnRDlCPsy0xs6fWk2OqilkmRbxr7xpgVihwaFgoOP0=;
 b=Acidc4UncceomjaxNDvEnJzWJ4bvH2YvgxX3UBnmcqkqtfMora0jajnjSwaTuaSOeRXZEe
 pWZDT74RinJalJZcBXCzGpzc303nFHanOwrrxud7A1yhn/VAQjCrPb5zXCmd4gkilcAaLV
 PpMO436jLwxGqVIfdSkCjcaaNchiWW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-1Wuh-dxUND2Mg3aTh-RldQ-1; Fri, 25 Sep 2020 08:57:48 -0400
X-MC-Unique: 1Wuh-dxUND2Mg3aTh-RldQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A03C4805EE4;
 Fri, 25 Sep 2020 12:57:46 +0000 (UTC)
Received: from [10.3.114.148] (ovpn-114-148.phx2.redhat.com [10.3.114.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A67578810;
 Fri, 25 Sep 2020 12:57:42 +0000 (UTC)
Subject: Re: [PATCH v9 0/7] coroutines: generate wrapper code
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <160097957795.12744.8809653264339815766@66eaa9a8a123>
 <92b92954-201f-ae95-89db-7de650cd9a0b@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a6d7a44c-1739-ee32-ddb8-14d5c8e7bcb0@redhat.com>
Date: Fri, 25 Sep 2020 07:57:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <92b92954-201f-ae95-89db-7de650cd9a0b@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 3:04 AM, Vladimir Sementsov-Ogievskiy wrote:
> 24.09.2020 23:32, no-reply@patchew.org wrote:
>> Patchew URL: 
>> https://patchew.org/QEMU/20200924185414.28642-1-vsementsov@virtuozzo.com/
>>

>> Program python3 found: YES (/usr/bin/python3)
>> Configuring ninjatool using configuration
>> ---
>>      return codecs.ascii_decode(input, self.errors)[0]
>> UnicodeDecodeError: 'ascii' codec can't decode byte 0xe2 in position 
>> 11406: ordinal not in range(128)

> Generating 'libqemu-aarch64-softmmu.fa.p/decode-vfp.c.inc'.
> Traceback (most recent call last):
>    File 
> "/tmp/qemu-test/src/block/../scripts/block-coroutine-wrapper.py", line 
> 187, in <module>
>      f_out.write(gen_wrappers(f_in.read()))
>    File "/usr/lib64/python3.6/encodings/ascii.py", line 26, in decode
>      return codecs.ascii_decode(input, self.errors)[0]
> UnicodeDecodeError: 'ascii' codec can't decode byte 0xe2 in position 
> 11406: ordinal not in range(128)
> 
> 
> Interesting:
> 
> [root@kvm up-coroutine-wrapper]# grep --color='auto' -P -n 
> '[^\x00-\x7F]' include/block/block.h
> 307:     * Child from which to read all data that isn’t allocated in the
>                                                       ^
> 
> The file really contains one non-ascii symbol. I think it worth a 
> separate patch. Still, it shouldn't break build process. On my system it 
> works as is, probably unicode is default for me.

Python 3 has had an interesting history when it comes to 8-bit cleanness 
by default.  Which means we DO have to be explicit about utf8.

> 
> Aha, from "open" specification:
> 
>     if encoding is not specified the encoding used is platform 
> dependent: locale.getpreferredencoding(False) is called to get the 
> current locale encoding.
> 
> 
> 
> Is it ok, that utf-8 is not default on test system?

It's intentional.

> 
> So, possible solutions are:
> 
> 1. Enforce utf-8 io in scripts/block-coroutine-wrapper.py (patch 4)

Yes, we should do that regardless (we do it in our other python scripts).

> 2. Drop non-ascii quotation mark from block.h

Yes, we should do that as well (it's only in a comment, but it is 
inconsistent).

> 3. Fix the test system default to be utf-8

No.  That one we want to keep where it is, because it helps us flush out 
these sorts of issues.

> 
> Do we want them all?
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


