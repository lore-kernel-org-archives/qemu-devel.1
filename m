Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02891C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 12:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1DC42074B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 12:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9Gxukz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DC42074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtVNO-00060e-2I
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 08:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtVLv-0004r1-Ue
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 08:08:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33485
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtVLr-0000Ml-HG
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 08:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594296510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=+ksn54tRAmeraIeI085ofvzBbtEBBiWra9qCjaTapJI=;
 b=P9Gxukz3Wo4x+JmsKkfcdcrIDpU0O0U5qKTiaKvt+Zvfn5a37pxTvFT+vZ80rdSyz0j5bS
 PcYqAyRDITkNt5QAI1i1c7kbhMQcUb8tJS3lvpuaa9Fob1SuhC24/me++m9a44CmQjunpR
 V3qBQlndeHufSfnwA2R4rfZq3TN+XWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-Aj4j-bACOTa7B8jLuJmp2w-1; Thu, 09 Jul 2020 08:08:22 -0400
X-MC-Unique: Aj4j-bACOTa7B8jLuJmp2w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1059810059A9;
 Thu,  9 Jul 2020 12:08:21 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-106.ams2.redhat.com [10.36.112.106])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E79601002380;
 Thu,  9 Jul 2020 12:08:12 +0000 (UTC)
Subject: Re: Migrating custom qemu.org infrastructure to GitLab
To: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <CAJSP0QV3uB4QY6mzw2JFDedr0PJhGkU5FdmLF5PbjMPyxiYSuw@mail.gmail.com>
 <20200708105353.GE3229307@redhat.com>
 <20200709101602.lc2uipjlxobjvjn3@sirius.home.kraxel.org>
 <3dacddaa-c739-445b-a24a-02f9e51b9b0e@redhat.com>
 <8e1276e2-8957-49db-0409-e85ab2f09739@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0d7c25a2-e636-46fc-ec9f-eb2c12b03a6d@redhat.com>
Date: Thu, 9 Jul 2020 14:08:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8e1276e2-8957-49db-0409-e85ab2f09739@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:20:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <cleber@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/07/2020 12.33, Paolo Bonzini wrote:
> On 09/07/20 12:22, Thomas Huth wrote:
>> FWIW, seems like we could use the "pandoc" tool to convert Mediawiki
>> (our old Wiki) to Markdown (Gitlab wiki). I've done a quick test and
>> converted https://wiki.qemu.org/Contribute/MailingLists into
>> https://gitlab.com/huth/qemu/-/wikis/Contribute/MailingLists with some
>> few clicks.
>>
>> But the longer I look at most Wiki pages, the more I think that we
>> should convert the important pages rather into a part of qemu-web
>> instead. I'll have a closer look and will suggest some patches when time
>> permits...
> 
> The wiki was cleaned up more or less at the same time as the
> qemu-web.git repo was created (actually as a prerequisite), it's
> actually not in a bad shape.

Agreed, there were definitely worse times in the past.

> We can certainly move some wiki pages to qemu-web, like we did for
> "report a bug" in the past and like Alex did recently for the
> Conservancy page.  But I think there aren't that many left, most of them
> are in the first category above and should be moved to docs/devel (for
> example https://wiki.qemu.org/Contribute/SubmitAPatch).

I was looking at pages like
https://wiki.qemu.org/Contribute/MailingLists and
https://wiki.qemu.org/License ... but yes, the first one should be
likely moved to docs/devel, too, and the second one is maybe redundant
anyway, since we have this information in the LICENSE file already (so
we could also link to
https://git.qemu.org/?p=qemu.git;a=blob_plain;f=LICENSE instead).

 Thomas


