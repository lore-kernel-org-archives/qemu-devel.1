Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF38C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:35:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60712206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+eR4ar7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60712206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Pln-0000iJ-Jo
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 09:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rmohr@redhat.com>) id 1k0MVq-0003U4-4J
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:07:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43290
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <rmohr@redhat.com>) id 1k0MVo-0006bI-6Q
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595930827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZXtTZPYGL+ZKCi8Z0tLZ6BdzWB9NWw0lgNcWs3Gv3dI=;
 b=f+eR4ar7BPQtvGtBVvjbr5p06mgCGaAQftrIL829oPA2cysukfg5FqljTUjrlGmlljwIvI
 peGNT4SwXVmNLiZnz3L/qgz9WsOc+sw4cUaol5yNZARHxVAZ6KBsFU3a0Fcy8ruW8sIj8F
 6u9uTSrBQ6xIM+KMWCtpJf8hl0K2nQ8=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-CROIG4NkPAW_PqK6K4XZ0w-1; Tue, 28 Jul 2020 06:00:33 -0400
X-MC-Unique: CROIG4NkPAW_PqK6K4XZ0w-1
Received: by mail-oo1-f71.google.com with SMTP id v21so6384207ooq.12
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 03:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZXtTZPYGL+ZKCi8Z0tLZ6BdzWB9NWw0lgNcWs3Gv3dI=;
 b=g/FN/VjGLTQrtmja/9CVz4H7iSi5WgHQY8qBBYvmV/NPDzvSx8xcE9eYE9JG2FpkA5
 o/5XzJgTgw7BrN4QXfkmYE3F4urTK3xglZrFm96D3RzYs6OLzX334XjuydpWCtV+GAgJ
 MPnRxfctRKhQh8iaNdPqLri2dPKG64BPXczl+32wkP4qcYlGgTydneLF6pYK44ql8J2S
 Y25fS80+P8mE/VSm7Quj2ewktoUu95XkWvftmBT58uxGA14hJ9byrMLIprez8r3b8Evx
 4RBcePAQWY80CvlUNOe38fPM/fFNEwBfGpg0Ytzlim7kdERvsmA6JOvjqDgQGC5Do69S
 66RQ==
X-Gm-Message-State: AOAM531u8gvh8fn2hNL3wA+/UwjnyBuFyNXZeojKPuhoPS1EH+qjR2el
 EsxfSrSoNvQ5686KtQPgE+OLxaNvPNIt1Cxwwlfe+L2mjvR3CNKeEXPghLlwB1x+9qfRv46qY6z
 CDyPnIC1dIpHCFBG/k+vOXTVSqNdu0sg=
X-Received: by 2002:a9d:6d97:: with SMTP id x23mr24030525otp.171.1595930431324; 
 Tue, 28 Jul 2020 03:00:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7axnV/+QHQr0EPbt/MO8R+JoguBYu59o8iDz5fexs6Jutv0YvS/wdefMQ1R4YQ3eScRB0saNcNLDoq6QsAmg=
X-Received: by 2002:a9d:6d97:: with SMTP id x23mr24030502otp.171.1595930431100; 
 Tue, 28 Jul 2020 03:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200727190223.422280-1-stefanha@redhat.com>
 <20200727190223.422280-4-stefanha@redhat.com>
 <OSBPR01MB45826073E5A54CF869E56721E5730@OSBPR01MB4582.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB45826073E5A54CF869E56721E5730@OSBPR01MB4582.jpnprd01.prod.outlook.com>
From: Roman Mohr <rmohr@redhat.com>
Date: Tue, 28 Jul 2020 12:00:20 +0200
Message-ID: <CALDPj7syG0KPhtZEma5n403=YFZ2ptcD4MtP=GdrY9n1eUs5Eg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print an
 error
To: "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000006eab2505ab7d8245"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=rmohr@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 06:05:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 28 Jul 2020 09:35:03 -0400
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
 Stefan Hajnoczi <stefanha@redhat.com>, "mpatel@redhat.com" <mpatel@redhat.com>,
 "vgoyal@redhat.com" <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006eab2505ab7d8245
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 28, 2020 at 3:07 AM misono.tomohiro@fujitsu.com <
misono.tomohiro@fujitsu.com> wrote:

> > Subject: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print an
> error
> >
> > An assertion failure is raised during request processing if
> > unshare(CLONE_FS) fails. Implement a probe at startup so the problem can
> > be detected right away.
> >
> > Unfortunately Docker/Moby does not include unshare in the seccomp.json
> > list unless CAP_SYS_ADMIN is given. Other seccomp.json lists always
> > include unshare (e.g. podman is unaffected):
> >
> https://raw.githubusercontent.com/seccomp/containers-golang/master/seccomp.json
> >
> > Use "docker run --security-opt seccomp=path/to/seccomp.json ..." if the
> > default seccomp.json is missing unshare.
>
> Hi, sorry for a bit late.
>
> unshare() was added to fix xattr problem:
>
> https://github.com/qemu/qemu/commit/bdfd66788349acc43cd3f1298718ad491663cfcc#
> In theory we don't need to call unshare if xattr is disabled, but it is
> hard to get to know
> if xattr is enabled or disabled in fv_queue_worker(), right?
>
>
In kubevirt we want to run virtiofsd in containers. We would already not
have xattr support for e.g. overlayfs in the VM after this patch series (an
acceptable con at least for us right now).
If we can get rid of the unshare (and potentially of needing root) that
would be great. We always assume that everything which we run in containers
should work for cri-o and docker.

"Just" pointing docker to a different seccomp.json file is something which
k8s users/admin in many cases can't do.

Best Regards,
Roman


> So, it looks good to me.
> Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
>
> Regards,
> Misono
>
> >
> > Cc: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  tools/virtiofsd/fuse_virtio.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/tools/virtiofsd/fuse_virtio.c
> b/tools/virtiofsd/fuse_virtio.c
> > index 3b6d16a041..9e5537506c 100644
> > --- a/tools/virtiofsd/fuse_virtio.c
> > +++ b/tools/virtiofsd/fuse_virtio.c
> > @@ -949,6 +949,22 @@ int virtio_session_mount(struct fuse_session *se)
> >  {
> >      int ret;
> >
> > +    /*
> > +     * Test that unshare(CLONE_FS) works. fv_queue_worker() will need
> it. It's
> > +     * an unprivileged system call but some Docker/Moby versions are
> known to
> > +     * reject it via seccomp when CAP_SYS_ADMIN is not given.
> > +     *
> > +     * Note that the program is single-threaded here so this syscall
> has no
> > +     * visible effect and is safe to make.
> > +     */
> > +    ret = unshare(CLONE_FS);
> > +    if (ret == -1 && errno == EPERM) {
> > +        fuse_log(FUSE_LOG_ERR, "unshare(CLONE_FS) failed with EPERM. If
> "
> > +                "running in a container please check that the container
> "
> > +                "runtime seccomp policy allows unshare.\n");
> > +        return -1;
> > +    }
> > +
> >      ret = fv_create_listen_socket(se);
> >      if (ret < 0) {
> >          return ret;
> > --
> > 2.26.2
>
>

--0000000000006eab2505ab7d8245
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 28, 2020 at 3:07 AM <a hr=
ef=3D"mailto:misono.tomohiro@fujitsu.com">misono.tomohiro@fujitsu.com</a> &=
lt;<a href=3D"mailto:misono.tomohiro@fujitsu.com">misono.tomohiro@fujitsu.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">&gt; Subject: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print=
 an error<br>
&gt; <br>
&gt; An assertion failure is raised during request processing if<br>
&gt; unshare(CLONE_FS) fails. Implement a probe at startup so the problem c=
an<br>
&gt; be detected right away.<br>
&gt; <br>
&gt; Unfortunately Docker/Moby does not include unshare in the seccomp.json=
<br>
&gt; list unless CAP_SYS_ADMIN is given. Other seccomp.json lists always<br=
>
&gt; include unshare (e.g. podman is unaffected):<br>
&gt; <a href=3D"https://raw.githubusercontent.com/seccomp/containers-golang=
/master/seccomp.json" rel=3D"noreferrer" target=3D"_blank">https://raw.gith=
ubusercontent.com/seccomp/containers-golang/master/seccomp.json</a><br>
&gt; <br>
&gt; Use &quot;docker run --security-opt seccomp=3Dpath/to/seccomp.json ...=
&quot; if the<br>
&gt; default seccomp.json is missing unshare.<br>
<br>
Hi, sorry for a bit late.<br>
<br>
unshare() was added to fix xattr problem: <br>
=C2=A0 <a href=3D"https://github.com/qemu/qemu/commit/bdfd66788349acc43cd3f=
1298718ad491663cfcc#" rel=3D"noreferrer" target=3D"_blank">https://github.c=
om/qemu/qemu/commit/bdfd66788349acc43cd3f1298718ad491663cfcc#</a><br>
In theory we don&#39;t need to call unshare if xattr is disabled, but it is=
 hard to get to know<br>
if xattr is enabled or disabled in fv_queue_worker(), right?<br>
<br></blockquote><div><br>In kubevirt we want to run virtiofsd in container=
s. We would already not have xattr support for e.g. overlayfs in the VM aft=
er this patch series (an acceptable con at least for us right now).<br>If w=
e can get rid of the unshare (and potentially of needing root) that would b=
e great. We always assume that everything which we run in containers should=
 work for cri-o and docker.<br><br></div><div>&quot;Just&quot; pointing doc=
ker to a different seccomp.json file is something which k8s users/admin in =
many cases can&#39;t do.</div><div><br></div><div>Best Regards,<br>Roman<br=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
So, it looks good to me.<br>
Reviewed-by: Misono Tomohiro &lt;<a href=3D"mailto:misono.tomohiro@jp.fujit=
su.com" target=3D"_blank">misono.tomohiro@jp.fujitsu.com</a>&gt;<br>
<br>
Regards,<br>
Misono<br>
<br>
&gt; <br>
&gt; Cc: Misono Tomohiro &lt;<a href=3D"mailto:misono.tomohiro@jp.fujitsu.c=
om" target=3D"_blank">misono.tomohiro@jp.fujitsu.com</a>&gt;<br>
&gt; Signed-off-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.c=
om" target=3D"_blank">stefanha@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tools/virtiofsd/fuse_virtio.c | 16 ++++++++++++++++<br>
&gt;=C2=A0 1 file changed, 16 insertions(+)<br>
&gt; <br>
&gt; diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virt=
io.c<br>
&gt; index 3b6d16a041..9e5537506c 100644<br>
&gt; --- a/tools/virtiofsd/fuse_virtio.c<br>
&gt; +++ b/tools/virtiofsd/fuse_virtio.c<br>
&gt; @@ -949,6 +949,22 @@ int virtio_session_mount(struct fuse_session *se)=
<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; <br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Test that unshare(CLONE_FS) works. fv_queue_wor=
ker() will need it. It&#39;s<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* an unprivileged system call but some Docker/Mob=
y versions are known to<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* reject it via seccomp when CAP_SYS_ADMIN is not=
 given.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Note that the program is single-threaded here s=
o this syscall has no<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* visible effect and is safe to make.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 ret =3D unshare(CLONE_FS);<br>
&gt; +=C2=A0 =C2=A0 if (ret =3D=3D -1 &amp;&amp; errno =3D=3D EPERM) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fuse_log(FUSE_LOG_ERR, &quot;unshare(CLON=
E_FS) failed with EPERM. If &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;running=
 in a container please check that the container &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;runtime=
 seccomp policy allows unshare.\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ret =3D fv_create_listen_socket(se);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; --<br>
&gt; 2.26.2<br>
<br>
</blockquote></div></div>

--0000000000006eab2505ab7d8245--


