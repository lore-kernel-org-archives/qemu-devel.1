Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2362EC32771
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 01:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E79A02072E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 01:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79A02072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioduY-0001F8-QX
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 20:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1iodsw-0008Kq-Ij
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 20:42:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1iodsv-0008QD-Hd
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 20:42:18 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:43212)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1iodsv-0008HV-60; Mon, 06 Jan 2020 20:42:17 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1198329|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.209858-0.00807429-0.782067;
 DS=CONTINUE|ham_news_journal|0.00943224-0.000278512-0.990289;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03300; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.GXacsWy_1578361327; 
Received: from 172.16.31.150(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GXacsWy_1578361327)
 by smtp.aliyun-inc.com(10.147.42.241);
 Tue, 07 Jan 2020 09:42:07 +0800
Subject: Re: [PATCH v3 2/4] RISC-V: configure and turn on vector extension
 from command line
To: Jim Wilson <jimw@sifive.com>, alistair23@gmail.com,
 richard.henderson@linaro.org, chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200103033347.20909-1-zhiwei_liu@c-sky.com>
 <20200103033347.20909-3-zhiwei_liu@c-sky.com>
 <2e85f9fd-c254-5403-43ac-6988c013e319@sifive.com>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <88b684d8-3718-6673-dd78-afdf22d500be@c-sky.com>
Date: Tue, 7 Jan 2020 09:42:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <2e85f9fd-c254-5403-43ac-6988c013e319@sifive.com>
Content-Type: multipart/alternative;
 boundary="------------8327F7377B8089BE63DF69DE"
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------8327F7377B8089BE63DF69DE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2020/1/7 5:48, Jim Wilson wrote:
> On 1/2/20 7:33 PM, LIU Zhiwei wrote:
>> +            if (cpu->cfg.vlen > RV_VLEN_MAX) {
>> +                error_setg(errp,
>> +                       "Vector extension VLEN must <= %d", 
>> RV_VLEN_MAX);
>> +                return;
>
> There is no architectural maximum for VLEN.  This is simply an 
> implementation choice so you can use static arrays instead of malloc.  
> I think this error should be reworded to something like "Vector 
> extension implementation only supports VLEN <= %d."
Thanks. It's good to reduce ambiguous.
Zhiwei
> The other errors here are for architecture requirements and are OK.
>
> Jim


--------------8327F7377B8089BE63DF69DE
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <div class="moz-cite-prefix">On 2020/1/7 5:48, Jim Wilson wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:2e85f9fd-c254-5403-43ac-6988c013e319@sifive.com">On
      1/2/20 7:33 PM, LIU Zhiwei wrote:
      <br>
      <blockquote type="cite">+            if (cpu-&gt;cfg.vlen &gt;
        RV_VLEN_MAX) {
        <br>
        +                error_setg(errp,
        <br>
        +                       "Vector extension VLEN must &lt;= %d",
        RV_VLEN_MAX);
        <br>
        +                return;
        <br>
      </blockquote>
      <br>
      There is no architectural maximum for VLEN.  This is simply an
      implementation choice so you can use static arrays instead of
      malloc.  I think this error should be reworded to something like
      "Vector extension implementation only supports VLEN &lt;= %d."
      <br>
       
    </blockquote>
    Thanks. It's good to reduce ambiguous.<br>
    Zhiwei<br>
    <span style="color: rgb(51, 51, 51); font-family: tahoma, 微软雅黑, 宋体,
      arial, georgia, verdana, helvetica, sans-serif; font-size: 14px;
      font-style: normal; font-variant-ligatures: normal;
      font-variant-caps: normal; font-weight: 400; letter-spacing:
      normal; orphans: 2; text-align: start; text-indent: 0px;
      text-transform: none; white-space: normal; widows: 2;
      word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial; display: inline
      !important; float: none;"></span>
    <blockquote type="cite"
      cite="mid:2e85f9fd-c254-5403-43ac-6988c013e319@sifive.com">The
      other errors here are for architecture requirements and are OK.
      <br>
      <br>
      Jim
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------8327F7377B8089BE63DF69DE--

