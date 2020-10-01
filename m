Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1285CC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 08:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6947A208B6
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 08:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9HMHbEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6947A208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNuAa-0000w3-SA
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 04:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kNu9Y-0000Hj-OI
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 04:41:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kNu9W-0003yF-0B
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 04:41:28 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601541684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dk7DCPuvHloP9ONvMt9gxhZith7QdPpFPGSkLigtPjI=;
 b=V9HMHbEtcqLcdrfb9yKcI6bcX9axjfmcHtYcMCq2Aij88WwCKuuiGy7k51lZ9Yv9J7Uq+i
 e8WD98onJ/FCuPyjyt9WHkUtKI6jPZB9fae49+FTbjtfTYuKT/YtDR1PRrf2fbAJiNjAqs
 OYD9Y7Pq01ac8ixnQvGuTF/DsJrHxtI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-1jD1dM8-PjmqdW4MlFmwkQ-1; Thu, 01 Oct 2020 04:41:19 -0400
X-MC-Unique: 1jD1dM8-PjmqdW4MlFmwkQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DFE7803F63;
 Thu,  1 Oct 2020 08:41:18 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-107.ams2.redhat.com [10.36.112.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A9F7619936;
 Thu,  1 Oct 2020 08:41:12 +0000 (UTC)
Subject: Re: [PATCH v6 11/15] iotests: add 298 to test new preallocate filter
 driver
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
 <20200918181951.21752-12-vsementsov@virtuozzo.com>
 <1d202398-7a0e-9e72-6f9d-c04b7f887a0a@redhat.com>
 <33d1a996-f212-eac7-ab78-659a4025c069@virtuozzo.com>
 <d36a27c8-0f2c-ede5-6f97-e134093dcf6e@redhat.com>
 <9d324820-cb15-84a6-574d-f92846e16928@virtuozzo.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3ae9cc8a-4270-6938-5d9c-6503f45e46b1@redhat.com>
Date: Thu, 1 Oct 2020 10:41:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9d324820-cb15-84a6-574d-f92846e16928@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/2020 17.11, Vladimir Sementsov-Ogievskiy wrote:
> 25.09.2020 12:11, Max Reitz wrote:
>> On 25.09.20 10:49, Vladimir Sementsov-Ogievskiy wrote:
>>> 25.09.2020 11:26, Max Reitz wrote:
>>>> On 18.09.20 20:19, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>> ---
>>>>>    tests/qemu-iotests/298     | 186
>>>>> +++++++++++++++++++++++++++++++++++++
>>>>>    tests/qemu-iotests/298.out |   5 +
>>>>>    tests/qemu-iotests/group   |   1 +
>>>>>    3 files changed, 192 insertions(+)
>>>>>    create mode 100644 tests/qemu-iotests/298
>>>>>    create mode 100644 tests/qemu-iotests/298.out
>>
>> [...]
>>
>>>>> +class TestTruncate(iotests.QMPTestCase):
>>>>
>>>> The same decorator could be placed here, although this class doesn’t
>>>> start a VM, and so is unaffected by the allowlist.  Still may be
>>>> relevant in case of block modules, I don’t know.
>>>
>>> Or just global test skip at file top
>>
>> Hm.  Like verify_quorum()?  Is there a generic function for that already?
>>
>> [...]
>>
>>>>> +        # Probably we'll want preallocate filter to keep align to
>>>>> cluster when
>>>>> +        # shrink preallocation, so, ignore small differece
>>>>> +        self.assertLess(abs(stat.st_size - refstat.st_size), 64 *
>>>>> 1024)
>>>>> +
>>>>> +        # Preallocate filter may leak some internal clusters (for
>>>>> example, if
>>>>> +        # guest write far over EOF, skipping some clusters - they
>>>>> will remain
>>>>> +        # fallocated, preallocate filter don't care about such
>>>>> leaks, it drops
>>>>> +        # only trailing preallocation.
>>>>
>>>> True, but that isn’t what’s happening here.  (We only write 10M at
>>>> 0, so
>>>> there are no gaps.)  Why do we need this 1M margin?
>>>
>>> We write 10M, but qcow2 also writes metadata as it wants
>>
>> Ah, yes, sure.  Shouldn’t result in 1M, but why not.
>>
>>>>> +        self.assertLess(abs(stat.st_blocks - refstat.st_blocks) *
>>>>> 512,
>>>>> +                        1024 * 1024)
>>>>
>>>> [...]
>>>>
>>>>> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
>>>>> index ff59cfd2d4..15d5f9619b 100644
>>>>> --- a/tests/qemu-iotests/group
>>>>> +++ b/tests/qemu-iotests/group
>>>>> @@ -307,6 +307,7 @@
>>>>>    295 rw
>>>>>    296 rw
>>>>>    297 meta
>>>>> +298 auto quick
>>>>
>>>> I wouldn’t mark it as quick, there is at least one preallocate=full of
>>>> 140M, and one of 40M, plus multiple 10M data writes and falloc
>>>> preallocations.
>>>>
>>>> Also, since you mark it as “auto”, have you run this test on all
>>>> CI-relevant hosts?  (Among other things I can’t predict) I wonder how
>>>> preallocation behaves on macOS.  Just because that one was always a bit
>>>> weird about not-really-data areas.
>>>>
>>>
>>> Ofcourse, I didn't run on all hosts. I'm a bit out of sync about this..
>>
>> Well, someone has to do it.  The background story is that tests are
>> added to auto all the time (because “why not”), and then they fail on
>> BSD or macOS.  We have BSD docker test build targets at least, so they
>> can be easily tested.  (Well, it takes like half an hour, but you know.)
>>
>> (We don’t have macOS builds, as far as I can tell, but I personally
>> don’t even know why we run the iotests on macOS at all.  (Well, I also
>> wonder about the BSDs, but given the test build targets, I shouldn’t
>> complain, I suppose.))
>>
>> (Though macOS isn’t part of the gating CI, is it?  I seem to remember
>> macOS errors are generally only reported to me half a week after the
>> pull request is merged, which is even worse.)
>>
>> Anyway.  I just ran the test for OpenBSD
>> (EXTRA_CONFIGURE_OPTS='--target-list=x86_64-softmmu' \
>>     make vm-build-openbsd)
> 
> Oh, I didn't know that it's so simple.
Running the tests on macOS is also quite simple if you have a github
account. You simply add the "Cirrus-CI" from the marketplace to your
forked qemu repository there, and then push your work to a branch in
that repo. Cirrus-CI then automatically tests your stuff on macOS (and
also FreeBSD), e.g.:

 https://cirrus-ci.com/build/4961684689256448

 Thomas


