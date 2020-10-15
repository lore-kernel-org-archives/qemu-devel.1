Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7900CC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 03:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78D222245
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 03:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKMdDH+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78D222245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSuDp-0007MQ-QJ
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 23:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hiharryharryharry@gmail.com>)
 id 1kSuCk-0006Si-3P
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 23:45:26 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:46834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hiharryharryharry@gmail.com>)
 id 1kSuCi-0004Am-Hj
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 23:45:25 -0400
Received: by mail-lf1-x144.google.com with SMTP id v6so1828958lfa.13
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 20:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z9zMX2coYN8H3CBILNpr7q+Vk2fAdNTcRYoWO7ULwRE=;
 b=kKMdDH+imlskdTjp+gjVXY1DrKt1Ep3Ytjb9qBpCPjUyBhxbCRiecmIslucxehpO4n
 94K6JKqf4UWSCahN3lwioeQ1xls6OR+ilsIPeQej9Otm8Zr6MrYAxTtSJwp0K6pzKYHU
 L2y1CMmLkLgDHlFIA/AZ9NpRnJW6tranwh6+AYlOSR2COC8/lGkWHPJJM8q7TPU7HfmW
 Pj+YaAK3TdiMtE7RrMsMD2MK0zu/h9FdyrISKIc7dH1knGMCNQVCCQu5+WskQsLcUxG/
 /uAveQssjFvYZ2PW7294kGGKD89Mnw7fMO2Sgym2cJk8lQWa3ZcpqsVTe5NmNkbWpgWE
 k1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z9zMX2coYN8H3CBILNpr7q+Vk2fAdNTcRYoWO7ULwRE=;
 b=r8Ugc69FplhMs9Mje1SRQZc1JNtpKz/LPe1L5bFDKtasgQ9ZNJ2rj49gTyhiSVZ2KZ
 mVFHkoaOJVBC7KlLm+Dln7oFmBBX02Xj+US2OYEAO+wZaYQMAWklXU7rKHHX1RzU8oLW
 SRLm/nlXmpUFqx/F4taMPY1b35sKxOn6VJiF9eT1CYxwVOG5DSB2g3KvDcl1zI2rqx2H
 BeLYrGRrxKz9Zr+WIumXTJ8wvSUamOrNw9kQioHYSogSWjPMoNvjyxAG8oE6nlmgfSs6
 Xs2FoB2eDLFtUCcX31qsCzqoiVQ/SBbqdsV5LUqVrtuxsWGMCL6o2qFzX2GxJi0HlHFD
 Xu/Q==
X-Gm-Message-State: AOAM533t1k17M8Ys/Adbt5PI75wqOt+7noyEpHexfFJZDwCFsJmkM3F4
 Fc1m2Dzg87qNdf2r4qdeRlGZ/Ma/atSggItDvTs=
X-Google-Smtp-Source: ABdhPJxmhGw0f35E0C3XKDWPhs9gxr7BD5N3ErbxT6FYWhPozjavL7xvKRkSdQMsQ7Mb2VXX/bDxA/I2LFN3YqzxYxM=
X-Received: by 2002:a19:4bd4:: with SMTP id y203mr330362lfa.539.1602733522366; 
 Wed, 14 Oct 2020 20:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <CA+-xGqMd4_58_+QKetjOsubBqrDnaYF+YWE3TC3kEcNGxPiPfg@mail.gmail.com>
 <47ead258320536d00f9f32891da3810040875aff.camel@redhat.com>
 <CA+-xGqOm2sWbxR=3W1pWrZNLOt7EE5qiNWxMz=9=gmga15vD2w@mail.gmail.com>
 <20201012165428.GD26135@linux.intel.com>
 <CA+-xGqPkkiws0bxrzud_qKs3ZmKN9=AfN=JGephfGc+2rn6ybw@mail.gmail.com>
 <20201013045245.GA11344@linux.intel.com>
 <CA+-xGqO4DtUs3-jH+QMPEze2GrXwtNX0z=vVUVak5HOpPKaDxQ@mail.gmail.com>
 <CA+-xGqMMa-DB1SND5MRugusDafjNA9CVw-=OBK7q=CK1impmTQ@mail.gmail.com>
 <a163c2d8-d8a1-dc03-6230-a2e104e3b039@redhat.com>
 <CA+-xGqOMKRh+_5vYXeLOiGnTMw4L_gUccqdQ+HGSOzuTosp6tw@mail.gmail.com>
 <a4f3816dab09f4e28e33c66b8ff8273147415567.camel@redhat.com>
In-Reply-To: <a4f3816dab09f4e28e33c66b8ff8273147415567.camel@redhat.com>
From: harry harry <hiharryharryharry@gmail.com>
Date: Wed, 14 Oct 2020 23:45:02 -0400
Message-ID: <CA+-xGqME1C180HcEfOF2cxUtmH6ZeeGqbGYjfYrE7ke8DpuzUg@mail.gmail.com>
Subject: Re: Why guest physical addresses are not the same as the
 corresponding host virtual addresses in QEMU/KVM? Thanks!
To: Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=hiharryharryharry@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 PLING_QUERY=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kvm@vger.kernel.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 mathieu.tarral@protonmail.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Maxim,

Thanks for your emphasis. It's much clearer.

Best,
Harry

