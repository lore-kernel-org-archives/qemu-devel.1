Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2EBC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:58:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E287C2080A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STVdSUU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E287C2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPlbj-0005ys-NB
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kPlaz-0005Qs-IC
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:57:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kPlav-0002dE-JS
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601985443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UyLUbwhvkDlq29fFKxuIjy+TznmvWkyOMhYFJeafKS4=;
 b=STVdSUU3zKm3rtbtwb8TL3etLTP0I6xlPg+EQb6C9085TaAUj4NHFzCvE3nh1gbpfHoQsd
 6RyM2pyGchR7K84rorxvezqznCXzfltDiygMoVgDPyXVty8JGy2ioAVd9alv8/Yy/AvwVw
 vaHY4cClLw4Y4/QcE2vz+NMkiUl2d8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-b0yN-dGTMpueOTPKpR1cbg-1; Tue, 06 Oct 2020 07:57:22 -0400
X-MC-Unique: b0yN-dGTMpueOTPKpR1cbg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27AA31018F7B;
 Tue,  6 Oct 2020 11:57:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE9385576D;
 Tue,  6 Oct 2020 11:57:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 36B5911329C1; Tue,  6 Oct 2020 13:57:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: <luoyonggang@gmail.com>
Subject: Re: [PATCH v3] scripts: Convert qemu-version.sh to qemu-version.py
In-Reply-To: <CAE2XoE-QZBm=nkimjzTN424LsciD1J3p4DwjDR4uFm2tY07y3w@mail.gmail.com>
 (=?utf-8?B?Iue9l+WLh+WImihZb25nZ2FuZw==?= Luo)"'s message of "Tue, 6 Oct
 2020 19:04:48 +0800")
References: <20201005195129.1507-1-luoyonggang@gmail.com>
 <CAFEAcA8oa7A8f9EjSTnutUKC8tZ98Y_DrSYxdhy22T3y9NHRaQ@mail.gmail.com>
 <CAE2XoE-QZBm=nkimjzTN424LsciD1J3p4DwjDR4uFm2tY07y3w@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date: Tue, 06 Oct 2020 13:57:19 +0200
Message-ID: <87362rsh28.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> writes:

> On Tue, Oct 6, 2020 at 6:33 PM Peter Maydell <peter.maydell@linaro.org>
> wrote:
>>
>> On Mon, 5 Oct 2020 at 20:51, Yonggang Luo <luoyonggang@gmail.com> wrote:
>> >
>> > The sh script are harder to maintain for compatible different
>> > xsh environment so convert it to python script
>> > Also incorporate the fixes in
>> >
> https://patchew.org/QEMU/20200929143654.518157-1-marcandre.lureau@redhat.=
com/
>> >
>> > Testing args length and if not enough, setting pkgversion and version
> to ''
>> >
>> > +#
>> > +# Script for retrieve qemu git version information
>> > +#
>> > +# Author: Yonggang Luo <luoyonggang@gmail.com>
>> > +#
>> > +# This work is licensed under the terms of the GNU GPL, version 2.  S=
ee
>> > +# the COPYING file in the top-level directory.
>>
>> Does this have to be GPL-v2-only ? We strongly prefer
>> v2-or-later...
> Directly copy from other python script, do you have a template for this?

Copy from scripts/qapi-gen.py:

# This work is licensed under the terms of the GNU GPL, version 2 or later.
# See the COPYING file in the top-level directory.


