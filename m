Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FD3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:03:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5535420890
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="xAx1oDC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5535420890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdTcc-0000t8-Be
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 03:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien.hedde@greensocs.com>)
 id 1jdTa4-0000NP-Ak
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:00:56 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:48972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien.hedde@greensocs.com>)
 id 1jdTa2-00012N-A2
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:00:55 -0400
Received: from [192.168.1.12] (lfbn-gre-1-344-171.w90-112.abo.wanadoo.fr
 [90.112.62.171])
 by beetle.greensocs.com (Postfix) with ESMTPSA id EEBF296EF0;
 Tue, 26 May 2020 07:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1590476450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0faZZaugXZw+q+2vSV/sjcObdSaRl/uB+p5HDcSGKs=;
 b=xAx1oDC4v6vEnJcLtuGF1tXRLtdu40gvkxjG4GkRY3Lu2QQne9awcIMMKf8AG8V5wKYkAp
 wxCIuvqIzLb1eEldhz73fEb4bBG35p8pttCiS2rgqSZdM/R26s66BVUaYHJoC1filmMAGy
 i8EX4hp+Y41CBfFA6v6wXngIvBKoyAw=
Subject: Re: [PATCH v5 4/7] dwc-hsotg (dwc2) USB host controller emulation
To: Paul Zimmerman <pauldzim@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200512064900.28554-1-pauldzim@gmail.com>
 <20200512064900.28554-5-pauldzim@gmail.com>
 <CAFEAcA8ru0DyVTvVcTjf0AH8wi+d64m=iP_qbHrsLnGt65Y0Kg@mail.gmail.com>
 <CADBGO79puzxx8dC2_kxe0eGJ34fn=DwwgNfL9xSBt=dQvEcOUw@mail.gmail.com>
 <CAFEAcA_SVkgtr959SGKCgdFHX15pq-bkHXbF5RvMJXhVgBfb0Q@mail.gmail.com>
 <CADBGO790Wy5rQqi1VSROe9pfVWef=_6-6opxjh7cojgKZU+CZQ@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <5a848198-d5b4-4450-fad5-bf40a3ecdac0@greensocs.com>
Date: Tue, 26 May 2020 09:00:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CADBGO790Wy5rQqi1VSROe9pfVWef=_6-6opxjh7cojgKZU+CZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1590476450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0faZZaugXZw+q+2vSV/sjcObdSaRl/uB+p5HDcSGKs=;
 b=6vshP0t5fOL8wtBpvtTJ0+rp+maTzrGfDltSQWIeCT0IalzHpxCUSCfafG6bBqt8sBcWOI
 MNN4ubtaKPp8/68BUIJT6sXH6AlTiEQQmtzHQyju6sZE+p+vYgP7BhrNln9n1YydttOoNQ
 gDoqqj3pYOPcksC6cMAixQCG2hInS60=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1590476450; a=rsa-sha256; cv=none;
 b=A+wC9KC4fCGugmhPVG2337VCJivrVzjvvrv4XmWigWmoBlUhOE83Bb1FzJQOSyQwbQoAYe
 TBpbAVUx6l7ixeXBA6xX5Yvy0UD/6sIOnlgLX0Ei1YHBkpTPY+paby/MylKCK56TN3Lgu9
 tAJidmR+aGOOtpCJNzhxwRBimozKdA0=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=damien.hedde@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 03:00:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/20/20 11:24 PM, Paul Zimmerman wrote:
> On Wed, May 20, 2020 at 6:18 AM Peter Maydell <peter.maydell@linaro.org
> <mailto:peter.maydell@linaro.org>> wrote:
> 
>     On Wed, 20 May 2020 at 06:49, Paul Zimmerman <pauldzim@gmail.com
>     <mailto:pauldzim@gmail.com>> wrote:
>     > Is there a tree somewhere that has a working example of a
>     > three-phase reset? I did a 'git grep' on the master branch and didn't
>     > find any code that is actually using it. I tried to implement it from
>     > the example in reset.rst, but I'm getting a segfault on the first
>     line in
>     > resettable_class_set_parent_phases() that I'm having trouble figuring
>     > out.
> 
>     Hmm, I thought we'd committed a change of a device to use the new
>     mechanism along with the actual implementation but I can't see it
>     now. Damien, what's the status with getting Xilinx devices to use the
>     3-phase reset API?
> 
> 
> Never mind, I found the problem, I wasn't initializing my class properly.
> It's working now,I'll send along a new patch series shortly.
> 
> Thanks,
> Paul
>

Sorry, I was off grid during the last days.
It's a bit late but if anyone is looking of examples theses xilinx
devices are in the tree:
+ hw/char/cadence_uart.c
+ hw/misc/zynq_slcr.c

Damien

