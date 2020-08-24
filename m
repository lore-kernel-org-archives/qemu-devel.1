Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE8EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E0FA206B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhhR9VOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0FA206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADui-00031q-BU
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kADtg-00029r-S6
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:56:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kADte-0007IN-Jp
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598280989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ucQufPWxjvHLqZyA9xTid5ZblKSW79kzuBx4WciDw18=;
 b=ZhhR9VOI4d96or8w2jAFg3j2uOXR0qHTBUKsfaiceSCVQdKoyOHFtgr5AY9V4499V8ov8J
 Ap8D/uBs9nAQmus8Kk+c3T+BG19xlujJVpEyXZajUX0HmGeH9SSIG/Q4L1uMNGaMatAy3f
 LnYaJoWHqZxPRG4NA4FlqNW+b4Za0vU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-IKpqx1aDNzGoy0rKzc2Omw-1; Mon, 24 Aug 2020 10:56:26 -0400
X-MC-Unique: IKpqx1aDNzGoy0rKzc2Omw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DFDA801AEA;
 Mon, 24 Aug 2020 14:56:25 +0000 (UTC)
Received: from [10.3.112.126] (ovpn-112-126.phx2.redhat.com [10.3.112.126])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C91F05DA2A;
 Mon, 24 Aug 2020 14:56:24 +0000 (UTC)
Subject: Re: [PATCH 3/4] configure: Prefer gmake on darwin
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200822212129.97758-1-r.bolshakov@yadro.com>
 <20200822212129.97758-4-r.bolshakov@yadro.com>
 <051b2296-f656-9488-f66a-1e74fdd53dc7@redhat.com>
 <20200824145127.GQ10011@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8538549c-c5ea-66d0-4ab7-72acbd54d5ff@redhat.com>
Date: Mon, 24 Aug 2020 09:56:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824145127.GQ10011@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 06:48:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.25, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/24/20 9:51 AM, Daniel P. Berrangé wrote:

>>> @@ -916,6 +917,27 @@ Darwin)
>>>      # won't work when we're compiling with gcc as a C compiler.
>>>      QEMU_CFLAGS="-DOS_OBJECT_USE_OBJC=0 $QEMU_CFLAGS"
>>>      HOST_VARIANT_DIR="darwin"
>>> +  cat > GNUmakefile <<'EOF'
>>> +# This file is auto-generated by configure to implicitly switch from a 'make'
>>> +# invocation to 'gmake'
>>
>> Are we going to run into issues with an in-tree build trying to create
>> GNUmakefile to switch over to build/, while also creating build/GNUmakefile
>> to switch from make to gmake?
> 
> Don't think so - it just means we'll go through both GNUmakefile in
> turn before getting to the real Makefile.

Actually, we won't - the top-level in-tree GNUmakefile calls $(MAKE) -C 
build -f Makefile, which means it skips build/GNUmakefile.  But on the 
other hand, since this series adjusts both places to source 
build/config-host.mak, which in turn assigns $MAKE in a timely manner, 
the recursion should be run through the correct gmake whether done from 
the top-level or directly from within build.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


