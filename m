Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DC9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:35:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E4920759
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHl2BpgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E4920759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaMhE-0006Ir-7N
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 12:35:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kaMch-00019T-TE
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:31:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kaMcf-0000UI-Iw
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:31:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604511059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M83s8+IEC5ep5B5ccnV/5k4BcUTI0sJTLMXw6XIDZtI=;
 b=LHl2BpgH99di1VS6UOio6IE/hgWDKW0Jt0TabHzVTHEVwCaj3H1fyqISmVYeOjtxQwxfyN
 PhDOy+tlxjrvIZXhTh93eSb/yKV1olsUlDXWukuDXJdWIB6+wsskL7jVY5nFbHZKBqnlfL
 Bin97WcITeod7wpkCzdUHFgKzOJuGh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-4ekcUxxlOSW25PwvTvR7kg-1; Wed, 04 Nov 2020 12:30:55 -0500
X-MC-Unique: 4ekcUxxlOSW25PwvTvR7kg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B3BC186DD24;
 Wed,  4 Nov 2020 17:30:54 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68E4F1002C03;
 Wed,  4 Nov 2020 17:30:50 +0000 (UTC)
Subject: Re: [PATCH v2 13/20] iotests: 129: prepare for backup over block-copy
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-14-vsementsov@virtuozzo.com>
 <0293433f-7b37-f7bb-c4dc-3d64b2dbbc68@redhat.com>
 <95c4411f-9b88-2fbb-1e36-2fda369e51a8@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bc4a3074-cda2-fad9-1bce-71aa3ce2f837@redhat.com>
Date: Wed, 4 Nov 2020 18:30:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <95c4411f-9b88-2fbb-1e36-2fda369e51a8@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: kwolf@redhat.com, wencongyang2@huawei.com, xiechanglong.d@gmail.com,
 armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22.10.20 23:10, Vladimir Sementsov-Ogievskiy wrote:
> 23.07.2020 11:03, Max Reitz wrote:
>> On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
>>> After introducing parallel async copy requests instead of plain
>>> cluster-by-cluster copying loop, backup job may finish earlier than
>>> final assertion in do_test_stop. Let's require slow backup explicitly
>>> by specifying speed parameter.
>>
>> Isn’t the problem really that block_set_io_throttle does absolutely
>> nothing?  (Which is a long-standing problem with 129.  I personally just
>> never run it, honestly.)
> 
> Hmm.. is it better to drop test_drive_backup() from here ?

I think the best would be to revisit this:

https://lists.nongnu.org/archive/html/qemu-block/2019-06/msg00499.html

Max


