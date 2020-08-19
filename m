Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD01FC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 13:52:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9805E204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 13:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UzdMse6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9805E204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8OW4-0007Te-0e
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 09:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dvossel@redhat.com>)
 id 1k8OTi-00044D-Ox
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 09:50:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dvossel@redhat.com>)
 id 1k8OTf-0003Ia-5f
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 09:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597845004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nt/bwu56DXvGx6x/fLtlahXmA1Ms8aVd4xeQwXu2yZs=;
 b=UzdMse6XcqAwDhL8K1NKRpcvM2iaiaUZY5mUv5oLUf0J33TEeFVi10eVTikxsid+Al7zOp
 7CSmlKl0WJjg8YwiLluTbauep+d5hAF+PkYXBc7ByCVlfyygKSraHF6r6pBx6WMvBtlNUn
 6GBXApcZR+Myawx6prEwOXzYEQ9PFV4=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-lByIw5PhPjqg-xQn8o_5Og-1; Wed, 19 Aug 2020 09:50:02 -0400
X-MC-Unique: lByIw5PhPjqg-xQn8o_5Og-1
Received: by mail-ua1-f72.google.com with SMTP id j13so6004608uaq.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 06:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nt/bwu56DXvGx6x/fLtlahXmA1Ms8aVd4xeQwXu2yZs=;
 b=EpPaN/vI/1kHa1iubTe+JbldN1Za1gE1GUi8MjCZpOPzln80z5EThliZfFRq7Gf/yG
 9yuses/YCF4iUMXcwWuhFVnEQpAndjqJlem6D7vX+WE3FUKUlpVJ5obZ5Lg6JuoHR7gk
 p9cRbuIwHGIDcOuUfNJyHZPT+jocyXTElS1zgCTN51s2f1bx/7TxNcZffepvO92Zbhp0
 c/dZTZI76Xs2JAlbCblPcpn1FkcM4HsmiLJHMTlPYRFjNX+mBGGbSECP+0rxaAdvuJHC
 NS46cUz/4hdLt/dglU32a/jtRi8Z/MWD4ijcJYJ2VuRTPIdmwshnaIS00KdsQgUDjsi+
 TuUQ==
X-Gm-Message-State: AOAM532FgUc8nNJjI7Ucgl0XwcS/53kLxUJZlo507ba1G6ptuoJBzK93
 giz91GvaDg3PnmQvKxNCLsvJ8jxhzJpsrtuKiNspIWYyJ+BM/Ge5LTyEXJ4w9CY5r+cNmXrfsIK
 zHjjO+IQmUKtMqb436e4ftGX6mHZKtgw=
X-Received: by 2002:a67:1e81:: with SMTP id
 e123mr13768336vse.210.1597845001911; 
 Wed, 19 Aug 2020 06:50:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxV9L1vI6taotBUu+js0ZnxVnB3zu8ZKMwrDCKMW9/3seT9+L0eLu8kFVWEgvHoF/G6KmSIhQtWRE1MDc1VkCY=
X-Received: by 2002:a67:1e81:: with SMTP id
 e123mr13768317vse.210.1597845001696; 
 Wed, 19 Aug 2020 06:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAPjOJFsjqFg6jO==Y5ExhL2+mZXA0Z1vce2pmUCODLtyS6Z7Yw@mail.gmail.com>
 <2310267.m5nKHIMqSz@silver>
In-Reply-To: <2310267.m5nKHIMqSz@silver>
From: David Vossel <dvossel@redhat.com>
Date: Wed, 19 Aug 2020 09:49:50 -0400
Message-ID: <CAPjOJFsr2_0Kdp03jbSUZ2vpde41uHrS6ki_Wax4pZ-d8RTDvQ@mail.gmail.com>
Subject: Re: guest agent public ssh key add/remove support?
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dvossel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000bb8e9f05ad3b4710"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dvossel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 06:57:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Michal Privoznik <mprivozn@redhat.com>,
 Fabian Deutsch <fdeutsch@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bb8e9f05ad3b4710
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 18, 2020 at 3:10 PM Christian Schoenebeck <
qemu_oss@crudebyte.com> wrote:

> On Dienstag, 18. August 2020 15:25:56 CEST David Vossel wrote:
> > - Guest Agent SSH add/remove Support?
> >
> > As a PoC, I cobbled together some guest agent exec and file write client
> > commands which can technically achieve the desired result of
> > adding/removing entries in a /home/<user>/.ssh/authorized_keys file.
> It's a
> > little unwieldy, but it works.
> >
> > This got me thinking, an officially supported guest agent api for this
> ssh
> > key management would be really nice. There's already a somewhat related
> > precedent with the "guest-set-user-password" guest agent command.
> >
> > So here's the question. What would you all think about the guest agent
> API
> > being expanded with new commands for adding/removing ssh public keys from
> > authorized_keys files?
>
> There are two pass-through file systems in QEMU: 9pfs and virtiofs. Don't
> you
> think they would be sufficient for the use case?
>

probably not entirely.

Understand this isn't an either/or scenario. Our api has been designed to
support multiple "propagation" methods for the ssh keys. We've converged on
the qemu guest agent for some other features and the agent appears to have
the potential to provide us the greatest flexibility when it comes to how
we want this pub ssh key use case to work.  This isn't to say something
like virtiofs won't make sense either in certain scenarios, but for the
purposes of this discussion we're hoping to explore how the qemu guest
agent could be used.

I don't want to go too deep into the shared filesystem approach. I'll
provide some context on the challenges there though.

- virtiofs requires guest kernel >= 5.4. We aren't considering 9p due to
security/performance concerns.
- file ownership/permissions. requires prior knowledge of uid/gid on the
host.
- persistence. if we share authorised_keys via virtiofs, then we have to
put this on a separate persistent network volume (otherwise user
modifications within guest are lost)
- potentially clobbers existing authorization_keys file on disk, with agent
we can merge our additions/removals to whatever the user has set in
authorized_keys.
- lack of KubeVirt support for virtiofs. however, it will likely make it
soon




> Best regards,
> Christian Schoenebeck
>
>
>

--000000000000bb8e9f05ad3b4710
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 18, 2020 at 3:10 PM Chris=
tian Schoenebeck &lt;<a href=3D"mailto:qemu_oss@crudebyte.com">qemu_oss@cru=
debyte.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Dienstag, 18. August 2020 15:25:56 CEST David Vossel wrote:<b=
r>
&gt; - Guest Agent SSH add/remove Support?<br>
&gt; <br>
&gt; As a PoC, I cobbled together some guest agent exec and file write clie=
nt<br>
&gt; commands which can technically achieve the desired result of<br>
&gt; adding/removing entries in a /home/&lt;user&gt;/.ssh/authorized_keys f=
ile. It&#39;s a<br>
&gt; little unwieldy, but it works.<br>
&gt; <br>
&gt; This got me thinking, an officially supported guest agent api for this=
 ssh<br>
&gt; key management would be really nice. There&#39;s already a somewhat re=
lated<br>
&gt; precedent with the &quot;guest-set-user-password&quot; guest agent com=
mand.<br>
&gt; <br>
&gt; So here&#39;s the question. What would you all think about the guest a=
gent API<br>
&gt; being expanded with new commands for adding/removing ssh public keys f=
rom<br>
&gt; authorized_keys files?<br>
<br>
There are two pass-through file systems in QEMU: 9pfs and virtiofs. Don&#39=
;t you <br>
think they would be sufficient for the use case?<br></blockquote><div><br><=
/div><div>probably not entirely.=C2=A0</div><div><br></div><div>Understand =
this isn&#39;t an either/or scenario. Our api has been designed to support =
multiple &quot;propagation&quot; methods for the ssh keys. We&#39;ve conver=
ged on the qemu guest agent for some other features and the agent appears t=
o have the potential to provide us the greatest flexibility when it comes t=
o how we want this pub ssh key use case to work.=C2=A0 This isn&#39;t to sa=
y something like virtiofs won&#39;t make sense either in certain scenarios,=
 but for the purposes of this discussion we&#39;re hoping to explore how th=
e qemu guest agent could be used.</div><div><br></div><div>I don&#39;t want=
 to go too deep into the shared filesystem approach. I&#39;ll provide some =
context on the challenges there though.</div><div><br></div><div>- virtiofs=
 requires guest kernel &gt;=3D 5.4. We aren&#39;t considering 9p due to sec=
urity/performance concerns.</div><div>- file ownership/permissions. require=
s prior knowledge of uid/gid on the host.<br>- persistence. if we share aut=
horised_keys via virtiofs, then we have to put this on a separate persisten=
t network volume (otherwise user modifications within guest are lost)</div>=
<div>- potentially clobbers existing authorization_keys file on disk, with =
agent we can merge our additions/removals to whatever the user has set in a=
uthorized_keys.</div><div>- lack of KubeVirt support for=C2=A0virtiofs. how=
ever, it will likely make it soon<br></div><div><br></div><div><br></div><d=
iv><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Best regards,<br>
Christian Schoenebeck<br>
<br>
<br>
</blockquote></div></div>

--000000000000bb8e9f05ad3b4710--


