Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4DDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 14:42:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 440FA2076E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 14:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+yDfurw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440FA2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8llZ-0005Qc-Hl
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 10:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8lkn-0004XO-O2
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 10:41:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52066)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8lkl-0002fj-QJ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 10:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597934478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V3XqL4Oun/AjNqML/PC+G9mmDOzUzsjsdVftI+HxRqk=;
 b=C+yDfurwZY7PTDjaDSvaxxOnuPTDsJ+m+0oGndhCne/kx3HZ3Hcroty0foaKuTMV8ks9Gf
 aa7EOm9RCtXdLooTD91HMlF+NdVmwni8ppHDdBECfNJhTo+rDhT3/QJAUumaCjcAaT7jMp
 BQ2KFGj8yFYHPoKT7MxB4oT4PBtDH1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-IAntt3RmNI6hUr3vrIYtQg-1; Thu, 20 Aug 2020 10:41:16 -0400
X-MC-Unique: IAntt3RmNI6hUr3vrIYtQg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0979101962C;
 Thu, 20 Aug 2020 14:41:15 +0000 (UTC)
Received: from [10.3.114.63] (ovpn-114-63.phx2.redhat.com [10.3.114.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 676617E301;
 Thu, 20 Aug 2020 14:41:15 +0000 (UTC)
Subject: Re: [RFC PATCH 07/22] block/export: Remove magic from block-export-add
To: Kevin Wolf <kwolf@redhat.com>
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-8-kwolf@redhat.com>
 <b2958a79-f7c6-7bc2-8895-50924f15afd9@redhat.com>
 <20200820110501.GB99531@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <87282a22-1263-c632-2ea1-a412b07d8519@redhat.com>
Date: Thu, 20 Aug 2020 09:41:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820110501.GB99531@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 06:28:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/20 6:05 AM, Kevin Wolf wrote:

> As long as we can keep the compatibility code local to qmp_nbd_*(), I
> don't think it's too bad. In particular because it's already written.
> 
> Instead of adjusting libvirt to changes in the nbd-* commands, I'd
> rather have it change over to block-export-*. I would like to see the
> nbd-server-add/remove commands deprecated soon after we have the
> replacements.

Makes sense to me. So deprecate nbd-server-add in 5.2, and require 
block-export in 6.1.


>>> +    /*
>>> +     * nbd-server-add doesn't complain when a read-only device should be
>>> +     * exported as writable, but simply downgrades it. This is an error with
>>> +     * block-export-add.
>>
>> I'd be happy with either marking this deprecated now (and fixing it in two
>> releases), or declaring it a bug in nbd-server-add now (and fixing it
>> outright).
> 
> How about deprecating nbd-server-add completely?

Works for me. Keeping the warts backwards-compatible in nbd-server-add 
is more palatable if we know we are going to drop it wholesale down the 
road.

>>> +    /*
>>> +     * nbd-server-add removes the export when the named BlockBackend used for
>>> +     * @device goes away.
>>> +     */
>>> +    on_eject_blk = blk_by_name(arg->device);
>>> +    if (on_eject_blk) {
>>> +        nbd_export_set_on_eject_blk(export, on_eject_blk);
>>> +    }
>>
>> Wait - is the magic export removal tied only to exporting a drive name, and
>> not a node name?  So as long as libvirt is using only node names whwen
>> adding exports, a drive being unplugged won't interfere?
> 
> Yes, seems so. It's the existing behaviour, I'm only moving the code
> around.
> 
>> Overall, the change makes sense to me, although I'd love to see if we could
>> go further on the writable vs. read-only issue.
> 
> If nbd-server-add will be going away relatively soon, it's probably not
> worth the trouble. But if you have reasons to keep it, maybe we should
> consider it.

No, I'm fine with the idea of getting rid of nbd-server-add, at which 
point changing it before removal is pointless.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


