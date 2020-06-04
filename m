Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37697C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 12:16:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04815206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 12:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04815206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgonN-0002LM-8b
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 08:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jgomK-0001Na-Mi
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 08:15:24 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:54320)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jgomH-0003le-U4
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 08:15:24 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.3729827|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0120727-0.00012559-0.987802;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03279; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=7; RT=7; SR=0; TI=SMTPD_---.Hi5sO69_1591272915; 
Received: from 30.225.208.46(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.Hi5sO69_1591272915)
 by smtp.aliyun-inc.com(10.147.41.231);
 Thu, 04 Jun 2020 20:15:15 +0800
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Subject: hw/char: a question about watch callback function in serial
Message-ID: <81607772-7cbc-1d61-2687-313f6389e1eb@c-sky.com>
Date: Thu, 4 Jun 2020 20:15:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------ED2FCEDEB114C777DA6AE50B"
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 08:15:16
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, mst@redhat.com, edgar.iglesias@gmail.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------ED2FCEDEB114C777DA6AE50B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi folks,

I see many UART implementations have a G_IO_OUT | G_IO_HUP  callback 
function.

In hw/serial.c, it is serial_watch_cb, setting by the following code,

   s->watch_tag = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,

                       serial_watch_cb, s);

In hw/candence_uart.c, it is cadence_uart_xmit, setting by the following 
code,

         guint r = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,

                                         cadence_uart_xmit, s);



I tried to call it with booting a Linux, but the interface will never be 
called.

Can someone give a reasonable answer why needs this interface, or a way 
to call it.

Best Regards,
Zhiwei

--------------ED2FCEDEB114C777DA6AE50B
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Hi folks, <br>
    <br>
    I see many UART implementations have a G_IO_OUT | G_IO_HUP  callback
    function.<br>
    <br>
    In hw/serial.c, it is serial_watch_cb, setting by the following
    code,<br>
    <br>
    <pre>  s-&gt;watch_tag = qemu_chr_fe_add_watch(&amp;s-&gt;chr, G_IO_OUT | G_IO_HUP,</pre>
    <pre>                      serial_watch_cb, s);

</pre>
    In hw/candence_uart.c, it is cadence_uart_xmit, setting by the
    following code,<br>
    <br>
    <pre>        guint r = qemu_chr_fe_add_watch(&amp;s-&gt;chr, G_IO_OUT | G_IO_HUP,                                                                                                                                       </pre>
    <pre>                                        cadence_uart_xmit, s);</pre>
    <br>
    <br>
    I tried to call it with booting a Linux, but the interface will
    never be called. <br>
    <br>
    Can someone give a reasonable answer why needs this interface, or a
    way to call it.<br>
    <br>
    Best Regards,<br>
    Zhiwei<br>
  </body>
</html>

--------------ED2FCEDEB114C777DA6AE50B--

