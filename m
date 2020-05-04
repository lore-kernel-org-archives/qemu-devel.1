Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D8CC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1759920707
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjS8GM/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1759920707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdqY-00042Z-4m
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVdgD-0004U8-RQ
 for qemu-devel@nongnu.org; Mon, 04 May 2020 12:10:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34320
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVdgC-0002ux-B9
 for qemu-devel@nongnu.org; Mon, 04 May 2020 12:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588608650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XLS+Nr7SucPK2pP97CaSzK3OzQfx2UPSET1T2/8209k=;
 b=GjS8GM/K0WLBAimHJUXBX8m13NRBIzMyLjA8lGPgFpFhCwpqr4mYZcVnFZN4TO5o9iwA6g
 Ceo5iRbkHJ/j3fYIR6ILeZvKxZJHh86+cXcvSlrQ6xiJSqUO+YZAzjp25Iz9p5THdbT8BG
 pfD3ONbLdTzxk/cd0TFjQ81KPsetHQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-pJaDS42GM1iE4SOMq8NSow-1; Mon, 04 May 2020 12:10:48 -0400
X-MC-Unique: pJaDS42GM1iE4SOMq8NSow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B0EC18FE861;
 Mon,  4 May 2020 16:10:37 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F30595D9DA;
 Mon,  4 May 2020 16:10:09 +0000 (UTC)
Date: Mon, 4 May 2020 18:10:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 10/15] acpi: parallel: don't use _STA method
Message-ID: <20200504181008.4127d85d@redhat.com>
In-Reply-To: <20200504132516.yfdysvnyv3oys75a@sirius.home.kraxel.org>
References: <20200429140003.7336-1-kraxel@redhat.com>
 <20200429140003.7336-11-kraxel@redhat.com>
 <20200430182524.5e6fd311@redhat.com>
 <20200504132516.yfdysvnyv3oys75a@sirius.home.kraxel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 4 May 2020 15:25:16 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Thu, Apr 30, 2020 at 06:25:24PM +0200, Igor Mammedov wrote:
> > On Wed, 29 Apr 2020 15:59:58 +0200
> > Gerd Hoffmann <kraxel@redhat.com> wrote:
> >   
> > > The _STA method dates back to the days where we had a static DSDT.  The
> > > device is listed in the DSDT table unconditionally and the _STA method
> > > checks a bit in the isa bridge pci config space to figure whenever a
> > > given is isa device is present or not, then evaluates to 0x0f (present)
> > > or 0x00 (absent).
> > > 
> > > These days the DSDT is generated by qemu anyway, so if a device is not
> > > present we can simply drop it from the DSDT instead.
> > > 
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > Reviewed-by: Igor Mammedov <imammedo@redhat.com>  
> > 
> > looking more at it, we should also cleanup no longer used LPEN field
> > the same applies to similar fields for serial and ...   
> 
> IIRC these bits are in the chipset specs so we should not remove them
> from pci config space.
we also can't touch device model due to migration resons
(ACPI code that checks STA bits is in the wild, and us removing ACPI part
of it won't change that)

> 
> Removing from DSDT should be possible indeed (I guess this is what you
> mean?)
yep

> 
> take care,
>   Gerd
> 


