Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959E5C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:21:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FFDA21927
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFDA21927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBqzV-0005Ma-FK
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 22:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBqya-0004oI-1G
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jBqyX-00071d-VV
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:20:03 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:47622)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jBqyX-0006gM-F8
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:20:01 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1152296|-1; CH=green; DM=||false|;
 DS=CONTINUE|ham_enroll_verification|0.131769-0.00493179-0.863299;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03310; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=5; RT=5; SR=0; TI=SMTPD_---.GzRPvIH_1583893187; 
Received: from 172.16.31.150(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GzRPvIH_1583893187)
 by smtp.aliyun-inc.com(10.147.44.129);
 Wed, 11 Mar 2020 10:19:47 +0800
To: Richard Henderson <richard.henderson@linaro.org>,
 Alistair.Francis@wdc.com, Palmer Dabbelt <palmer@dabbelt.com>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Subject: Questions about pollute the mail list archives
Message-ID: <a17be147-3e03-b79f-1008-11734c03cfdf@c-sky.com>
Date: Wed, 11 Mar 2020 10:19:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------87BF6B54B825841EB428B125"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------87BF6B54B825841EB428B125
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, forks

When I sent vector extension patchset v3(2020/03/09),  my mail system 
works some wrong,
and only part of the patchset were sent.  When I try to send again, it 
either can't work.

Even more, I found the mail list archives were polluted, many 
repetitions and scattered
in many threads. And no thread is complete.

Is it serious?
Is there any way to clear it in the mail list archives?
Can I send it again to the mail list?

Zhiwei




--------------87BF6B54B825841EB428B125
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Hi, forks<br>
    <br>
    When I sent vector extension patchset v3(2020/03/09),  my mail
    system works some wrong,<br>
    and only part of the patchset were sent.  When I try to send again,
    it either can't work.<br>
    <br>
    Even more, I found the mail list archives were polluted, many
    repetitions and scattered<br>
    in many threads. And no thread is complete.<span style="color:
      rgb(51, 51, 51); font-family: arial; font-size: 13px; font-style:
      normal; font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; orphans: 2; text-align:
      start; text-indent: 0px; text-transform: none; white-space:
      normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width:
      0px; background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial; display: inline
      !important; float: none;"></span><br>
    <br>
    Is it serious? <br>
    Is there any way to clear it in the mail list archives?<br>
    Can I send it again to the mail list?<br>
    <br>
    Zhiwei<br>
    <br>
    <br>
    <br>
  </body>
</html>

--------------87BF6B54B825841EB428B125--

