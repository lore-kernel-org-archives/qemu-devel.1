Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A02CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5729720781
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJ5DVGAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5729720781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joQAb-00020v-LD
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 07:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joQ8h-0000BK-JE
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:33:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42288
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joQ8e-0007eo-QT
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593084831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nfPn426myRmED6ghMs4rbuZ9lbmlZs9ENHTzju+wl7k=;
 b=RJ5DVGAT0GT0FCBmpd4tUSofliqw76yfLqGfGFjUCLD+K5ifpOwXY27bqSHfdnxnQkUNNK
 ShLmcsl+y7N8NE2NLvmkyawqxRlQtJLkkX3sa5AJoCEz/s+4kjDFvV9UC/1dwR+D/w0gif
 7DhK+7b0VEW4dGD+xJWZHWOazqa4rlE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-g68GiC9LNfqyaYS2nagomw-1; Thu, 25 Jun 2020 07:33:49 -0400
X-MC-Unique: g68GiC9LNfqyaYS2nagomw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97BD1107ACF5;
 Thu, 25 Jun 2020 11:33:48 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-150.ams2.redhat.com [10.36.112.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 155E919D61;
 Thu, 25 Jun 2020 11:33:43 +0000 (UTC)
Subject: Re: [PATCH RFC 0/3] gitlab: build containers to use in build jobs
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200622153318.751107-1-berrange@redhat.com>
 <a08ca3b1-ddde-693b-60e0-cca9b0094721@redhat.com>
 <20200625112653.GA1014704@redhat.com> <20200625112919.GB1014704@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <def1de86-3183-56c3-81a0-b56d7550b953@redhat.com>
Date: Thu, 25 Jun 2020 13:33:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200625112919.GB1014704@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/06/2020 13.29, Daniel P. Berrangé wrote:
> On Thu, Jun 25, 2020 at 12:26:53PM +0100, Daniel P. Berrangé wrote:
>> On Thu, Jun 25, 2020 at 01:15:52PM +0200, Thomas Huth wrote:
>>> On 22/06/2020 17.33, Daniel P. Berrangé wrote:
>>>> The current gitlab CI jobs are quite inefficient because they
>>>> use the generic distro images and then apt-get/dnf install
>>>> extra packages every time.
>>>>
>>>> The other downside is that the container environment used is
>>>> only defined in thte .gitlab-ci.yml file, so it tedious to
>>>> reproduce locally.
>>>>
>>>> We already have containers defined in tests/docker for use by
>>>> developers building locally. We can use these for CI systems
>>>> too if we just had a way to build them....
>>>>
>>>> ...GitLab CI offers such a way. We can use docker-in-docker
>>>> to build the images at the start of the CI cycle, and use
>>>> the built images in later jobs.
>>>>
>>>> These later jobs are now faster because they're not having
>>>> to install any software.
>>>
>>> Did you see any speed-up? I had a look at some pipelines, and it seems to me
>>> that they rather got slower now? For example, this is the system1 pipeline
>>> before your change:
>>>
>>>   https://gitlab.com/huth/qemu/-/jobs/610924897
>>>
>>> and after your change:
>>>
>>>   https://gitlab.com/huth/qemu/-/jobs/611069374
>>>
>>> Duration went up from 35 minutes to 42 minutes.
>>>
>>> Seems also to happen in your builds, before the change:
>>>
>>>   https://gitlab.com/berrange/qemu/-/jobs/582995084
>>>
>>> and after the change:
>>>
>>>   https://gitlab.com/berrange/qemu/-/jobs/606175927
>>>
>>> ... went from 36 minutes up to 42 minutes.
>>>
>>> Could be a coincidence due to the load on the shared runners, but it looks
>>> at least a little bit suspicious...
>>
>> I think the difference is because we're building more features now. The
>> dockerfiles have provided more build pre-requisites that the old gitlab
>> recipe did.
>>
>> If you compare the configure summary, I see the new build now covers
>> SDL, curses, curl, pulseaudio, virtiofs, SASL, libjpeg, xen, docs
>> and a few more.  So we've saved time by not intsallling many packages
>> each time, but consumed a greater amount of time by compiling more
>> features.
> 
> Oh a missed a lot more actually - there's also spice, opengl, libiscsi,
> libnfs, libusb, seccomp, libssh, lzo, snappy, bzip, zstd, numa and udev
> too.

Ok, that's fair, I think it's ok to spend some additional minutes for 
the extended test coverage here.

  Thomas


