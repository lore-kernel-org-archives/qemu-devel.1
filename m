Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FE9C4725A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 06:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 920B320714
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 06:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920B320714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWDSJ-0007Bk-Nf
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 02:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1jWDRj-0006mg-80
 for qemu-devel@nongnu.org; Wed, 06 May 2020 02:22:19 -0400
Received: from mailout05.t-online.de ([194.25.134.82]:58434)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1jWDRg-0001Ll-VB
 for qemu-devel@nongnu.org; Wed, 06 May 2020 02:22:18 -0400
Received: from fwd07.aul.t-online.de (fwd07.aul.t-online.de [172.20.27.150])
 by mailout05.t-online.de (Postfix) with SMTP id BA53142240AB;
 Wed,  6 May 2020 08:22:12 +0200 (CEST)
Received: from [192.168.211.200]
 (Vs-85iZB8h6pNo4jJ84nbBprfFP6AdCQSTcf8olr2lx4TBbhxX49-yp+gMoIM6Uwlv@[46.86.59.135])
 by fwd07.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jWDRZ-0TBNoG0; Wed, 6 May 2020 08:22:09 +0200
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Subject: Re: [PATCH 5/7] audio: Let HWVoice write() handlers take a const
 buffer
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200505132603.8575-1-f4bug@amsat.org>
 <20200505132603.8575-6-f4bug@amsat.org>
Message-ID: <a52cb124-ff0a-c529-038e-6559c5e59e1a@t-online.de>
Date: Wed, 6 May 2020 08:22:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505132603.8575-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ID: Vs-85iZB8h6pNo4jJ84nbBprfFP6AdCQSTcf8olr2lx4TBbhxX49-yp+gMoIM6Uwlv
X-TOI-MSGID: b366da38-c4f1-4b71-9828-a0458a8dcd26
Received-SPF: none client-ip=194.25.134.82; envelope-from=vr_qemu@t-online.de;
 helo=mailout05.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:22:13
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001 autolearn=_AUTOLEARN
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
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <DirtY.iCE.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
> index 4cdf19ab67..bba6bafda4 100644
> --- a/audio/dsoundaudio.c
> +++ b/audio/dsoundaudio.c
> @@ -454,7 +454,7 @@ static void *dsound_get_buffer_out(HWVoiceOut *hw, size_t *size)
>      return ret;
>  }
>  
> -static size_t dsound_put_buffer_out(HWVoiceOut *hw, void *buf, size_t len)
> +static size_t dsound_put_buffer_out(HWVoiceOut *hw, const void *buf, size_t len)
>  {
>      DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
>      LPDIRECTSOUNDBUFFER dsb = ds->dsound_buffer;

You forgot to make the buffer const in dsound_put_buffer_in().

I had to cast buf to LPVOID in dsound_get_buffer_in() and dsound_put_buffer_in() because otherwise I see:

C:/usr/msys64/home/ruemelin/git/qemu/audio/dsoundaudio.c: In function 'dsound_put_buffer_out':
C:/usr/msys64/home/ruemelin/git/qemu/audio/dsoundaudio.c:466:38: error: passing argument 2 of 'dsound_unlock_out' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
  466 |     int err = dsound_unlock_out(dsb, buf, NULL, len, 0);
      |                                      ^~~
In file included from C:/usr/msys64/home/ruemelin/git/qemu/audio/dsoundaudio.c:266:
C:/usr/msys64/home/ruemelin/git/qemu/audio/dsound_template.h:48:12: note: expected 'LPVOID' {aka 'void *'} but argument is of type 'const void *'
   48 |     LPVOID p1,
      |     ~~~~~~~^~
C:/usr/msys64/home/ruemelin/git/qemu/audio/dsoundaudio.c: In function 'dsound_put_buffer_in':
C:/usr/msys64/home/ruemelin/git/qemu/audio/dsoundaudio.c:571:38: error: passing argument 2 of 'dsound_unlock_in' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
  571 |     int err = dsound_unlock_in(dscb, buf, NULL, len, 0);
      |                                      ^~~
In file included from C:/usr/msys64/home/ruemelin/git/qemu/audio/dsoundaudio.c:268:
C:/usr/msys64/home/ruemelin/git/qemu/audio/dsound_template.h:48:12: note: expected 'LPVOID' {aka 'void *'} but argument is of type 'const void *'
   48 |     LPVOID p1,
      |     ~~~~~~~^~

With best regards,
Volker

