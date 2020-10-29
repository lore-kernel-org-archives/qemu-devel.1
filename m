Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58DCC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C81CF207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3A+YkvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81CF207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYCJ8-0000dK-P9
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 14:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kYCHU-00086n-RS
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53653)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kYCHR-0001VI-Vo
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603994648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QSUrVNQeHB9KQbS4jgSVP0BGI++z4ZK3g0U40kbbllQ=;
 b=Z3A+YkvP9gp/h/9vwbsslbcGkk+4aRu1g1X8Bk3B+Dm9Yl4QJW50U0cYtbCIah2azOUJSc
 vL1fJLVxk5Ci0gFqO0vSsCAUfbUsqkheZl5zRxoKGZ+e96SOTkzMobpNwPXqmyXqL6lruQ
 m1PoqEhnBnjbGJevnxHeyjZsvBTP344=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-NjZ399X8NCesLRqr_Soe1w-1; Thu, 29 Oct 2020 14:04:05 -0400
X-MC-Unique: NjZ399X8NCesLRqr_Soe1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D285264149
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 18:04:04 +0000 (UTC)
Received: from [10.10.118.238] (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E9A26EF73;
 Thu, 29 Oct 2020 18:04:04 +0000 (UTC)
Subject: Re: Migrating to the gitlab issue tracker
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
References: <bda4f471-8ed6-3832-29ac-279a6d3bb7cc@redhat.com>
 <20201029174114.47e2b351.cohuck@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <2fecc4a0-7aec-16db-1150-50fc0463d6ac@redhat.com>
Date: Thu, 29 Oct 2020 14:04:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201029174114.47e2b351.cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.261, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/29/20 12:41 PM, Cornelia Huck wrote:
> On Thu, 29 Oct 2020 12:01:27 -0400
> John Snow <jsnow@redhat.com> wrote:
> 
>> If you're in the CC list, it's because you are listed in MAINTAINERS.
> 
> <cleared the cc: list except for qemu-devel :)>
> 
>>
>> Paolo's QEMU keynote this morning mentioned the possible use of the
>> Gitlab issue tracker instead of using Launchpad.
>>
>> I'm quite fond of the gitlab issue tracker, I think it works quite well
>> and it has pretty good and uncomplicated API access to it in order to
>> customize your workflow if you'd really like to.
>>
>> In experimenting with my mirror on gitlab though, I was unable to find a
>> way to configure it to send issue tracker notifications to the email
>> list. A move to gitlab would likely mean, then:
>>
>> 1. The cessation of (automatic) issue tracker mails to the list
>> 2. The loss of the ability to update the issue tracker by replying to
>> said emails
>> 3. Anyone listed in MAINTAINERS would be expected to have a gitlab
>> account in order to interact with the issue tracker.
> 
> The gitlab issue tracker is almost certainly is an improvement over
> launchpad (and I do have a gitlab account); but not being able to
> interact via email is at least annoying. I expect that not only
> maintainers will want to interact with bug reports?
> 

Nothing stopping reviewers or contributors from signing up and 
subscribing to labels or issues they care about... It will just be more 
opaque to the ebb and flow of the list.

There are still perhaps things we could do; a bot that generates weekly 
bug report summaries might be a solution.

>>
>> However, once you have a gitlab account, you DO gain the ability to
>> receive emails for issues; possibly only those tagged with labels that
>> you cared about -- giving a nice filtering mechanism to receive only
>> bugs you care about.
>>
>> Gitlab also does support individual accounts updating issues using a
>> generated personalized email address, so if the email workflow is
>> crucial to you, it is still available.
> 
> You mean that I can update via email, provided it's an address
> associated with my account?
> 

https://gitlab.com/qemu-project/qemu

Click the "bell" icon, choose "custom", and you can subscribe to issues 
project-wide if you'd like. (Reopen, New, Closed, Reassigned).

I started experimenting with using the gitlab issue tracker for my 
Python library project, I'll use it as an example here:

https://gitlab.com/jsnow/qemu/-/labels

You can "subscribe" to labels to be notified about tracker activity in 
just an area of your concern. Here I'm using "Python" and "QMP" labels 
for areas of concern for this topic area.

When an issue gets tagged with one of your subscribed labels, you'll 
receive a notification (I get an email) informing you of the new issue.

(Unfortunately, it looks like issues that are triaged to contain your 
tag after their initial creation only show you the tag change event and 
not the bug text. It might be the case that subscribing to *all* new 
bugs, but then subscribing to labels of concern is the way to go.)

You can reply directly to that email, or any update emails, to update 
the tracker.

Also, you can view your notification settings by going to 
https://gitlab.com/-/profile/notifications

and you can check out your notification settings per-group, per-project, 
etc.

Lastly, you can go to the issue tracker for a project e.g. 
https://gitlab.com/jsnow/qemu/-/issues and at the bottom (If you have 
permission, I assume?) you can click "Email a new issue to this 
project." and receive a special email address for you to use to create 
new issues:

  You can create a new issue inside this project by sending an email to 
the following email address:

The subject will be used as the title of the new issue, and the message 
will be the description. Quick actions and styling with Markdown are 
supported.

This is a private email address generated just for you. Anyone who gets 
ahold of it can create issues or merge requests as if they were you. You 
should reset it if that ever happens.

>>
>> I'm for it, or at least for beginning a pilot program where we
>> experiment with the idea for interested parties. I wanted to send up a
>> trial balloon to see how we were feeling about this.
>>
>> --js
> 
> 


