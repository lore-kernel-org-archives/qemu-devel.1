Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8425C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 17:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD45420828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 17:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD45420828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieMwk-0004V7-Pr
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 12:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ieMvk-0003l8-Ie
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ieMvj-0004fS-78
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:34:44 -0500
Received: from 8.mo7.mail-out.ovh.net ([46.105.77.114]:49755)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ieMvj-0004ei-11
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 12:34:43 -0500
Received: from player756.ha.ovh.net (unknown [10.108.57.44])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 91CE9141F6F
 for <qemu-devel@nongnu.org>; Mon,  9 Dec 2019 18:34:40 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player756.ha.ovh.net (Postfix) with ESMTPSA id 17361C42DB58;
 Mon,  9 Dec 2019 17:34:36 +0000 (UTC)
Date: Mon, 9 Dec 2019 18:34:30 +0100
From: Greg Kurz <groug@kaod.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] virtfs: Remove the deprecated "-virtfs_synth" option
Message-ID: <20191209183430.46ec8137@bahia.w3ibm.bluemix.net>
In-Reply-To: <20191209145240.9271-1-thuth@redhat.com>
References: <20191209145240.9271-1-thuth@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9633199603446159666
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeltddguddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejheeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.77.114
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  9 Dec 2019 15:52:40 +0100
Thomas Huth <thuth@redhat.com> wrote:

> It's been marked as deprecated since QEMU v4.1, time to remove it now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Pushed to 9p-next.

>  qemu-deprecated.texi |  5 -----
>  qemu-options.hx      | 10 ----------
>  vl.c                 | 23 -----------------------
>  3 files changed, 38 deletions(-)
> 
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 2f9efb45ba..3745334e80 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -84,11 +84,6 @@ error in the future.
>  The @code{-realtime mlock=on|off} argument has been replaced by the
>  @code{-overcommit mem-lock=on|off} argument.
>  
> -@subsection -virtfs_synth (since 4.1)
> -
> -The ``-virtfs_synth'' argument is now deprecated. Please use ``-fsdev synth''
> -and ``-device virtio-9p-...'' instead.
> -
>  @subsection -numa node,mem=@var{size} (since 4.1)
>  
>  The parameter @option{mem} of @option{-numa node} is used to assign a part of
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 65c9473b73..4cf7751ade 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1468,16 +1468,6 @@ would still return entries from other devices).
>  @end table
>  ETEXI
>  
> -DEF("virtfs_synth", 0, QEMU_OPTION_virtfs_synth,
> -    "-virtfs_synth Create synthetic file system image\n",
> -    QEMU_ARCH_ALL)
> -STEXI
> -@item -virtfs_synth
> -@findex -virtfs_synth
> -Create synthetic file system image. Note that this option is now deprecated.
> -Please use @code{-fsdev synth} and @code{-device virtio-9p-...} instead.
> -ETEXI
> -
>  DEF("iscsi", HAS_ARG, QEMU_OPTION_iscsi,
>      "-iscsi [user=user][,password=password]\n"
>      "       [,header-digest=CRC32C|CR32C-NONE|NONE-CRC32C|NONE\n"
> diff --git a/vl.c b/vl.c
> index 6a65a64bfd..c0904b365b 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3374,29 +3374,6 @@ int main(int argc, char **argv, char **envp)
>                               qemu_opt_get(opts, "mount_tag"), &error_abort);
>                  break;
>              }
> -            case QEMU_OPTION_virtfs_synth: {
> -                QemuOpts *fsdev;
> -                QemuOpts *device;
> -
> -                warn_report("'-virtfs_synth' is deprecated, please use "
> -                             "'-fsdev synth' and '-device virtio-9p-...' "
> -                            "instead");
> -
> -                fsdev = qemu_opts_create(qemu_find_opts("fsdev"), "v_synth",
> -                                         1, NULL);
> -                if (!fsdev) {
> -                    error_report("duplicate option: %s", "virtfs_synth");
> -                    exit(1);
> -                }
> -                qemu_opt_set(fsdev, "fsdriver", "synth", &error_abort);
> -
> -                device = qemu_opts_create(qemu_find_opts("device"), NULL, 0,
> -                                          &error_abort);
> -                qemu_opt_set(device, "driver", "virtio-9p-pci", &error_abort);
> -                qemu_opt_set(device, "fsdev", "v_synth", &error_abort);
> -                qemu_opt_set(device, "mount_tag", "v_synth", &error_abort);
> -                break;
> -            }
>              case QEMU_OPTION_serial:
>                  add_device_config(DEV_SERIAL, optarg);
>                  default_serial = 0;


