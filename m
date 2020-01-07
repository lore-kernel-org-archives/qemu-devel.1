Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2984C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:40:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ACC92070E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aEsM7CHo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ACC92070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ionE6-0007BQ-36
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 06:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1iomWy-0001D1-6U
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:56:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1iomWw-00083I-Qo
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:56:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56554
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1iomWw-000832-Mk
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578394570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EES1OAuNaFge24Ux8k5oj0ISuj+xvaYv7MXVNmDEGL4=;
 b=aEsM7CHoqDIWVjYItp51IHTXENNWeE5paVkDWePqEyxr2hyVXNxVviK3aUBPyEuiy1K1ZV
 /70zwgGzWWCEZ5//2j4VcY7hnHuTRdYDA2LGOSRt7wawDgzBGK2JjbfdO3V78rO4KNPxqo
 /4fby+qJOfWfmK3tmU5jG9/Z+nwpfOw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-w2L3vccSOT6Uf8lxMsS48w-1; Tue, 07 Jan 2020 05:56:08 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E467801E6C;
 Tue,  7 Jan 2020 10:56:07 +0000 (UTC)
Received: from [10.43.2.30] (unknown [10.43.2.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9C895D9D6;
 Tue,  7 Jan 2020 10:55:57 +0000 (UTC)
Subject: Re: Making QEMU easier for management tools and applications
To: Kevin Wolf <kwolf@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
 <c445ecbe-1559-462a-31c2-f44f60e60a8b@redhat.com>
 <20200107093655.GF4076@linux.fritz.box>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <d18b8c0f-3054-dd63-0d10-dda6d0655175@redhat.com>
Date: Tue, 7 Jan 2020 11:55:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200107093655.GF4076@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: w2L3vccSOT6Uf8lxMsS48w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 10:36 AM, Kevin Wolf wrote:
> The easy way out would be tying libvirt to a specific QEMU version. And
> I'm only half joking.
> 
> If libvirt didn't exist yet and we needed a management library for QEMU,
> what we would build now would probably not look much like libvirt looks
> today. We wouldn't try to have basic support for every hypervisor out
> there, but integrate it much closer with QEMU and avoid much of the
> backwards compatibility requirements that the interface between QEMU and
> libvirt has (which requires us to deal with compatibility twice for
> everything).
> 

By doing this, you would force your consumers to implement compatibility 
layer each on their own. Freshly finished blockdev is a beautiful 
example - OpenStack, oVirt and whatnot - they all are/can use blockdev 
without even noticing, because the API provided by libvirt is stable and 
provides abstraction, i.e. you don't need to change anything in your 
domain XML to use blockdev.

Of course, you can apply the argument one more time and have mgmt 
application tied to a specific version of qemu. But even that is not 
good enough, because with backports version is just meaningless number.

> Maybe it would even be part of the QEMU repository, allowing a single
> patch series to implement a new feature in the system emulator and
> expose it in the API immediately instead of waiting for the next QEMU
> release before libvirt can even think about implementing support for it.

Thing is, it's not just qmp that a mgmt application has to master, it's 
also process managing (and with growing number of helper binaries this 
is not as trivial as fork() + exec()). This would need to be the bare 
minimum your API layer has to provide to be consumable by anybody.
But then you have some advanced subsystems to take care of (CGroups, 
SELinux, etc.) which are used heavily by OpenStack. oVirt and friends.

> 
> So should libvirt move in that direction? Do people actually still make
> much use of its multi-hypervisor nature, or would it make sense to split
> it into separate libraries for each hypervisor that can be much tighter
> integrated with (a specific version of) the respective hypervisor?

Truth to be told, I don't think libvirt is held back by its attempts to 
provide hypervisor agnostic APIs. Sure, it leads to some weirdness (e.g. 
different naming in libvirt and qemu), but as a libvirt developer I 
don't remember feeling blocked by this multi-hypervisor nature (not to 
mention that this has saved us couple of times).

Also, it would be not correct to think that a feature is implemented for 
all hypervisors in libvirt. I mean, when implementing a feature I 
usually implement it only for qemu driver and don't even look at other 
drivers (unless I'm doing a change in a core that causes build 
failures). On the other hand, I do sometimes review patches posted by 
developers from other companies which have interest in different 
hypervisors (e.g. there is a SUSE guy working on LXC driver, and another 
SUSE guy working on libxenlight (basically Xen)), so I do spend some 
time not working on qemu driver, but I'd say it's negligible.

Michal


