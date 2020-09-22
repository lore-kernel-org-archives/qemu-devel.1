Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DC5C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 14:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431DB214F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 14:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jRzzXlu3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431DB214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKj3s-0005Zu-B3
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 10:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKj30-000584-Ou
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 10:13:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKj2y-0005ef-HU
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 10:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600784011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/EIJB2Gdr6PcsqquBFohODzJp/sIzLD0tPb9sjVgIWo=;
 b=jRzzXlu37DTh64fXD9R2+XJ99SMSiuSv+iyRRj7ij5V+v00W55aot9HzZWrS7E0vBTkCfr
 pILXk5gU95fKClRDYD24TKfEtHhmotEuMP12BcXyziudLqg1zmT0xU+PgyQ5r+Krx9k+Z1
 4dk3n43Wtm622cKQW7Dd6FH1YTPr+Do=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-whDf1rRoPgikYq2R4g7EhA-1; Tue, 22 Sep 2020 10:13:13 -0400
X-MC-Unique: whDf1rRoPgikYq2R4g7EhA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EF891800D4A;
 Tue, 22 Sep 2020 14:13:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31DBA7A41F;
 Tue, 22 Sep 2020 14:13:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ADB881132E9A; Tue, 22 Sep 2020 16:13:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 10/20] docs/interop: Convert qemu-ga-ref to rST
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-11-peter.maydell@linaro.org>
 <875z8t7kd0.fsf@dusky.pond.sub.org>
 <CAFEAcA9ZPO32XC1NwH=qa4mNF8c_xZeW8Z6MTrJ0FLmB6kytXQ@mail.gmail.com>
 <87wo0mqavm.fsf@dusky.pond.sub.org>
 <CAFEAcA8uYhrpsYM5u+0MJKOK3R_NwPefC1jdJMYF3VWohe4mfA@mail.gmail.com>
Date: Tue, 22 Sep 2020 16:13:10 +0200
In-Reply-To: <CAFEAcA8uYhrpsYM5u+0MJKOK3R_NwPefC1jdJMYF3VWohe4mfA@mail.gmail.com>
 (Peter Maydell's message of "Tue, 22 Sep 2020 13:58:22 +0100")
Message-ID: <873639q4qx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 22 Sep 2020 at 13:01, Markus Armbruster <armbru@redhat.com> wrote=
:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> > The Sphinx interop manual has the usual footer:
>> > https://www.qemu.org/docs/master/interop/index.html
>> > "=C2=A92020, The QEMU Project Developers."
>> >
>> > The system manual has an explicit "License" section:
>> > https://www.qemu.org/docs/master/system/license.html
>> > but that's documenting the license of the program, not the
>> > manual (it's docs/system/license.rst).
>> >
>> > We could do any or all of:
>> >  * decide that we're happy with the current situation
>> >  * expand the "copyright" footer to something like
>> >    '=C2=A92020, The QEMU Project Developers; this manual is GPLv2'
>> >  * have a docs/foo/license.rst for each manual, and expand
>> >    it to mention the documentation license as well as the
>> >    code license
>> >
>> > Given that the Texinfo generated QMP/QGA references don't
>> > actually present this text to the reader, my inclination
>> > is to say that this is something we should address in
>> > a separate patchseries, not as part of this conversion.
>>
>> I think the manual should have a proper copyright notice.
>
> It does -- that's the standard Sphinx footer that reads
> "=C2=A92020, The QEMU Project Developers." What it's missing
> is more precise licensing information.

Yes.

>> If you'd prefer to (re-)add it later, stick in TODO comment.
>
> Where would you want a TODO to be ?

Before the patch, the licensing information is in
docs/interop/qemu-ga-ref.texi.  That file gets replaced by
docs/interop/qemu-ga-ref.rst, losing the licensing information.  What
about putting the TODO right there?


