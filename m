Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FEAC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC122145D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TD4SE+n3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC122145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNKFk-0000M0-ET
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 14:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNKBf-0005PD-Cz
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 14:17:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25500)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNKBd-0003My-7N
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 14:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601403431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jaIpiXjQ0D5nRFIHcEo+c00sVy1CBwqDgjwwbSj2Nw4=;
 b=TD4SE+n37FyOHQ+yBvURDRt41MZKCaUpqpDyWx2mvuNUMhbuJXVTI9uTP/dIghIUbbHTj/
 YlZMZq3jpt1LLRhkIU0CMv06LZ97yJOmh3gpAg1opKogrN36123od2fLO/UKYx2oFV/F0h
 efsxdm6mOpaf5V4+Y4VHT90P6V7B6RU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-qoSXmHR-OAWFDJqDDXpoiQ-1; Tue, 29 Sep 2020 14:17:09 -0400
X-MC-Unique: qoSXmHR-OAWFDJqDDXpoiQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24311803F67
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 18:16:56 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9ABFC78806;
 Tue, 29 Sep 2020 18:16:55 +0000 (UTC)
Subject: Re: [PATCH v3 02/47] [DO-NOT-MERGE] docs: repair broken references
To: Cleber Rosa <crosa@redhat.com>
References: <20200925002900.465855-1-jsnow@redhat.com>
 <20200925002900.465855-3-jsnow@redhat.com>
 <20200929031422.GC700868@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <adff8ee5-1251-e63e-8004-7325fa3316b7@redhat.com>
Date: Tue, 29 Sep 2020 14:16:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200929031422.GC700868@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/28/20 11:14 PM, Cleber Rosa wrote:
> On Thu, Sep 24, 2020 at 08:28:15PM -0400, John Snow wrote:
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   docs/devel/multi-thread-tcg.rst | 2 +-
>>   docs/devel/testing.rst          | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/devel/multi-thread-tcg.rst b/docs/devel/multi-thread-tcg.rst
>> index 21483870db..92a9eba13c 100644
>> --- a/docs/devel/multi-thread-tcg.rst
>> +++ b/docs/devel/multi-thread-tcg.rst
>> @@ -267,7 +267,7 @@ of view of external observers (e.g. another processor core). They can
>>   apply to any memory operations as well as just loads or stores.
>>   
>>   The Linux kernel has an excellent `write-up
>> -<https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/plain/Documentation/memory-barriers.txt>`
>> +<https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/plain/Documentation/memory-barriers.txt>`_
>>   on the various forms of memory barrier and the guarantees they can
>>   provide.
>>   
>> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
>> index 666c4d7240..f21f3f58eb 100644
>> --- a/docs/devel/testing.rst
>> +++ b/docs/devel/testing.rst
>> @@ -953,7 +953,7 @@ compiler flags are needed to build for a given target.
>>   If you have the ability to run containers as the user you can also
>>   take advantage of the build systems "Docker" support. It will then use
>>   containers to build any test case for an enabled guest where there is
>> -no system compiler available. See :ref: `_docker-ref` for details.
>> +no system compiler available. See `docker-ref` for details.
>>
> 
> Actually, I take the "r-b" back because I missed this line... it
> should be:
> 
>     no system compiler available. See `docker-ref`_ for details.
> 
> - Cleber.
> 

I'm reworking this patch and dropping the DO-NOT-MERGE and fixing this 
reference to read:

:ref:`docker-ref`

This works *without* my other sphinx patches, so it should now stand alone.

I've sent this as a standalone patch to qemu-trivial.

(I'll fix it in this branch too, but it's DO-NOT-MERGE here, so ... 
whatever!)

--js


