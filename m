Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C23BC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 21:59:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F6682054F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 21:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6682054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJlO4-0002YV-Jj
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 17:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vr_qemu@t-online.de>) id 1jJlNM-00021d-7E
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 17:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vr_qemu@t-online.de>) id 1jJlNL-00013t-5D
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 17:58:20 -0400
Received: from mailout12.t-online.de ([194.25.134.22]:42168)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vr_qemu@t-online.de>) id 1jJlNK-0000yK-Tn
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 17:58:19 -0400
Received: from fwd09.aul.t-online.de (fwd09.aul.t-online.de [172.20.27.151])
 by mailout12.t-online.de (Postfix) with SMTP id 974A441C6344;
 Wed,  1 Apr 2020 23:58:16 +0200 (CEST)
Received: from [192.168.211.200]
 (SU6BlvZUYhx+3eAezGiqD+m8MUh9gxzJHu9SAjmmFz1SbJQ8rUefLGiChydm-Chwru@[93.236.147.242])
 by fwd09.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jJlNC-05XB2G0; Wed, 1 Apr 2020 23:58:10 +0200
Subject: Re: [PATCH 0/3] DirectSound fixes for 5.0
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
References: <19cd6a5a-97b7-b684-f026-11d82e34dab9@t-online.de>
Message-ID: <bfeae910-0086-66e5-200f-37101407b94b@t-online.de>
Date: Wed, 1 Apr 2020 23:58:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <19cd6a5a-97b7-b684-f026-11d82e34dab9@t-online.de>
Content-Type: multipart/alternative;
 boundary="------------6D86C8131D59EF5488D81AED"
Content-Language: en-US
X-ID: SU6BlvZUYhx+3eAezGiqD+m8MUh9gxzJHu9SAjmmFz1SbJQ8rUefLGiChydm-Chwru
X-TOI-MSGID: ca64f643-ce8b-459e-96f8-4f58a7240b70
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.22
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
Cc: QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------6D86C8131D59EF5488D81AED
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Sorry, please ignore this patch series. Patch 1/3 "dsoundaudio:
fix never-ending playback loop" is wrong. I'll send a version 2.

With best regards,
Volker


--------------6D86C8131D59EF5488D81AED
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">
      <pre>Sorry, please ignore this patch series. Patch 1/3 "dsoundaudio:
fix never-ending playback loop" is wrong. I'll send a version 2.

With best regards,
Volker
</pre>
    </div>
  </body>
</html>

--------------6D86C8131D59EF5488D81AED--

