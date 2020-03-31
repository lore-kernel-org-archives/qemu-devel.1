Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43210C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 18:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 105F82072E
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 18:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpXBBcLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105F82072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJLsY-0004Gi-7a
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 14:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jJLrt-0003aV-Qa
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 14:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jJLrs-0004qR-Jf
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 14:44:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25275
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jJLrs-0004q6-Go
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 14:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585680248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xokonUBEQ5L1ouRcpbM9kYcYggYrpsqE5udki7Qm/Ts=;
 b=UpXBBcLQEwBx6o7tCAlIH6hC/1NVqDghXCBV9cHqdXJZyjp1XliRyoWIINFcH8iV2/jrRq
 ZcPrq8oqV0oi+PBZwPH+UVcI4RZKyn8+GEBFO2M/Av7CbTq/MZBd2xLbui8GBEZUxBqeuo
 T4n1dQVKiXJ4CmUV0KTkKBxAi1Iee08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-ALJFarkyPT61AVxmHd6Jxw-1; Tue, 31 Mar 2020 14:44:01 -0400
X-MC-Unique: ALJFarkyPT61AVxmHd6Jxw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AB0B802593;
 Tue, 31 Mar 2020 18:44:00 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C88F196B96;
 Tue, 31 Mar 2020 18:43:57 +0000 (UTC)
Subject: Re: [PATCH v14 4/4] iotests: 287: add qcow2 compression type test
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200331174455.31792-1-dplotnikov@virtuozzo.com>
 <20200331174455.31792-5-dplotnikov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <bebbcc59-9392-9461-7976-5ab3367df3a2@redhat.com>
Date: Tue, 31 Mar 2020 13:43:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331174455.31792-5-dplotnikov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/31/20 12:44 PM, Denis Plotnikov wrote:
> The test checks fulfilling qcow2 requiriements for the compression
> type feature and zstd compression type operability.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/287     | 128 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/287.out |  43 +++++++++++++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 172 insertions(+)
>   create mode 100755 tests/qemu-iotests/287
>   create mode 100644 tests/qemu-iotests/287.out
> 

> +
> +# Check if we can run this test.
> +
> +IMGOPTS='compression_type=zstd' _make_test_img 64M | grep "Invalid parameter 'zstd'" 2>&1 1>/dev/null
> +
> +ZSTD_SUPPORTED=$?
> +
> +if (($ZSTD_SUPPORTED==0)); then

This is a bash script, so (()) works; but the bash manual documents that 
(()) is not idiomatic.  Also, what you have is rather verbose...

> +    _notrun "ZSTD is disabled"
> +fi

...I might have written:

if IMGOPTS='compression_type=zstd' _make_test_img 64M |
     grep "Invalid parameter 'zstd'"; then
     _notrun "ZSTD is disabled"
fi


> +# Test: an image can't be openned if compression type is zlib and

opened

> +#       incompatible feature compression type is set
> +echo
> +echo "=== Testing zlib with incompatible bit set  ==="
> +echo
> +
> +IMGOPTS='compression_type=zlib' _make_test_img 64M
> +$PYTHON qcow2.py "$TEST_IMG" set-feature-bit incompatible 3
> +# to make sure the bit was actually set
> +$PYTHON qcow2.py "$TEST_IMG" dump-header | grep incompatible_features
> +$QEMU_IMG info "$TEST_IMG" 2>1 1>/dev/null
> +if (($?==0)); then
> +    echo "Error: The image openned successfully. The image must not be openned"

twice more

> +fi
> +
> +# Test: an image can't be openned if compression type is NOT zlib and

and again.  Multiple spots in the file, I'll quit pointing them out.

> +#       incompatible feature compression type is UNSET
> +echo
> +echo "=== Testing zstd with incompatible bit unset  ==="

Why the double space?

> +# Test: using zstd compression, write to and read from an image
> +echo
> +echo "=== Testing reading and writing with zstd ==="
> +echo
> +
> +IMGOPTS='compression_type=zstd' _make_test_img 64M
> +$QEMU_IO -c "write -c -P 0xAC 65536 64k " "$TEST_IMG" | _filter_qemu_io

That's only one cluster.  Wouldn't it be better to write more than one, 
to prove that we handle back-to-back compressed clusters resulting from 
back-to-back inputs?

> +$QEMU_IO -c "read -P 0xAC 65536 65536 " "$TEST_IMG" | _filter_qemu_io

And if you do compress more than one cluster, you may also want to use 
different patterns over those various clusters.

> +$QEMU_IO -c "read -v 131070 8 " "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "read -v 65534 8" "$TEST_IMG" | _filter_qemu_io
> +
> +# success, all done
> +echo "*** done"

Is it also worth trying to generate an image with (pseudo-)random 
contents, and trying qemu-img convert to prove that uncompressable 
clusters are handled sanely?  Ideally, there would be a way to use a 
fixed PRNG and seed that produces a deterministic sequence that cannot 
be compressed, but even if we can't meet the ideal, having a test that 
non-deterministically is likely to generate an uncompressable cluster in 
most runs is better than nothing (such as 1M of data copied from 
/dev/urandom, then qemu-img convert on that data).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


