Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671BBC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADDCD2388B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWpxie1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDCD2388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKh05-0002qV-BP
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 08:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKgz6-0002Ok-N3
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:01:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37117)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKgz4-0004gl-1v
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600776080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eOkaQrUB9m3f9G5nII3iDJbEHDA9mw2l6Liq9CvVggo=;
 b=eWpxie1oXXCwTnO2bVX2hmHUll/A1lg0WBKc7kHoArordPCuIOYPxTi4pf+DaSMw8hd9wJ
 u54uwTEvOd5Qtqz2lG0W/9aijQkfC6XlOYp5FpNRTp8LAEHKI/0OgxdLFaXN7wy8paPnV6
 hFRBcBFk4gWmU62TvszRaHccO0UFuQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-kqkY8EfAM8Ka1wO7-fY7xQ-1; Tue, 22 Sep 2020 08:01:15 -0400
X-MC-Unique: kqkY8EfAM8Ka1wO7-fY7xQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73EEB88C7BC;
 Tue, 22 Sep 2020 12:00:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C7199CBA;
 Tue, 22 Sep 2020 12:00:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9CD961132E9A; Tue, 22 Sep 2020 14:00:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 10/20] docs/interop: Convert qemu-ga-ref to rST
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-11-peter.maydell@linaro.org>
 <875z8t7kd0.fsf@dusky.pond.sub.org>
 <CAFEAcA9ZPO32XC1NwH=qa4mNF8c_xZeW8Z6MTrJ0FLmB6kytXQ@mail.gmail.com>
Date: Tue, 22 Sep 2020 14:00:45 +0200
In-Reply-To: <CAFEAcA9ZPO32XC1NwH=qa4mNF8c_xZeW8Z6MTrJ0FLmB6kytXQ@mail.gmail.com>
 (Peter Maydell's message of "Mon, 21 Sep 2020 16:30:57 +0100")
Message-ID: <87wo0mqavm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
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

> On Fri, 4 Sep 2020 at 14:16, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > Convert qemu-ga-ref to rST format. This includes dropping
>> > the plain-text, pdf and info format outputs for this document;
>> > as with all our other Sphinx-based documentation, we provide
>> > HTML and manpage only.
>
>> > -@copying
>> > -This is the QEMU Guest Agent Protocol reference manual.
>> > -
>> > -Copyright @copyright{} 2016 The QEMU Project developers
>> > -
>> > -@quotation
>> > -This manual is free documentation: you can redistribute it and/or
>> > -modify it under the terms of the GNU General Public License as
>> > -published by the Free Software Foundation, either version 2 of the
>> > -License, or (at your option) any later version.
>> > -
>> > -This manual is distributed in the hope that it will be useful, but
>> > -WITHOUT ANY WARRANTY; without even the implied warranty of
>> > -MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> > -General Public License for more details.
>> > -
>> > -You should have received a copy of the GNU General Public License
>> > -along with this manual.  If not, see http://www.gnu.org/licenses/.
>> > -@end quotation
>> > -@end copying
>>
>> Does the interop manual carry an equivalent copyright notice?
>
> NB: in the Texinfo versions, Texinfo does not put this copyright/license
> notice in its generated manpages, and it is in the generated HTML only
> as an HTML comment, not visible to the ordinary reader.

For what it's worth, the generated PDF has it on page 2.

> The Sphinx interop manual has the usual footer:
> https://www.qemu.org/docs/master/interop/index.html
> "=C2=A92020, The QEMU Project Developers."
>
> The system manual has an explicit "License" section:
> https://www.qemu.org/docs/master/system/license.html
> but that's documenting the license of the program, not the
> manual (it's docs/system/license.rst).
>
> We could do any or all of:
>  * decide that we're happy with the current situation
>  * expand the "copyright" footer to something like
>    '=C2=A92020, The QEMU Project Developers; this manual is GPLv2'
>  * have a docs/foo/license.rst for each manual, and expand
>    it to mention the documentation license as well as the
>    code license
>
> Given that the Texinfo generated QMP/QGA references don't
> actually present this text to the reader, my inclination
> is to say that this is something we should address in
> a separate patchseries, not as part of this conversion.

I think the manual should have a proper copyright notice.

If you'd prefer to (re-)add it later, stick in TODO comment.


