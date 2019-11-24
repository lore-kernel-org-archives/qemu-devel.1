Return-Path: <SRS0=aI0a=ZQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19182C432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 12:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D07AB2073F
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 12:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ayljtXHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07AB2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYqtT-0005eJ-Oj
	for qemu-devel@archiver.kernel.org; Sun, 24 Nov 2019 07:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iYqpo-0004iX-7N
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 07:17:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iYqpm-0003kn-34
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 07:17:47 -0500
Received: from mout.web.de ([212.227.15.14]:46425)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1iYqpj-0003jB-Jf
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 07:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1574597852;
 bh=aTT/3O/0fGozJ0PmGJWxbOBYvgmn9SjBwYKp57AguZA=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=ayljtXHRdJUF5i9fAnanIACqTeoUJti1/7AscZr/8LV46Kt+17ZktDv5xQ9x3H1W0
 ZIvgONNdsbSCOZVKNPVMYIQ82CCdQzAqQ2iqu3H9g/HWfmM+TzGJsfy0ymNu21iCSK
 PusoFRcT5DKo4fTPpJCvjrpMmSSO4zw86XiZ1XO0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.79]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lvk9E-1hlNJI0zfQ-017Z1h; Sun, 24
 Nov 2019 13:17:32 +0100
Date: Sun, 24 Nov 2019 13:17:30 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH 0/5] hvf: stability fixes for HVF
Message-ID: <20191124131730.19ad6bf1@luklap>
In-Reply-To: <cover.1574375668.git.dirty@apple.com>
References: <cover.1574375668.git.dirty@apple.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KoOxK4nL/V4kvm1tr8QsczCdyjta2CWZNqd3viHeSYMS9rM5sHS
 NlsZeWE7Mc6+tg9kcyxpqAu3nFThfTuryYeBDL/Lxr9l70TsvfPaD9XDr7xdGjq6bILhSSp
 NTLGrGRbl5JyH1MSAVAIvhpRuuHn5jH4gT4XDz+vlyg49LlfT3SEm/dKE7ct8z2c5NtJJJs
 ubeL09ExSE4DLgYoKlN9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JhCeIDF/BU0=:On+uon7uPabvdOlnCb54JC
 ZXquVk2+3oSkkbGCzfezcth3bd11gLjlH6Jy4pY7qNIsJO7VonblrSS+4sNl0XvIz8TXU4wem
 CUxSVMR+I/KoB3gTY2AHwy/heZNKA11ROBW7Obs8oIz1G3QIFk7Mz3OrPwSaagXAfsqASfEC4
 TdH3gsZrKv5FyuWc9TX64zhMt0RwP2yFv2UF4lZMCZutss2McTk9WUfrnprHq04Jps5NB5oHd
 I1VNQUm78xHx8gGbwfd1SFAlnjm87xm9xTBtgwQozM0SR7CHGPfrQcYTNxa6bMiq8g5FZ6OuM
 LdXNSMTtp8DlyhqYUIByU6P01oQv/8Z7Yij7yGnPjp5ivzhpvI9pqVhdQTGe8nMAG3+XjX3lh
 bQopY0vsDKp1Ih7WxX5scsFucf7oxZHdRX5i7F9G1geTulEkZi+i76dsid3Ct6FDKJK1XqQqM
 jvOr5v1Jf3lbAIILS7n9qHn75st1+lXLZf8nSerZdx0Egnx/3pliXeRN4EC8x4GUOE5KEAYlF
 EYWuHKkVGKQQo3ZLSik1AG02h+qaAUx2LqoDUoOW73YvDtv69EJ+xAJtYIGp6u4runNA1NEHL
 e6pdmLDAPRtEUxl/JvORm4AcPxR9MoP2iT84n8CTkxknkFYCWb3aNBsWjiuGO//JJhxtBsR/4
 4Gi8ogqLqrSmjKi4AV24djwkbdkdSb3GUgYIzVPwjpCC3qh/7dLxHFvpY2qv5Ra5g6ibKde6w
 Fo3dQzxyKpoE/551sIDK1RSZj3vzD/bVAmFW0iy4Is8zYrMhbz8yc66mEfoL98XZ9LpqoSrOU
 lmBQa1tXRZEPFz4A4IC4XcYWuCPkzsGjebRaAYe2104lQoRc7N53LHzpGMDCPf1Cq7ZUXP553
 p+S81oSAvr9waHoPu1VLde+nMFvA0joAMmCWgCnBsRG2IAPiiabbmBp1f2IUjrUTj/eMtg4lz
 J8kvOOHy9H/gw3HlT47GcwkbtrCwXuvn9On9U1jjAT6Y9YJmnUXlg/PBl1M0yVoYSafmLra4F
 g33Km7hxrq66wXU20JRwHTDE4Aw1GWejLezymC4+2PkXcxSQOZV9S7hAd5aUFi0W+W1IHZpz5
 B1+gJsXxyEB8+dkbgiF6I9ISOCaX+AzSh2Bp+dSRa9UwE/UknY71oyhPuHJo8nBfZxvwtUOOy
 SCD4viUkKKicw3EuRb5C3+/QKRUkLpu8BfCB19WvmiZfCWG3VORysf3vs/0QqbQhlQykBBoh7
 fTvaw2axWm1760LByNg+/9ZssF7Bxx4Emm3t9fn7TNYKAdqPqTjta0lb5E3Q=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.14
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
Cc: pbonzini@redhat.com, Cameron Esfahani <dirty@apple.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 Nov 2019 14:54:49 -0800
Cameron Esfahani via <qemu-devel@nongnu.org> wrote:

> The following patches fix stability issues with running QEMU on Apple
> Hypervisor Framework (HVF):
> - non-RAM, non-ROMD areas need to trap so accesses can be correctly
>   emulated.
> - Current TSC synchronization implementation is insufficient: when
>   running with more than 1 core, TSC values can go backwards.  Until
>   a correct implementation can be written, remove calls to
>   hv_vm_sync_tsc().  Pass through TSC to guest OS.
> - Fix REX emulation in relation to legacy prefixes.
> - More correctly match SDM when setting CR0 and PDPTE registers.
> - Save away exception type as well as vector in hvf_store_events() so
>   they can be correctly reinjected in hvf_inject_interrupts().  Under
>   heavy loads, exceptions got misrouted.
>
> Cameron Esfahani (5):
>   hvf: non-RAM, non-ROMD memory ranges are now correctly mapped in
>   hvf: remove TSC synchronization code because it isn't fully complete
>   hvf: correctly handle REX prefix in relation to legacy prefixes
>   hvf: more accurately match SDM when setting CR0 and PDPTE registers
>   hvf: save away type as well as vector so we can reinject them
>
>  target/i386/hvf/hvf.c        | 74 +++++++++++++++++++++++++-----------
>  target/i386/hvf/vmx.h        | 18 +++++----
>  target/i386/hvf/x86_decode.c | 55 ++++++++++++++-------------
>  target/i386/hvf/x86_decode.h | 16 ++++----
>  target/i386/hvf/x86_emu.c    |  3 --
>  target/i386/hvf/x86hvf.c     | 26 +++++--------
>  6 files changed, 108 insertions(+), 84 deletions(-)
>

Hi,
I can't comment on your code, but simply resend this as v2 with the
checkpatch.pl errors fixed. You can run checkpatch.pl locally before
posting (scripts/checkpatch.pl).

Regards,
Lukas Straub

