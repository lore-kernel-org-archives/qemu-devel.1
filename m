Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A620C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 09:17:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 880F32087D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 09:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzIJjxWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880F32087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNuiH-0007FX-I9
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 05:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kNuhP-0006na-IN
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 05:16:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kNuhJ-0000Wz-Rv
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 05:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601543779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3TNLQcNoLUTQfEWGWlkUd3k+DXS+IdGfbZ8OVTlkGVc=;
 b=YzIJjxWjKZea3yxzi6tRVDWtf/rzRu/S6NyTPJ2eVOesK35SmJHRWM/F5kPKQYb3fT+kaR
 pdSxig8pn/GVc58OpxfvenODjVjKY6NYUhbGfoKwCKC1U6yv5+DwgyK4OjO6nMEs9h4Omb
 aywfnp+16LsTY/h+1LtNUKu8fnq56xw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-VAiDfoYsOJOSlJxtqxe5fQ-1; Thu, 01 Oct 2020 05:16:18 -0400
X-MC-Unique: VAiDfoYsOJOSlJxtqxe5fQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3951E1021203;
 Thu,  1 Oct 2020 09:16:17 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A99FA10016DA;
 Thu,  1 Oct 2020 09:16:13 +0000 (UTC)
Subject: Re: [PULL v4 00/48] virtio,pc,acpi: fixes, tests
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200929071948.281157-1-mst@redhat.com>
 <20200929070322-mutt-send-email-mst@kernel.org>
 <CAFEAcA_D+qM6jW9LeB4gpU-A9skUv8mpWWQJ1uu9xMjw7nwxOA@mail.gmail.com>
 <20200929071323-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8ec0e261-dd02-5160-dd05-b969c4627b02@redhat.com>
Date: Thu, 1 Oct 2020 11:16:12 +0200
MIME-Version: 1.0
In-Reply-To: <20200929071323-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/29/20 13:13, Michael S. Tsirkin wrote:
> On Tue, Sep 29, 2020 at 12:07:01PM +0100, Peter Maydell wrote:
>> On Tue, 29 Sep 2020 at 12:04, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>
>>> On Tue, Sep 29, 2020 at 03:20:52AM -0400, Michael S. Tsirkin wrote:
>>>> Changes from v3:
>>>> - dropped reconnect tests
>>>> - added more fixes, an smbios feature
>>>>
>>>> The following changes since commit 74504514b154ebebdff577d88e4bf5c13074e9ed:
>>>>
>>>>   Merge remote-tracking branch 'remotes/alistair/tags/pull-register-20200927' into staging (2020-09-28 16:49:10 +0100)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>>>>
>>>> for you to fetch changes up to 8138405528c29af2a850cd672a8f8a0b33b7ab40:
>>>
>>> Ani Sinha pointed out that this included unnecessary files, I pushed out
>>> a new commit 192d48b4ae4216f0dc40fba35e8edf3b92713aa7 which should be
>>> ok.
>>
>> Oops, I just merged 8138405528c before reading this mail. Could
>> you send another pullreq which makes the fixes as changes to master,
>> please?
>>
>> thanks
>> -- PMM
> 
> Done. Sorry about making this mess.
> 

This was a large pullreq; on my end, I'm thankful that Igor's patches
are now upstream. Also, commit f142e4ede728 ("tests/acpi: drop
unnecessary files", 2020-09-29) exists now.

Thanks!
Laszlo


