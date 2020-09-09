Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C282C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C9021973
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCuZN2PT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C9021973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwtL-0003hT-QB
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFwkd-0004ST-Rx
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 05:50:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50858
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFwkb-0008AU-5a
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 05:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599645048;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x7KD2yO9XMdfkxohp6JCadNavF+jVGZf4rRI37N77LM=;
 b=YCuZN2PTkfyHpwiOZ3nzwb9ZFAqN5R0gzRzuJd13yWLg1LKrDlYpnbNjbf1wRj/FwtBnvv
 EU30DZzThymCeziEjKvsxUmNS0A6AnuiK6Otdg44VFsQcoj20CFPFCkTKRH1m6jjxHqiKL
 IgZz39Py6/JL0ti1SMgiEWVvZOMP8uM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-QFxHpZ1XPZiJ6zMMciIFQw-1; Wed, 09 Sep 2020 05:50:45 -0400
X-MC-Unique: QFxHpZ1XPZiJ6zMMciIFQw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B908B8030CD;
 Wed,  9 Sep 2020 09:50:44 +0000 (UTC)
Received: from redhat.com (ovpn-115-8.ams2.redhat.com [10.36.115.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C13E75D9E8;
 Wed,  9 Sep 2020 09:50:38 +0000 (UTC)
Date: Wed, 9 Sep 2020 10:50:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH 0/5] Add support for loading SMBIOS OEM strings from a file
Message-ID: <20200909095035.GO1011023@redhat.com>
References: <20200908165438.1008942-1-berrange@redhat.com>
 <d3c345b6-c2db-ef61-2ac0-afc0f9f737c2@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d3c345b6-c2db-ef61-2ac0-afc0f9f737c2@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:05:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 09, 2020 at 11:44:40AM +0200, Laszlo Ersek wrote:
> On 09/08/20 18:54, Daniel P. Berrangé wrote:
> > I previously added support for SMBIOS OEM strings tables but only
> > allowed for data to be passed inline. Potential users indicated they
> > wanted to pass some quite large data blobs which is inconvenient todo
> > inline. Thus I'm adding support for passing the data from a file.
> >
> > In testing this I discovered the hard way that on x86 we're limited to
> > using the SMBIOS 2.1 entry point currently. This has a maximum size of
> > 0xffff, and if you exceed this all sorts of wierd behaviour happens.
> >
> > QEMU forces SMBIOS 2.1 on x86 because the default SeaBIOS firmware
> > does not support SMBIOS 3.0. The EDK2 firmware supports SMBIOS 3.0 and
> > QEMU defaults to this on the ARM virt machine type.
> >
> > This series adds support for checking the SMBIOS 2.1 limits to protect
> > users from impossible to diagnose problems.
> >
> > There is also a fix needed to SeaBIOS which fails to check for
> > integer overflow when it appends the type 0 table.
> >
> >   https://mail.coreboot.org/hyperkitty/list/seabios@seabios.org/thread/3EMIOY6YS6MG5UQN3JJJS2A3DJZOVFR6/
> >
> > IIUC, SMBIOS 3.0 should onlky be limited by what you can fit into RAM,
> > but in testing, EDK2 appears to hang shortly after the SMBIOS 3.0 data
> > size exceeds 128 KB. I've not spotted an obvious flaw in EDK2 or QEMU,
> > nor do I attempt to enforce a limit in QEMU for SMBIOS 3.0.

snip

> So we're exceeding "__brk_limit".
> 
> ... I'm quite getting out of my league here, but "__brk_limit" seems to
> be controlled by "brk_reservation" in "arch/x86/kernel/vmlinux.lds.S"...
> and ultimately through the RESERVE_BRK() macro:
> 
> [arch/x86/include/asm/setup.h]
> 
> > /*
> >  * Reserve space in the brk section.  The name must be unique within
> >  * the file, and somewhat descriptive.  The size is in bytes.  Must be
> >  * used at file scope.
> >  *
> >  * (This uses a temp function to wrap the asm so we can pass it the
> >  * size parameter; otherwise we wouldn't be able to.  We can't use a
> >  * "section" attribute on a normal variable because it always ends up
> >  * being @progbits, which ends up allocating space in the vmlinux
> >  * executable.)
> >  */
> > #define RESERVE_BRK(name,sz)                                            \
> 
> OK, so let's see RESERVE_BRK() invocations... The relevant match is
> likely the one below:
> 
> > arch/x86/kernel/setup.c:RESERVE_BRK(dmi_alloc, 65536);
> 
> ... Then see kernel commits:
> 
> - 6de6cb442e76 ("x86: use brk allocation for DMI", 2009-03-14)
> 
> - 796216a57fe4 ("x86: allow extend_brk users to reserve brk space",
> 2009-03-14)
> 
> - e808bae2407a ("x86: Do not reserve brk for DMI if it's not going to be
> used", 2010-02-25)
> 
> Commit 796216a57fe4 is helpful:
> 
> >     Add RESERVE_BRK(name, size) macro to reserve space in the brk
> >     area.  This should be a conservative (ie, larger) estimate of
> >     how much space might possibly be required from the brk area.
> >     Any unused space will be freed, so there's no real downside
> >     on making the reservation too large (within limits).
> 
> So it seems like the 64K limit could be increased, but still
> - it requires guest kernels to be rebuilt,
> - it doesn't seem suitable for passing MBs of data (on x86 anyway).

Yeah, this feels like we're just venturing into a bad part of town.
Simplest is probably to just document that applications should never
expect more than 64kb of total SMBIOS data to be viable regardless
of the SMBIOS entry point.

Given this, I'm thinking it might be overkill to even both with
supporting SMBIOS 3.0 for x86, unless it offers some other compelling
benefit over SMBIOS 2.1 that you know of ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


