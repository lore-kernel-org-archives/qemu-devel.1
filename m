Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC8DC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 18:10:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81EA92074A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 18:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRipPriG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81EA92074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMxbm-0004CO-I7
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 14:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kMxaO-0003c8-MA
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 14:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50998)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kMxaM-0005vM-Kv
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 14:09:16 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601316553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tYtZ30AjDctjUZZa0nrIRuqqXMqJh5Jv5+QHev3pg+Q=;
 b=LRipPriGYcVDlLnvp9hy29eiVIEOAfAeffEQJvaI35WXlbyAAQruy25oalGI3OiCpa/HIN
 Wz76ahgpsvmXSa2LRgmCgEnS88IxJq/AM36DhPIijllgclgkyO8u3lPil6QFIPafVOujob
 3LBd7a5PKNSvip1njivlUv9kBtL7dKg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-ctLWIV46MqOwW4jd1eRGPw-1; Mon, 28 Sep 2020 14:09:11 -0400
X-MC-Unique: ctLWIV46MqOwW4jd1eRGPw-1
Received: by mail-ed1-f70.google.com with SMTP id n19so883557eds.8
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 11:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tYtZ30AjDctjUZZa0nrIRuqqXMqJh5Jv5+QHev3pg+Q=;
 b=jieaD7CUVlYamRvbwMFQx+CKhGgMYpJ+GADHsAvxTqWwfwoHhQ+B369xknNLOrHeu6
 wRlATFViAnxlUi3pKzwMYKoyqEkCwDH1Ea5ENHj7fTvgjPXH/NEmIO4La4L0Xk8JeN1I
 6CYoNxt3/okdyyaped0vUKjdnwazpcPrIDHrFT5BYoiWb9AyDly5ozYeVvXSM8feTpwe
 w19z9wS4410LH79h6ZlEwR0IzQRi+gP6CWrMlitxjH9F9pQ/blRJ3dhG0S/GM/36dX0O
 gFngijT4DGxlXziS1oweRaQqyamD9n4w2xW+P5tCDd3FYIO++3raBwlkzwLOlWmhqZab
 2W/g==
X-Gm-Message-State: AOAM53210y7Cjq5Cb/4zf+MwXtVP7qx6TOEde90XCcdgEBNNtukHdl6/
 JLOtrhtp8Bth4oHl6zBjKlinEBsOWMnJMm9oqvS68j7HNf3T1T9JnZ8vFBZ14HodM4gLxF3901I
 lvRLluwgyMOKbXzedNoPDWZRsrxcDHSM=
X-Received: by 2002:a50:8d57:: with SMTP id t23mr3226377edt.308.1601316549678; 
 Mon, 28 Sep 2020 11:09:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3mrEPpGkfCuMvcCB9H4ZM+U9ASB/2wf2zAjTyiEN0JfXtUGcZDdOwGJqieJM1QCC96XxfgqEM68vFgrFDdV0=
X-Received: by 2002:a50:8d57:: with SMTP id t23mr3226356edt.308.1601316549483; 
 Mon, 28 Sep 2020 11:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200922201124.GA6606@ashkalra_ubuntu_server>
 <5a58509c-5838-f0aa-d9ab-4f85ca0ac35f@redhat.com>
 <20200925204607.GA10964@ashkalra_ubuntu_server>
 <e9b09c9b-4d4c-c6de-4cce-807effc38836@redhat.com>
 <20200925234841.GA11103@ashkalra_ubuntu_server>
 <6a0188c5-8dbc-e86c-6726-ba7bfb821697@redhat.com>
 <20200928132639.GA13172@ashkalra_ubuntu_server>
In-Reply-To: <20200928132639.GA13172@ashkalra_ubuntu_server>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 28 Sep 2020 20:08:56 +0200
Message-ID: <CABgObfZfiCRU_m-ispWdL0e8gHNPn2v=x6hMjWpFE0=3U-kKwg@mail.gmail.com>
Subject: Re: SEV guest debugging support for Qemu
To: Ashish Kalra <ashish.kalra@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000001af02b05b063903f"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: thomas.lendacky@amd.com, jon.grimm@amd.com, brijesh.singh@amd.com,
 David Gilbert <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001af02b05b063903f
Content-Type: text/plain; charset="UTF-8"

Il lun 28 set 2020, 15:26 Ashish Kalra <ashish.kalra@amd.com> ha scritto:

> Hello Paolo,
>
> On Sat, Sep 26, 2020 at 02:02:20AM +0200, Paolo Bonzini wrote:
> > On 26/09/20 01:48, Ashish Kalra wrote:
> > > Thanks for your input, i have one additional query with reference to
> this support :
> > >
> > > For all explicitly unecrypted guest memory regions such as S/W IOTLB
> bounce buffers,
> > > dma_decrypted() allocated regions and for guest regions marked as
> "__bss_decrypted",
> > > we need to ensure that DBG_DECRYPT API calls are bypassed for such
> > > regions and those regions are dumped as un-encrypted.
> >
> > Yes those would be a bit different as they would be physical memory
> > accesses.  Those currently go through address_space_read in memory_dump
> > (monitor/misc.c), and would have to use the MemoryDebugOps instead.
> > That is the place to hook into in order to read the KVM page encryption
> > bitmap (which is not per-CPU, so another MemoryDebugOps entry
> > get_phys_addr_attrs?); the MemTxAttrs can then be passed to the read
> > function in the MemoryDebugOps.
> >
>
> Actually, currently we do this in sev_dbg_crypt() in KVM itself by
> checking the page encryption bitmap and if it is an un-encrypted guest
> memory region then returning the un-encrypted buffer read from user
> back to it as it is.
>

Fair enough. :-)

Paolo


> > > This guest memory regions encryption status is found using KVM's page
> encryption bitmap
> > > support which is part of the page encryption bitmap hypercall
> interface of the
> > > KVM/QEMU SEV live migration patches.
> > >
> > > As this additional debug support is dependent on the KVM's page
> encryption bitmap
> > > support, are there any updates on KVM SEV live migration patches ?
> >
> > Sorry about that, I've been busy with QEMU.  I'll review them as soon as
> > possible.H
>
> Looking forward to your updates and reviews regarding the same.
>
> Thanks,
> Ashish
>
>

--0000000000001af02b05b063903f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 28 set 2020, 15:26 Ashish Kalra &lt;<a href=3D"=
mailto:ashish.kalra@amd.com">ashish.kalra@amd.com</a>&gt; ha scritto:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">Hello Paolo,<br>
<br>
On Sat, Sep 26, 2020 at 02:02:20AM +0200, Paolo Bonzini wrote:<br>
&gt; On 26/09/20 01:48, Ashish Kalra wrote:<br>
&gt; &gt; Thanks for your input, i have one additional query with reference=
 to this support :<br>
&gt; &gt; <br>
&gt; &gt; For all explicitly unecrypted guest memory regions such as S/W IO=
TLB bounce buffers,<br>
&gt; &gt; dma_decrypted() allocated regions and for guest regions marked as=
 &quot;__bss_decrypted&quot;,<br>
&gt; &gt; we need to ensure that DBG_DECRYPT API calls are bypassed for suc=
h<br>
&gt; &gt; regions and those regions are dumped as un-encrypted.<br>
&gt; <br>
&gt; Yes those would be a bit different as they would be physical memory<br=
>
&gt; accesses.=C2=A0 Those currently go through address_space_read in memor=
y_dump<br>
&gt; (monitor/misc.c), and would have to use the MemoryDebugOps instead.<br=
>
&gt; That is the place to hook into in order to read the KVM page encryptio=
n<br>
&gt; bitmap (which is not per-CPU, so another MemoryDebugOps entry<br>
&gt; get_phys_addr_attrs?); the MemTxAttrs can then be passed to the read<b=
r>
&gt; function in the MemoryDebugOps.<br>
&gt;<br>
<br>
Actually, currently we do this in sev_dbg_crypt() in KVM itself by<br>
checking the page encryption bitmap and if it is an un-encrypted guest<br>
memory region then returning the un-encrypted buffer read from user<br>
back to it as it is.=C2=A0 <br></blockquote></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Fair enough. :-)</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto=
"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; &gt; This guest memory regions encryption status is found using KVM&#3=
9;s page encryption bitmap<br>
&gt; &gt; support which is part of the page encryption bitmap hypercall int=
erface of the<br>
&gt; &gt; KVM/QEMU SEV live migration patches.<br>
&gt; &gt; <br>
&gt; &gt; As this additional debug support is dependent on the KVM&#39;s pa=
ge encryption bitmap<br>
&gt; &gt; support, are there any updates on KVM SEV live migration patches =
?<br>
&gt; <br>
&gt; Sorry about that, I&#39;ve been busy with QEMU.=C2=A0 I&#39;ll review =
them as soon as<br>
&gt; possible.H<br>
<br>
Looking forward to your updates and reviews regarding the same.<br>
<br>
Thanks,<br>
Ashish<br>
<br>
</blockquote></div></div></div>

--0000000000001af02b05b063903f--


