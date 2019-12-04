Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C20C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:58:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FDCE20833
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAeosMCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDCE20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icW6n-0005DL-1M
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 09:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1icW5q-0004j3-Ky
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:57:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1icW5p-0001xu-Hn
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:57:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51677
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1icW5p-0001tx-E9
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575471447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mtjOLLxqnus2yVUjhuie5+4HlDENsrCgZj76bycgtcM=;
 b=FAeosMCLd9kNrfby1YLqTn/+BvZvHW2NhU2vei55hVVvIzIbVCFJjsqUTa8tkSm+DI2OTA
 JrX1u6p3LCyOSBUX4oCeAbdNQIbPJqKuP+78vXtePgGB7VFhr+7wfvioUaymW8/vJWVxmZ
 AG+ZThu3SKreicQ0nUzPlsQFEpSikxM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-sGD526SoOGSVg_A5AqpGwA-1; Wed, 04 Dec 2019 09:57:26 -0500
Received: by mail-wr1-f72.google.com with SMTP id f17so3740879wrt.19
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 06:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IKd1j5nx0qht9JJskTFE03g1Ft1XF9eMK0orYIgve5w=;
 b=UWcsHP1xbBPFnMpugRg1rhG42db7ibC6F2ZDoTTg06wsZfRjlyH/KVPqE6z9jPgsr2
 ixNRTdvrpsYqsX+NGUHFEx7g9qo0hTzdHedBrpY4hyAmcM0klQO3CEZDDimSmtqAl9dU
 P6P6mpNGxcnH+11a2xpQCWP8++PDWSkdJNwpbW6C8aAXdrCBEi31azs5BonFQ1uota8h
 UshhEKILQt23paYGGvtPF6wgTz3mX1Qm6g5SiW3225qx9BQ6aonEOWLtqErLywM4IhQd
 1wZq+Yqgoqt9iNnHEcpss+DNlAIoecPop+iIuVIze32z7oYuedg2TZ8xVDznwN1UaC52
 LeNQ==
X-Gm-Message-State: APjAAAUk+HIGAOErFvfMVU/VOz//1nNFUIPQAKfmBkwP93ZrH2sg358L
 IgMBHdc4I0B5FBCDOH/vHtlGfvGHLxBNpMDXqcPJgVPHGcdrmrOwlu+LWPLdbaurRWhkRArVoHb
 cMCta+nggzf2DZ20=
X-Received: by 2002:adf:f5cf:: with SMTP id k15mr4666715wrp.182.1575471445223; 
 Wed, 04 Dec 2019 06:57:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqz9/WOo523+JxIIQUFeOok9DUHid3A0dffrnHUH0TcfnK1cAAH6t9MJVMnCUZLCzTaYeI8x6A==
X-Received: by 2002:adf:f5cf:: with SMTP id k15mr4666704wrp.182.1575471445066; 
 Wed, 04 Dec 2019 06:57:25 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id n8sm8403990wrx.42.2019.12.04.06.57.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2019 06:57:24 -0800 (PST)
Subject: Re: [PATCH v2 09/18] qga: Fix guest-get-fsinfo error API violations
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20191204093625.14836-1-armbru@redhat.com>
 <20191204093625.14836-10-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cd70098b-539e-f3bb-219a-8545bb3de11d@redhat.com>
Date: Wed, 4 Dec 2019 15:57:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191204093625.14836-10-armbru@redhat.com>
Content-Language: en-US
X-MC-Unique: sGD526SoOGSVg_A5AqpGwA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/4/19 10:36 AM, Markus Armbruster wrote:
> build_guest_fsinfo_for_virtual_device() dereferences @errp when
> build_guest_fsinfo_for_device() fails.  That's wrong; see the big
> comment in error.h.  Introduced in commit 46d4c5723e "qga: Add
> guest-get-fsinfo command".
>=20
> No caller actually passes null.
>=20
> Fix anyway: splice in a local Error *err, and error_propagate().
>=20
> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qga/commands-posix.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 1c1a165dae..0be527ccb8 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1049,6 +1049,7 @@ static void build_guest_fsinfo_for_virtual_device(c=
har const *syspath,
>                                                     GuestFilesystemInfo *=
fs,
>                                                     Error **errp)
>   {
> +    Error *err =3D NULL;
>       DIR *dir;
>       char *dirpath;
>       struct dirent *entry;
> @@ -1078,10 +1079,11 @@ static void build_guest_fsinfo_for_virtual_device=
(char const *syspath,
>  =20
>               g_debug(" slave device '%s'", entry->d_name);
>               path =3D g_strdup_printf("%s/slaves/%s", syspath, entry->d_=
name);
> -            build_guest_fsinfo_for_device(path, fs, errp);
> +            build_guest_fsinfo_for_device(path, fs, &err);
>               g_free(path);
>  =20
> -            if (*errp) {
> +            if (err) {
> +                error_propagate(errp, err);
>                   break;
>               }
>           }
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


