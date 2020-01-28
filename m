Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5C6C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:32:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85AE924681
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lxn76Gtw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AE924681
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwP6w-00060c-Nz
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 06:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <abologna@redhat.com>) id 1iwP5t-0005LS-Bc
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <abologna@redhat.com>) id 1iwP5r-0001LV-RE
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:31:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47638
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <abologna@redhat.com>) id 1iwP5p-00018c-CI
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580211100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bhyhTo/GJZ03hPyXZgtCn4Y09lckBLWsvstF/M9NfKo=;
 b=Lxn76Gtw5kv6g2ei596hP5mSIaJFXnNy+sYFEmt+sBN2mYriwU4iKWKMZc32Iqi/Cbzujj
 x7zlNKxZUiCeF9mW9kfJH2XF/ByNlaXRnlEwHQu3GqKrBv8/Zfz1qFehsDItHe/edrSULh
 WbyPYAeQmVojWMBJcFuHsmXeUA9h2vQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-B6k2w_UrPH6u6jpca3Odog-1; Tue, 28 Jan 2020 06:31:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DBC813F1;
 Tue, 28 Jan 2020 11:31:35 +0000 (UTC)
Received: from kinshicho.usersys.redhat.com (unknown [10.43.2.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4AE660C18;
 Tue, 28 Jan 2020 11:31:33 +0000 (UTC)
Message-ID: <f8c6e5cccc0dfc6a02cc6746808c023a4a4ff238.camel@redhat.com>
Subject: Re: [PATCH qemu v5] spapr: Kill SLOF
From: Andrea Bolognani <abologna@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy
 <aik@ozlabs.ru>
Date: Tue, 28 Jan 2020 12:31:31 +0100
In-Reply-To: <20200123051156.GO2347@umbus.fritz.box>
References: <20200110020925.98711-1-aik@ozlabs.ru>
 <20200121051100.GG265522@umbus.fritz.box>
 <2aee3928-0acb-65ee-de54-de2e8106a6ba@ozlabs.ru>
 <20200122063222.GJ2347@umbus.fritz.box>
 <6ccbb008-9300-0e4d-bfc2-873d8562cb68@ozlabs.ru>
 <20200123051156.GO2347@umbus.fritz.box>
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: B6k2w_UrPH6u6jpca3Odog-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-01-23 at 16:11 +1100, David Gibson wrote:
> On Wed, Jan 22, 2020 at 06:14:37PM +1100, Alexey Kardashevskiy wrote:
> > On 22/01/2020 17:32, David Gibson wrote:
> > > I'm not thinking of "grub" as a separate option - that would be the
> > > same as "vof".  Using vof + no -kernel we'd need to scan the disks in
> > > the same way SLOF does, and look for a boot partition, which will
> > > probably contain a GRUB image. 
> > 
> > I was hoping we can avoid that by allowing
> > "-kernel grub" and let grub do filesystems and MBR/GPT.
> 
> I don't want that to be the only way, because I want the GRUB
> installed by the OS installer to be the GRUB we use.

Agreed, the bootloader and the kernel should live inside the guest
image and not on the host's filesystem.

-- 
Andrea Bolognani / Red Hat / Virtualization


