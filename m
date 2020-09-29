Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B797AC4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E41E207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZznJeUWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E41E207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNFM7-0002Zz-UN
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 09:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNFIQ-0006eS-Jh
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55418)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNFIH-0004D4-AV
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:03:53 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601384624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRsgFf3iUHaMJH/O4TZA1uYAzkHliD3XbE8x/djBt1c=;
 b=ZznJeUWHEg5Hc//vh60m9kJRFw/TjQOG+PjDZkABgaA8NDyE9vRWtwYUrUu/byChtw7adh
 IOqkiwLt3Y17xhlf7AsqqaWncQBR3PsBdPxSiiFvfYzFqsEbTfxa3lQxYwk88gS6reVEtH
 R5pzvbZuK231s0EcNWsffkEL/uZITS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-8Dvgkhx0PJiOx3tW9U2RxA-1; Tue, 29 Sep 2020 09:03:42 -0400
X-MC-Unique: 8Dvgkhx0PJiOx3tW9U2RxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6B26427C4;
 Tue, 29 Sep 2020 13:03:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 95EB45C1BD;
 Tue, 29 Sep 2020 13:03:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1EBAC113864A; Tue, 29 Sep 2020 15:03:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v6 05/21] scripts/qapi/parser.py: improve doc comment
 indent handling
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <20200925162316.21205-6-peter.maydell@linaro.org>
 <874knhbtm8.fsf@dusky.pond.sub.org>
 <CAFEAcA94vOAbk_SkRZwyp3GsyknzWQ9GkvVPKYzW2MSL3KO2Pg@mail.gmail.com>
Date: Tue, 29 Sep 2020 15:03:40 +0200
In-Reply-To: <CAFEAcA94vOAbk_SkRZwyp3GsyknzWQ9GkvVPKYzW2MSL3KO2Pg@mail.gmail.com>
 (Peter Maydell's message of "Tue, 29 Sep 2020 09:55:45 +0100")
Message-ID: <87o8lospjn.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 28 Sep 2020 at 20:16, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> > +Descriptions of arguments can span multiple lines. The description
>> > +text can start on the line following the '@argname:', in which case
>> > +it must not be indented at all. It can also start on the same line
>> > +as the '@argname:'. In this case if it spans multiple lines then
>> > +second and subsequent lines must be indented to line up with the
>> > +first character of the first line of the description:
>>
>> Please put two spaces after sentence-ending punctuation, for local
>> consistency, and to keep Emacs sentence commands working.
>
> Is there a python lint program that can auto-check this?
> Otherwise I am going to continue to put single-spaces at
> least some of the time, because that's the way I write all
> the other English text I write...

John, any idea?  The ones I use apparently don't, even though PEP 8 asks
for this style.

>> Can touch this up in my tree, of course.
>
> That would certainly be easier for me :-)

Happy to help :)


