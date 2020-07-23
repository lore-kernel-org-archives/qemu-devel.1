Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C290C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 22:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63DDF206E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 22:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpYP5Nw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DDF206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyjKK-0002e7-Eq
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 18:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyjJ5-000284-LT
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 18:03:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24153
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyjJ2-00062b-TB
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 18:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595541791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EMnNDH+PcOiKBWh0aTrDo3w0S2e2VbcPIKnfCz238zU=;
 b=QpYP5Nw9cqMFBHbIAgOU8zuACH10Kffh+P/qTNMkvPauco4ToW7ty+5IWv4OO+aEDZEPH+
 /WFjchQWZjnFv94oXapU3b4bKHr6Nlc60DHlYbyosGBJgiGfr00Hu4naYPOk0hGmAQhsZX
 wiAOQQ4kNE7itgxT3g7LLaQS5Yokxno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-yh5iTv3WNbSb9G9LTEetPw-1; Thu, 23 Jul 2020 18:03:09 -0400
X-MC-Unique: yh5iTv3WNbSb9G9LTEetPw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48775800460;
 Thu, 23 Jul 2020 22:03:08 +0000 (UTC)
Received: from [10.3.112.189] (ovpn-112-189.phx2.redhat.com [10.3.112.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C78E171D3D;
 Thu, 23 Jul 2020 22:03:03 +0000 (UTC)
Subject: Re: [PATCH v2 12/22] qemu-iotests/199: fix style
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-13-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c50989d3-462e-003d-24b3-29b6fe4d46ac@redhat.com>
Date: Thu, 23 Jul 2020 17:03:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200217150246.29180-13-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 06:04:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, quintela@redhat.com,
 dgilbert@redhat.com, Max Reitz <mreitz@redhat.com>,
 andrey.shinkevich@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:02 AM, Vladimir Sementsov-Ogievskiy wrote:
> Mostly, satisfy pep8 complains.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/199 | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)

With none of your series applied, I get:

$ ./check -qcow2 199
...
199      not run    [16:52:34] [16:52:34]                    not 
suitable for this cache mode: writeback
Not run: 199
Passed all 0 iotests
199      fail       [16:53:37] [16:53:37]                    output 
mismatch (see 199.out.bad)
--- /home/eblake/qemu/tests/qemu-iotests/199.out	2020-07-23 
16:48:56.275529368 -0500
+++ /home/eblake/qemu/build/tests/qemu-iotests/199.out.bad	2020-07-23 
16:53:37.728416207 -0500
@@ -1,5 +1,13 @@
-.
+E
+======================================================================
+ERROR: test_postcopy (__main__.TestDirtyBitmapPostcopyMigration)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "199", line 41, in setUp
+    os.mkfifo(fifo)
+FileExistsError: [Errno 17] File exists
+
  ----------------------------------------------------------------------
  Ran 1 tests

-OK
+FAILED (errors=1)
Failures: 199
Failed 1 of 1 iotests

Ah, 'scratch/mig_fifo' was left over from some other aborted run of the 
test. I removed that file (which implies it might be nice if the test 
handled that automatically, instead of making me do it), and tried 
again; now I got the desired:

199      pass       [17:00:34] [17:01:48]  74s
Passed all 1 iotests


After trying to rebase your series, I once again got failures, but that 
could mean I botched the rebase (since quite a few of the code patches 
earlier in the series were non-trivially changed).  If you send a v3 
(which would be really nice!), I'd hoist this and 13/22 first in the 
series, to get to a point where testing 199 works, to then make it 
easier to demonstrate what the rest of the 199 enhancements do in 
relation to the non-iotest patches.  But I like that you separated the 
199 improvements from the code - testing-wise, it's easy to apply the 
iotests patches first, make sure it fails, then apply the code patches, 
and make sure it passes, to prove that the enhanced test now covers what 
the code fixes did.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


