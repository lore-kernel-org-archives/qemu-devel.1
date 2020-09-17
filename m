Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36738C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF98C21D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRn9EbkC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF98C21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIvsA-00044q-Oc
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 11:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIvb7-0002NC-F3
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:13:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIvb4-0003AG-C6
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600355596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hsvX3wnkEsLx2oAxTjaN6+ufS3qwaNHhSfJQ+RGAvF8=;
 b=QRn9EbkC5n41dprPpSOjno+x0wfxZY0gRIyL9plFgddueIhwt+OqHqRQA1XqOr37WHG4se
 0slblgZfgIr6TURfq5p27xDTBid9G7aw6Ypep/b2Yu6lOggdpaTl8IsnHL/PDk4NgmyVmY
 8m1Bz7iCB02O99oEKUfdmvQhT2wYXf8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-pI35eXPvOV2YGa0iQ16HyQ-1; Thu, 17 Sep 2020 11:12:58 -0400
X-MC-Unique: pI35eXPvOV2YGa0iQ16HyQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23AD180EDAF;
 Thu, 17 Sep 2020 15:12:57 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-38.ams2.redhat.com [10.36.113.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3249F99147;
 Thu, 17 Sep 2020 15:12:55 +0000 (UTC)
Subject: Re: [PULL 00/24] qtests, unit tests and Cirrus-CI fixes / improvements
To: luoyonggang@gmail.com, Peter Maydell <peter.maydell@linaro.org>
References: <20200916114731.102080-1-thuth@redhat.com>
 <CAFEAcA-sN1+wsZ9sN6PckR=_74Ncj1y=AVZ9QHj5WpxxsJvQ8A@mail.gmail.com>
 <CAE2XoE_APDazcLgdrv3h1TW_3Fw_qEADhQKb58O74pdeGz=stQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0ab55eef-1c95-83bb-235c-e01a5545a530@redhat.com>
Date: Thu, 17 Sep 2020 17:12:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_APDazcLgdrv3h1TW_3Fw_qEADhQKb58O74pdeGz=stQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/09/2020 16.40, 罗勇刚(Yonggang Luo) wrote:
> 
> 
> On Thu, Sep 17, 2020 at 9:46 PM Peter Maydell <peter.maydell@linaro.org
> <mailto:peter.maydell@linaro.org>> wrote:
>>
>> On Wed, 16 Sep 2020 at 12:47, Thomas Huth <thuth@redhat.com
> <mailto:thuth@redhat.com>> wrote:
>> >
>> >  Hi Peter,
>> >
>> > the following changes since commit
> de39a045bd8d2b49e4f3d07976622c29d58e0bac:
>> >
>> >   Merge remote-tracking branch
> 'remotes/kraxel/tags/vga-20200915-pull-request' into staging (2020-09-15
> 14:25:05 +0100)
>> >
>> > are available in the Git repository at:
>> >
>> >   https://gitlab.com/huth/qemu.git tags/pull-request-2020-09-16
>> >
>> > for you to fetch changes up to 114daec31d64600e5a070abcdb8de2cf74d01e94:
>> >
>> >   cirrus: Building freebsd in a single shot (2020-09-16 12:15:07 +0200)
>> >
>> > ----------------------------------------------------------------
>> > * Fix "readlink -f" problem in iotests on macOS (to fix the
> Cirrus-CI tests)
>> > * Some minor qtest improvements
>> > * Fix the unit tests to work on MSYS2, too
>> > * Enable building and testing on MSYS2 in the Cirrus-CI
>> > * Build FreeBSD with one task again in the Cirrus-CI
>> > ----------------------------------------------------------------
>>
>>
>> Applied, thanks.
>>
>> Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
>> for any user-visible changes.
>>
>> -- PMM
> 
> cirrus are too slow:
> ```
> 
> pm215 Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2…
> …
> 5e0a8fd2 hours ago
> 
> Git stats
> 
>  80,622 commits
> --
> 
> after two hours still not finished.

It now finished successfully:

 https://cirrus-ci.com/task/6178816496238592

Sometimes you just have to be a little bit patient :-)

 Thomas


