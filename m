Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69765C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8F8B2075A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iwa72SCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F8B2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMuG9-0006HL-0R
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 10:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kMuDf-00052R-1P
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 10:33:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kMuDc-0004vb-Qc
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 10:33:34 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601303610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W7fK/NQPPePoj8L/gqsYMkyYNYN5zy779blewpwgWb8=;
 b=Iwa72SCDu2iYEK8mVzK3COQQllnG2pxO5OYzC53prSczbXVmD/y/ZUMW0nDKqA2PUp+qYV
 KzGm2a2qLcZ4Gc5QeodkesBD0RHOxUfzrPX5TdVDy4x3RQAuvb2vyqrnhQPen5DsH99NGT
 Vd38fiJKNqsy47YqupZVE2w5hJCv33c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-wPVAIw2tOwCpqLwvU_mJww-1; Mon, 28 Sep 2020 10:33:28 -0400
X-MC-Unique: wPVAIw2tOwCpqLwvU_mJww-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49E4880572E;
 Mon, 28 Sep 2020 14:33:26 +0000 (UTC)
Received: from [10.3.112.208] (ovpn-112-208.phx2.redhat.com [10.3.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9D055C1BB;
 Mon, 28 Sep 2020 14:33:22 +0000 (UTC)
Subject: Re: [PATCH 2/3] nbd: Add new qemu:allocation-depth metacontext
To: "Richard W.M. Jones" <rjones@redhat.com>
References: <20200925203249.155705-1-eblake@redhat.com>
 <20200925203249.155705-3-eblake@redhat.com>
 <20200926073308.GV3888@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d0290138-f9d9-86a1-faf7-34f3ef4218c2@redhat.com>
Date: Mon, 28 Sep 2020 09:33:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200926073308.GV3888@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, vsementsov@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/26/20 2:33 AM, Richard W.M. Jones wrote:
> On Fri, Sep 25, 2020 at 03:32:48PM -0500, Eric Blake wrote:
>> +The second is related to exposing the source of various extents within
>> +the image, with a single context named:
>> +
>> +    qemu:allocation-depth
>> +
>> +In the allocation depth context, bits 0 and 1 form a tri-state value:
>> +
>> +    bits 0-1 clear: NBD_STATE_DEPTH_UNALLOC, means the extent is unallocated
>> +    bit 0 set: NBD_STATE_DEPTH_LOCAL, the extent is allocated in this image
>> +    bit 1 set: NBD_STATE_DEPTH_BACKING, the extent is inherited from a
>> +               backing layer
> 
>>From the cover description I imagined it would show the actual depth, ie:
> 
>           top -> backing -> backing -> backing
>   depth:   1        2         3   ....          (0 = unallocated)
> 
> I wonder if that is possible?  (Perhaps there's something I don't
> understand here.)

The real reason I don't want to do a straight depth number is that 
'qemu-img map' combined with x-dirty-bitmap is still a very convenient 
way to get at bits 0 and 1 (even if it requires decoding).  But if we 
plumb in a way for bdrv_get_status to return depth counts (rather than 
reimplementing the depth count ourselves), I would have no problem with 
returning a struct:

bits 31-4: the depth of the chain
bits 3-2: reserved (to make reading hex values easier...)
bits 1-0: tri-state of unalloc, local, or backing

where it would look like:

0x0000 -> unallocated
0x0011 -> depth 1, local
0x0022 -> depth 2, from the first backing layer
0x0032 -> depth 3, from the second backing layer
0x0042 ...

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


