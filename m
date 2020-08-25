Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFC1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:01:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239A320665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6pmeX4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239A320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAZVg-0006M0-Er
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kAZTu-00054U-Sw
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 09:59:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31767)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kAZTt-0000d3-6Z
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 09:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598363960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y6MUJ6ud3xrDZ5A3pgl4aBIhU9eONfJ48zxSl85lgyU=;
 b=f6pmeX4TDFFk5JwbyquVFBGDNo2tGmdmVv7Ey7Gwi1qijCqIeHx+C0I58t26gDrFCccLJ2
 Gzq5Bh6+ysr39uqEjS27I4z58UYjNk9l08rVz1mXWZOjEmWsG3WkIzl+szr2fkbRyOokvH
 Iok0025KvibEO1KPSThkfWtPZytT9DA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-JyNz-llbMdiy7nSbNGxslQ-1; Tue, 25 Aug 2020 09:59:03 -0400
X-MC-Unique: JyNz-llbMdiy7nSbNGxslQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF0CD640C3;
 Tue, 25 Aug 2020 13:59:02 +0000 (UTC)
Received: from [10.3.112.126] (ovpn-112-126.phx2.redhat.com [10.3.112.126])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69E4D5DEB3;
 Tue, 25 Aug 2020 13:59:02 +0000 (UTC)
Subject: Re: [PATCH 4/5] meson: !/bin/sh are msys2 friendly.
To: luoyonggang@gmail.com, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20200825083500.359-1-luoyonggang@gmail.com>
 <20200825083500.359-4-luoyonggang@gmail.com>
 <20200825085949.GC107278@redhat.com>
 <CAE2XoE_jgZg8wjKZ5J5gPaR5VLORosJDv3+kr=re+LHqzbNoVg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <146febe9-64ae-96de-e2df-4a65a320de9b@redhat.com>
Date: Tue, 25 Aug 2020 08:59:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_jgZg8wjKZ5J5gPaR5VLORosJDv3+kr=re+LHqzbNoVg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.602, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/25/20 4:11 AM, 罗勇刚(Yonggang Luo) wrote:
> Hi, works, msys2 sh compiled and run

Top-formatting makes it harder to read, compared to interleaving your 
responses.

msys2 sh _is_ bash, so that's not answering the question Dan asked.


>>> +++ b/scripts/undefsym.sh
>>> @@ -1,4 +1,4 @@
>>> -#! /usr/bin/env bash
>>> +#!/bin/sh
>>
>> Does this script actually work on non-bash shells ?  If not, then this
>> change will likely break on plaforms where /bin/sh is not bash.

A quick look at the script sees:

comm -12 \
   <( $NM -P -g $staticlib | awk '$2!="U"{print "-Wl,-u," $1}' | sort -u) \
   <( $NM -P -g "$@" | awk '$2=="U"{print "-Wl,-u," $1}' | sort -u)


<() is a bash'ism, so you _are_ breaking things on platforms like Debian 
where /bin/sh is dash rather than bash.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


