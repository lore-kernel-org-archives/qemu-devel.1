Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8809AC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 07:14:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E63207E8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 07:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYG7yYOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E63207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Jos-0003nG-Ki
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 03:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0Jnz-0002nX-JI
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 03:13:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41481
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0Jnx-00086N-V2
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 03:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595920421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=Nsq/K0cHy36uLyGHLotdp7Jm1mgA/469RX4IJhdaXMI=;
 b=UYG7yYOwmMmhWiwCz4U6BdYqlpqYgEcMRoR4gb1pzxdZqhF/9oPXPvZdoES7RByQaWvaXc
 VtGvpMZuLn3oKpQ6cYqMd8Oi+eUnUQusmouBLfKC7VTh8aebTiijkiQKZFtEuWcQxoEw/K
 nmJI3tc8bOe1scnipsOI1S1E9iBt+S8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-FVNFH-5VMoKAPuHBZMJsUQ-1; Tue, 28 Jul 2020 03:13:36 -0400
X-MC-Unique: FVNFH-5VMoKAPuHBZMJsUQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C026A102C7EC;
 Tue, 28 Jul 2020 07:13:35 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-161.ams2.redhat.com [10.36.112.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A8B072699;
 Tue, 28 Jul 2020 07:13:32 +0000 (UTC)
Subject: Re: [PATCH for-5.1?] iotests: Adjust which tests are quick
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200727195117.132151-1-eblake@redhat.com>
 <f304c499-0c4a-a179-c20e-af7fb8940b20@virtuozzo.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a0e7e923-5ef2-837b-2397-5783e0942f49@redhat.com>
Date: Tue, 28 Jul 2020 09:13:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f304c499-0c4a-a179-c20e-af7fb8940b20@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 03:13:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, dgilbert@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/07/2020 22.07, Vladimir Sementsov-Ogievskiy wrote:
> 27.07.2020 22:51, Eric Blake wrote:
>> A quick run of './check -qcow2 -g migration' shows that test 169 is
>> NOT quick, but meanwhile several other tests ARE quick.  Let's adjust
>> the test designations accordingly.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> Still, why do we need quick group? make check uses "auto" group..
> Some tests are considered important enough to run even not being quick.
> Probably, everyone who don't want to run all tests, should run "auto"
> group, not "quick"?
> I, when want to check my changes, run all tests or limit them with
> help of grep. I mostly run tests on tmpfs, so they all are quick enough.
> Saving several minutes of cpu work doesn't worth missing a bug..

I think it still makes at least some sense:

- "quick" is for tests that run fast on the developers systems (i.e.
  only Linux, I guess) - can be used during development for a quick
  check in between when you don't want to wait too long

- "auto" group is for "make check", i.e. the test runs fine and
  reasonable fast on all systems (including macOS, *BSD and weird
  CI pipelines)

- The full check should be done before submitting block-layer related
  code, to make sure that no regression happened

Just my 0.02 €, of course.

 Thomas


