Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE9FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 18:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A412065F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 18:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtmpSZWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A412065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvltk-0001Av-98
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 14:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jvlt7-0000l0-NO
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 14:12:13 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jvlt6-0008OU-2I
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 14:12:13 -0400
Received: by mail-wm1-x344.google.com with SMTP id c80so6545516wme.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 11:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ePbhznCji/n73rbmHIxRwJa7umXFcCK8iUXNep3QdYw=;
 b=UtmpSZWFlB8vCQUD0bJ19xGiAQjtzQ/GbKAOGZj3ucFb7iM9Hg3xCDHHKoo1FHR6+a
 LBchrZgWr4x1lKCctsVrGZ0hVeLF4ESGitidiaCXQX7YdGQQUufPGEUNBW+YsKSTjCis
 NpqPCtnU56hn8/QLtBtbXXVKbdLDVueLYWA/yqUO5VlSwTVM411wrXIY57SoTy+0Vs3z
 2/iAVwaqYFBEqx0QVJcFEI8puWO/JuJ7vrvBumfN6iFU5KnwqR3SLnohJooLPVb4+URD
 EMcjVRBfDR8b/zNahhEHTau14cCVmAiJcz/KIlZKUvElMAE2AkRECx7d1kRHArBsGiaF
 ZFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ePbhznCji/n73rbmHIxRwJa7umXFcCK8iUXNep3QdYw=;
 b=WRprSZzd6RxOrVDSK6FmB5Om8oGFv51Ult02/GJTu+am22mTgenPWd2JDGlskiouOy
 wmd/L1eF5Zb1em9O2qWkiEVhLMJjUD9OYBWHGC/vlUYy7tlDMglvhd1U0CLiC7UqqLSx
 7FArtSx/y8TgcyxD9H6xtcbzvK2gPSyi76WsoOvhfA6QmPwz6P0bIoM04WHzGrEM84T1
 XnB0bI8zsfmoxIjW6PBXZCoklI9sVEPIUb4JtEYgP+8cVO4YvX1SaPOJMeFe7ZTn47G1
 Ct1oFCFLgsxbcTK8Z3M2jJzjFRRudKgL1MUVWJeirQwT4iVUtXkcG7zJEr0EQNMpM8nP
 EOQw==
X-Gm-Message-State: AOAM5323t5Y3dU9V1bX+FqecOLe8g1RmWDhlJGgyZYULCQTVa/HlUje5
 ikUkEBJnbUkUqfXNxgKSrMILg7aaoXUg2+HP7qk8xObbwGg=
X-Google-Smtp-Source: ABdhPJylegJeI9wjioOJMhSSi2XIaiX2g1Tz3W7x0kXcxDagwGgpOQqMlEbGfwRHk59mK0NHx8YzvLGQXDQItSLOGE8=
X-Received: by 2002:a1c:b608:: with SMTP id g8mr628135wmf.55.1594836728608;
 Wed, 15 Jul 2020 11:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200713083250.2955536-1-marcandre.lureau@redhat.com>
In-Reply-To: <20200713083250.2955536-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 15 Jul 2020 22:11:55 +0400
Message-ID: <CAJ+F1C+6fjXvfPYECjc0YniJM5xwYjU7T26OgFDFSAatLL85AQ@mail.gmail.com>
Subject: Re: [PATCH] slirp: update to v4.3.1
To: QEMU <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000af005a05aa7edcb4"
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000af005a05aa7edcb4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi


On Mon, Jul 13, 2020 at 12:33 PM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> Switch from stable-4.2 branch back to master (which is actually
> maintained, I think we tend to forget about stable...).
>

ping

Peter, should I send a pull request directly?

(I feel like it should be part of rc0, since it has a few new
functionality/API...)


>
> git shortlog 2faae0f7..a62d3673:
>
> 5eraph (2):
>       disable_dns option
>       limit vnameserver_addr to port 53
>
> Akihiro Suda (1):
>       libslirp.h: fix SlirpConfig v3 documentation
>
> Jindrich Novy (4):
>       Fix possible infinite loops and use-after-free
>       Use secure string copy to avoid overflow
>       Be sure to initialize sockaddr structure
>       Check lseek() for failure
>
> Marc-Andr=C3=A9 Lureau (12):
>       Merge branch 'master' into 'master'
>       Merge branch 'fix-slirpconfig-3-doc' into 'master'
>       Fix use-afte-free in ip_reass() (CVE-2020-1983)
>       Update CHANGELOG
>       Merge branch 'cve-2020-1983' into 'master'
>       Release v4.3.0
>       Merge branch 'release-v4.3.0' into 'master'
>       changelog: post-release
>       util: do not silently truncate
>       Merge branch 'slirp-fmt-truncate' into 'master'
>       Release v4.3.1
>       Merge branch 'release-v4.3.1' into 'master'
>
> Philippe Mathieu-Daud=C3=A9 (3):
>       Fix win32 builds by using the SLIRP_PACKED definition
>       Fix constness warnings
>       Remove unnecessary break
>
> Ralf Haferkamp (2):
>       Drop bogus IPv6 messages
>       Fix MTU check
>
> Samuel Thibault (1):
>       Merge branch 'ip6_payload_len' into 'master'
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  slirp | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/slirp b/slirp
> index 2faae0f778f..a62d36734ff 160000
> --- a/slirp
> +++ b/slirp
> @@ -1 +1 @@
> -Subproject commit 2faae0f778f818fadc873308f983289df697eb93
> +Subproject commit a62d36734ffe9828d0f70df1b3898a3b4fbda755
> --
> 2.27.0.221.ga08a83db2b
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000af005a05aa7edcb4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div><br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Jul 13, 2020 at 12:33 PM Marc-Andr=C3=
=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lur=
eau@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Switch from stable-4.2 branch back to master (which is actual=
ly<br>
maintained, I think we tend to forget about stable...).<br></blockquote><di=
v><br></div><div><div>ping</div><div><br></div><div>Peter, should I send a =
pull request directly?</div><div><br></div><div>(I feel like it should be p=
art of rc0, since it has a few new functionality/API...)</div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
git shortlog 2faae0f7..a62d3673:<br>
<br>
5eraph (2):<br>
=C2=A0 =C2=A0 =C2=A0 disable_dns option<br>
=C2=A0 =C2=A0 =C2=A0 limit vnameserver_addr to port 53<br>
<br>
Akihiro Suda (1):<br>
=C2=A0 =C2=A0 =C2=A0 libslirp.h: fix SlirpConfig v3 documentation<br>
<br>
Jindrich Novy (4):<br>
=C2=A0 =C2=A0 =C2=A0 Fix possible infinite loops and use-after-free<br>
=C2=A0 =C2=A0 =C2=A0 Use secure string copy to avoid overflow<br>
=C2=A0 =C2=A0 =C2=A0 Be sure to initialize sockaddr structure<br>
=C2=A0 =C2=A0 =C2=A0 Check lseek() for failure<br>
<br>
Marc-Andr=C3=A9 Lureau (12):<br>
=C2=A0 =C2=A0 =C2=A0 Merge branch &#39;master&#39; into &#39;master&#39;<br=
>
=C2=A0 =C2=A0 =C2=A0 Merge branch &#39;fix-slirpconfig-3-doc&#39; into &#39=
;master&#39;<br>
=C2=A0 =C2=A0 =C2=A0 Fix use-afte-free in ip_reass() (CVE-2020-1983)<br>
=C2=A0 =C2=A0 =C2=A0 Update CHANGELOG<br>
=C2=A0 =C2=A0 =C2=A0 Merge branch &#39;cve-2020-1983&#39; into &#39;master&=
#39;<br>
=C2=A0 =C2=A0 =C2=A0 Release v4.3.0<br>
=C2=A0 =C2=A0 =C2=A0 Merge branch &#39;release-v4.3.0&#39; into &#39;master=
&#39;<br>
=C2=A0 =C2=A0 =C2=A0 changelog: post-release<br>
=C2=A0 =C2=A0 =C2=A0 util: do not silently truncate<br>
=C2=A0 =C2=A0 =C2=A0 Merge branch &#39;slirp-fmt-truncate&#39; into &#39;ma=
ster&#39;<br>
=C2=A0 =C2=A0 =C2=A0 Release v4.3.1<br>
=C2=A0 =C2=A0 =C2=A0 Merge branch &#39;release-v4.3.1&#39; into &#39;master=
&#39;<br>
<br>
Philippe Mathieu-Daud=C3=A9 (3):<br>
=C2=A0 =C2=A0 =C2=A0 Fix win32 builds by using the SLIRP_PACKED definition<=
br>
=C2=A0 =C2=A0 =C2=A0 Fix constness warnings<br>
=C2=A0 =C2=A0 =C2=A0 Remove unnecessary break<br>
<br>
Ralf Haferkamp (2):<br>
=C2=A0 =C2=A0 =C2=A0 Drop bogus IPv6 messages<br>
=C2=A0 =C2=A0 =C2=A0 Fix MTU check<br>
<br>
Samuel Thibault (1):<br>
=C2=A0 =C2=A0 =C2=A0 Merge branch &#39;ip6_payload_len&#39; into &#39;maste=
r&#39;<br>
<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0slirp | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/slirp b/slirp<br>
index 2faae0f778f..a62d36734ff 160000<br>
--- a/slirp<br>
+++ b/slirp<br>
@@ -1 +1 @@<br>
-Subproject commit 2faae0f778f818fadc873308f983289df697eb93<br>
+Subproject commit a62d36734ffe9828d0f70df1b3898a3b4fbda755<br>
-- <br>
2.27.0.221.ga08a83db2b<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000af005a05aa7edcb4--

