Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CFEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 14:07:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B400E2067B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 14:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dH6BvCmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B400E2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj1Nv-000800-Sn
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 10:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jj1NA-0007LK-GC
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 10:06:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32342
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jj1N8-000179-8S
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 10:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591797988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T5yh4MU28IH/Cn8TPifu3ZP5Fc6O1Lb46Svy33h8XhQ=;
 b=dH6BvCmvxDE1kxTbwlQvBJklK3up6gzbDT5ht9jxJHIytU5YOZ1LYgpry314XZ5JBzsMs9
 uBnNHCCruBzqATglKxrvhyQ+fwyb4nSTfR1X/MOSnclNZOXtVaBGf88MuVSEi73xMOmX7T
 2DrtATrKJM8I9G2AZO91uPuPMG5ru5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-JoDkAR2HPHuzbUNWLATTzQ-1; Wed, 10 Jun 2020 10:06:25 -0400
X-MC-Unique: JoDkAR2HPHuzbUNWLATTzQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E82D5107ACCA;
 Wed, 10 Jun 2020 14:06:23 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-151.ams2.redhat.com [10.36.113.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CCE378B3A;
 Wed, 10 Jun 2020 14:06:22 +0000 (UTC)
Date: Wed, 10 Jun 2020 16:06:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Sam Eiderman <sameid@google.com>
Subject: Re: Clarification regarding new qemu-img convert --target-is-zero flag
Message-ID: <20200610140620.GE6947@linux.fritz.box>
References: <CAFr6bU=LjeW5_eGtwL38cher2TM52skohuANNXN9EpO+mA-z8Q@mail.gmail.com>
 <m2imfz877v.fsf@dme.org>
 <CAFr6bUk5LrEL8BPXYkNOqj_jsbxHBfbj_NYryUjszMtG89L+2w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFr6bUk5LrEL8BPXYkNOqj_jsbxHBfbj_NYryUjszMtG89L+2w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, David Edmondson <dme@dme.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Tony Zhang <tzz@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.06.2020 um 14:19 hat Sam Eiderman geschrieben:
> Thanks David,
> 
> Yes, I imaging the following use case:
> 
> disk.vmdk is a 50 GB disk that contains 12 MB binary of zeroes in its beginning.
> /dev/sda is a raw disk containing garbage
> 
> I invoke:
> qemu-img convert disk.vmdk -O raw /dev/sda
> 
> Required output:
> The first 12 MB of /dev/sda contain zeros, the rest garbage, qemu-img
> finishes fast.
> 
> Kevin, from what I understood from you, this is the default behavior.

Sorry, I misunderstood what you want. qemu-img will write zeros to all
unallocated parts, too. If it didn't do that, the resulting image on
/dev/sda wouldn't be a copy of disk.vmdk.

As the metadata (which blocks are allocated) cannot be preserved in raw
images, you wouldn't be able to tell which part of the image contains
valid data and which part needs to be interpreted as zeros even though
it contains random garbage.

What is your use case for this result where the actual virtual disk
content is mixed with garbage?

Kevin


