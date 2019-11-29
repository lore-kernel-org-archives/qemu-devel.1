Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9508FC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 23:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50403206BF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 23:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRbzF7fF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50403206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iapZ2-00047O-A4
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 18:20:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iapYE-0003h5-NA
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 18:19:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iapYB-0007vA-IM
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 18:19:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29942
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iapYB-0007uu-8e
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 18:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575069586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xpfRwn2RWMpV7rVUBve5GTZ448sFadYYhLU9kIYYI4k=;
 b=fRbzF7fFwtbmmSBLfLLG1dsbtfaxe3uwON2yiXD2aFMCv1szH1VmwAD3Hiz2+U+I/wkass
 lCqSXi+3hirEpwPsWkUp0c8ay2L0u7lDcLYZSfVB08W4znMoJY4IFV0TWlJIrT3FJ0bMmx
 Za24J3xYUOyMDKJSHaGT43ake3zF8DA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-4_ZhlNttP0KWqQZapIPtgw-1; Fri, 29 Nov 2019 18:19:40 -0500
Received: by mail-ed1-f69.google.com with SMTP id h2so18403244edd.19
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 15:19:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ec/Pc5wcME+VPKk2xmT3/s8R/RqjGikWvvrSljqsThk=;
 b=lTBQiM2l41+gcIqa49ZIHClPX4GWFetE+PAjZxZx+Fpu6zhkLfX2lQLWuDyF5lEQ11
 Ckg2OQ/1vriUvqtFAi2axfJRs3tjFojqilG+s54VpLz+J1HJUj9B+4TV+Sj9W6+LoMSn
 CbkZ8D+6g6Y0cWb6EzGw2FUcyqFpc8Gx9x63qI/HWctwPwALHIbXv5nAtfHMAmJS/Zal
 GO8lsQNZwUzbTG4CGNR6kgGhHfbO9Ynl9W0toS8OAJk5N4TtzghQo6lFt/tMbLr3B8nE
 yrGP2dHD9ooC6eOhw35GCBkB/v7tylqH94QhhMisl18WOxNeulnrfw+nJi5sWt+Rt59Q
 SMew==
X-Gm-Message-State: APjAAAXoJwwGbyrnHmsQGyI6AvzJ83qhDv/HH7kItDnn7sXOho3Z254W
 ZvD+tqmbr7gLcqnurF1o8Bz1AHKYqKZ9lr1f1M1xghCd8S9rUq5Z/PBpqZ5ZZPNcGhAkSp5nqNd
 0YxKBmaRoR2sQTAgTDsDqa4xZd6pHufs=
X-Received: by 2002:a05:6402:cb5:: with SMTP id
 cn21mr3961161edb.92.1575069579740; 
 Fri, 29 Nov 2019 15:19:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqwkEEpLwjpfHrlI4WfEAiWJHnUn6mnA/yY9zzcrYOW7PNwx2FE69Koy1h08vVuWra+gRttwWIWO2Pto9y6mF78=
X-Received: by 2002:a05:6402:cb5:: with SMTP id
 cn21mr3961130edb.92.1575069579494; 
 Fri, 29 Nov 2019 15:19:39 -0800 (PST)
MIME-Version: 1.0
References: <20191128190408.GC3294@work-vm>
 <20191129093409.GB2260471@redhat.com>
 <98520a07-cf5d-a2a9-cfa4-944839b94c7c@redhat.com>
 <20191129180103.GA2840@work-vm>
 <1e59f880-1a62-3230-c56a-533f2b797525@redhat.com>
 <20191129182021.GD2837@work-vm>
 <c024ad69-2b94-cdd0-e9d3-617188d82bc3@redhat.com>
 <20191129185400.GF2837@work-vm>
In-Reply-To: <20191129185400.GF2837@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Nov 2019 00:19:28 +0100
Message-ID: <CABgObfZjz=5vWs+-DHTaxfOEu+9Vw1+SuZLSpzxZpRNFRzNKEQ@mail.gmail.com>
Subject: Re: libcap vs libcap-ng mess
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
X-MC-Unique: 4_ZhlNttP0KWqQZapIPtgw-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/alternative; boundary="000000000000c865770598847607"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Thomas Huth <thuth@redhat.com>, "P. Berrange, Daniel" <berrange@redhat.com>,
 qemu-devel@nongnu.org, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c865770598847607
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 29 nov 2019, 19:54 Dr. David Alan Gilbert <dgilbert@redhat.com> ha
scritto:

> > Yes, it's per thread.  The state can be built from
> > capng_clear/capng_get_caps_process + capng_update, and left in there
> > forever.  There is also capng_save_state/capng_restore_state which, as
> > far as I can see from the sources, can be used across threads.
>
> So, I think what you're saying is I need to:
>   a) Before we sandbox do the capng_get_caps_process
>

Why not after sandboxing? If the code is in any way similar to the 9p
proxy, you have two states, "sandboxed with capabilities" and "sandboxed
without capabilities". The former (permitted=3Deffective) is what you get
after setresuid/setresgid, the other can be computed after sandboxing and
saved using capng_save_state. The FSETID capability can be updated
explicitly before/after capng_apply.

  b) Before we start a new thread do a capng_save_state and restore it
> in the thread
>

Or just save after (a), and restore always before capng_apply.

  a) This code is very local - it does a drop FSETID, a write, restore
> FSETID
>   b) I'm not sure but I suspect it's used only in the non-uid=3D0 case;
> the whole thing is just a hack to cause setuid/setgid to be dropped
> in the case where it's written by a process that doesn't have FSETID
> (hmm I guess if the guest was root but didn't have fsetid then it would
> be 0?)
>

Yes it would. For uid!=3D0 the kernel clears the effective capabilities so =
it
shouldn't need to do anything, unless virtiodsd restores capabilities after
setresuid/setresgid.

But are you suggesting I need to change something other than the
> effective caps in that case?
>

No, only the effective caps.

Paolo

--000000000000c865770598847607
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 29 nov 2019, 19:54 Dr. David Alan Gilbert &lt;<=
a href=3D"mailto:dgilbert@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
dgilbert@redhat.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">&gt; Yes, it&#39;s per thread.=C2=A0 The state can be built from<br>
&gt; capng_clear/capng_get_caps_process + capng_update, and left in there<b=
r>
&gt; forever.=C2=A0 There is also capng_save_state/capng_restore_state whic=
h, as<br>
&gt; far as I can see from the sources, can be used across threads.<br><br>
So, I think what you&#39;re saying is I need to:<br>
=C2=A0 a) Before we sandbox do the capng_get_caps_process<br></blockquote><=
/div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Why not after sand=
boxing? If the code is in any way similar to the 9p proxy, you have two sta=
tes, &quot;sandboxed with capabilities&quot; and &quot;sandboxed without ca=
pabilities&quot;. The former (permitted=3Deffective) is what you get after =
setresuid/setresgid, the other can be computed after sandboxing and saved u=
sing capng_save_state. The FSETID capability can be updated explicitly befo=
re/after capng_apply.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><d=
iv class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0 b) Before we start a new thread do a capng_save_state and restore it=
<br>
in the thread<br></blockquote></div></div><div dir=3D"auto"><br></div><div =
dir=3D"auto">Or just save after (a), and restore always before capng_apply.=
</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quo=
te"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">=C2=A0 a) This code is very local - it d=
oes a drop FSETID, a write, restore<br>
FSETID<br>
=C2=A0 b) I&#39;m not sure but I suspect it&#39;s used only in the non-uid=
=3D0 case; <br>
the whole thing is just a hack to cause setuid/setgid to be dropped<br>
in the case where it&#39;s written by a process that doesn&#39;t have FSETI=
D<br>
(hmm I guess if the guest was root but didn&#39;t have fsetid then it would=
<br>
be 0?)<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Yes it would. For uid!=3D0 the kernel clears the effective capabiliti=
es so it shouldn&#39;t need to do anything, unless virtiodsd restores capab=
ilities after setresuid/setresgid.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">But ar=
e you suggesting I need to change something other than the<br>
effective caps in that case?<br></blockquote></div></div><div dir=3D"auto">=
<br></div><div dir=3D"auto">No, only the effective caps.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Paolo</div></div>

--000000000000c865770598847607--


