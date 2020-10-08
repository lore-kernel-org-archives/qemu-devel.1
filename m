Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5320C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 20:59:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D7022203
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 20:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=wisemo.com header.i=@wisemo.com header.b="Dkb5TMqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D7022203
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=wisemo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQd0z-0002rD-3a
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 16:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jb-gnumlists@wisemo.com>)
 id 1kQZ6p-0001lJ-Gx; Thu, 08 Oct 2020 12:49:39 -0400
Received: from smtpv6n-hq2.wisemo.com ([2a01:4f0:4018::24b]:14194)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jb-gnumlists@wisemo.com>)
 id 1kQZ6j-0002vV-UW; Thu, 08 Oct 2020 12:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wisemo.com;
 s=v2016; 
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject;
 bh=uTrzYsQs4KsYRnZkapeSkkj7Ijtcpy3+9Jx3LZAVU00=; 
 b=Dkb5TMqPipAyQaEdLSJ1utQRWzzGV2H0bJ0ERraXiAJht+WYZLe7Gx3mh0Qqgb9yo050+OaXhd1tw680biOd6ONwcSnw1+ltOd8bhVXe8OqqnjdpoNYv4kNB0Jg0XdkmIdyjuAVxPIH6+rjgeEvc061uWHL+IeItKYsf7MxJ/q209LD8Po/znOIWsTgLYxt/d1gEFdgjvGqaBmirU4ZTxPIopiDp7rtnzWd6B4o/t/lUymhfQXlZHigYotNcaqpH6baEFovXsAmTL3JO57wpdkwIILLDzVv+M2Lc5MevUWJZFva3kdkwD2vmDNkuJ1g3y1RjPH4EftQMGcHwJIPYpA==;
Received: from [2a01:4f0:4018:f0:658a:ada3:5fda:4897]
 by mailout.i.wisemo.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.84_2) (envelope-from <jb-gnumlists@wisemo.com>)
 id 1kQZ6Q-0000N3-Re; Thu, 08 Oct 2020 18:49:14 +0200
Subject: Re: Which qemu change corresponds to RedHat bug 1655408
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-discuss@nongnu.org, qemu-devel <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>
References: <2d9c8525-470f-a4e5-5d71-895046e2d782@wisemo.com>
 <653b9595-ae60-181a-2975-2e351ade9788@redhat.com>
From: Jakob Bohm <jb-gnumlists@wisemo.com>
Organization: WiseMo A/S
Message-ID: <43072820-c04f-b706-4b37-2d2e37e8499f@wisemo.com>
Date: Thu, 8 Oct 2020 18:49:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <653b9595-ae60-181a-2975-2e351ade9788@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f0:4018::24b;
 envelope-from=jb-gnumlists@wisemo.com; helo=smtpv6n-hq2.wisemo.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.214,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 08 Oct 2020 16:58:00 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(Top posting because previous reply did so):

If the bug was closed as "can't reproduce", why was a very similar bug 
listed as fixed in RHSA-2019:2553-01 ?


On 2020-10-08 18:41, Philippe Mathieu-Daudé wrote:
> Hi Jakob,
> 
> On 10/8/20 6:32 PM, Jakob Bohm wrote:
>> Red Hat bugzilla bug 1655408 against qemu is listed by Red Hat as fixed in
>> April 2019, but I cannot find the corresponding change on qemu.org (the
>> Changelog in the wiki is not a traditional changelog and doesn't cover
>> bugfix releases such as 5.0.1, the git commit log is too detailed to
>> search, the Red Hat bugzilla and security advisory pages do not link
>> red hat bugs back to upstream (launchpad) bugs or git changes.
>>
>> Here is the bug title (which also affects my Debian packaged qemu 5.0):
>>
>> VM can not boot up due to "Failed to lock byte 100" if cdrom has been
>> mounted on the host
>>
>> Further observation:
>>
>> The basic problem is that qemu-system refuses to start with the error
>> message "Failed to lock byte 100" when -drive points to a read-only
>> ISO file.  For the reporter of the Red Hat bug, that was a mount-induced
>> read-only condition, in my case it is an NFS mount of a read-only
>> directory.
>>
>> The error message itself seams meaningless, as there is no particular
>> reason to request file locks on a read-only raw disk image.
>>
>> my qemu-system-x86_64 invocation contains the option (on one line):
>>
>> -drive if=none,id=drive-ide0-1-0,readonly=on,
>> file=/mnt/someshare/path/gparted-live-1.1.0-5-amd64.iso,format=raw
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1655408 has been
> closed due to lack of reproducer. Can you amend your information
> to the BZ? It will likely be re-opened. Thanks!
> 
>>
>> Enjoy
>>
>> Jakob
>> -- 
>> Jakob Bohm, CIO, Partner, WiseMo A/S.  https://www.wisemo.com
>> Transformervej 29, 2860 Søborg, Denmark.  Direct +45 31 13 16 10
>> This public discussion message is non-binding and may contain errors.
>> WiseMo - Remote Service Management for PCs, Phones and Embedded
>>
> 


Enjoy

Jakob
-- 
Jakob Bohm, CIO, Partner, WiseMo A/S.  https://www.wisemo.com
Transformervej 29, 2860 Søborg, Denmark.  Direct +45 31 13 16 10
This public discussion message is non-binding and may contain errors.
WiseMo - Remote Service Management for PCs, Phones and Embedded

