Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0514AC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:38:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 875B521BE5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efJSqn7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875B521BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX2hR-0007yh-90
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 09:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kX2gN-0007S4-4K
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kX2gL-0007wB-NE
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603719424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7C2ayH26KYGWGb2OWxpQkjx9rYlDwqJAqkRUBSCv78I=;
 b=efJSqn7qDqGdK/2tItBnwXaACbBv70g9pnOLLFyA75SghFIdvgyyMYBHT+k8+fKpGTFU2S
 qjKbpiDUQGtijDRldb5H+NTFCqF84uFyMeTkX9wjVMGUxSxwzhsxwP5+3zWfQvdQUkQEk0
 rf5zaFmmgadgKk2hi6xTYSCvvCmfWu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-9vAuFOZqOYCFM1klvw0xew-1; Mon, 26 Oct 2020 09:37:02 -0400
X-MC-Unique: 9vAuFOZqOYCFM1klvw0xew-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 837EB1882FB3;
 Mon, 26 Oct 2020 13:37:01 +0000 (UTC)
Received: from localhost (unknown [10.40.208.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB9026EF66;
 Mon, 26 Oct 2020 13:36:59 +0000 (UTC)
Date: Mon, 26 Oct 2020 14:36:57 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 25/33] tests/acceptance: Add a test for the N800 and N810
 arm machines
Message-ID: <20201026143657.68147517@redhat.com>
In-Reply-To: <CAFEAcA_wP1t1+o_PnCOotHvs54qSxJQSyuhtbSCSg4oewD43ng@mail.gmail.com>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
 <20200228163840.23585-26-peter.maydell@linaro.org>
 <a049110f-b7cb-52bd-de77-6e1193b5b6de@amsat.org>
 <6ce6a790-c68e-e3ed-962e-ba6f49244315@redhat.com>
 <f02d74fb-af6e-6e04-7ce7-48ab09a20e4f@amsat.org>
 <f2f276a9-a6ad-a2f8-2fbc-f1aca5423f79@amsat.org>
 <20201023174351.31838a86@redhat.com>
 <c80350d2-3591-6541-abf3-960b69cedf7d@amsat.org>
 <20201023210445.2fa72562@redhat.com>
 <CAFEAcA_wP1t1+o_PnCOotHvs54qSxJQSyuhtbSCSg4oewD43ng@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 25 Oct 2020 17:03:43 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 23 Oct 2020 at 20:04, Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Fri, 23 Oct 2020 19:39:16 +0200
> > Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote: =20
> > > Are you saying arm_boot_info should hold a pointer to MachineState*
> > > instead of duplicating? =20
> >
> > yep, some parts of it (fdt related) already use MachineState* so it's
> > complete rewrite. The same probably applies to the fields you've just
> > quoted. =20
>=20
> Hmm, maybe, maybe not. The original design idea here was that
> the boot loader code took a structure defining only the things
> that the bootloader needed to know. It doesn't really need to
> know about all the stuff that's in MachineState, which is
> the state structure for the machine.

Yep It doesn't need all data the MachineState contains, but then we end up
with this kind of bugs which could be avoided if duplication were not there=
.
And some of the fields in  MachineState are pure bootloader data.

>=20
> thanks
> -- PMM
>=20


