Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D233AC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 07:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3828C21532
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 07:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRONEQD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3828C21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFuBw-0008IZ-4j
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 03:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFuB0-0007nk-G7
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 03:05:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40640
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFuAv-0003O0-Jq
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 03:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599635147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eRgmyaNh49/Pxx9SmSURAr+OEnGZ+8ZaSbiof9SpR+4=;
 b=ZRONEQD40oNqAkJD8mk03n33JfrxoHKvNYxfxgXRntSScNCB+VoiIxDk/PkGAqLNKJpSIm
 tmWJYI70UfGilMtAwmVb94Y2ZTOFuEwZ65ExPFO1mkDW1nPON7yu+OjfHFXz383z15rWlj
 FnajoTxwR5/ZqJvR5fMEWT6/T3+hpIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-SUzsk1KhMD63F_807iRYiw-1; Wed, 09 Sep 2020 03:05:44 -0400
X-MC-Unique: SUzsk1KhMD63F_807iRYiw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CA5064088;
 Wed,  9 Sep 2020 07:05:43 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-234.ams2.redhat.com [10.36.112.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4825960C15;
 Wed,  9 Sep 2020 07:05:35 +0000 (UTC)
Subject: Re: [PULL 00/16] Msys2 patches patches
To: Eric Blake <eblake@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>
References: <20200908184918.1085-1-luoyonggang@gmail.com>
 <2327c062-c19e-c405-0f2f-76ad0abfd471@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <83a14825-5ad2-913a-75c5-0c118f31455e@redhat.com>
Date: Wed, 9 Sep 2020 09:05:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2327c062-c19e-c405-0f2f-76ad0abfd471@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:05:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 qemu-block@nongnu.org, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/09/2020 20.56, Eric Blake wrote:
> On 9/8/20 1:49 PM, Yonggang Luo wrote:
>> The following changes since commit
>> 6779038537360e957dbded830f76b08ef5070161:
>>
>>    Merge remote-tracking branch
>> 'remotes/armbru/tags/pull-qapi-2020-09-08' int=
>> o staging (2020-09-08 17:23:31 +0100)
>>
>> are available in the Git repository at:
>>
>>    http://github.com/lygstate/qemu tags/msys2-patches-pull-request
>>
>> for you to fetch changes up to 1892e4360f55ac8cbeeeae0043e0a9dc05c50269:
>>
>>    rcu: add uninit destructor for rcu (2020-09-09 02:34:59 +0800)
>>
>> ----------------------------------------------------------------
>> msys2 patch queue 2020-09-09
> 
> MAINTAINERS doesn't mention a category for msys2, and this patch series
> doesn't add one.  It is unusual to send a pull request without being a
> listed maintainer for the code in question.  I'm not objecting to you
> taking on a maintainership role, if we are ready for that, but I also
> worry that you have so few contributions currently in the main
> repository that you have not necessarily proven the quality of your
> work.  Maybe it's better to just send this as an ordinary patch series,
> and let an existing maintainer incorporate it?

We already have a maintainer for Windows-related patches (see W32, W64
section in maintainers), so I was hoping that Stefan Weil could pick up
the msys2 related patches, too. Stefan?

 Thomas



