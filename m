Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D08C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 05:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF85120663
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 05:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TPgiyNIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF85120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkhVl-0006Nk-96
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 01:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jkhV6-0005rX-M9
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 01:17:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31750
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jkhV3-0007yi-My
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 01:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592198256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=P75QsGVo7uZ4+AvkQjhhjK0qNa1sQ/H5N3Y7+Tmh0zs=;
 b=TPgiyNIW0cnxf1ryQofTmtK2xLKKB6lRB+kajNn/Eb5c1RiAVslyLvS2sxX0VIyaExLxNo
 RimkbfvB7DVXmfnRQsNNZ6UvNGxaiobEhHdZfd02PXOFE2K3E3/3dZrK1HerT22dV17CMC
 YPb29l8IE4xD7YpiRvbkIVojj9nwJYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-o2c0Z24HPqqw0Xyg1lHYsg-1; Mon, 15 Jun 2020 01:17:32 -0400
X-MC-Unique: o2c0Z24HPqqw0Xyg1lHYsg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFB191009456;
 Mon, 15 Jun 2020 05:17:31 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-111.ams2.redhat.com [10.36.112.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 056FA100238C;
 Mon, 15 Jun 2020 05:17:26 +0000 (UTC)
Subject: Re: [PATCH v2] Makefile: Remove generated files when doing
 'distclean' (and 'clean')
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20191008082815.8267-1-thuth@redhat.com>
 <CAL1e-=gYkhM99Ee0LxZJ5dCjeEdC08G4_Tm3WCZpCSWvJ=b26Q@mail.gmail.com>
 <4bfea125-eb63-f4a2-bca0-bce462f73d89@redhat.com>
 <CAFEAcA_+V7SNsxPSgsd04s8f7PnP3qdyXMp6NvS2inHjE08pJw@mail.gmail.com>
 <CAL1e-=ijjbTG19NHnsDrcJdb7kajBdcndMT8JXymqC6UViiitQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <770c89b9-44d1-0982-34ff-1830911ac413@redhat.com>
Date: Mon, 15 Jun 2020 07:17:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=ijjbTG19NHnsDrcJdb7kajBdcndMT8JXymqC6UViiitQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:17:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/06/2020 18.28, Aleksandar Markovic wrote:
> On Tue, Oct 8, 2019 at 2:41 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Tue, 8 Oct 2019 at 13:37, Thomas Huth <thuth@redhat.com> wrote:
>>>
>>> On 08/10/2019 14.18, Aleksandar Markovic wrote:
>>>> If I remember well, QAPI-related c files are generated while doing
>>>> 'make'. If that is true, these files should be deleted by 'make clean',
>>>> shouldn't they?
>>>
>>> I think that's a philosophical question. Should "make clean" delete all
>>> files that have been generated by a Makefile (i.e. not by "configure"),
>>> or rather mainly the binary files?
>>
>> https://www.gnu.org/software/automake/manual/html_node/Clean.html
>>
>> The autoconf manual suggests some heuristics:
>>  - If make built it, and it is commonly something that one would want
>>    to rebuild (for instance, a .o file), then mostlyclean should delete it.
>>  - Otherwise, if make built it, then clean should delete it.
>>  - If configure built it, then distclean should delete it.
>>  - If the maintainer built it (for instance, a .info file), then
>>    maintainer-clean should delete it. However maintainer-clean should
>>    not delete anything that needs to exist in order to run
>> './configure && make'.
>>
> 
> Thomas, can we reincarnate this patch? It needs only fairly simple
> corrections, as said by Peter above. It would be nice to have at least
> one release of QEMU with clean clean and distclean.

That depends ... Marc-André, Paolo, what's the status of the meson patch
series? Do you think it will be merged for the next release already? If
so, it does not make much sense to respin my distclean patch. Otherwise
I could do another iteration...

 Thomas


