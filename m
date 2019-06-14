Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDA5C31E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 07:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB9FA21473
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 07:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9FA21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49094 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbgtA-0003GU-89
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 03:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43484)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ndevos@redhat.com>) id 1hbgsO-0002ki-6H
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 03:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ndevos@redhat.com>) id 1hbgsN-0002UZ-6f
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 03:43:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54924)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ndevos@redhat.com>)
 id 1hbgsK-00021s-Sl; Fri, 14 Jun 2019 03:43:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DA86C308FBA9;
 Fri, 14 Jun 2019 07:43:19 +0000 (UTC)
Received: from localhost (ovpn-117-41.ams2.redhat.com [10.36.117.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E02C666D3B;
 Fri, 14 Jun 2019 07:43:12 +0000 (UTC)
Date: Fri, 14 Jun 2019 09:43:10 +0200
From: Niels de Vos <ndevos@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190614074310.GA1188@ndevos-x270>
References: <20190614072432.820-1-philmd@redhat.com>
 <20190614072432.820-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190614072432.820-2-philmd@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 14 Jun 2019 07:43:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/6] configure: Only generate GLUSTERFS
 variables if glusterfs is usable
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 integration@gluster.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, =?iso-8859-1?Q?Lo=EFc?= Minier <loic.minier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Bharata B Rao <bharata@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 14, 2019 at 09:24:27AM +0200, Philippe Mathieu-Daud=E9 wrote:
> It is pointless and confusing to have GLUSTERFS variables
> in config-host.mak when glusterfs is not usable.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Looks good to me, thanks.

Reviewed-by: Niels de Vos <ndevos@redhat.com>

> ---
>  configure | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>=20
> diff --git a/configure b/configure
> index b091b82cb3..13fd4a1166 100755
> --- a/configure
> +++ b/configure
> @@ -7118,30 +7118,30 @@ if test "$glusterfs" =3D "yes" ; then
>    echo "CONFIG_GLUSTERFS=3Dm" >> $config_host_mak
>    echo "GLUSTERFS_CFLAGS=3D$glusterfs_cflags" >> $config_host_mak
>    echo "GLUSTERFS_LIBS=3D$glusterfs_libs" >> $config_host_mak
> -fi
> =20
> -if test "$glusterfs_xlator_opt" =3D "yes" ; then
> -  echo "CONFIG_GLUSTERFS_XLATOR_OPT=3Dy" >> $config_host_mak
> -fi
> +  if test "$glusterfs_xlator_opt" =3D "yes" ; then
> +    echo "CONFIG_GLUSTERFS_XLATOR_OPT=3Dy" >> $config_host_mak
> +  fi
> =20
> -if test "$glusterfs_discard" =3D "yes" ; then
> -  echo "CONFIG_GLUSTERFS_DISCARD=3Dy" >> $config_host_mak
> -fi
> +  if test "$glusterfs_discard" =3D "yes" ; then
> +    echo "CONFIG_GLUSTERFS_DISCARD=3Dy" >> $config_host_mak
> +  fi
> =20
> -if test "$glusterfs_fallocate" =3D "yes" ; then
> -  echo "CONFIG_GLUSTERFS_FALLOCATE=3Dy" >> $config_host_mak
> -fi
> +  if test "$glusterfs_fallocate" =3D "yes" ; then
> +    echo "CONFIG_GLUSTERFS_FALLOCATE=3Dy" >> $config_host_mak
> +  fi
> =20
> -if test "$glusterfs_zerofill" =3D "yes" ; then
> -  echo "CONFIG_GLUSTERFS_ZEROFILL=3Dy" >> $config_host_mak
> -fi
> +  if test "$glusterfs_zerofill" =3D "yes" ; then
> +    echo "CONFIG_GLUSTERFS_ZEROFILL=3Dy" >> $config_host_mak
> +  fi
> =20
> -if test "$glusterfs_ftruncate_has_stat" =3D "yes" ; then
> -  echo "CONFIG_GLUSTERFS_FTRUNCATE_HAS_STAT=3Dy" >> $config_host_mak
> -fi
> +  if test "$glusterfs_ftruncate_has_stat" =3D "yes" ; then
> +    echo "CONFIG_GLUSTERFS_FTRUNCATE_HAS_STAT=3Dy" >> $config_host_mak
> +  fi
> =20
> -if test "$glusterfs_iocb_has_stat" =3D "yes" ; then
> -  echo "CONFIG_GLUSTERFS_IOCB_HAS_STAT=3Dy" >> $config_host_mak
> +  if test "$glusterfs_iocb_has_stat" =3D "yes" ; then
> +    echo "CONFIG_GLUSTERFS_IOCB_HAS_STAT=3Dy" >> $config_host_mak
> +  fi
>  fi
> =20
>  if test "$libssh2" =3D "yes" ; then
> --=20
> 2.20.1
>=20

