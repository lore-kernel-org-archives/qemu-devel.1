Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BB6C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 09:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B7420838
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 09:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HEhFvSEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B7420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIqel-0008UU-JS
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 05:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIqdP-0007E9-Jn
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 05:55:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40445
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIqdM-0001Ko-UW
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 05:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600336519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JB0goBgGvrjFqTmzZrry6hEeCECRZYsjQ1bnsicGFEM=;
 b=HEhFvSEuRjKsKUE4r+bLaQHdZT6FlbC6wAvttKSZEM/gPuXm8rRMww+5K+zpPDnpzD+a0w
 VHyZyUaZtBsFL/n2D8clkjZWGNF5xmHF3RT+JLme7u06igXlezCr5gzPEtJYDR+mjqWmlY
 dqt1phVFmTPWjZKuhklVhOYF90+vPHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-A7EBD0MFNKm6yjAOe3olpQ-1; Thu, 17 Sep 2020 05:55:17 -0400
X-MC-Unique: A7EBD0MFNKm6yjAOe3olpQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C12598010C7;
 Thu, 17 Sep 2020 09:55:15 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-38.ams2.redhat.com [10.36.113.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A10A3101418C;
 Thu, 17 Sep 2020 09:55:00 +0000 (UTC)
Subject: Re: QEMU policy for real file tests
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <1836935.RIYQIvKipu@silver> <87y2l8ycs3.fsf@linaro.org>
 <20200917093756.GC1568038@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8e3f59a3-925e-d89f-2073-6c9654bff75f@redhat.com>
Date: Thu, 17 Sep 2020 11:55:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200917093756.GC1568038@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 03:47:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/09/2020 11.37, Daniel P. Berrangé wrote:
> On Thu, Sep 17, 2020 at 10:26:36AM +0100, Alex Bennée wrote:
>>
>> Christian Schoenebeck <qemu_oss@crudebyte.com> writes:
>>
>>> Hi,
>>>
>>> is there a QEMU policy for test cases that create/write/read/delete real files 
>>> and directories? E.g. should they be situated at a certain location and is any 
>>> measure of sandboxing required?
>>
>> I don't think we have a hard and fast policy. It also depends on what
>> you are doing the test in - but ideally you should use a secure mktempd
>> (that can't clash) and clean-up after you are finished. This is a bit
>> easier in python than shell I think.
> 
> mktempd will end up on /tmp usually which can be tmpfs and size limited,
> so be mindful of the size of files you create. Don't assume you can
> create multi-GB sized files !  Creating a temp dir underneath the build
> dir (effectively CWD of the test) is a reasonable alternative.

Another thing to consider: If you want to create Unix sockets in your
tests, make sure that the file name does not get too long, since there
are limits on certain systems - i.e. socket files should be created in a
/tmp subdirectory, indeed.

 Thomas


