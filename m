Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E52C28D1E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1071206E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1071206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58904 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYqsz-0005XR-QU
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 07:48:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hYqrt-00059k-AB
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hYqrs-0001EP-8m
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:47:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
	id 1hYqrl-0000x6-Dq; Thu, 06 Jun 2019 07:47:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 952EFC04BD44;
	Thu,  6 Jun 2019 11:47:09 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A4F7C691A0;
	Thu,  6 Jun 2019 11:47:03 +0000 (UTC)
Message-ID: <ec83bd8083beaf97053a60425a7730056ce9c272.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>, qemu-devel@nongnu.org
Date: Thu, 06 Jun 2019 14:47:02 +0300
In-Reply-To: <20190603123823.32661-2-mehta.aaru20@gmail.com>
References: <20190603123823.32661-1-mehta.aaru20@gmail.com>
	<20190603123823.32661-2-mehta.aaru20@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Thu, 06 Jun 2019 11:47:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 1/9] configure: permit use
 of io_uring
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-06-03 at 18:08 +0530, Aarushi Mehta wrote:
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  configure | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/configure b/configure
> index 6cdcfb2dc3..cb49ef0fcc 100755
> --- a/configure
> +++ b/configure
> @@ -365,6 +365,7 @@ xen=""
>  xen_ctrl_version=""
>  xen_pci_passthrough=""
>  linux_aio=""
> +linux_io_uring=""
>  cap_ng=""
>  attr=""
>  libattr=""
> @@ -1266,6 +1267,10 @@ for opt do
>    ;;
>    --enable-linux-aio) linux_aio="yes"
>    ;;
> +  --disable-linux-io-uring) linux_io_uring="no"
> +  ;;
> +  --enable-linux-io-uring) linux_io_uring="yes"
> +  ;;
>    --disable-attr) attr="no"
>    ;;
>    --enable-attr) attr="yes"
> @@ -1784,6 +1789,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>    vde             support for vde network
>    netmap          support for netmap network
>    linux-aio       Linux AIO support
> +  linux-io-uring  Linux io_uring support
>    cap-ng          libcap-ng support
>    attr            attr and xattr support
>    vhost-net       vhost-net kernel acceleration support
> @@ -3973,6 +3979,21 @@ EOF
>      linux_aio=no
>    fi
>  fi
> +##########################################
> +# linux-io-uring probe
> +
> +if test "$linux_io_uring" != "no" ; then
> +  if $pkg_config liburing; then
> +    linux_io_uring_cflags=$($pkg_config --cflags liburing)
> +    linux_io_uring_libs=$($pkg_config --libs liburing)
> +    linux_io_uring=yes
> +  else
> +    if test "$linux_io_uring" = "yes" ; then
> +      feature_not_found "linux io_uring" "Install liburing devel"
> +    fi
> +    linux_io_uring=no
> +  fi
> +fi
>  
>  ##########################################
>  # TPM emulation is only on POSIX
> @@ -6396,6 +6417,7 @@ echo "PIE               $pie"
>  echo "vde support       $vde"
>  echo "netmap support    $netmap"
>  echo "Linux AIO support $linux_aio"
> +echo "Linux io_uring support $linux_io_uring"
>  echo "ATTR/XATTR support $attr"
>  echo "Install blobs     $blobs"
>  echo "KVM support       $kvm"
> @@ -6876,6 +6898,11 @@ fi
>  if test "$linux_aio" = "yes" ; then
>    echo "CONFIG_LINUX_AIO=y" >> $config_host_mak
>  fi
> +if test "$linux_io_uring" = "yes" ; then
> +  echo "CONFIG_LINUX_IO_URING=y" >> $config_host_mak
> +  echo "LINUX_IO_URING_CFLAGS=$linux_io_uring_cflags" >> $config_host_mak
> +  echo "LINUX_IO_URING_LIBS=$linux_io_uring_libs" >> $config_host_mak
> +fi
>  if test "$attr" = "yes" ; then
>    echo "CONFIG_ATTR=y" >> $config_host_mak
>  fi



Reviewed-by: Maxim Levitsky <maximlevitsky@gmail.com>

Best regards,
	Maxim Levitsky


