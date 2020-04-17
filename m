Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF057C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 15:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4FD220936
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 15:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FD220936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digitalsignallabs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPTGD-0000Te-Uv
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 11:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yates@digitalsignallabs.com>) id 1jPTFM-00080m-74
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 11:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yates@digitalsignallabs.com>) id 1jPTFL-0000Zx-1l
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 11:49:40 -0400
Received: from mail.onyx.syn-alias.com ([206.152.134.66]:7900
 helo=smtp.centurylink.net)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yates@digitalsignallabs.com>)
 id 1jPTFK-0000ZA-Sf
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 11:49:39 -0400
X_CMAE_Category: , ,
X-CNFS-Analysis: v=2.3 cv=JJdFTPCb c=1 sm=1 tr=0
 a=/DUmtE38f4iOwNXrSUBayA==:117 a=/DUmtE38f4iOwNXrSUBayA==:17
 a=KGjhK52YXX0A:10 a=cl8xLZFz6L8A:10 a=PPsO2EghCewA:10 a=eQrCS-SpgXYA:10
 a=yrnTiy7_AAAA:8 a=CHELGaInbuG0p1oXFN4A:9 a=lbpfFqayHvHkQ8LnpU4A:9
 a=d2wp0cl8BqqoVUBAGsA6:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
Feedback-ID: dfw:ctl:res:onyx
X-Authed-Username: eWF0ZXNmcmVlZGFyYW5keUBjZW50dXJ5bGluay5uZXQ=
Authentication-Results: smtp01.onyx.dfw.sync.lan
 smtp.user=yatesfreedarandy@centurylink.net; auth=pass (LOGIN)
Received: from [71.217.96.46] ([71.217.96.46:41482]
 helo=galois.digitalsignallabs.com)
 by smtp.centurylink.net (envelope-from <yates@digitalsignallabs.com>)
 (ecelerity 3.6.25.56547 r(Core:3.6.25.0)) with ESMTPA
 id 39/21-10847-110D99E5; Fri, 17 Apr 2020 11:49:37 -0400
Received: from localhost.localdomain (unknown [71.217.96.46])
 by galois.digitalsignallabs.com (Postfix) with ESMTPA id 2A0D02E0C4B
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 11:49:36 -0400 (EDT)
From: Randy Yates <yates@digitalsignallabs.com>
To: qemu-devel@nongnu.org
Subject: Re: QEMU Development Questions
Organization: Digital Signal Labs
Date: Fri, 17 Apr 2020 11:49:35 -0400
Message-ID: <87o8rqdsds.fsf@digitalsignallabs.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="=-=-="
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.6.x
X-Received-From: 206.152.134.66
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain

Thanks for the answers I've received so far - much appreciated.


Is there a standard way to define your own custom coprocessor CP15 registers?


----Randy



                                                  1
Randy Yates, DSP/Embedded Firmware Developer
Digital Signal Labs
http://www.digitalsignallabs.com

--=-=-=
Content-Type: text/html








  
<style>
*
{
  font-size: 12px;
  font-family: Verdana, Geneva, sans-serif;
}

p 
{
  font-size: 12px;
  font-family: Verdana, Geneva, sans-serif;
}

div
{
  font-size: 12px;
  font-family: Verdana, Geneva, sans-serif;
}

v
{
  font-size: 12px;
  font-family: Verdana, Geneva, sans-serif;
}

li
{
  font-size: 12px;
  font-family: Verdana, Geneva, sans-serif;
}

table 
{
  font-size: 12px;
  font-family: Verdana, Geneva, sans-serif;
  color: rgb(31,73,125);
%  background-color: white;
%  border-style: solid;
%  border-width: 1px;
%  border-color: white;
}

pre 
{
  font-size: 11px;
  font-weight: bold;
  font-family: Courier New, Courier, monospace;
%  color: #404040;
  background-color: #c0c0c0;
}

a, a:visited, a:hover, a:active 
{
  color: inherit;
}

.sig
{
  font-size: 10px;
  font-weight: bold;
}

</style>





<span style="color:#1F497D">
<span style="font-family:helvetica">

<div class="p"><!----></div>
<p>Thanks for the answers I've received so far - much appreciated. 

<div class="p"><!----></div>
<p>Is there a standard way to define your own custom coprocessor CP15 registers?

<div class="p"><!----></div>
<p>--Randy

<div class="p"><!----></div>
</span></span>
--=-=-=--

