Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A41DC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7A6320773
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HMfFLB7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A6320773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3rX-00043y-42
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kX3eQ-0005ww-Cr
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kX3eO-0000kN-Re
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603723147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FC7uDYskSiwdeFskvuhQ0Nr3GuPsiFmlPOIpHooM2Aw=;
 b=HMfFLB7Pm/J24+j2QGNy8YAVJkk5HoW1GdBySLq5tODBvmeWoPpNMPHhjiSkGZPtdqFjwR
 jNUnUsgsZ5q+8os56kGfAw5VS0sds2Tbqk2G/TwNo/OZ8CcycMHVZTIY9ryo6CSjOsqFNR
 hJeaVXmc9p7R1bqg+xoWMWY48vHzN8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-I9MFUL_kMY-SM6HcwJBrPA-1; Mon, 26 Oct 2020 10:39:03 -0400
X-MC-Unique: I9MFUL_kMY-SM6HcwJBrPA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0DBE188C136;
 Mon, 26 Oct 2020 14:39:01 +0000 (UTC)
Received: from [10.3.112.145] (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F87310021AA;
 Mon, 26 Oct 2020 14:38:58 +0000 (UTC)
Subject: Re: [PATCH v5 02/12] qapi: Make QAPI_LIST_ADD() public
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
References: <20201023183652.478921-1-eblake@redhat.com>
 <20201023183652.478921-3-eblake@redhat.com>
 <87v9ex3vzl.fsf@dusky.pond.sub.org>
 <19e7105e-534e-7e4e-702f-3227a5f714e7@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c6259b99-a7db-0afd-d7c8-facf80097e86@redhat.com>
Date: Mon, 26 Oct 2020 09:38:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <19e7105e-534e-7e4e-702f-3227a5f714e7@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 rjones@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 9:37 AM, Eric Blake wrote:

>> PATCH 12 has more.  I wonder whether PATCH 12 should be squashed into
>> this one.  You decide.
> 
> Patch 12 has a LOT more.  And we're really close to soft freeze.  I kept
> them separate to minimize the risk of landing my QAPI changes (4/12)

Correction - the QAPI change was 6/12 of v5 (whereas it moves earlier in
the series in my upcoming v6 posting)

> before 5.2 (that MUST happen, or we've locked in a problematic API with
> block-export-add), vs. cleanup changes that may require review from a
> lot more areas in the tree.
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


