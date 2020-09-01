Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A5AC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:40:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD072098B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD072098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCzxc-0002UN-QM
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 02:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kCzwo-0001Hi-9P; Tue, 01 Sep 2020 02:39:14 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:47697)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kCzwm-0002wE-Em; Tue, 01 Sep 2020 02:39:14 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mv2gw-1kUOIl3XxA-00qwmN; Tue, 01 Sep 2020 08:38:52 +0200
Subject: Re: [PATCH 11/12] target/sh4: Remove superfluous breaks
To: Thomas Huth <thuth@redhat.com>, Yi Wang <wang.yi59@zte.com.cn>,
 qemu-devel@nongnu.org
References: <1594631142-36745-1-git-send-email-wang.yi59@zte.com.cn>
 <038e7f75-8c34-0a26-1451-75120d703c3d@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <be244055-0fc4-bc7a-776e-32cdede9636c@vivier.eu>
Date: Tue, 1 Sep 2020 08:38:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <038e7f75-8c34-0a26-1451-75120d703c3d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BlxzRNxxMsvhHyv5MfGELEvgY/rPpnnBYVA1fTPRGv/TuZ+kkVp
 brGOBzd/izODXElWsF0F2icsBVOvyCy9MSlrhLG4uNLonCors4c4FEdD+PkPg+3xSy7VBjF
 4VcrAShT3JtfQDXn4Ns1cg3hNgDe3bRdtTZSd8kkrtd7C+xGYn625OPGXhrukGFSw8bS1CF
 iIMBnIYxX7t5sS2B5t99w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lKUQvxnqQyk=:QPS17tl8z7d1BLklwnuyZw
 kGdU1Cxnu0zBXEdQ/7HDwd57AcPQehkzMgHAwlXHURodXma8x59XDyxMCoF2dujQOfn9eD5IF
 HQtAuxq88fk2WSotwgnFqHizscdnpblt4AV9Zcs1DXRNaiCbFItEmZTCVBXe4gqa2sdTL7112
 CwPBV5WYv7Cv9T5mX/zVJBiOGlwpwameYEJeRXJFxupDW104X4aCzuINzYK7TESGkZgWG4wPg
 +V9qQqwmODVU88ZHZavatgf7zylqxD+kWXfXpcttj9xO6Nn5sLcA/LUipSerhJDIQCw3OCaaQ
 kjI7A0q2qy7AfHPNul3IFQvCliuPb7rpFYn8esGI+8Tpkgo+MS96GFyAd/g3TTtdg5fm79s1Z
 opUyS50rIbtoFU+QeqKAMCSFuXBtytFieuuBkEJYdHpnOj62/YW+c3qj2uycP3b7AXt8VrtyC
 JJkbmQiIXdUwUj5+BCOoyyEPj9oWnM0vDlMQe17vgub4NghHLptqJiSEKAPYwcLjfwZ1VDNCD
 V15dCvhA6CnKjGosvfglH7XASBHWvkuzlK6QR5quqJ2Fvl8dUqkg9jIe68EtHfuxJsqCc7Fj0
 iw49J/4/VrdphgUaWyo3qVjsQb1oCLNmUSA8URQ1hUryfX26eX7m6P6Qs7lUgfdcKCI6YF6zB
 CzSKMVI6Qi2yOuYXxiOeHOzwWLSatQ0dAbCIeLyKSBh5STl4mbXWXZlCy8ufgP0PEYtHIHCY2
 3/2Xn/osP/KB+jv2DlB+gfDjqRIDUPHb65i57E6+RuwnbfS0oNNTFdS1otfk8OnL35eoYDceB
 rXsY8BiGlF0+msT+87eOJ7nvW8Dr8naDfJT9feFC0MXhvSD6ruSjVR9MjyOSpuSF3unYPEk
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 02:33:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Liao Pingfang <liao.pingfang@zte.com.cn>, wang.liang82@zte.com.cn,
 xue.zhihong@zte.com.cn, Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 13/07/2020 à 11:38, Thomas Huth a écrit :
> On 13/07/2020 11.05, Yi Wang wrote:
>> From: Liao Pingfang <liao.pingfang@zte.com.cn>
>>
>> Remove superfluous breaks, as there is a "return" before them.
>>
>> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
>> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  target/sh4/translate.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
>> index 6192d83..60c863d 100644
>> --- a/target/sh4/translate.c
>> +++ b/target/sh4/translate.c
>> @@ -1542,7 +1542,6 @@ static void _decode_opc(DisasContext * ctx)
>>          tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx,
>>                              MO_TEUL | MO_UNALN);
>>          return;
>> -        break;
>>      case 0x40e9:                /* movua.l @Rm+,R0 */
>>          CHECK_SH4A
>>          /* Load non-boundary-aligned data */
>> @@ -1550,7 +1549,6 @@ static void _decode_opc(DisasContext * ctx)
>>                              MO_TEUL | MO_UNALN);
>>          tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
>>          return;
>> -        break;
>>      case 0x0029:		/* movt Rn */
>>          tcg_gen_mov_i32(REG(B11_8), cpu_sr_t);
>>  	return;
>> @@ -1638,7 +1636,6 @@ static void _decode_opc(DisasContext * ctx)
>>          CHECK_SH4A
>>          tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
>>          return;
>> -        break;
>>      case 0x4024:		/* rotcl Rn */
>>  	{
>>  	    TCGv tmp = tcg_temp_new();
>>
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


