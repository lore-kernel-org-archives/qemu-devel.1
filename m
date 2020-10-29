Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC0BC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 00:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DAB32072C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 00:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbXeaAX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DAB32072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXvUA-0004BR-Rh
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 20:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXvSr-0003fZ-NF
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 20:06:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20447)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXvSp-0005Tj-EB
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 20:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603930005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SFyH9v0mvQdn+IyXxExVLIiRvDY0gWmM2/pDl6Szjdw=;
 b=cbXeaAX7QcQWLy22tf+SqSEXr88aporyVgR5M3tAhLfwB+tjof2tYeXdRb/HG4rCSHvHf0
 1J+YGp/FIAwrQ2zwC7tBycCZlYt2MaofJMxddaaBJ/Ve4QqQoQNfoPTtqDV1EUjh0WecVU
 tNIMvG0Yu/625T7Bms+4GHVbDzE97tQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-I3NdLpV7NQKlWcGmMgXyeg-1; Wed, 28 Oct 2020 20:06:43 -0400
X-MC-Unique: I3NdLpV7NQKlWcGmMgXyeg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F03C81007465;
 Thu, 29 Oct 2020 00:06:41 +0000 (UTC)
Received: from [10.10.118.238] (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 29B745B4B2;
 Thu, 29 Oct 2020 00:06:36 +0000 (UTC)
Subject: Re: [PATCH v3 08/15] python: add pylint to pipenv
To: Cleber Rosa <crosa@redhat.com>
References: <20201020193555.1493936-1-jsnow@redhat.com>
 <20201020193555.1493936-9-jsnow@redhat.com>
 <20201028223851.GA2549351@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <8042f7d2-3889-b937-1e2c-c7983d1feee7@redhat.com>
Date: Wed, 28 Oct 2020 20:06:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201028223851.GA2549351@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.921, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 10/28/20 6:38 PM, Cleber Rosa wrote:
> On Tue, Oct 20, 2020 at 03:35:48PM -0400, John Snow wrote:
>> We are specifying >= pylint 2.6.x for two reasons:
>>
>> 1. For setup.cfg support, added in pylint 2.5.x
>> 2. To clarify that we are using a version that has incompatibly dropped
>> bad-whitespace checks.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
> 
> I'm not a huge fan of this level of verbosity that pipenv generates,
> but at the same time, I've been bitten too many times by not providing
> the entire dep tree in a "requirements.txt"-like style.  And it is
> what pipenv uses, so there's no way around that.
> 

Unless we don't use Pipenv :)

> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> Tested-by: Cleber Rosa <crosa@redhat.com>
> 

I will say I'm open to using tools that aren't Pipenv -- this is just 
something I knew how to use in order to provide a fairly robust 
venv-recreation mechanism, so I am using it. Don't know what I don't 
know, otherwise.

I hear Poetry is nice, but I haven't looked into it yet.

Tox I believe also does venv-management to some extent, though my 
impression of it was that it was less specific about the environments 
than Pipenv was and allowed more wiggle room. Could be wrong.

Pipenv does not manage multiple environments either, unlike Tox, which 
can multiplex your environments for different versions of things. That's 
one point in favor, perhaps.

If you'd like to propose using something else, feel free to fork this 
branch and implement something else; it's probably quicker that way than 
to have me learn tox/poetry/etc.

What I was using Pipenv to solve here is this:

"Create a package list pinned to explicit versions that is not for the 
purpose of installing or using the package, but is for the purpose of 
recreating a precise testing environment. Use this environment to run 
the linters with precisely known tooling versions."

My initial read was that using pip and requirements.txt alone was 
insufficient for this purpose; so I have been using Pipenv for the purpose.

Suggestions/patches welcome.

--js


