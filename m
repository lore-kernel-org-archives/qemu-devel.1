Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D7DC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 20:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF884247D4
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 20:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWEaQVFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF884247D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXrdx-0005Kz-RF
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 16:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXrd9-0004aH-R5
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 16:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXrd4-0005Gx-3p
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 16:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603915263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ql3HEoljugiqFM38t1O/1yZZVofAzfZ/Ci4QaQymCt4=;
 b=AWEaQVFEGwvFX4rH4Kngay22JFEx0j6OmXkr7EZLhLL3VXTZp/f4hX/EzQYvWKg5jSdLjG
 hItOsoOfamda0T3teuj5x5h9dXNZlCQbz5D3MQ2YWKsmWdroSGMN0ijJPrwFd90WP2PS65
 kK8uRpwwFa08bckuvz/P8ApPwoyXueg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-U4KhZEthNPGzjVQxE-bBBQ-1; Wed, 28 Oct 2020 16:00:59 -0400
X-MC-Unique: U4KhZEthNPGzjVQxE-bBBQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D135580B714;
 Wed, 28 Oct 2020 20:00:57 +0000 (UTC)
Received: from [10.10.118.238] (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 962FC19931;
 Wed, 28 Oct 2020 20:00:53 +0000 (UTC)
Subject: Re: [PATCH v3 03/15] python: add VERSION file
To: Cleber Rosa <crosa@redhat.com>
References: <20201020193555.1493936-1-jsnow@redhat.com>
 <20201020193555.1493936-4-jsnow@redhat.com>
 <20201028195113.GG2201333@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <00f1a9ab-a8b9-8205-3bf8-628fdc7d4f84@redhat.com>
Date: Wed, 28 Oct 2020 16:00:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201028195113.GG2201333@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.921,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Ben Widawsky <ben@bwidawsk.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Rohit Shinde <rohit.shinde12194@gmail.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/20 3:51 PM, Cleber Rosa wrote:
> On Tue, Oct 20, 2020 at 03:35:43PM -0400, John Snow wrote:
>> Python infrastructure as it exists today is not capable reliably of
>> single-sourcing a package version from a parent directory. The authors
>> of pip are working to correct this, but as of today this is not possible
>> to my knowledge.
>>
>> The problem is that when using pip to build and install a python
>> package, it copies files over to a temporary directory and performs its
>> build there. This loses access to any information in the parent
>> directory, including git itself.
>>
>> Further, Python versions have a standard (PEP 440) that may or may not
>> follow QEMU's versioning. In general, it does; but naturally QEMU does
>> not follow PEP 440. To avoid any automatically-generated conflict, a
>> manual version file is preferred.
>>
>>
>> I am proposing:
>>
>> - Python tooling follows the QEMU version, indirectly, but with a major
>>    version of 0 to indicate that the API is not expected to be
>>    stable. This would mean version 0.5.2.0, 0.5.1.1, 0.5.3.0, etc.
>>
>> - In the event that a Python package needs to be updated independently
>>    of the QEMU version, a pre-release alpha version should be preferred,
>>    but *only* after inclusion to the qemu development or stable branches.
>>
>>    e.g. 0.5.2.0a1, 0.5.2.0a2, and so on should be preferred prior to
>>    5.2.0's release.
>>
>> - The Python core tooling makes absolutely no version compatibility
>>    checks or constraints. It *may* work with releases of QEMU from the
>>    past or future, but it is not required to.
>>
>>    i.e., "qemu.machine" will always remain in lock-step with QEMU.
>>
>> - We reserve the right to split the qemu package into independently
>>    versioned subpackages at a later date. This might allow for us to
>>    begin versioning QMP independently from QEMU at a later date, if
>>    we so choose.
>>
>>
>> Implement this versioning scheme by adding a VERSION file and setting it
>> to 0.5.2.0a1.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
> 
> I'd rather have the version to be sync'd with QEMU, but, I understand
> this is a more conservative approach that can maybe evolve into that.
> 
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> 

It's definitely me taking the cowardly way out. I did use the exact QEMU 
version in the last spin, because that seemed like the dumbest thing :)

I think qemu.machine would eventually evolve to track the QEMU version 
directly, whereas qemu.qmp would evolve to keep its own independent 
versioning system.

This is just, I guess, one more semantic nudge towards the idea that 
this is really an independent little component. I just want to give it 
some more time in the oven before I declare it truly and genuinely 
supported as its own project. Once it's on PyPI, I am beholden to more 
than the other QEMU contributors. Satisfying both crowds simultaneously 
seems like it will be tough.

--js


