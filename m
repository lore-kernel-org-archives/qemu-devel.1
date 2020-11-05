Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E44FC00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 06:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C7521556
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 06:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sv7YfoMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C7521556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaYZ6-0004kE-4Q
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 01:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kaYXy-0004Ef-W5
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 01:14:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47769)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kaYXu-0005q8-Nv
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 01:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604556893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4JLP0whgH9EJOjnGptw9QzwP77kKkdkLlXPAxmXeosc=;
 b=Sv7YfoMtsN0tk2e88S5PaEYFzLjPaPkNx0DxVIpw82uobtv9OorWaLS7gM4iL78thsntCV
 3HRfgteeuOJZ3l5WfkoLTSppu1BdtxGi9TZwlO3ANwCN7QOkE4MFD4q66UtEs24bIephTR
 Eu6c7Srccl8m4P+iZ0Dz/M9YnrbOzH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-WGWdXq__MS6s_h9a50xPug-1; Thu, 05 Nov 2020 01:14:51 -0500
X-MC-Unique: WGWdXq__MS6s_h9a50xPug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2044B186DD22;
 Thu,  5 Nov 2020 06:14:50 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-117.ams2.redhat.com [10.36.112.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C40B6EF70;
 Thu,  5 Nov 2020 06:14:47 +0000 (UTC)
Subject: Re: Migrating to the gitlab issue tracker
To: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
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
From: Thomas Huth <thuth@redhat.com>
Message-ID: <37a00b98-428b-d1ca-79c2-7846ccfda651@redhat.com>
Date: Thu, 5 Nov 2020 07:14:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <c75f91b7-6972-9e48-efa9-49792fc011d2@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 05/11/2020 01.06, John Snow wrote:
> On 10/30/20 6:57 AM, Peter Maydell wrote:
>> On Fri, 30 Oct 2020 at 10:10, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>> This
>>> makes it more appealing to leave existing bugs in the LP tracker until
>>> they are resolved, auto-closed, or there is a compelling reason to move
>>> to gitlab.
>>
>> The compelling reason is that there is no way that I want to
>> have to consult two entirely separate bug tracking systems
>> to see what our reported bugs are. We must have an entry
>> in the new BTS for every 'live' bug, whether it was originally
>> reported to LP or to gitlab.
[...]
> OK. I will try to investigate using the Launchpad API to pull our
> existing information, and then using the Gitlab API to re-create them. 

Before we migrate hundreds of bugs around, I think we should first check
which ones are stale, and which are still valid. So for all bugs that are in
"New" state and older than, let's say 2 years, I think we should add a
message a la:

 The QEMU project is currently considering to move its bug tracking to
another system. For this we need to know which bugs are still valid and
which could be closed already. Thus we are setting all older bugs to
"Incomplete" now. If you still think this bug report here is valid, then
please switch the state back to "New" within the next 60 days, otherwise
this report will be marked as "Expired". Thank you and sorry for the
inconvenience.

Then set the state to "Incomplete" and wait and see how many bugs expire in
60 days.

As a start, we could use the bug list from my QEMU bug dashboard here:

 http://people.redhat.com/~thuth/qemu/bugs-dashboard.html

See the "Expired" tab for the list with old bugs.

 Thomas


PS: I think we should also not migrate the bugs marked with "Wishlist" ...
if people are interested in new features, they should either contribute code
or pay for support, but opening feature requests often simply get ignored
completely, so we should likely rather close them now, too, instead of
migrating them.


