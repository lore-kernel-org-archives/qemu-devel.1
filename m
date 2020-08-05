Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F50CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 02:45:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA42E2086A
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 02:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8upxKWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA42E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k39QK-0000be-T0
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 22:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k39PL-0007jp-IW
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 22:43:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45288
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k39PI-0005y8-Q5
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 22:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596595436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7IRn4PBYyAyqO2RvzTPWmDg9FiFfyrfER90m2mprTpw=;
 b=g8upxKWz31QnVYKbmN+2SPNZFgjBV19gJpbWkxS+6hh4Wa3PNpoRsMq5BxzWIVKDSCNadO
 GMgtvXBp6V8Vx+NIq1XRPe4awe6pRizuQ8NlSKO8c4c7X2s3e7pCsLMpYLFnlv6UlSlRRE
 MoK7JjWi67mh/mLcMlR9+KdBkVgYq/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-9VH50E30NwO6PxL_JECFWQ-1; Tue, 04 Aug 2020 22:43:52 -0400
X-MC-Unique: 9VH50E30NwO6PxL_JECFWQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 466E6101C8A7;
 Wed,  5 Aug 2020 02:43:51 +0000 (UTC)
Received: from [10.72.13.71] (ovpn-13-71.pek2.redhat.com [10.72.13.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 542A35DA75;
 Wed,  5 Aug 2020 02:43:50 +0000 (UTC)
Subject: Re: [PULL 0/2] Net patches
To: Peter Maydell <peter.maydell@linaro.org>
References: <1596523270-5492-1-git-send-email-jasowang@redhat.com>
 <CAFEAcA8+sFuAU+WdtUT4V-SUCk9qeFenXg24FeKzwCTx7bFFtg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9cecb5c9-46b1-1484-0ee1-d63419fe4c12@redhat.com>
Date: Wed, 5 Aug 2020 10:43:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8+sFuAU+WdtUT4V-SUCk9qeFenXg24FeKzwCTx7bFFtg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 22:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


On 2020/8/4 下午6:53, Peter Maydell wrote:
> On Tue, 4 Aug 2020 at 07:41, Jason Wang <jasowang@redhat.com> wrote:
>> The following changes since commit 5c1c3e4f02e458cf280c677c817ae4fd1ed9bf10:
>>
>>    Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200803' into staging (2020-08-03 20:34:26 +0100)
>>
>> are available in the git repository at:
>>
>>    https://github.com/jasowang/qemu.git tags/net-pull-request
>>
>> for you to fetch changes up to 035e69b063835a5fd23cacabd63690a3d84532a8:
>>
>>    hw/net/net_tx_pkt: fix assertion failure in net_tx_pkt_add_raw_fragment() (2020-08-04 14:14:48 +0800)
>>
>> ----------------------------------------------------------------
>>
>> ----------------------------------------------------------------
>> Lukas Straub (1):
>>        colo-compare: Remove superfluous NULL-pointer checks for s->iothread
>>
>> Mauro Matteo Cascella (1):
>>        hw/net/net_tx_pkt: fix assertion failure in net_tx_pkt_add_raw_fragment()
> Hi; this pullreq includes a patch where there's mangled UTF-8 in
> one of the commit messages: the "colo-compare: Remove superfluous
> NULL-pointer checks for s->iothread" patch has a mangled version
> of the e-with-acute-accent character in Philippe's surname in his
> Reviewed-by: tag.
>
> Since this is the day of rc3 and I think you're at a timezone
> offset that would make rerolling the series in time tricky,
> I'm going to let this through. But please can you fix your
> patch-handling workflow to ensure it doesn't corrupt UTF-8 ?


My bad, it's time for me to use patchwork probably (or is there a better 
tools)?

Thanks


>
> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
> for any user-visible changes.
>
> -- PMM
>


