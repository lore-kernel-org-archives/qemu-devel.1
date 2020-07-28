Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117D3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF9362074F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMwCROf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9362074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0SOJ-0003z0-5W
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 12:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0SNj-0003Rr-28
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:23:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54539
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0SNZ-0002aD-HN
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595953380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=S2IvhYQ5Xm0ErwXs3Q92eqLXabE5MEngHH7UJiL7kQM=;
 b=AMwCROf5ZWkVGgPnW9VF4lUhpatnDhCkBV8KQ0yiTFPyg8iJIQETw3x487XRzpnGLXIVlT
 o44F/OjGFuIQddvTHMnKkDZFHs7tvwiu4NBbpwY7N55ww9MfqBYkm+vaGpUFl7Bm4bzeRL
 ZpwHLVp9Q1DmDSxRQcjYFeZG7EuXSBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-GthZzNCUMqayaUYTTprdTg-1; Tue, 28 Jul 2020 12:22:56 -0400
X-MC-Unique: GthZzNCUMqayaUYTTprdTg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1146C8005B0;
 Tue, 28 Jul 2020 16:22:55 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-161.ams2.redhat.com [10.36.112.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C6C6F712E8;
 Tue, 28 Jul 2020 16:22:53 +0000 (UTC)
Subject: Re: [PULL 0/3] Block patches for 5.1
To: Peter Maydell <peter.maydell@linaro.org>, Max Reitz <mreitz@redhat.com>
References: <20200727143812.1101547-1-mreitz@redhat.com>
 <CAFEAcA_8hhEUJdxGzmjVjG+CFosAtDf9GAR0D2x+-k_mU7Gfug@mail.gmail.com>
 <CAFEAcA_W+G_5iSGj+rg0dx0rUod7XYmR8cxEfGcSKsccVNrtTA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <355c94af-aa03-f56f-ee84-e82ef31e797c@redhat.com>
Date: Tue, 28 Jul 2020 18:22:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_W+G_5iSGj+rg0dx0rUod7XYmR8cxEfGcSKsccVNrtTA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:28:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/07/2020 18.12, Peter Maydell wrote:
> On Tue, 28 Jul 2020 at 11:19, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Mon, 27 Jul 2020 at 15:38, Max Reitz <mreitz@redhat.com> wrote:
>>> ----------------------------------------------------------------
>>> Block patches for 5.1:
>>> - Coverity fix
>>> - iotests fix for rx and avr
>>> - iotests fix for qcow2 -o compat=0.10
>>>
>>
>> Applied, thanks.
> 
> This seems to have broken the "tcg disabled" build on gitlab:
> https://gitlab.com/qemu-project/qemu/-/jobs/659352096

Max already sent another pull request that contains the fix for this
issue, look for "[PULL 0/3] Block patches for 5.1.0-rc2?"

 Thomas


