Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56727C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 19:56:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BECA220825
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 19:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9ktbpLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECA220825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYE2U-0007Hm-OR
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 15:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kYE1n-0006qi-31
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 15:56:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kYE1l-0007v9-CC
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 15:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604001364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3CU3QPSbcLEWgDkO5xIhjLe9IXSspEV802pFK9p3YH8=;
 b=A9ktbpLd3NFh3Kh9oExzqJE+LS69bj6/uOolyL1LblqKitboCNJd0dCYIEtbt+bKXN+2aX
 AsPh8kAGrnGpQLpMqxhMoKJ89Hm/PO+EuDJtefk+9oHyeqzuPJKjTN0I2C7XGEOf+zhD64
 UCZfCB+1Uehgm6YbYMb27WdMbegKVuI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-u2ateHGNOFWBMYJpvdSvmQ-1; Thu, 29 Oct 2020 15:56:02 -0400
X-MC-Unique: u2ateHGNOFWBMYJpvdSvmQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DF631074642;
 Thu, 29 Oct 2020 19:56:01 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-23.ams2.redhat.com [10.36.112.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AD6F196FB;
 Thu, 29 Oct 2020 19:55:59 +0000 (UTC)
Subject: Re: Migrating to the gitlab issue tracker
To: John Snow <jsnow@redhat.com>, Alistair Francis <alistair23@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <bda4f471-8ed6-3832-29ac-279a6d3bb7cc@redhat.com>
 <20201029174114.47e2b351.cohuck@redhat.com>
 <CAKmqyKOY+5WcxUg3Rvq2t3vYWOHrHQdhcv8PkiqZX2zVMdqJ3Q@mail.gmail.com>
 <3713093e-bf3b-bf23-a8d0-70fe429032ba@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c7308133-cf29-8668-f781-6d025eb16722@redhat.com>
Date: Thu, 29 Oct 2020 20:55:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3713093e-bf3b-bf23-a8d0-70fe429032ba@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.261, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/10/2020 18.12, John Snow wrote:
> On 10/29/20 12:49 PM, Alistair Francis wrote:
>> On Thu, Oct 29, 2020 at 9:41 AM Cornelia Huck <cohuck@redhat.com> wrote:
>>>
>>> On Thu, 29 Oct 2020 12:01:27 -0400
>>> John Snow <jsnow@redhat.com> wrote:
>>>
>>>> If you're in the CC list, it's because you are listed in MAINTAINERS.
>>>
>>> <cleared the cc: list except for qemu-devel :)>
>>>
>>>>
>>>> Paolo's QEMU keynote this morning mentioned the possible use of the
>>>> Gitlab issue tracker instead of using Launchpad.
>>>>
>>>> I'm quite fond of the gitlab issue tracker, I think it works quite well
>>>> and it has pretty good and uncomplicated API access to it in order to
>>>> customize your workflow if you'd really like to.
>>>>
>>>> In experimenting with my mirror on gitlab though, I was unable to find a
>>>> way to configure it to send issue tracker notifications to the email
>>>> list. A move to gitlab would likely mean, then:
>>>>
>>>> 1. The cessation of (automatic) issue tracker mails to the list
>>>> 2. The loss of the ability to update the issue tracker by replying to
>>>> said emails
>>>> 3. Anyone listed in MAINTAINERS would be expected to have a gitlab
>>>> account in order to interact with the issue tracker.
>>>
>>> The gitlab issue tracker is almost certainly is an improvement over
>>> launchpad (and I do have a gitlab account); but not being able to
>>> interact via email is at least annoying. I expect that not only
>>> maintainers will want to interact with bug reports?
>>>
>>>>
>>>> However, once you have a gitlab account, you DO gain the ability to
>>>> receive emails for issues; possibly only those tagged with labels that
>>>> you cared about -- giving a nice filtering mechanism to receive only
>>>> bugs you care about.
>>>>
>>>> Gitlab also does support individual accounts updating issues using a
>>>> generated personalized email address, so if the email workflow is
>>>> crucial to you, it is still available.
>>>
>>> You mean that I can update via email, provided it's an address
>>> associated with my account?
>>>
>>>>
>>>> I'm for it, or at least for beginning a pilot program where we
>>>> experiment with the idea for interested parties. I wanted to send up a
>>>> trial balloon to see how we were feeling about this.
>>
>> I'm not sure if you want Acks, but it sounds good to me.
>>
>> Alistair
>>
> 
> Mostly I was looking for any hard objections over the idea of issues not
> necessarily being sent to the list anymore, if there were any.
> 
> I want to hear from Thomas Huth too, but maybe we can work out a pilot
> migration and give it a test-run and find more concrete objections that way.

I'd certainly give it a try! Launchpad is IMHO really a pain (let me know if
I should elaborate on that topic again...), and the email bridge is often
also not working correctly (replies to bug mails sometimes get put into the
bug tracker, sometimes not), so this is not something I would really miss
when we quite Launchpad.

So could somebody please enable the issue tracker there, so we can give it a
try? Phil? Alex? Stefan? ...?

If it works well, I can certainly help to get the links etc. in our website
fixed.

 Thomas


