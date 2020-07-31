Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3E6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 08:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8CF120838
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 08:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrRAg+xt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CF120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Qaf-0006c7-4T
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 04:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rmohr@redhat.com>) id 1k1Qa4-0006BF-CV
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 04:39:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47609
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <rmohr@redhat.com>) id 1k1Qa2-0006EN-Dx
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 04:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596184793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vLCcjsDe5WPrIchAiT+XruRPH9aIJZKT06MxjWX9+RE=;
 b=FrRAg+xtOpDyWqW3WRIcH+EgTfIRiwBlA18YDsznrQfuljsHlHRY1Mt+KrKs+YqJXlhYYd
 H+/ws/sC9PzcR05inU3AiD+DpXccoYz4o9z3kcvcC14Yo23ouO3eD5ZMMMTwfg8Umx2ypM
 xC42RFwcIvkSZqumQ2z8vJiZndzhPwY=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-i1v_zjkEMJWRmTLBgs1vDA-1; Fri, 31 Jul 2020 04:39:50 -0400
X-MC-Unique: i1v_zjkEMJWRmTLBgs1vDA-1
Received: by mail-oo1-f69.google.com with SMTP id t20so5735000oot.7
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 01:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vLCcjsDe5WPrIchAiT+XruRPH9aIJZKT06MxjWX9+RE=;
 b=A44gwDQN7prZNftU4508Sr1wbRNgPHif5JDY+SO/RyQtdzFeUx7qo61k6z2reZSISa
 E3uLNN6a/TlR6xu0Bo01S0gSTlTc1qXg+6xrP2wriPD5Ml45Kq9ogBUkEnuXoa+Eu0ut
 c6eybAUmI+j2dAJKe9FevKzCC/gzhXk1czknEMQOki7Tw6hqwOG3fgnS3Ie3pTwV9bjC
 2mnY5pYFLwRtJxi5S5ocP/Wt5ku3XvLm4dZGa7pc3uT1GNJi/d+tS1t96DZTTXk+2TYX
 73UpE0Z9kEQSmeBVmeDXJU/2RD1DBMlq1i4v9hCxFe0G6l2qZ4a9jGVlsWBWHtrO/eoR
 t0Ag==
X-Gm-Message-State: AOAM532Pm//FHmPW6KPBlzCaUaiawsPFyU+GuU5rZXIHwURwZmAw5bop
 yVVo+0mdkbSNMD+ti5HtVTSSmtujOlG9XmIJjpqv4MamlZdLu8FomvkdeEcHWdfqNBOxXtrGWGH
 YXM3lutq80c4IZ3FmfBZgIPFKAxU/QNU=
X-Received: by 2002:aca:1209:: with SMTP id 9mr2211091ois.136.1596184789256;
 Fri, 31 Jul 2020 01:39:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxX4fn3Alg8lc8GYtq9YBSgkyz8ejVQmYt4FW0/Yen3Zu+dgMWULJoZW2XoW8F7LUrgWduA86ex7VEjzRahk1Y=
X-Received: by 2002:aca:1209:: with SMTP id 9mr2211081ois.136.1596184789018;
 Fri, 31 Jul 2020 01:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200727190223.422280-1-stefanha@redhat.com>
 <20200727190223.422280-4-stefanha@redhat.com>
 <OSBPR01MB45826073E5A54CF869E56721E5730@OSBPR01MB4582.jpnprd01.prod.outlook.com>
 <CALDPj7syG0KPhtZEma5n403=YFZ2ptcD4MtP=GdrY9n1eUs5Eg@mail.gmail.com>
 <20200728131250.GB78409@redhat.com>
 <CALDPj7uvquu=YWX_Ve7ROdj=LZWjkgPOm+wvEAynGvjeF4Xivg@mail.gmail.com>
 <20200729144027.GF52286@stefanha-x1.localdomain>
 <ad75a25c-0343-5c57-1933-e3c88f76df1c@redhat.com>
 <20200731082638.GA173083@stefanha-x1.localdomain>
In-Reply-To: <20200731082638.GA173083@stefanha-x1.localdomain>
From: Roman Mohr <rmohr@redhat.com>
Date: Fri, 31 Jul 2020 10:39:37 +0200
Message-ID: <CALDPj7s-UjrvgD4-mhEwisetz7PtAO-RCmKvH+=1UTM8K8oLPw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print an
 error
To: Stefan Hajnoczi <stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=rmohr@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000005880c605abb8bb38"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=rmohr@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 04:39:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "vromanso@redhat.com" <vromanso@redhat.com>,
 Daniel Walsh <dwalsh@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
 "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>,
 "mpatel@redhat.com" <mpatel@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005880c605abb8bb38
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 31, 2020 at 10:26 AM Stefan Hajnoczi <stefanha@redhat.com>
wrote:

> On Thu, Jul 30, 2020 at 06:21:34PM -0400, Daniel Walsh wrote:
> > On 7/29/20 10:40, Stefan Hajnoczi wrote:
> > > On Wed, Jul 29, 2020 at 09:59:01AM +0200, Roman Mohr wrote:
> > >> On Tue, Jul 28, 2020 at 3:13 PM Vivek Goyal <vgoyal@redhat.com>
> wrote:
> > >>
> > >>> On Tue, Jul 28, 2020 at 12:00:20PM +0200, Roman Mohr wrote:
> > >>>> On Tue, Jul 28, 2020 at 3:07 AM misono.tomohiro@fujitsu.com <
> > >>>> misono.tomohiro@fujitsu.com> wrote:
> > >>>>
> > >>>>>> Subject: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and
> print
> > >>> an
> > >>>>> error
> > >> Yes they can run as root. I can tell you what we plan to do with the
> > >> containerized virtiofsd: We run it as part of the user-owned pod (a
> set of
> > >> containers).
> > >> One of our main goals at the moment is to run VMs in a user-owned pod
> > >> without additional privileges.
> > >> So that in case the user (VM-creator/owner) enters the pod or
> something
> > >> breaks out of the VM they are just in the unprivileged container
> sandbox.
> > >> As part of that we try to get also rid of running containers in the
> > >> user-context with the root user.
> > >>
> > >> One possible scenario which I could think of as being desirable from a
> > >> kubevirt perspective:
> > >> We would run the VM in one container and have an unprivileged
> > >> virtiofsd container in parallel.
> > >> This container already has its own mount namespace and it is not that
> > >> critical if something manages to enter this sandbox.
> > >>
> > >> But we are not as far yet as getting completely rid of root right now
> in
> > >> kubevirt, so if as a temporary step it needs root, the current
> proposed
> > >> changes would still be very useful for us.
> > > What is the issue with root in user namespaces?
> > >
> > > I remember a few years ago it was seen as a major security issue but
> > > don't remember if container runtimes were already using user namespaces
> > > back then.
> > >
> > > I guess the goal might be simply to minimize Linux capabilities as much
> > > as possible?
> > >
> > > virtiofsd could nominally run with an arbitrary uid/gid but it still
> > > needs the Linux capabilities that allow it to change uid/gid and
> > > override file system permission checks just like the root user. Not
> sure
> > > if there is any advantage to running with uid 1000 when you still have
> > > these Linux capabilities.
> > >
> > > Stefan
> >
> > When you run in a user namespace, virtiofsd would only have
> > setuid/setgid over the range of UIDs mapped into the user namespace.  So
> > if UID=0 on the host is not mapped, then the container can not create
> > real UID=0 files on disk.
> >
> > Similarly you can protect the user directories and any content by
> > running the containers in a really high UID Mapping.
>
> Roman, do user namespaces address your concerns about uid 0 in
> containers?
>

They may eventually solve it. I would not let us hang up on this right now,
since as said at least in kubevirt we can't get rid right now of root
anyway.
Even if it is at some point in the future save and supported on
bleeding-edge managed k8s clusters to allow ordinary users to run with uid
0, from my perspective it is right now common to restrict namespaces with
PodSecurityPolicies or SecurityContexts to not allow running pods as root
for normal users.
It is also common that a significant part of the community users run docker
and/or run on managed k8s clusters where they can not influence if
user-namespaces are enabled, if they can run pods as root, if the runtime
points to a seccomp file they like or if the runtime they prefer is used.

But let me repeat again that we require root right now anyway and that we
don't run the pods right now with the user privileges (but we should and we
aim for that). Right now PSPs and SCCs restrict access to these pods by the
users.
So for our use case, at this exact moment root is acceptable, the unshare
call is a little bit more problematic.

Best Regards,
Roman



>
> Stefan
>

--0000000000005880c605abb8bb38
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 31, 2020 at 10:26 AM Stef=
an Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stefanha@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n Thu, Jul 30, 2020 at 06:21:34PM -0400, Daniel Walsh wrote:<br>
&gt; On 7/29/20 10:40, Stefan Hajnoczi wrote:<br>
&gt; &gt; On Wed, Jul 29, 2020 at 09:59:01AM +0200, Roman Mohr wrote:<br>
&gt; &gt;&gt; On Tue, Jul 28, 2020 at 3:13 PM Vivek Goyal &lt;<a href=3D"ma=
ilto:vgoyal@redhat.com" target=3D"_blank">vgoyal@redhat.com</a>&gt; wrote:<=
br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; On Tue, Jul 28, 2020 at 12:00:20PM +0200, Roman Mohr wrot=
e:<br>
&gt; &gt;&gt;&gt;&gt; On Tue, Jul 28, 2020 at 3:07 AM <a href=3D"mailto:mis=
ono.tomohiro@fujitsu.com" target=3D"_blank">misono.tomohiro@fujitsu.com</a>=
 &lt;<br>
&gt; &gt;&gt;&gt;&gt; <a href=3D"mailto:misono.tomohiro@fujitsu.com" target=
=3D"_blank">misono.tomohiro@fujitsu.com</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Subject: [PATCH v2 3/3] virtiofsd: probe unsh=
are(CLONE_FS) and print<br>
&gt; &gt;&gt;&gt; an<br>
&gt; &gt;&gt;&gt;&gt;&gt; error<br>
&gt; &gt;&gt; Yes they can run as root. I can tell you what we plan to do w=
ith the<br>
&gt; &gt;&gt; containerized virtiofsd: We run it as part of the user-owned =
pod (a set of<br>
&gt; &gt;&gt; containers).<br>
&gt; &gt;&gt; One of our main goals at the moment is to run VMs in a user-o=
wned pod<br>
&gt; &gt;&gt; without additional privileges.<br>
&gt; &gt;&gt; So that in case the user (VM-creator/owner) enters the pod or=
 something<br>
&gt; &gt;&gt; breaks out of the VM they are just in the unprivileged contai=
ner sandbox.<br>
&gt; &gt;&gt; As part of that we try to get also rid of running containers =
in the<br>
&gt; &gt;&gt; user-context with the root user.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; One possible scenario which I could think of as being desirab=
le from a<br>
&gt; &gt;&gt; kubevirt perspective:<br>
&gt; &gt;&gt; We would run the VM in one container and have an unprivileged=
<br>
&gt; &gt;&gt; virtiofsd container in parallel.<br>
&gt; &gt;&gt; This container already has its own mount namespace and it is =
not that<br>
&gt; &gt;&gt; critical if something manages to enter this sandbox.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; But we are not as far yet as getting completely rid of root r=
ight now in<br>
&gt; &gt;&gt; kubevirt, so if as a temporary step it needs root, the curren=
t proposed<br>
&gt; &gt;&gt; changes would still be very useful for us.<br>
&gt; &gt; What is the issue with root in user namespaces?<br>
&gt; &gt;<br>
&gt; &gt; I remember a few years ago it was seen as a major security issue =
but<br>
&gt; &gt; don&#39;t remember if container runtimes were already using user =
namespaces<br>
&gt; &gt; back then.<br>
&gt; &gt;<br>
&gt; &gt; I guess the goal might be simply to minimize Linux capabilities a=
s much<br>
&gt; &gt; as possible?<br>
&gt; &gt;<br>
&gt; &gt; virtiofsd could nominally run with an arbitrary uid/gid but it st=
ill<br>
&gt; &gt; needs the Linux capabilities that allow it to change uid/gid and<=
br>
&gt; &gt; override file system permission checks just like the root user. N=
ot sure<br>
&gt; &gt; if there is any advantage to running with uid 1000 when you still=
 have<br>
&gt; &gt; these Linux capabilities.<br>
&gt; &gt;<br>
&gt; &gt; Stefan<br>
&gt; <br>
&gt; When you run in a user namespace, virtiofsd would only have<br>
&gt; setuid/setgid over the range of UIDs mapped into the user namespace.=
=C2=A0 So<br>
&gt; if UID=3D0 on the host is not mapped, then the container can not creat=
e<br>
&gt; real UID=3D0 files on disk.<br>
&gt; <br>
&gt; Similarly you can protect the user directories and any content by<br>
&gt; running the containers in a really high UID Mapping.<br>
<br>
Roman, do user namespaces address your concerns about uid 0 in<br>
containers?<br></blockquote><div><br>They may eventually solve it. I would =
not let us hang up on this right now, since as said at least in kubevirt we=
 can&#39;t get rid right now of root anyway.<br>Even if it is at some point=
 in the future save and supported on bleeding-edge managed k8s clusters to =
allow ordinary users to run with uid 0, from my perspective it is right now=
 common to restrict namespaces with PodSecurityPolicies or SecurityContexts=
 to not allow running pods as root for normal users.</div><div>It is also c=
ommon that a significant part of the community users run docker and/or run =
on managed k8s clusters where they can not influence if user-namespaces are=
 enabled, if they can run pods as root, if the runtime points to a seccomp =
file they like or if the runtime they prefer is used.<br><br>But let me rep=
eat again that we require root right now anyway and that we don&#39;t run t=
he pods right now with the user privileges (but we should and we aim for th=
at). Right now PSPs and SCCs restrict access to these pods by the users.</d=
iv><div>So for our use case, at this exact moment root is acceptable, the u=
nshare call is a little bit more problematic.<br></div><div><br>Best Regard=
s,</div><div>Roman</div><div><br>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<br>
Stefan<br>
</blockquote></div></div>

--0000000000005880c605abb8bb38--


