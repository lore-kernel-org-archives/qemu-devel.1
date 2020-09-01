Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51310C2BBD0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 07:32:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15FA2208DB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 07:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FA2208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD0mZ-0007Vg-7Q
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 03:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD0lk-0006Gt-23; Tue, 01 Sep 2020 03:31:52 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:58353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD0lh-0001KK-UI; Tue, 01 Sep 2020 03:31:51 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MCbR7-1kM3RS3cF1-009hyx; Tue, 01 Sep 2020 09:31:46 +0200
Subject: Re: [PATCH] docs: Fix broken links
To: Han Han <hhan@redhat.com>, qemu-devel@nongnu.org
References: <20200807101736.3544506-1-hhan@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d1db6563-763b-dfea-65c1-033b1a9c5d3e@vivier.eu>
Date: Tue, 1 Sep 2020 09:31:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200807101736.3544506-1-hhan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AF0Xctm7HmGO0lIoJwgW3iQJaA0tKNnbr/DC8TTCa6hoS+6FrJy
 D6a4XMeAf00NSdVqJuo9ee0WJaeDlAKXdF/6xduYBzDZS7s9VAfKy0Twmwu93ZLhRxTWiS3
 7LOVnDYKCOnUmxZXkBhG/2qbsK70irqUerrAyD8homiuUhsYBAw0fqyA20CY1EYrzbullgh
 Vfwe6j4DCfPScFl2HHaYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lwq9R20wlHo=:+3JwcTJIFdeW8RpBkgiZdr
 4+W9UKRNGovUvNWsYiWzTFOykg86PUslEYIiiUlSErjwm19kFN4kiXg4LHutVzHp0Fk+/Wacf
 dSEobMJRu+wwClLnHy9g3LBUrXUKlo9cjjzvVdFagbXst8Lzu8WGT2aELBSSiVJqhjuY5tT0Q
 z3mGT5tmJTfP4arklVVzem68vLP/h7jbM5sVx2HhcwwTiASXRBbtQQ2+dpbjIY5yhcncDMFFE
 qDvglGdQSkWsrUomZQYB1CJN0qYQfYCnEbsHLoCUXeGHpt69xoeAy6irM/tCQ4ctW5A4G4L3d
 pl/2ZKLOvJuvFk7ilR+uVp8JX5UzBNCZ9iP88QF/CCkLgzNvnQU8nHMa3Vxu9zHvadjXfbVOu
 He6s9ioiw7HlqV58dc84sUoq29pyXUDSwS9BcdnC1y7Izuirb7sKGVSFMHZJWWFKFosq67GGy
 U5h/rcL3nn9jgxzVF3vQGnAYZKIfplou9hzvK/rjLaMG8CuvieaykPe8bqO3ex6IKw37JsJmk
 UOUyYAgKihVRwU5Sd9LfNUfdvNNWYnYgLH2lg6fYVHqNxl6tWsluAal3O0WOJlmUlcQ2lpE2O
 AQ03V4HOnkq/6Z04YqmWwBXd61l1zZYbs/Y72ZpbgUNzwVYnCwvO/JmVeLxd6BR6sCohuCeEy
 gtZNYDzBDjnflUD5R7aHeFi94Gsncrr9pqCloyXloSpMKkf0rr+ieq0enBzjC53ty+iGu8J70
 FDeaW5zKyPiCrTp9rHG07PeBnyJt61lY1FQRbSq7a1RFJRyPFaEryj2d++q/qK6xrgZQEkg+W
 Pr2fba2h4HHwTfHTzyI6FSZOFb0RrNBSyFroVkGGRo2VyYMmHXTOF5vS+aiLwOhp2tIyDAM
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 07/08/2020 à 12:17, Han Han a écrit :
> Signed-off-by: Han Han <hhan@redhat.com>
> ---
>  docs/amd-memory-encryption.txt | 4 ++--
>  docs/pvrdma.txt                | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/amd-memory-encryption.txt b/docs/amd-memory-encryption.txt
> index 43bf3ee6a5..80b8eb00e9 100644
> --- a/docs/amd-memory-encryption.txt
> +++ b/docs/amd-memory-encryption.txt
> @@ -95,10 +95,10 @@ References
>  -----------------
>  
>  AMD Memory Encryption whitepaper:
> -http://amd-dev.wpengine.netdna-cdn.com/wordpress/media/2013/12/AMD_Memory_Encryption_Whitepaper_v7-Public.pdf
> +https://developer.amd.com/wordpress/media/2013/12/AMD_Memory_Encryption_Whitepaper_v7-Public.pdf
>  
>  Secure Encrypted Virtualization Key Management:
> -[1] http://support.amd.com/TechDocs/55766_SEV-KM API_Specification.pdf
> +[1] http://developer.amd.com/wordpress/media/2017/11/55766_SEV-KM-API_Specification.pdf
>  
>  KVM Forum slides:
>  http://www.linux-kvm.org/images/7/74/02x08A-Thomas_Lendacky-AMDs_Virtualizatoin_Memory_Encryption_Technology.pdf
> diff --git a/docs/pvrdma.txt b/docs/pvrdma.txt
> index 0f0dd8a7e5..5c122fe818 100644
> --- a/docs/pvrdma.txt
> +++ b/docs/pvrdma.txt
> @@ -18,7 +18,7 @@ over-commit and, even if not implemented yet, migration support will be
>  possible with some HW assistance.
>  
>  A project presentation accompany this document:
> -- http://events.linuxfoundation.org/sites/events/files/slides/lpc-2017-pvrdma-marcel-apfelbaum-yuval-shaia.pdf
> +- https://blog.linuxplumbersconf.org/2017/ocw/system/presentations/4730/original/lpc-2017-pvrdma-marcel-apfelbaum-yuval-shaia.pdf
>  
>  
>  
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


