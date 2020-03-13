Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A0BC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 10:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBCA6206E7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 10:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcRmOc1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBCA6206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jChDo-0008Ek-0n
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 06:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jChC9-0006ol-DE
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 06:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jChC7-0002AF-EX
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 06:05:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34771
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jChC7-00023z-83
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 06:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584093926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5/1mZfVV49bdl7SXFTqOMP7K9pzC66yUxjwlZxpbdQQ=;
 b=EcRmOc1avu4XGUHcU0T+qaKJV7DkXvdQzlpp4TRViEOJimgVAUOaFrr9VxpHnfZQz7PThG
 Xt1kV9tCfTp1lpNOFbl05Vz6t9+nuPAsqGWMyRY3XzPyj06Y1wk1WUWb2Pi26PbvXNjypl
 cjg4EaVDwDDe785IChviDPDmBaJauPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-0v_5aIvYN7iMr96XomRlAw-1; Fri, 13 Mar 2020 06:05:24 -0400
X-MC-Unique: 0v_5aIvYN7iMr96XomRlAw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97B6710509DF;
 Fri, 13 Mar 2020 10:05:23 +0000 (UTC)
Received: from localhost (ovpn-200-60.brq.redhat.com [10.40.200.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D0D97386F;
 Fri, 13 Mar 2020 10:05:17 +0000 (UTC)
Date: Fri, 13 Mar 2020 11:05:16 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH] acpi: Add Windows ACPI Emulated Device Table (WAET)
Message-ID: <20200313110516.6f4ca2b2@redhat.com>
In-Reply-To: <8b3f3166-cc60-eae2-c20d-ad4a593c3e30@oracle.com>
References: <20200311170826.79419-1-liran.alon@oracle.com>
 <20200312172745.1b7b2222@redhat.com>
 <8b3f3166-cc60-eae2-c20d-ad4a593c3e30@oracle.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Elad Gabay <elad.gabay@oracle.com>, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Mar 2020 19:28:31 +0200
Liran Alon <liran.alon@oracle.com> wrote:

> On 12/03/2020 18:27, Igor Mammedov wrote:
> > On Wed, 11 Mar 2020 19:08:26 +0200
> > Liran Alon <liran.alon@oracle.com> wrote:  
> >> +
[...]
> > we typically do not version ACPI table changes (there might be exceptions
> > but it should be a justified one).
> > ACPI tables are considered to be a part of firmware (even though they are
> > generated by QEMU) so on QEMU upgrade user gets a new firmware along with
> > new ACPI tables.  
> 
> Hmm... I would have expected as a QEMU user that upgrading QEMU may 
> update my firmware exposed table (Such as ACPI),
> but only if I don't specify I wish to run on a specific machine-type. In 
> that case, I would've expect to be exposed with exact same firmware 
> information.
That would be ideal but it's not the case with current QEMU, even with
specific machine type user will get new firmware when it's started with
upgraded QEMU which usually ships with new firmware.

mgmt layer theoretically can take care of maintaining different firmwares
on host and explicitly specify which should be used (though I'm not aware
of any doing it)

another issue with adding flags consistently for every acpi related
change would complicate code quite a bit making it hard to read/maintain,
hence flags are used only when we have to introduce them (i.e when it
would break guest).

> I understood that this was one of the main reasons why ACPI/SMBIOS 
> generation was moved from SeaBIOS to QEMU.

If I recall correctly, Michael moved table to QEMU so we won't have to
extend ABI for constantly growing ACPI interface and then maintain it
forever, which indeed would require using compat machinery for every
knob (which is unsustainable).

[...]


