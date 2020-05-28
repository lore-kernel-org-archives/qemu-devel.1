Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50C4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:50:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72EEE20814
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 17:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UuUiXr7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72EEE20814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeMfM-00016g-L7
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 13:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jeMem-0000bz-0I
 for qemu-devel@nongnu.org; Thu, 28 May 2020 13:49:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57675
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jeMek-0003qy-Pq
 for qemu-devel@nongnu.org; Thu, 28 May 2020 13:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590688165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c9gJY3tvU7YgpfZBy8a55Jd/r5FTXf2Rr8gGTFdkuNU=;
 b=UuUiXr7yezs60ZMlFVNDR75/S7AaiaB0nridKL9p72WJA/RVF3g8uYI199fGwCHtUgSs2t
 UqeB/AtDedNzSCz7pVDu8843Vj7yd+OXOYP21garcDg8mMDdojjDmpeYNTPyHwlDqBIkfp
 i7KsbeTWpWtxW92yJB4kyfrxU9YTNYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107--mxuYaQqPY-nS9cCiYx8nw-1; Thu, 28 May 2020 13:49:23 -0400
X-MC-Unique: -mxuYaQqPY-nS9cCiYx8nw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 422431005510;
 Thu, 28 May 2020 17:49:22 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BFA17C081;
 Thu, 28 May 2020 17:49:21 +0000 (UTC)
Subject: Re: [PULL v2 00/11] bitmaps patches for 2020-05-26
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200527213708.1783644-1-eblake@redhat.com>
 <CAFEAcA-30_q6ZtFnpocVh9PH8qroZbqem6NYSRsGRCD7dzp8Ew@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <eda79152-942a-fc2d-1859-77aea9c6d497@redhat.com>
Date: Thu, 28 May 2020 12:49:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-30_q6ZtFnpocVh9PH8qroZbqem6NYSRsGRCD7dzp8Ew@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 03:11:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 12:13 PM, Peter Maydell wrote:

>> v2: fix iotest 190 to not be as sensitive to different sparseness of
>> qcow2 file on various filesystems, such as FreeBSD (sending only the
>> changed patch)
>>
>> ----------------------------------------------------------------
>> bitmaps patches for 2020-05-26
>>
>> - fix non-blockdev migration of bitmaps when mirror job is in use
>> - add bitmap sizing to 'qemu-img measure'
>> - add 'qemu-img convert --bitmaps'
>>
> 
> Your fix for iotest 190 doesn't seem to work. Here's the new output
> (same on openbsd, freebsd, netbsd):

> -required size: SIZE
> +required size: 17170432
>   fully allocated size: 17170432
>   required size: 335806464
>   fully allocated size: 2199359062016
> 
> I think this is an issue with your sed expression:
> +$QEMU_IMG measure -O qcow2 -f raw "$TEST_IMG" |
> +    sed '/^required size:/ s/[0-9]\+/SIZE/'
> 
> BSD sed seems to strictly implement POSIX basic regexes,
> in which '+' is not handled. Compare:
> 
> $ echo "required size: 17170432" | sed '/^required size:/ s/[0-9]+/SIZE/'
> required size: 17170432
> $
> $ echo "required size: 17170432" | sed '/^required size:/ s/[0-9][0-9]*/SIZE/'
> required size: SIZE

D'oh.  v3 coming up with the long-hand more portable sed usage.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


