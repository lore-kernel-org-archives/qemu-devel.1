Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82189C2BC11
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 13:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F5C21D92
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 13:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0ZPbudi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F5C21D92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGjSk-0001b4-U0
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 09:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGjRT-0000Ae-4m
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 09:50:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26609
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGjRQ-0004pp-2h
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 09:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599832214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9l3rsCVunPDqwfQ10JNApv17QPnEFiX8rt7toCmbdQg=;
 b=K0ZPbudiI3ZDTLJ7NbWlKgEJoizD69+OkUBUT4Y1h8LhdOzyIgAy53CdACcOrYCEqOvZDa
 NNZB82hBtt3DMCTP6uS4jAxbs3g19TzNplsXlpsJDQb00big1UG75tfcov8yxeFb/BpQte
 ZKEBWTnTK8o+lFnONXOXWsLyHjw7TgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-1Bf4VKgdPC-STY936XWuJw-1; Fri, 11 Sep 2020 09:50:12 -0400
X-MC-Unique: 1Bf4VKgdPC-STY936XWuJw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87CA3800050;
 Fri, 11 Sep 2020 13:50:11 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BE005C1BD;
 Fri, 11 Sep 2020 13:50:08 +0000 (UTC)
Date: Fri, 11 Sep 2020 09:50:07 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH 00/18] chardev: QOM cleanups
Message-ID: <20200911135007.GR1618070@habkost.net>
References: <20200910194903.4104696-1-ehabkost@redhat.com>
 <CAJ+F1CLLKesMvZo4DJcC=f387d_fN8g--qX8YEQGu8Thf1qotA@mail.gmail.com>
 <20200911081018.GA1203593@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200911081018.GA1203593@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 09:43:46
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
Cc: QEMU <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 11, 2020 at 09:10:18AM +0100, Daniel P. Berrangé wrote:
> On Fri, Sep 11, 2020 at 12:07:27PM +0400, Marc-André Lureau wrote:
> > Hi
> > 
> > On Thu, Sep 10, 2020 at 11:50 PM Eduardo Habkost <ehabkost@redhat.com>
> > wrote:
> > 
> > > Some chardev QOM cleanup patches had to be dropped from my queue
> > > due to build erros introduced by code movements across ifdef
> > > boundaries at char-parallel.c.  This series redo the changes from
> > > those patches, but the macro renames are now a little different:
> > >
> > > In this version I have decided to rename the type checking macros
> > > from *_CHARDEV to CHARDEV_* instead of renaming tye
> > > TYPE_CHARDEV_* constants to TYPE_*_CHARDEV, to make the
> > > identifiers actually match the QOM type name strings
> > > ("chardev-*").
> > >
> > 
> > Sounds reasonable to me, but it loses the matching with the
> > structure/object type name though.
> > 
> > - MuxChardev *d = MUX_CHARDEV(s);
> > + MuxChardev *d = CHARDEV_MUX(s);
> > 
> > I have a preference for the first. Unless we rename all the chardev types
> > too...
> 
> I tend to think the structs should be renamed too - I've always considerd
> them to be backwards.

FWIW, "MuxChardev" sounds better to me.  Not a big deal, though.

(Also, I am not planning to touch any struct names for the sake
of the new QOM declaration/definition macros.  Renaming the type
checking functions is enough churn.)

> 
> > Imho, the QOM type name is mostly an internal detail, the C type name is
> > dominant in the code.
> 
> Err it is the reverse. The QOM type name is exposed public API via QOM
> commands, while the C struct names are a internal private detail.

I agree with Marc-André here.  The C code is not just a detail.
Code needs be easy to read, change and refactor.  I'd really
prefer to not have the external public API forcing a specific
internal naming style.

We have at least one case where it's probably going to be
impossible to keep an exact match between the QOM type and type
checker functions: "accel"/ACCEL.
https://lore.kernel.org/qemu-devel/CAFEAcA9WEjne5TfwggVWPuBprkRs-a2-iNc43Xa_jBamaf9t8A@mail.gmail.com/

-- 
Eduardo


