Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE70C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:25:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EAAC21BE5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TY900ICA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EAAC21BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL8Vs-0001DP-2g
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 13:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kL8Us-0000kh-MG
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 13:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45669)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kL8Ur-0000vs-4x
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 13:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600881840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZEIzr5gdIhW/d73ZsuPHjABnTNR7I2F25RBLl5zZfDQ=;
 b=TY900ICAhAbBV4E+ewhVbfKe+TeEv8ZsLMDM+yCXYoD/t6JG7Z1CSaW0A9HPj4GXPiYrFu
 ChMwU5dpF2Eg5KD55szdOSQ0Q70COW67aOURD8yrY62XL8s4d0xXB8DaMAyCg5jBe9zcQd
 YOvklfo9TQETGjjHVtrXwhTtLQ+0tqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-LyvJMn5nMNiN3c1as0OvRg-1; Wed, 23 Sep 2020 13:23:58 -0400
X-MC-Unique: LyvJMn5nMNiN3c1as0OvRg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 772D51017DC1;
 Wed, 23 Sep 2020 17:23:57 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A964860BEC;
 Wed, 23 Sep 2020 17:23:56 +0000 (UTC)
Subject: Re: [PATCH v2 07/38] qapi: add pylintrc
To: Cleber Rosa <crosa@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-8-jsnow@redhat.com>
 <20200923134235.GG191229@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <751aa453-8c25-6769-d305-d0729beb3415@redhat.com>
Date: Wed, 23 Sep 2020 13:23:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923134235.GG191229@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 9:42 AM, Cleber Rosa wrote:
> On Tue, Sep 22, 2020 at 05:00:30PM -0400, John Snow wrote:
>> Using `pylint --generate-rcfile > pylintrc`, generate a skeleton
>> pylintrc file. Sections that are not presently relevant (by the end of
>> this series) are removed leaving just the empty section as a search
>> engine / documentation hint to future authors.
>>
>> Right now, quite a few modules are ignored as they are known to fail as
>> of this commit. modules will be removed from the known-bad list
>> throughout this and following series as they are repaired.
>>
>> Note: Normally, pylintrc would go in the folder above the module, but as
>> that folder is shared by many things, it is going inside the module
>> folder (for now). Due to a bug in pylint 2.5.x, pylint does not
>> correctly recognize when it is being run from "inside" a package, and
>> must be run *outside* of the package.
>>
>> Therefore, to run it, you must:
>>
>>   > pylint scripts/qapi/ --rcfile=scripts/qapi/pylintrc
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
> 
> One concern I have here is that the pylint version is not defined.
> Based on experience, different pylint will behave differently, because
> among other things, it may introduce new checks.
> 
> I'd at the very least document the pylint version used in the commit
> message, until a "requirements.txt"-like solution pinning a version is
> given.
> 
> Other than that,
> 
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> Tested-by: Cleber Rosa <crosa@redhat.com>
> 

Alright, I'll put it in the commit message itself instead of in the 
cover letter.

The next step is to re-engage on that Makefile patch that I was working 
on for ./python/qemu and introduce it here too, which will document the 
pinned versions correctly.

--js


