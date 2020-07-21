Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A07BC433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C942120720
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FsQDrFZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C942120720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxo4t-0005sL-QW
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 04:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jxo4J-0005OI-6y
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:56:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49619
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jxo4H-0004ED-DV
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595321768;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=TII/fgOrGssfx5JRsD2yWOJbn3c6DV++mYvTOBpxmvM=;
 b=FsQDrFZuhKHto0X4n68Y7Siwrd4+oGj2XkT/2oCcXtoI/5KCqIQtJucGMqwfUMjVp0Y8Rb
 X6YgI81xxmpX9GsiSnkM+rhtSQnabd35okQZXO7+fk9XmFQg6gBJVCFgUaa6beiEo2i1Bv
 NZG8Kbzidj2KsraGni04g/j71z49jXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-5S7dGpRyO-qHMyPhHsnHzQ-1; Tue, 21 Jul 2020 04:56:06 -0400
X-MC-Unique: 5S7dGpRyO-qHMyPhHsnHzQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48322800688;
 Tue, 21 Jul 2020 08:56:05 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9155C5C22A;
 Tue, 21 Jul 2020 08:56:03 +0000 (UTC)
Date: Tue, 21 Jul 2020 09:56:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH for-5.2 2/3] qga/commands-posix: Rework
 build_guest_fsinfo_for_real_device() function
Message-ID: <20200721085600.GB843362@redhat.com>
References: <20200720110133.4366-1-thuth@redhat.com>
 <20200720110133.4366-3-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200720110133.4366-3-thuth@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:30:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 20, 2020 at 01:01:32PM +0200, Thomas Huth wrote:
> We are going to support non-PCI devices soon. For this we need to split
> the generic GuestDiskAddress and GuestDiskAddressList memory allocation
> and chaining into a separate function first.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qga/commands-posix.c | 65 ++++++++++++++++++++++++++++----------------
>  1 file changed, 41 insertions(+), 24 deletions(-)
> 
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 1a62a3a70d..cddbaf5c69 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -861,28 +861,30 @@ static int build_hosts(char const *syspath, char const *host, bool ata,
>      return i;
>  }
>  
> -/* Store disk device info specified by @sysfs into @fs */
> -static void build_guest_fsinfo_for_real_device(char const *syspath,
> -                                               GuestFilesystemInfo *fs,
> -                                               Error **errp)
> +/*
> + * Store disk device info for devices on the PCI bus.
> + * Returns true if information has been stored, or false for failure.
> + */
> +static bool build_guest_fsinfo_for_pci_dev(char const *syspath,
> +                                           GuestDiskAddress *disk,
> +                                           GuestPCIAddress *pciaddr,
> +                                           Error **errp)
>  {
>      unsigned int pci[4], host, hosts[8], tgt[3];
>      int i, nhosts = 0, pcilen;
> -    GuestDiskAddress *disk;
> -    GuestPCIAddress *pciaddr;
> -    GuestDiskAddressList *list = NULL;
>      bool has_ata = false, has_host = false, has_tgt = false;
>      char *p, *q, *driver = NULL;
>  #ifdef CONFIG_LIBUDEV
>      struct udev *udev = NULL;
>      struct udev_device *udevice = NULL;
>  #endif
> +    bool ret = false;
>  
>      p = strstr(syspath, "/devices/pci");
>      if (!p || sscanf(p + 12, "%*x:%*x/%x:%x:%x.%x%n",
>                       pci, pci + 1, pci + 2, pci + 3, &pcilen) < 4) {
>          g_debug("only pci device is supported: sysfs path '%s'", syspath);
> -        return;
> +        return false;
>      }
>  
>      p += 12 + pcilen;
> @@ -903,7 +905,7 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
>          }
>  
>          g_debug("unsupported driver or sysfs path '%s'", syspath);
> -        return;
> +        return false;
>      }
>  
>      p = strstr(syspath, "/target");
> @@ -929,18 +931,11 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
>          }
>      }
>  
> -    pciaddr = g_malloc0(sizeof(*pciaddr));
>      pciaddr->domain = pci[0];
>      pciaddr->bus = pci[1];
>      pciaddr->slot = pci[2];
>      pciaddr->function = pci[3];
>  
> -    disk = g_malloc0(sizeof(*disk));
> -    disk->pci_controller = pciaddr;
> -
> -    list = g_malloc0(sizeof(*list));
> -    list->value = disk;
> -
>  #ifdef CONFIG_LIBUDEV
>      udev = udev_new();
>      udevice = udev_device_new_from_syspath(udev, syspath);
> @@ -1018,21 +1013,43 @@ static void build_guest_fsinfo_for_real_device(char const *syspath,
>          goto cleanup;
>      }
>  
> -    list->next = fs->disk;
> -    fs->disk = list;
> -    goto out;
> +    ret = true;
>  
>  cleanup:
> -    if (list) {
> -        qapi_free_GuestDiskAddressList(list);
> -    }
> -out:
>      g_free(driver);
>  #ifdef CONFIG_LIBUDEV
>      udev_unref(udev);
>      udev_device_unref(udevice);
>  #endif
> -    return;
> +    return ret;
> +}
> +
> +/* Store disk device info specified by @sysfs into @fs */
> +static void build_guest_fsinfo_for_real_device(char const *syspath,
> +                                               GuestFilesystemInfo *fs,
> +                                               Error **errp)
> +{
> +    GuestDiskAddress *disk;
> +    GuestPCIAddress *pciaddr;
> +    GuestDiskAddressList *list = NULL;
> +    bool has_pci;
> +
> +    pciaddr = g_malloc(sizeof(*pciaddr));

g_new0 instead of g_malloc and thus kill the sizeof.

> +    memset(pciaddr, -1, sizeof(*pciaddr));  /* -1 means field is invalid */

Each field in GuestPCIAddress is an "int64_t", but memset works on bytes.

So you're not setting the fields to "-1" here, you're setting
each octet in the "int64_t" to -1.

> +
> +    disk = g_malloc0(sizeof(*disk));
> +    disk->pci_controller = pciaddr;
> +
> +    list = g_malloc0(sizeof(*list));
> +    list->value = disk;

g_new0 for these too.

(yes, I realize these were all pre-existing bugs)

> +
> +    has_pci = build_guest_fsinfo_for_pci_dev(syspath, disk, pciaddr, errp);
> +    if (has_pci) {
> +        list->next = fs->disk;
> +        fs->disk = list;
> +    } else {
> +        qapi_free_GuestDiskAddressList(list);
> +    }
>  }


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


