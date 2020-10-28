Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F30BC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 20:28:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C3B247FE
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 20:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zgob1qxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C3B247FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXs3O-0007eO-GG
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 16:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXs1u-00071u-BX
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 16:26:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47977)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXs1q-0000PZ-6W
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 16:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603916799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BY0foAQx9B1yolHepWieCq0wOk4/Sp6DOgStVXn1jbU=;
 b=Zgob1qxRdJ8JKPXQE7rW4iFy/JWIbV979RrPYQ4WQ0MO20xow1kd++Q0Ty9tbxt9f/EWN7
 YW5P5SWklDAm0hsQJnDoWUw5tmrrnV6lVe/04trqaB3pikppadMk5vfENPC4XGPt+OSnoC
 MWiw5Sd/wGzQPlYzR9BPX/SAnl50pSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-w4XSZxwzNQi5qEAAy0c9mA-1; Wed, 28 Oct 2020 16:26:37 -0400
X-MC-Unique: w4XSZxwzNQi5qEAAy0c9mA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18D2F10E218F;
 Wed, 28 Oct 2020 20:25:59 +0000 (UTC)
Received: from [10.10.118.238] (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 160A66EF49;
 Wed, 28 Oct 2020 20:25:53 +0000 (UTC)
Subject: Re: [PATCH v3 02/15] python: add qemu package installer
To: Cleber Rosa <crosa@redhat.com>
References: <20201020193555.1493936-1-jsnow@redhat.com>
 <20201020193555.1493936-3-jsnow@redhat.com>
 <20201028194905.GF2201333@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <feb3a1d8-fe92-561c-d3d0-1f8c31e6edd0@redhat.com>
Date: Wed, 28 Oct 2020 16:25:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201028194905.GF2201333@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.921, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 10/28/20 3:49 PM, Cleber Rosa wrote:
> On Tue, Oct 20, 2020 at 03:35:42PM -0400, John Snow wrote:
>> Add setup.cfg and setup.py, necessary for installing a package via
>> pip. Add a rst document explaining the basics of what this package is
>> for and who to contact for more information. This document will be used
>> as the landing page for the package on PyPI.
>>
>> I am not yet using a pyproject.toml style package manifest, because
>> using pyproject.toml (and PEP-517) style packages means that pip is not
>> able to install in "editable" or "develop" mode, which I consider
>> necessary for the development of this package.
>>
>> Use a light-weight setup.py instead.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   python/PACKAGE.rst | 26 ++++++++++++++++++++++++++
>>   python/setup.cfg   | 18 ++++++++++++++++++
>>   python/setup.py    | 23 +++++++++++++++++++++++
>>   3 files changed, 67 insertions(+)
>>   create mode 100644 python/PACKAGE.rst
>>   create mode 100755 python/setup.cfg
> 
> I missed this earlier: setup.cfg does not need to have the execute bit
> on.
> 
> - Cleber.
> 

Fixed this locally already; it came along when I ran 'cp setup.py 
setup.cfg', obviously!


