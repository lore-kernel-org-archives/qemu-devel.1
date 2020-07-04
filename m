Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BABC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:28:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470F221473
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mindspring.com header.i=@mindspring.com header.b="W3U8S+Rn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470F221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mindspring.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrk5O-0004bS-Io
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jrk4m-00045l-Cj
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:27:36 -0400
Received: from elasmtp-masked.atl.sa.earthlink.net ([209.86.89.68]:50968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <denber@mindspring.com>)
 id 1jrk4k-0004AG-OW
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
 s=dk12062016; t=1593876454; bh=9KIsc9S//HEuNz3u9mVUpGrqE3JPNdkRiPC1
 rxlQId4=; h=Received:Message-ID:Date:From:User-Agent:MIME-Version:
 To:CC:Subject:References:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP; b=W3U8S+R
 nCBNFBiFy+lFkGDn2r/1OCPEPGOrkvOrOPbD1B4fjwLoMTFtNdWeq605IqcbzAYLoOv
 L8eP2/ZPXf10CtVIinrMHC5zN3f0PAqfGVGtuz2r5CZPAHvHb6BdhtQ7A46PvOl5rvo
 hE/WSq3uMNMrvt8aJjMmf/bZTyuN5HDVoThl2imXNIyFEHJwRGtAO4YIr5hZu//cUbh
 bf8WjUkoxzLGDOToFhsef1hF5xKhBJeMIDTSa+hxoTefeO0PdnzvVWJ0wZwDCESx92l
 VzVDTdIKVkxykBsM4d0qj92XyHVK0MoepZkAgV6fqLsHqAFfZdm7dBlq4aAop286meg
 ==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
 s=dk12062016; d=mindspring.com;
 b=EdGasK03BNCI7V5l6ns+QEVOQtQyld6E0jn1suy3bYezFcfB8GX8eC2oMPBsxA/FEs/YzbW+ilgHmRzbkgOGtpXwWZRjookKcBkv4PgoKR1WYXFcmJ+LAGgYGj1GKb0sBt5zSRftIo+4Fj5TqOQqJbMygjw6/nUJnarHQ4Cz3B4fkl90XC1TvzNsRKIOt6lkau6q8OXOaSZs33gNXHjk8ud2aWAMZWx9Il7ot/JcHDSbG2EzjE5N8dkGlfaCxdd5URP3P4kRXsyNZsDkbB5nbhQRFthP6qEpZxI96Mbrip8jOscnPoOXLZfTMNmeubLnujhr2S+FDJGNaYkuLLoXPg==;
 h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP;
Received: from [8.9.81.230] (helo=[192.168.0.78])
 by elasmtp-masked.atl.sa.earthlink.net with esmtpa (Exim 4)
 (envelope-from <denber@mindspring.com>)
 id 1jrk4h-0000zy-DW; Sat, 04 Jul 2020 11:27:31 -0400
Message-ID: <5F009FE2.4000406@mindspring.com>
Date: Sat, 04 Jul 2020 11:27:30 -0400
From: Michele Denber <denber@mindspring.com>
User-Agent: Mozilla/5.0 (X11; SunOS sun4v;
 rv:10.0.7) Gecko/20121005 Thunderbird/10.0.7
MIME-Version: 1.0
To: =?UTF-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: gmake in Solaris 11.4: TFR missing
References: <20200702143955.678-1-thuth@redhat.com>
 <5EFE07BC.6040407@mindspring.com>
 <1e699fdc-639e-ef8a-313f-7e665cad868c@redhat.com>
 <5EFE5291.6030300@mindspring.com>
 <975b5072-43de-da16-bf62-fc7e5a7a87f5@redhat.com>
 <5EFF5DFC.2060006@mindspring.com>
 <CAFEAcA81y59yaOCW=QONy9EKv6Fdkkwb=XGJ786-N5du2+P9NQ@mail.gmail.com>
 <5EFF7DD7.1000605@mindspring.com> <5EFFA499.7050008@mindspring.com>
 <601a18a7-d564-b9d7-7187-53a05d819551@amsat.org>
In-Reply-To: <601a18a7-d564-b9d7-7187-53a05d819551@amsat.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ELNK-Trace: 17a948d2f1835c375e89bb4777695beb24867385ea7beca58f71a1d2ee89226d48a6c440315425d5350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 8.9.81.230
Received-SPF: pass client-ip=209.86.89.68; envelope-from=denber@mindspring.com;
 helo=elasmtp-masked.atl.sa.earthlink.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:27:32
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Peter Tribble <peter.tribble@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 07/03/20 17:55, Philippe Mathieu-Daudé wrote:
> TFR() is defined in include/qemu-common.h: #define TFR(expr) do { if 
> ((expr) != -1) break; } while (errno == EINTR) 
Ah ha, thank you.  It figures, the one place I didn't look.  I assumed 
that QEMU would know how to find its own things so TFR must be something 
external.

             - Michele


