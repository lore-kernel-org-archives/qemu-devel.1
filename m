Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8AAC55179
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:46:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01D41206FA
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2dUaRAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D41206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kahSc-0001Z2-TT
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 10:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kahRV-00011A-PJ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 10:44:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kahRS-0005fO-ME
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 10:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604591088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+JHCfOF8zLGcfW9mCwYJHbrmumTYixtWSqo/7uKm1pI=;
 b=B2dUaRAm07URh702NegzGjPf65h8DOgdSgo04sKH7Yusg3q8IgKoJ0x4IVnpV2s9exVNbJ
 9IF6eHzPIEaf7EI76Jp2bxIVOLxLZt33Qx8UmWboCtuUcNL+Pp+X6ToMAJrN7jnkQZox8m
 sOTyebbjjBG0rKJHJL75mcqDQrR4JvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-5tZu6tjMO6ShbGvcaZV12Q-1; Thu, 05 Nov 2020 10:44:45 -0500
X-MC-Unique: 5tZu6tjMO6ShbGvcaZV12Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 173D9EC103;
 Thu,  5 Nov 2020 15:44:44 +0000 (UTC)
Received: from [10.10.113.61] (ovpn-113-61.rdu2.redhat.com [10.10.113.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D23D960C17;
 Thu,  5 Nov 2020 15:44:42 +0000 (UTC)
Subject: Re: Migrating to the gitlab issue tracker
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <bda4f471-8ed6-3832-29ac-279a6d3bb7cc@redhat.com>
 <20201029174114.47e2b351.cohuck@redhat.com>
 <CAKmqyKOY+5WcxUg3Rvq2t3vYWOHrHQdhcv8PkiqZX2zVMdqJ3Q@mail.gmail.com>
 <3713093e-bf3b-bf23-a8d0-70fe429032ba@redhat.com>
 <c7308133-cf29-8668-f781-6d025eb16722@redhat.com>
 <3d9b264a-5e1f-b936-8455-bafc6b89ebe5@redhat.com>
 <20201030092324.GC99222@redhat.com>
 <CAFEAcA_8PKkfeninOXCzPdtY7WVHnC7Pkon758zXe7h9MzS+aw@mail.gmail.com>
 <20201030101013.GG99222@redhat.com>
 <CAFEAcA9crYaa8-guWkYFDYgEi8=gH3xaXraD7iWZMHM6vryAtw@mail.gmail.com>
 <c75f91b7-6972-9e48-efa9-49792fc011d2@redhat.com>
 <37a00b98-428b-d1ca-79c2-7846ccfda651@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <de1d3c49-967b-bc96-220f-3deabc441dfa@redhat.com>
Date: Thu, 5 Nov 2020 10:44:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <37a00b98-428b-d1ca-79c2-7846ccfda651@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Alistair Francis <alistair23@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 1:14 AM, Thomas Huth wrote:
> On 05/11/2020 01.06, John Snow wrote:
>> On 10/30/20 6:57 AM, Peter Maydell wrote:
>>> On Fri, 30 Oct 2020 at 10:10, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>> This
>>>> makes it more appealing to leave existing bugs in the LP tracker until
>>>> they are resolved, auto-closed, or there is a compelling reason to move
>>>> to gitlab.
>>>
>>> The compelling reason is that there is no way that I want to
>>> have to consult two entirely separate bug tracking systems
>>> to see what our reported bugs are. We must have an entry
>>> in the new BTS for every 'live' bug, whether it was originally
>>> reported to LP or to gitlab.
> [...]
>> OK. I will try to investigate using the Launchpad API to pull our
>> existing information, and then using the Gitlab API to re-create them.
> 
> Before we migrate hundreds of bugs around, I think we should first check
> which ones are stale, and which are still valid. So for all bugs that are in
> "New" state and older than, let's say 2 years, I think we should add a
> message a la:
> 
>   The QEMU project is currently considering to move its bug tracking to
> another system. For this we need to know which bugs are still valid and
> which could be closed already. Thus we are setting all older bugs to
> "Incomplete" now. If you still think this bug report here is valid, then
> please switch the state back to "New" within the next 60 days, otherwise
> this report will be marked as "Expired". Thank you and sorry for the
> inconvenience.
> 

One reason to NOT do this is that if the bug does wind up being 
legitimate -- perhaps it is still a top google hit for searching a 
particular error string -- once we have migrated, there will be no 
recourse for the hapless googler.

We can leave a generic forwarder to the new tracker once we migrate, but 
there's no way to "re-open" the issue. If someone re-files on the new 
tracker, they won't be able to update the bug to leave a new breadcrumb.

However, if we migrate the bug first, we can leave breadcrumbs on the 
old tracker pointing to the new one, and then if the bug winds up being 
legitimate, googlers can follow the breadcrumb to the gitlab issue and 
either update that bug, reopen it, etc.

So I might actually, though it seems strange, recommend migrating all of 
these bugs but labeling any that are over that 2 year mark with "stale", 
then closing them on the new system.

> Then set the state to "Incomplete" and wait and see how many bugs expire in
> 60 days.
> 
> As a start, we could use the bug list from my QEMU bug dashboard here:
> 
>   http://people.redhat.com/~thuth/qemu/bugs-dashboard.html
> 
> See the "Expired" tab for the list with old bugs.
> 
>   Thomas
> 
> 
> PS: I think we should also not migrate the bugs marked with "Wishlist" ...
> if people are interested in new features, they should either contribute code
> or pay for support, but opening feature requests often simply get ignored
> completely, so we should likely rather close them now, too, instead of
> migrating them.
> 

I might recommend a similar thing here: migrate-then-close.



P.S.: I am playing around with the Launchpad API right now. I think what 
I can see as a "non-contributor" is enough for us to migrate, but just 
in case, can I receive elevated privileges?

--js


