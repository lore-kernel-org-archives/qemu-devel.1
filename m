Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D919AC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 20:58:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEEAB20693
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 20:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEEAB20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6LJ5-0005E1-Le
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 16:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i6LHQ-00043H-AC
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 16:56:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i6LHP-0004MJ-9g
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 16:56:28 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:35111)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i6LHP-0004Lv-0S
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 16:56:27 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N8nnU-1iB86b2bd0-015ujv; Fri, 06 Sep 2019 22:56:23 +0200
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20190906165736.5612-1-jcmvbkbc@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d7397f47-5c13-dcaa-1bbc-9c0f71f3ec67@vivier.eu>
Date: Fri, 6 Sep 2019 22:56:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906165736.5612-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9edM8wzynhFsN7Dmucqpgo8tKkVbpPFzv7zOP4HKPnwb+VI8mj/
 h36AXGHyruocfvOQUQ6aem8QJW2NB+WO/xU4Bj/T1SqrgQJk578dxVeKl3m/GLPKXAhtZlg
 rr6XRCauQOxexGrO73EmOnLSYE2Rx0D/yP94UOEt/QsyMFFkcGuhrdaqMtOlq4BkPAN32sM
 ZKzhDObF9SdQjRHk5vEMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:veDjKx/8w/E=:1PeNUCeizwwUpf9LctPdW0
 lLg0K+pj2/OQsqvhVxe87FSrTW2MhLaDHmL3jrXHbBrM/d1LLdUMUYauCeivbPXSBnwr/yhEV
 dlaHnT4KuSWiqZbtH64DBBsU2wryZTXRHJ4zzDuJDBgSVVDcOc34JackfeGx/nZYM7acF7I8h
 6SxImYgfngdweWBwAJ5KmeA2aBq41ihtr08hCxPjz+eocWYCPJZVL8n0rlGTjsn5DkGdipkkz
 ckmhlBcT01KwsXs9++bTZRw1/GCyPdwLNU43mCmSUDe9GIDse4ioYC8mjwxOKjcRixQiwhFb2
 3wP5LPfneNM1Q6to9duft21im2Ctmv25aymLTma8azeVj2vGllcWfOvE+vxYVM2T4o8zoW/HM
 Vv8fRv5MVHitsSMyq5OvIorwy6Kr1zhYrHMCcQ9yad3UmylKh3s5/9U4r898j0DqRNPfWQk9d
 N8hfkJ8mZKVp7Ex4UmwATbOdwAHW+v3qnLSk6Q98/RVaU+USooySGQ+VHRTSaSeiwjp8zbgWf
 Cn4RBE69UjD/AQG/yd1Vxv0Bgb6gSI3eEgaOMN/hDaM9SVhG3W3DLx5JkNGpiXB99gCQl1jaG
 B41567T1ruQjif0Ftv2cknx/J+/bGaETfef6IOFznc+YE40dJtRFPOjCGQ5TwOQpqbcpWixtg
 ftIqFz/seJelhw4rIBIq9LpZbQc1QQEWQ56cVphYAi5zgRLIh8cjU4PJq0M5UuHN5i6IZ+IOP
 gIz2lSPP3fpLnIXbd6u91Ml1mgPlQjCJNdSqehln+kHA2CjDXdJwASB7Zb6J+iH15psFCuZl0
 tkFv043IvheDqYEx0bBZ6bmsib+sAxUyuTDtlD1ANcKcwSoaCU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: Re: [Qemu-devel] [PATCH] linux-user: drop redundant handling of
 environment variables
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

Le 06/09/2019 à 18:57, Max Filippov a écrit :
> QEMU_STRACE and QEMU_RAND_SEED are handled by the parse_args, no need to
> do it again in main.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  linux-user/main.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index c9d97d2b1fc6..22ae2b3e65d1 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -701,13 +701,6 @@ int main(int argc, char **argv, char **envp)
>  
>      thread_cpu = cpu;
>  
> -    if (getenv("QEMU_STRACE")) {
> -        do_strace = 1;
> -    }
> -
> -    if (seed_optarg == NULL) {
> -        seed_optarg = getenv("QEMU_RAND_SEED");
> -    }
>      {
>          Error *err = NULL;
>          if (seed_optarg != NULL) {
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

