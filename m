Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E483C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE2482466E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G95pDsV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2482466E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFe6-0005Ho-7q
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1idEeZ-00021b-3l
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:32:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1idEeY-0007yY-0W
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:32:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57116
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1idEeX-0007th-Gp
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575642733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=dBw5Hht3i5NT1wbo3N9PvhLCY6shtHxMkjWxQHye7yo=;
 b=G95pDsV+YzWC3XGuUyRRZdJ5vrqUC+atiiK+BcjLX0kFZCFJp9YF9DykpaqhAALk6ciqfR
 NDJvIyiJIUUxjN0wwJVfJaHgNxfqBdD+YFr6/ZBghotabACmN/2MeQXH/FExaFz9pzaTug
 KMxDh8Li4UeZrjw3Y4RmAIPRVP7RSPo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-XdwVLilgPDqvbmYjUaw09w-1; Fri, 06 Dec 2019 03:29:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A458EDB60
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2019 08:29:39 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-138.ams2.redhat.com [10.36.117.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 673BE5DA60;
 Fri,  6 Dec 2019 08:29:30 +0000 (UTC)
Subject: Re: [PATCH 0/3] Remove deprecated pc-0.x machine types and related
 hacks
To: Markus Armbruster <armbru@redhat.com>
References: <20191205160652.23493-1-thuth@redhat.com>
 <874kyeosmg.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a25c0ae9-38cf-8a8f-730e-b618ad05bb7b@redhat.com>
Date: Fri, 6 Dec 2019 09:29:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <874kyeosmg.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: XdwVLilgPDqvbmYjUaw09w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/12/2019 07.49, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> These have been on the deprecation list since a year now, so it's
>> time to finally remove the pc-0.x machine types.
>>
>> We then can also remove some compatibility hacks in the devices, i.e.
>> the "use_broken_id" in ac97 and "command_serr_enable" in PCI devices.
>>
>> Note that there is also the "rombar" property of the PCI devices which
>> is now not required for the x86 machine types anymore. But it seems to
>> me like this is still used by various people to bypass the ROM loading
>> for PCI devices in certain cases, so I did not remove that property here
>> yet.
> 
> With this series applied:
> 
> $ git-grep pc-0
> hw/display/vga-pci.c:        /* compatibility with pc-0.13 and older */
> hw/display/vga.c:    /* With pc-0.12 and below we map both the PCI BAR and the fixed VBE region,
> hw/display/vmware_vga.c:        /* compatibility with pc-0.13 and older */

These are the "rombar" hacks that I've mentioned above. The question is
whether we want to remove them or whether I should just adjust the comments?

> hw/i386/pc_piix.c:/* PC compat function

Right, the comment still needs to be adjusted.

 Thomas


