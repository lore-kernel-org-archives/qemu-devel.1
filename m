Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AD0C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36DE920CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36DE920CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQT6L-0005fH-EA
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 05:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48402 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jQT5h-0005D6-PA
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:51:50 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jQT5h-0004ZF-7F
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:51:49 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:51119)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jQT5g-0004Sh-Iv
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:51:48 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MNOZO-1jbwV22baU-00Orzk; Mon, 20 Apr 2020 11:51:42 +0200
Subject: Re: [PATCH 3/3] plugins: avoid failing plugin when CPU is inited
 several times
To: Nikolay Igotti <igotti@gmail.com>, riku.voipio@iki.fi
References: <CAEme+7FPF+inSJSXQPmuv8Up3Eam0N7fT03zqM-RvcvKsxjfVQ@mail.gmail.com>
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
Message-ID: <f4feb648-7dc5-ac54-bc0b-db650dd176f1@vivier.eu>
Date: Mon, 20 Apr 2020 11:51:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAEme+7FPF+inSJSXQPmuv8Up3Eam0N7fT03zqM-RvcvKsxjfVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bQEOPWtyMeF0SITcgAa0cjT8IuQzcGfgkhje/l6yAhlrgDrTaOw
 /Ur8viV3x49RhiUfIIUAht/g+KCm4wvJcEGETYXz8HruX/YgFt4Qn2qlK+fb94zNq5KZFXs
 0AiErRPLQZy3DuJhiJ80oogL5/m6egvbLtzM4ypOXodWkhkNHV2647JzypNpkAXRqOr18Yi
 26tOw5kHMu25mTT6ucdPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:46EUutRews4=:rwAIy5bzkpZ8q3rBSKmIYD
 yL4KOoM8rumdmzD0corA8WadP6NNZo5aAWndGwTVW8JEY81WV0se93fsum0mESelg2cwRqkbe
 /x5rhLNwY7CUYiPSnr8/HAdLs7EvsYDPoGPJrvI9QqPcBrDvqkF4LR0Pqx2i9YQ6QlbdhfMAy
 u38nuGwXv0EH7Z9AcS979CUjIi1QleCd2szHRglcvD318qXk0Xc4ZINbNvSidjzUUwtIBklnY
 27UoJDSm/ekvVQEePcqDgsvy28SkbjwQ0aCqg9Yyr7gJELBWww7SJfAUlQ2YUiIa80qE8RyGH
 VFaPIWq/9rSQLnO/SEVo6KR5fTwblXRV9PsC6KHZQvBaDCZS1JaueFDiP1URoSMUgOhrIdNof
 R0+mUALGBZbr1cvcRv/SlqaX0p+6IEkU7atmJQDavInr8GV1Goo3SbeQ4rsnrc/c5r29QIjX5
 l36uCW1OMogO4YFbTekPTQeVYH1MLzmRfL37eAPTwqdmLhia5xyc24l8gpP9QYdb1B5uORAhY
 cGblhtk04RggYJlmpyXm1USc6WpiVIczhcUSEsYkQStiQryHQGs0VnibGWVxRTIrCsVnGeKcN
 fVRQ2eQNvgceGlK013qeFbktimmRsfnuB/TXu2Z4N0EYrZat+4gZI0qGF6e8QvXcHkq8/jFDm
 QWxzx6TtoRR7CiQLfsvZw3U1OU8hfSg+watwYbi3/IgmL2UNTLMCbgpmwCBFMCQW2XX06HXZX
 /Vde02c4T/1d/4GgFH0PNOZAbHXJYsJ4AtOJ+mjJ4NL0TL69RzW/BC5dKagFNq49ZGEo64idu
 yqbcj4yZiLMCarM2e0Xo6qYAS1JHenPGGLe9jubWKDdahwqWwwWyWhjlG+cU1EMUCKuvZTv
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 05:22:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 212.227.126.131
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
Cc: "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Nikolay,

the patch seems corrupted by your mailer.

CC: Alex and Emilio as this code is theirs.

Thanks,
Laurent

Le 20/04/2020 à 11:15, Nikolay Igotti a écrit :
> In linux-user multithreaded scenarious CPU could be inited many times
> with the same id,
> 
> so avoid assertions on already present hashtable entry.
> 
> 
> Signed-off-by: Nikolay Igotti <igotti@gmail.com <mailto:igotti@gmail.com>>
> 
> ---
> 
>  plugins/core.c | 5 +----
> 
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> 
> diff --git a/plugins/core.c b/plugins/core.c
> 
> index 51bfc94787..889cc6441a 100644
> 
> --- a/plugins/core.c
> 
> +++ b/plugins/core.c
> 
> @@ -196,13 +196,10 @@ plugin_register_cb_udata(qemu_plugin_id_t id, enum
> qemu_plugin_event ev,
> 
>  
> 
>  void qemu_plugin_vcpu_init_hook(CPUState *cpu)
> 
>  {
> 
> -    bool success;
> 
> -
> 
>      qemu_rec_mutex_lock(&plugin.lock);
> 
>      plugin_cpu_update__locked(&cpu->cpu_index, NULL, NULL);
> 
> -    success = g_hash_table_insert(plugin.cpu_ht, &cpu->cpu_index,
> 
> +    g_hash_table_insert(plugin.cpu_ht, &cpu->cpu_index,
> 
>                                    &cpu->cpu_index);
> 
> -    g_assert(success);
> 
>      qemu_rec_mutex_unlock(&plugin.lock);
> 
>  
> 
>      plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_INIT);
> 
> -- 
> 
> 2.24.2 (Apple Git-127)
> 


