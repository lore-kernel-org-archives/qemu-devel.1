Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1550C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 14:12:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 509FE2076C
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 14:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwFQEW+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509FE2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRc5o-0004ug-Ac
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 10:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hiharryharryharry@gmail.com>)
 id 1kRc4q-00045l-KX
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 10:11:56 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:40642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hiharryharryharry@gmail.com>)
 id 1kRc4p-0005xp-6K
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 10:11:56 -0400
Received: by mail-lj1-x242.google.com with SMTP id f21so14292762ljh.7
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2020 07:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EbMJEKt9eTLHmHaJUMiW2DhPkTQLllPYPo11qQ19vqc=;
 b=VwFQEW+MA+vk3KOHAnZ9RVYMNyrl/CBEEU9DwY0RhQCk8Fd7VREXwzYh5qnzBz75Bi
 hwNZRtvbDPcUeveJ+puH8GNwt2t8IjAkvmPCq1/Rv+1O48zzBpivnDjdQtqnwLsRhm+F
 FSV8wFTSDfN2XzKf6CyGs7vuuxdm6FCaS17SkHBhaB8gPrPg6+JXKHag4P6Tf0wq2vEZ
 nRxcewgXEyfb8LvxO78H4VNFIqEH0a6KJxyrNZSQrrpY/V2nThgE+IM0bEXeFFZsS10T
 RqPsGxk5E0dqeMwFaaPP7aAKAHWq18cQnSWSBKNYSvunR60O8/zftuFW0YLf4Li/8H1A
 T8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EbMJEKt9eTLHmHaJUMiW2DhPkTQLllPYPo11qQ19vqc=;
 b=GMF3c6AAqlXAN4SsalgHCWcwfkXZ8hxoCXkREerRM/6s5I62gGE43SKq4HcfFaU8Gb
 /YAP91ullao9SRJMy30HXmrYRmiWnXeV4oQnUv6cw6KaT0+//nbJlIKDa/KWwUA0JBnS
 7RPTwXm/VxNLo6gjm/jOGRFJxZxU/vpLRFl6B30hyR+GafrbIo+eJ1m3gGwFnvyqZR6w
 V2WUVOeTKcrNfZYvvpg0qCkTZHwawuoMwiYj/Tl+rVZT8KU4XfZMXWWVKxHCpSUCbpFA
 btL9kj7WOtA2+rvRXaN29mPSla3Zizg2cLbq0tPOsuev/qdWbjAEfQ8QiWGcNHZ6EfPU
 KJwQ==
X-Gm-Message-State: AOAM531D4JqigH2vKqfoHx/WEoDpDh56lK5MBsdGLKEqhfrJYnain3TF
 X/7W/ZndMJQsDWYbbv1C8PTofgbhpHBNrvCwsDU=
X-Google-Smtp-Source: ABdhPJxgRCiezPh0DkXDi4N9xHZs2IAqqtQfmwr4RO6QX/433VQxrQuWMt1y5v0dAxA2Ea1OaP8ESzABOe9eA/3piAY=
X-Received: by 2002:a2e:9f4d:: with SMTP id v13mr5977931ljk.379.1602425513594; 
 Sun, 11 Oct 2020 07:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <CA+-xGqMd4_58_+QKetjOsubBqrDnaYF+YWE3TC3kEcNGxPiPfg@mail.gmail.com>
 <47ead258320536d00f9f32891da3810040875aff.camel@redhat.com>
In-Reply-To: <47ead258320536d00f9f32891da3810040875aff.camel@redhat.com>
From: harry harry <hiharryharryharry@gmail.com>
Date: Sun, 11 Oct 2020 10:11:39 -0400
Message-ID: <CA+-xGqOm2sWbxR=3W1pWrZNLOt7EE5qiNWxMz=9=gmga15vD2w@mail.gmail.com>
Subject: Re: Why guest physical addresses are not the same as the
 corresponding host virtual addresses in QEMU/KVM? Thanks!
To: Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=hiharryharryharry@gmail.com; helo=mail-lj1-x242.google.com
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
 mathieu.tarral@protonmail.com, stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Maxim,

Thanks much for your reply.

On Sun, Oct 11, 2020 at 3:29 AM Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> On Sun, 2020-10-11 at 01:26 -0400, harry harry wrote:
> > Hi QEMU/KVM developers,
> >
> > I am sorry if my email disturbs you. I did an experiment and found the
> > guest physical addresses (GPAs) are not the same as the corresponding
> > host virtual addresses (HVAs). I am curious about why; I think they
> > should be the same. I am very appreciated if you can give some
> > comments and suggestions about 1) why GPAs and HVAs are not the same
> > in the following experiment; 2) are there any better experiments to
> > look into the reasons? Any other comments/suggestions are also very
> > welcome. Thanks!
> >
> > The experiment is like this: in a single vCPU VM, I ran a program
> > allocating and referencing lots of pages (e.g., 100*1024) and didn't
> > let the program terminate. Then, I checked the program's guest virtual
> > addresses (GVAs) and GPAs through parsing its pagemap and maps files
> > located at /proc/pid/pagemap and /proc/pid/maps, respectively. At
> > last, in the host OS, I checked the vCPU's pagemap and maps files to
> > find the program's HVAs and host physical addresses (HPAs); I actually
> > checked the new allocated physical pages in the host OS after the
> > program was executed in the guest OS.
> >
> > With the above experiment, I found GPAs of the program are different
> > from its corresponding HVAs. BTW, Intel EPT and other related Intel
> > virtualization techniques were enabled.
> >
> > Thanks,
> > Harry
> >
> The fundemental reason is that some HVAs (e.g. QEMU's virtual memory addresses) are already allocated
> for qemu's own use (e.g qemu code/heap/etc) prior to the guest starting up.
>
> KVM does though use quite effiecient way of mapping HVA's to GPA. It uses an array of arbitrary sized HVA areas
> (which we call memslots) and for each such area/memslot you specify the GPA to map to. In theory QEMU
> could allocate the whole guest's memory in one contiguous area and map it as single memslot to the guest.
> In practice there are MMIO holes, and various other reasons why there will be more that 1 memslot.

It is still not clear to me why GPAs are not the same as the
corresponding HVAs in my experiment. Since two-dimensional paging
(Intel EPT) is used, GPAs should be the same as their corresponding
HVAs. Otherwise, I think EPT may not work correctly. What do you
think?

Thanks,
Harry

