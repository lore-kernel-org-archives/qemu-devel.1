Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F04AC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F532098B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F532098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD003-0003be-7c
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 02:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kCzzU-00038U-MM; Tue, 01 Sep 2020 02:42:00 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:33321)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kCzzS-0003J4-HW; Tue, 01 Sep 2020 02:42:00 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MCs9W-1kLlPa0x0q-008uf5; Tue, 01 Sep 2020 08:41:42 +0200
Subject: Re: [PATCH 12/12] target/cris: Remove superfluous breaks
To: Thomas Huth <thuth@redhat.com>, Yi Wang <wang.yi59@zte.com.cn>,
 qemu-devel@nongnu.org
References: <1594631150-36801-1-git-send-email-wang.yi59@zte.com.cn>
 <454721ce-1508-dcc0-bf08-2c27fd37854f@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <23b37ce6-a7da-9366-928f-5ce6df41f79a@vivier.eu>
Date: Tue, 1 Sep 2020 08:41:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <454721ce-1508-dcc0-bf08-2c27fd37854f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:V0y26JkjvLFFCZMfBSShf63k4rSUtXGbkaLvnauKJ4w5ddVjs5c
 cAQM9rwBP4zmpPasTsImQPAsW+Uzsc1nQWrqbNqNDvAx+juw2eCRqilju2aaKMz+lrcT7ot
 SXCQwz8q30STcWAW7ywOc+Wkk+WBVXqSZRgX3ysYX5WVBdYP5K1WXp3aTV5t/AHuLvPIoNp
 1S9YIJwQi/T+6GE1JRoSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vl06Cf6tiuE=:ynZvFyLJv8q1RwMXUi8pOI
 o1beXpiC8+KdKlD4FzKOchZs6zlGT42BmHmIbrsnr8d6T2YJgcF59ggI/jwtcN2wjkKQ+TGhQ
 oaXk+aHIaQnJvQVzqs+07vvV4z8KVQbe5+o5lKqCz52foEUKcSYHivFBUl6cXHFOEquZMIU7I
 OXWehAQQwAagOWx0Cd1jumUH4RsI/b8cptkuKpTg3XuynT/eGrLO43TKiHMB+GaJ7ZEt31P+L
 s0thVHu2zdaNRzXvHzenS4SfL+1vpEtTjHs2CkKh9SeMhmTU2uDSEuT+7iUQhQpApiaR4moNn
 EWoa/D6y+qM1S1wwClVZr7WfskH/G4uRqx/fSaFF6kCnC6vgULCI9is1r9Hm1cdVThhNLw0h+
 9G+/YvG/R5wyB2WV3d8jms5j0fVJUYGOoRcThe4Qwpkfiv+QDpSR2bv5WOZPV15xpQSFhVv4S
 O1ZsZlD0GyixW0rFjaNavDqZ2lqWx+NL4EsHQypsqzIKAfwcHBB5zUZ/F5lctjmkjaTj5og4T
 LbAZB71Sq92tAsQg2PQcjPv3XTePvZfp8fuMCeYUwRQ7e68iVNr6biGH6uQu6TlMYo1g1hxDR
 21FhwVF9brPofy59f0pI0W3EU3htLnOjlON21OTLP+Wgs91zjLv2VkE2GQKrBIkbnSMKSY7tq
 jzG4E5w7xQgXEptbCFdQ2JlEunxvxriK/04jvrXpVodFqp/wknI8adI2GAbtVRejpLnh/w3q5
 Cto16hRAe1BCfS+LzNfjlXOpmPgV2QNJCL5dWDe6HegSK6C7txwPLtl/7JUH31GtQ1b9aQrNW
 /t0GUof6D2eEouzaFeDX3sqIXYyRcuYarnLvZNPS49zDKOC4w87e/Osdg5RxxRI5wp8zvSp
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 02:35:25
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
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liao Pingfang <liao.pingfang@zte.com.cn>, wang.liang82@zte.com.cn,
 xue.zhihong@zte.com.cn
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 13/07/2020 à 11:39, Thomas Huth a écrit :
> On 13/07/2020 11.05, Yi Wang wrote:
>> From: Liao Pingfang <liao.pingfang@zte.com.cn>
>>
>> Remove superfluous breaks, as there is a "return" before them.
>>
>> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
>> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  target/cris/translate.c         | 7 +++----
>>  target/cris/translate_v10.inc.c | 2 --
>>  2 files changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/cris/translate.c b/target/cris/translate.c
>> index aaa46b5..64a478b 100644
>> --- a/target/cris/translate.c
>> +++ b/target/cris/translate.c
>> @@ -1178,12 +1178,11 @@ static inline void t_gen_zext(TCGv d, TCGv s, int size)
>>  static char memsize_char(int size)
>>  {
>>      switch (size) {
>> -    case 1: return 'b';  break;
>> -    case 2: return 'w';  break;
>> -    case 4: return 'd';  break;
>> +    case 1: return 'b';
>> +    case 2: return 'w';
>> +    case 4: return 'd';
>>      default:
>>          return 'x';
>> -        break;
>>      }
>>  }
>>  #endif
>> diff --git a/target/cris/translate_v10.inc.c b/target/cris/translate_v10.inc.c
>> index ae34a0d..7f38fd2 100644
>> --- a/target/cris/translate_v10.inc.c
>> +++ b/target/cris/translate_v10.inc.c
>> @@ -1026,10 +1026,8 @@ static unsigned int dec10_ind(CPUCRISState *env, DisasContext *dc)
>>          switch (dc->opcode) {
>>              case CRISV10_IND_MOVE_M_R:
>>                  return dec10_ind_move_m_r(env, dc, size);
>> -                break;
>>              case CRISV10_IND_MOVE_R_M:
>>                  return dec10_ind_move_r_m(dc, size);
>> -                break;
>>              case CRISV10_IND_CMP:
>>                  LOG_DIS("cmp size=%d op=%d %d\n",  size, dc->src, dc->dst);
>>                  cris_cc_mask(dc, CC_MASK_NZVC);
>>
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


