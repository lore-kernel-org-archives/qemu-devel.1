Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6258C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 00:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909832080C
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 00:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZjv6/n+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909832080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBRwU-0002t3-Qm
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 20:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1kBRvj-0002LV-PK; Thu, 27 Aug 2020 20:07:43 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:34636)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1kBRvi-0000MK-7O; Thu, 27 Aug 2020 20:07:43 -0400
Received: by mail-pj1-x1042.google.com with SMTP id n3so3341221pjq.1;
 Thu, 27 Aug 2020 17:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jLA2Kfpf0j2+iS43FL0rjBWy4RbI10Z6krHixhdhzEo=;
 b=kZjv6/n+fRqdE2+R9q/wZ3ls1/2rQ+YW5mJIlJRaPl5GG7tdp1JojK/K6QV769K3gm
 ME1SO+ufDPQS+mJMOwgI7zzK5F3Vu71wcX7ad/gRpzpv8jGAIn8vse8m74M+qRDNv2Mw
 8b5iJdJj27CNQcxVBNv1d/fHVbCcwEmgBNggdBbr+VehN5Cr86LrCaEM7NG5yj7oUisD
 OiWjjwabnQweARu3nk9yQq6kJTG0SHCzUU0V+0TetStE+vPdajc/Z6udZE4jLdfRmbKe
 u4NQCCZZKY8m1h0lWmn9RSknL0ca1QAJDnTSXZfhgvYMmepnk+4vt98nxVOaTVEpjd55
 kbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jLA2Kfpf0j2+iS43FL0rjBWy4RbI10Z6krHixhdhzEo=;
 b=O1ENcsYS8n6QmHgm65IhWcjgnXA5zhUGITT1fPhACGnvteEymJ660fKrEdiDPszCrB
 OGh7lDHEAP/yaZH6PDKMp6/EG57SknmPK4NinAGi64VlSmA160UPq/u3QW5d7qe4GtgF
 tr2EAsCTZOyMLa7tjfv0EHF8KMCiwAR1Eoo3wAj3tWMibxGN2P6Le0zWTvenVM6Z7dwO
 1ul/Ou71UfD3OqqcONbyHf5NCa+SLWUEF0XeuiZhOshvLMBzlis4UUP5YPC6t2Qga1yH
 ivEEAcL9y7Qh55XdUIyptp3FggZICsy97Fzr/Z7yKwSbcKldaXQY/MvNea5+WV68nr1T
 jabQ==
X-Gm-Message-State: AOAM531A/IJ0b5/v9tnEhw+1s9qrMhfJLwUM35SE5E/XDjg4XHfbxMF4
 QcsQs8CbBBqU527FlWXrvoiJeBOT6GDPBg14gi4=
X-Google-Smtp-Source: ABdhPJxIMO3MWRR/Y0DW9NzQ7FMRp/X8eD3M9X0Lt2yxRy8NDng6EcBqlBDqsRQ5OqGtl6MgzLG7kB1KgddMh3+wR7c=
X-Received: by 2002:a17:90a:191a:: with SMTP id 26mr47932pjg.197.1598573260042; 
 Thu, 27 Aug 2020 17:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200818105021.4998-1-rohit.shinde12194@gmail.com>
 <87o8mzjm7r.fsf@dusky.pond.sub.org>
 <CA+Ai=tD2QK9+GaXQoQWzKTPY-uZhLSCBeLUfz95eCiHv0v2i+A@mail.gmail.com>
 <87r1rsoc05.fsf@dusky.pond.sub.org>
In-Reply-To: <87r1rsoc05.fsf@dusky.pond.sub.org>
From: Rohit Shinde <rohit.shinde12194@gmail.com>
Date: Thu, 27 Aug 2020 17:07:30 -0700
Message-ID: <CA+Ai=tANWy2=PmW8Le9t8Ehj97Uny1FE3gCyrV6i6HhoOc0DoQ@mail.gmail.com>
Subject: Re: [PATCH v5] qapi/opts-visitor: Added missing fallthrough
 annotations
To: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004ff5a705ade4d79f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=rohit.shinde12194@gmail.com; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004ff5a705ade4d79f
Content-Type: text/plain; charset="UTF-8"

Hey Markus,

Thanks for the clarification! No, I do not have patches for the same. I was
browsing through the bite sized tasks page and that did not mention these
details. I will keep this in mind however. For now, I will leave this task
and I might return to it at a later time.

Thanks,
Rohit.

On Wed, Aug 26, 2020 at 11:10 PM Markus Armbruster <armbru@redhat.com>
wrote:

> Rohit Shinde <rohit.shinde12194@gmail.com> writes:
>
> > I am just compiling with cflag set to -Wimplicit-fallthrough. I am using
> > gcc.
>
> -Wimplicit-fallthrough is the same as -Wimplicit-fallthrough=3.  Our
> -code is not prepared for that.  What should work is
> --Wimplicit-fallthrough=2.
>
> If you have patches to make the entire tree compile with
> -Wimplicit-fallthrough=3, we can talk.  You'd have to test them on all
> supported hosts, and with a sufficient range of configurations to ensure
> they are not breaking builds.
>
>

--0000000000004ff5a705ade4d79f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hey Markus,<div><br></div><div>Thanks for the clarificatio=
n! No, I do not have patches for the same. I was browsing through the bite =
sized tasks page and that did not mention these details. I will keep this i=
n mind however. For now, I will leave this task and I might return to it at=
 a later time.</div><div><br></div><div>Thanks,</div><div>Rohit.</div></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On We=
d, Aug 26, 2020 at 11:10 PM Markus Armbruster &lt;<a href=3D"mailto:armbru@=
redhat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Rohit Shinde &lt;<a href=3D"mailto:rohit.shind=
e12194@gmail.com" target=3D"_blank">rohit.shinde12194@gmail.com</a>&gt; wri=
tes:<br>
<br>
&gt; I am just compiling with cflag set to -Wimplicit-fallthrough. I am usi=
ng<br>
&gt; gcc.<br>
<br>
-Wimplicit-fallthrough is the same as -Wimplicit-fallthrough=3D3.=C2=A0 Our=
<br>
-code is not prepared for that.=C2=A0 What should work is<br>
--Wimplicit-fallthrough=3D2.<br>
<br>
If you have patches to make the entire tree compile with<br>
-Wimplicit-fallthrough=3D3, we can talk.=C2=A0 You&#39;d have to test them =
on all<br>
supported hosts, and with a sufficient range of configurations to ensure<br=
>
they are not breaking builds.<br>
<br>
</blockquote></div>

--0000000000004ff5a705ade4d79f--

