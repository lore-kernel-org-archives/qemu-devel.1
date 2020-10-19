Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE6EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:25:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6838722257
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6838722257
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUTI8-0007D7-8l
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 07:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kUTH1-0006jg-O8
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:24:21 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:17349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kUTGx-0005lw-H9
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:24:18 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 0D420746383;
 Mon, 19 Oct 2020 13:24:09 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DEF95746333; Mon, 19 Oct 2020 13:24:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DDAB374594E;
 Mon, 19 Oct 2020 13:24:08 +0200 (CEST)
Date: Mon, 19 Oct 2020 13:24:08 +0200 (CEST)
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 2/9] configure: cross-compiling without cross_prefix
In-Reply-To: <ec63904c-f0d2-b37b-9f9f-8f2109f1335a@redhat.com>
Message-ID: <1f92b68-6d6c-d125-c034-7cbe414b198e@eik.bme.hu>
References: <20201019013928.72770-1-j@getutm.app>
 <20201019013928.72770-3-j@getutm.app>
 <9a68e856-cb97-bf44-eef6-52d7cbca9884@redhat.com>
 <ec63904c-f0d2-b37b-9f9f-8f2109f1335a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

On Mon, 19 Oct 2020, Thomas Huth wrote:
> On 19/10/2020 10.07, Thomas Huth wrote:
>> On 19/10/2020 03.39, Joelle van Dyne wrote:
>>> From: osy <osy86@users.noreply.github.com>
>>>
>>> The iOS toolchain does not use the host prefix naming convention. We add a
>>> new option `--enable-cross-compile` that forces cross-compile even without
>>> a cross_prefix.
>>>
>>> Signed-off-by: Joelle van Dyne <j@getutm.app>
>>> ---
>>>  configure | 13 ++++++++++++-
>>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/configure b/configure
>>> index 3c63879750..46d5db63e8 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -234,6 +234,7 @@ cpu=""
>>>  iasl="iasl"
>>>  interp_prefix="/usr/gnemul/qemu-%M"
>>>  static="no"
>>> +cross_compile="no"
>>>  cross_prefix=""
>>>  audio_drv_list=""
>>>  block_drv_rw_whitelist=""
>>> @@ -456,6 +457,11 @@ for opt do
>>>    optarg=$(expr "x$opt" : 'x[^=]*=\(.*\)')
>>>    case "$opt" in
>>>    --cross-prefix=*) cross_prefix="$optarg"
>>> +                    cross_compile="yes"
>>> +  ;;
>>> +  --enable-cross-compile) cross_compile="yes"
>>> +  ;;
>>> +  --disable-cross-compile) cross_compile="no"
>>
>> Can't you simply use --cros-prefix="" instead?
>
> I mean, still introduce the "cross_compile=yes" variable, just omit the new
> options.

That seems less intuitive for people trying to find this option. If --help 
lists --enable-cross-compile I can guess what that means but there's no 
way I could guess --cros-prefix="" unless I've been told or searched and 
stumbled upon it. So unless it's a big problem I like the explicit options 
better. Or is that a convention in other projects to use empty prefix to 
enable cross compile that I don't know about?

Regards,
BALATON Zoltan

