Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D39C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6151D2078D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="bofkyeia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6151D2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiaUo-0002Gx-LB
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 05:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <basil@daynix.com>) id 1jiaTo-00019w-R6
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 05:23:36 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44858)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <basil@daynix.com>) id 1jiaTn-0000mz-Ib
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 05:23:36 -0400
Received: by mail-wr1-x443.google.com with SMTP id y17so20425536wrn.11
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 02:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bE6XsbX8hhovSUi1c3IvBpxU7U+SFfrfRdbEbDnlQis=;
 b=bofkyeia4zBTQABvEmOYxGaENuZnLROo2qLGWdUPrxJIgGaBaZAxFyAT2BYACYanOl
 OwOkL8RJcrlAEcsXfUqKJo1j1J6RcFfmnBWsz0sL/EydyXYG0jwTr/j7yVvn2K55jja1
 EP0GRgjqaEi0uF9+7XdbkopWfJ02pPCjSkSbCsK+NhhhuV0SM2wlnc0/Jcog2vn/46+v
 x8pjh748N34/RxO3hBFSeiLNU6RNKfBqvQCY55YsvZaPcLf2wwF625kAUox+etcLn2ls
 fxIAxO1F3joMvhrckVUTX/aETkuLv/+bkNZeyTHLxYa4POLzrNaoL+g2rFp8GZLisoTl
 O3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bE6XsbX8hhovSUi1c3IvBpxU7U+SFfrfRdbEbDnlQis=;
 b=JhGyAtkQw8OggBqYbjciLu3mwbCo4T7uBiozq5TA1YUpNWrGetP2GRJrxHqXoktRUY
 SDuP3lRJBijuKttYu1uxdetWnX/nmZ7nYblCczMvt+6MOQ52odFk1PR/Jb60ELXnAHVm
 QRs630H3MGjddze47/NU0+TM3qxyQo/Q2kA3wFXTEBxKJQblifkPid58B8/pxOmV2d50
 UyLlkVJSEyjBtEBWtgNYB9afjFZviyw7QAr0l8vSyIY1d5Emj7Fhq9xdFMQMKDrldLwQ
 QDPs7kLgvePDFIlh7EweMYo5c+V3zA4q9lTkTfWAqe5/2Wmx7QYu65ceCZ+STSWqdTsD
 1pgQ==
X-Gm-Message-State: AOAM533R2hdx/zHgZTUAy+jEXQguST+KP/jnnIRY3xqeb30CNi9ZOkgp
 fauUa97HnPq9kZEc5pdghpS17k19G4qYiBxDPqtiYM+C
X-Google-Smtp-Source: ABdhPJzSGaajvXIrdeTLP/Y813OzQlNRnC6K5Pi1AvCSiWLU81a5DZVGlPL1wTgdj1DaiVQSHY8mPrnTdW870hDedMo=
X-Received: by 2002:adf:f54c:: with SMTP id j12mr3257220wrp.369.1591694612518; 
 Tue, 09 Jun 2020 02:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <1588248700-2715-1-git-send-email-basil@daynix.com>
In-Reply-To: <1588248700-2715-1-git-send-email-basil@daynix.com>
From: Basil Salman <basil@daynix.com>
Date: Tue, 9 Jun 2020 12:23:17 +0300
Message-ID: <CAMpN4hg+3BKY-oh-tSj4TnB7hqZzy7dTpsFP3rxjs90yM-zmaw@mail.gmail.com>
Subject: Re: [PATCH 1/1] qga-win: fix "guest-get-fsinfo" wrong filesystem type
To: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary="000000000000f872eb05a7a34774"
Received-SPF: none client-ip=2a00:1450:4864:20::443;
 envelope-from=basil@daynix.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Yan Vugenfirer <yan@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f872eb05a7a34774
Content-Type: text/plain; charset="UTF-8"

Ping

On Thu, Apr 30, 2020 at 3:11 PM Basil Salman <basil@daynix.com> wrote:

> From: Basil Salman <bsalman@redhat.com>
>
> This patch handles the case where unmounted volumes exist,
> where in that case GetVolumePathNamesForVolumeName returns
> empty path, GetVolumeInformation will use the current working
> directory instead.
> This patch fixes the issue by opening a handle to the volumes,
> and using GetVolumeInformationByHandleW instead.
>
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1746667
>
> Signed-off-by: Basil Salman <bsalman@redhat.com>
> Signed-off-by: Basil Salman <basil@daynix.com>
> ---
>  qga/commands-win32.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 82cf053..be07712 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -1021,11 +1021,13 @@ static GuestFilesystemInfo
> *build_guest_fsinfo(char *guid, Error **errp)
>  {
>      DWORD info_size;
>      char mnt, *mnt_point;
> +    wchar_t wfs_name[32];
>      char fs_name[32];
> -    char vol_info[MAX_PATH+1];
> +    wchar_t vol_info[MAX_PATH + 1];
>      size_t len;
>      uint64_t i64FreeBytesToCaller, i64TotalBytes, i64FreeBytes;
>      GuestFilesystemInfo *fs = NULL;
> +    HANDLE hLocalDiskHandle = NULL;
>
>      GetVolumePathNamesForVolumeName(guid, (LPCH)&mnt, 0, &info_size);
>      if (GetLastError() != ERROR_MORE_DATA) {
> @@ -1040,18 +1042,27 @@ static GuestFilesystemInfo
> *build_guest_fsinfo(char *guid, Error **errp)
>          goto free;
>      }
>
> +    hLocalDiskHandle = CreateFile(guid, 0 , 0, NULL, OPEN_EXISTING,
> +                                  FILE_ATTRIBUTE_NORMAL |
> +                                  FILE_FLAG_BACKUP_SEMANTICS, NULL);
> +    if (INVALID_HANDLE_VALUE == hLocalDiskHandle) {
> +        error_setg_win32(errp, GetLastError(), "failed to get volume
> name");
> +        goto free;
> +    }
> +
>      len = strlen(mnt_point);
>      mnt_point[len] = '\\';
>      mnt_point[len+1] = 0;
> -    if (!GetVolumeInformation(mnt_point, vol_info, sizeof(vol_info),
> NULL, NULL,
> -                              NULL, (LPSTR)&fs_name, sizeof(fs_name))) {
> +
> +    if (!GetVolumeInformationByHandleW(hLocalDiskHandle, vol_info,
> +                                       sizeof(vol_info), NULL, NULL, NULL,
> +                                       (LPWSTR) & wfs_name,
> sizeof(wfs_name))) {
>          if (GetLastError() != ERROR_NOT_READY) {
>              error_setg_win32(errp, GetLastError(), "failed to get volume
> info");
>          }
>          goto free;
>      }
>
> -    fs_name[sizeof(fs_name) - 1] = 0;
>      fs = g_malloc(sizeof(*fs));
>      fs->name = g_strdup(guid);
>      fs->has_total_bytes = false;
> @@ -1070,9 +1081,11 @@ static GuestFilesystemInfo *build_guest_fsinfo(char
> *guid, Error **errp)
>              fs->has_used_bytes = true;
>          }
>      }
> +    wcstombs(fs_name, wfs_name, sizeof(wfs_name));
>      fs->type = g_strdup(fs_name);
>      fs->disk = build_guest_disk_info(guid, errp);
>  free:
> +    CloseHandle(hLocalDiskHandle);
>      g_free(mnt_point);
>      return fs;
>  }
> --
> 1.8.3.1
>
>

--000000000000f872eb05a7a34774
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ping</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Apr 30, 2020 at 3:11 PM Basil Salman &lt;<a hr=
ef=3D"mailto:basil@daynix.com">basil@daynix.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">From: Basil Salman &lt;<a hr=
ef=3D"mailto:bsalman@redhat.com" target=3D"_blank">bsalman@redhat.com</a>&g=
t;<br>
<br>
This patch handles the case where unmounted volumes exist,<br>
where in that case GetVolumePathNamesForVolumeName returns<br>
empty path, GetVolumeInformation will use the current working<br>
directory instead.<br>
This patch fixes the issue by opening a handle to the volumes,<br>
and using GetVolumeInformationByHandleW instead.<br>
<br>
Buglink: <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1746667" =
rel=3D"noreferrer" target=3D"_blank">https://bugzilla.redhat.com/show_bug.c=
gi?id=3D1746667</a><br>
<br>
Signed-off-by: Basil Salman &lt;<a href=3D"mailto:bsalman@redhat.com" targe=
t=3D"_blank">bsalman@redhat.com</a>&gt;<br>
Signed-off-by: Basil Salman &lt;<a href=3D"mailto:basil@daynix.com" target=
=3D"_blank">basil@daynix.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-win32.c | 21 +++++++++++++++++----<br>
=C2=A01 file changed, 17 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index 82cf053..be07712 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -1021,11 +1021,13 @@ static GuestFilesystemInfo *build_guest_fsinfo(char=
 *guid, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DWORD info_size;<br>
=C2=A0 =C2=A0 =C2=A0char mnt, *mnt_point;<br>
+=C2=A0 =C2=A0 wchar_t wfs_name[32];<br>
=C2=A0 =C2=A0 =C2=A0char fs_name[32];<br>
-=C2=A0 =C2=A0 char vol_info[MAX_PATH+1];<br>
+=C2=A0 =C2=A0 wchar_t vol_info[MAX_PATH + 1];<br>
=C2=A0 =C2=A0 =C2=A0size_t len;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t i64FreeBytesToCaller, i64TotalBytes, i64FreeBy=
tes;<br>
=C2=A0 =C2=A0 =C2=A0GuestFilesystemInfo *fs =3D NULL;<br>
+=C2=A0 =C2=A0 HANDLE hLocalDiskHandle =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0GetVolumePathNamesForVolumeName(guid, (LPCH)&amp;mnt, 0=
, &amp;info_size);<br>
=C2=A0 =C2=A0 =C2=A0if (GetLastError() !=3D ERROR_MORE_DATA) {<br>
@@ -1040,18 +1042,27 @@ static GuestFilesystemInfo *build_guest_fsinfo(char=
 *guid, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto free;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 hLocalDiskHandle =3D CreateFile(guid, 0 , 0, NULL, OPEN_EXIS=
TING,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE_ATTRIBUTE_NORMAL |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE_FLAG_BACKUP_SEMANTICS, N=
ULL);<br>
+=C2=A0 =C2=A0 if (INVALID_HANDLE_VALUE =3D=3D hLocalDiskHandle) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(), &quot;f=
ailed to get volume name&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto free;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0len =3D strlen(mnt_point);<br>
=C2=A0 =C2=A0 =C2=A0mnt_point[len] =3D &#39;\\&#39;;<br>
=C2=A0 =C2=A0 =C2=A0mnt_point[len+1] =3D 0;<br>
-=C2=A0 =C2=A0 if (!GetVolumeInformation(mnt_point, vol_info, sizeof(vol_in=
fo), NULL, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, (LPSTR)&amp;fs_name, sizeof(fs_name))=
) {<br>
+<br>
+=C2=A0 =C2=A0 if (!GetVolumeInformationByHandleW(hLocalDiskHandle, vol_inf=
o,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(vo=
l_info), NULL, NULL, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(LPWSTR) =
&amp; wfs_name, sizeof(wfs_name))) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (GetLastError() !=3D ERROR_NOT_READY) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg_win32(errp, GetL=
astError(), &quot;failed to get volume info&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto free;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 fs_name[sizeof(fs_name) - 1] =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0fs =3D g_malloc(sizeof(*fs));<br>
=C2=A0 =C2=A0 =C2=A0fs-&gt;name =3D g_strdup(guid);<br>
=C2=A0 =C2=A0 =C2=A0fs-&gt;has_total_bytes =3D false;<br>
@@ -1070,9 +1081,11 @@ static GuestFilesystemInfo *build_guest_fsinfo(char =
*guid, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fs-&gt;has_used_bytes =3D t=
rue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 wcstombs(fs_name, wfs_name, sizeof(wfs_name));<br>
=C2=A0 =C2=A0 =C2=A0fs-&gt;type =3D g_strdup(fs_name);<br>
=C2=A0 =C2=A0 =C2=A0fs-&gt;disk =3D build_guest_disk_info(guid, errp);<br>
=C2=A0free:<br>
+=C2=A0 =C2=A0 CloseHandle(hLocalDiskHandle);<br>
=C2=A0 =C2=A0 =C2=A0g_free(mnt_point);<br>
=C2=A0 =C2=A0 =C2=A0return fs;<br>
=C2=A0}<br>
-- <br>
1.8.3.1<br>
<br>
</blockquote></div>

--000000000000f872eb05a7a34774--

