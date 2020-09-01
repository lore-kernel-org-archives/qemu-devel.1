Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887BFC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:35:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56DA72068E
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56DA72068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCztL-0005zr-Gm
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 02:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kCzsO-00054k-Kg; Tue, 01 Sep 2020 02:34:40 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:56435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kCzsM-0002RI-UG; Tue, 01 Sep 2020 02:34:40 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N3K9E-1kdhcc41nW-010Ke3; Tue, 01 Sep 2020 08:34:21 +0200
Subject: Re: [PATCH 02/12] target/ppc: Remove superfluous breaks
To: Thomas Huth <thuth@redhat.com>, Yi Wang <wang.yi59@zte.com.cn>,
 qemu-devel@nongnu.org
References: <1594631025-36219-1-git-send-email-wang.yi59@zte.com.cn>
 <9429f7c1-0bcf-5092-9f39-302f6b1cf598@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 mQINBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABtCJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+iQI4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +bkCDQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAYkCHwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
Message-ID: <6d8affc9-60d2-4ad4-8954-bccffb239b1d@vivier.eu>
Date: Tue, 1 Sep 2020 08:34:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <9429f7c1-0bcf-5092-9f39-302f6b1cf598@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4bW2GV2yLkhcDEyWlCPMhKZ65geIVyYFrVKJUUgqE75RJ4VZhe3
 /47hvWwnaVvX48yKjLlQgNpgmukxtIPxic/qUkzexRVQOALexGYfYVLol2sq/IWElDath5/
 99r5Z7NH11cXBehm9Rk48kS4W25YaRD/9w6zDFDCkN4DfIRRFHRiKCBgaRsF/tlUpX7Bp/s
 LfEikGp80UrVrywLBgzAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:be5YsKfY67Y=:0QCuznt5Zo8hzKNbPdkIlm
 r3MyffXbUHs2tPwGG5r/DKk75pTkp0jE2R76SgbGJsZXc9suk2c7MAN6XHMr0ZcrqeAaWy9bw
 gEMI88+JUG1XLnr6aT5YRXOzzDQ2JfaZdD6settwYRjze2hieOQHQkOhtPwMzacJFqgm4IdEH
 g8o2m7KY5e00DKAHWtAuvWuCAlVzFaSntvi60DlNYzkx+wHy/D029YELNp18bdyWA2hGcPQe3
 5Z4evHDp3nucpls49eOpq2gx4D+Qm/gRlCDUnpSHXNBXC0BoD2wwuHSoHh31A2aJPx8SzCLfg
 /wXI7/YluoqeeGbPWF1I+OsitbajJZyRuhM81BjQ1gtA3dF7TQCOgwouZVFMNsraR15115sRW
 fFDwmKnExaIh4ydxZazm+qQ1KTVqVqpfxwT9nqzNa574vAB9RouFmTy5w4K91XyHRUjih+RdJ
 YDLsTJMT6mj77/JNvRPIDgTDD+nt5M42A8SmfI2CSGHuBI47doudbiIZQiELxBYlZXNEMjh5U
 C4Snwy1rujiwVRICmgA21R4amkzE73JO09Kg2ETng+WwAJiTxQTUIm6aBC9c1HIOYy8BI/V8Q
 qr5lGyLaNuOr2g77oNHoUAdjhgcwq1wSWYDI3/df2G/9P+JDKvJrFoRFq7M1+N45oFOcmrXxQ
 MKhMnUdM4k+EJCoN3CRKCj9PPPuxk2zLVvW/SXcwXmAt+OuzI9q6K9YOjCce3zl7IugXC7z+m
 8pU59LdrRm6koccc79GxdIkxXpdyUVBLxXjvgbwLXoZitGMcpomV0Gep7fOrZFpAjJgP4WmGs
 LOj4jErn8yNP4sLnH2ZrN0gC0E6AA1P5pLoeetXQ/VfA4Y+Yz2TA6Wz1M9ubANmKRU4hUlr
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 02:34:36
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
Cc: wang.liang82@zte.com.cn, QEMU Trivial <qemu-trivial@nongnu.org>,
 qemu-ppc@nongnu.org, xue.zhihong@zte.com.cn,
 Liao Pingfang <liao.pingfang@zte.com.cn>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 13/07/2020 à 11:30, Thomas Huth a écrit :
> On 13/07/2020 11.03, Yi Wang wrote:
>> From: Liao Pingfang <liao.pingfang@zte.com.cn>
>>
>> Remove superfluous breaks, as there is a "return" before them.
>>
>> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
>> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org> 
>> ---
>>  target/ppc/misc_helper.c | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
>> index 55b68d1..e43a3b4 100644
>> --- a/target/ppc/misc_helper.c
>> +++ b/target/ppc/misc_helper.c
>> @@ -234,25 +234,20 @@ target_ulong helper_clcs(CPUPPCState *env, uint32_t arg)
>>      case 0x0CUL:
>>          /* Instruction cache line size */
>>          return env->icache_line_size;
>> -        break;
>>      case 0x0DUL:
>>          /* Data cache line size */
>>          return env->dcache_line_size;
>> -        break;
>>      case 0x0EUL:
>>          /* Minimum cache line size */
>>          return (env->icache_line_size < env->dcache_line_size) ?
>>              env->icache_line_size : env->dcache_line_size;
>> -        break;
>>      case 0x0FUL:
>>          /* Maximum cache line size */
>>          return (env->icache_line_size > env->dcache_line_size) ?
>>              env->icache_line_size : env->dcache_line_size;
>> -        break;
>>      default:
>>          /* Undefined */
>>          return 0;
>> -        break;
>>      }
>>  }
>>  
>>
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


