Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44DEC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:36:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C37C21726
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C37C21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1CXm-0005OE-U1
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 12:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i1CV4-0003oR-VS
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i1CV3-000069-1T
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:33:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i1CV0-0008Vl-3h
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:33:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C602230013A1;
 Fri, 23 Aug 2019 16:33:09 +0000 (UTC)
Received: from work-vm (ovpn-117-244.ams2.redhat.com [10.36.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BB851001959;
 Fri, 23 Aug 2019 16:33:02 +0000 (UTC)
Date: Fri, 23 Aug 2019 17:32:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Boeuf, Sebastien" <sebastien.boeuf@intel.com>, mst@redhat.com
Message-ID: <20190823163259.GR2784@work-vm>
References: <8df105774471bc72bca1397b4058ecc66d963848.camel@intel.com>
 <20190807160917.GI2867@work-vm>
 <e99d520edca6deca1ff6b838fd43f1bde00761ee.camel@intel.com>
 <1E91073893EF8F498411079ED374F912460D54E7@ORSMSX115.amr.corp.intel.com>
 <1E91073893EF8F498411079ED374F912460D551D@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1E91073893EF8F498411079ED374F912460D551D@ORSMSX115.amr.corp.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 23 Aug 2019 16:33:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] libvhost-user: Fix the
 VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD check
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
Cc: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Boeuf, Sebastien (sebastien.boeuf@intel.com) wrote:
> From 734625fe0c031d26e612800cd9331235f58ae2e0 Mon Sep 17 00:00:00 2001
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Date: Wed, 7 Aug 2019 07:15:32 -0700
> Subject: [PATCH] libvhost-user: Fix the VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD
>  check
> 
> Vhost user protocol features are set as a bitmask. And the following
> constant VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD value is 10 because the bit
> 10 indicates if the features is set or not.
> 
> The proper way to check for the presence or absence of this feature is
> to shift 1 by the value of this constant and then mask it with the
> actual bitmask representing the supported protocol features.
> 
> This patch aims to fix the current code as it was not doing the
> shifting, but instead it was masking directly with the value of the
> constant itself.
> 
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Michael: Can you pick this up?

> ---
>  contrib/libvhost-user/libvhost-user.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index fb61142bcc..d75a9c86ed 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -1112,7 +1112,8 @@ bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,
>  
>      vmsg.fd_num = fd_num;
>  
> -    if ((dev->protocol_features & VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD) == 0) {
> +    if ((dev->protocol_features &
> +        (1ULL << VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)) == 0) {
>          return false;
>      }
>  
> @@ -2537,7 +2538,8 @@ int64_t vu_fs_cache_request(VuDev *dev, VhostUserSlaveRequest req, int fd,
>  
>      vmsg.fd_num = fd_num;
>  
> -    if ((dev->protocol_features & VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD) == 0) {
> +    if ((dev->protocol_features &
> +        (1ULL << VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)) == 0) {
>          return -EINVAL;
>      }
>  
> -- 
> 2.17.1
> 
> ________________________________________
> From: Boeuf, Sebastien
> Sent: Wednesday, August 07, 2019 9:35 AM
> To: dgilbert@redhat.com
> Cc: marcandre.lureau@redhat.com; qemu-devel@nongnu.org
> Subject: RE: libvhost-user: Fix the VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD check
> 
> From 950c62dd450c8f6c3fc04269bbefa3a368bb39b6 Mon Sep 17 00:00:00 2001
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Date: Wed, 7 Aug 2019 07:15:32 -0700
> Subject: [PATCH] libvhost-user: Fix the VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD
>  check
> 
> Vhost user protocol features are set as a bitmask. And the following
> constant VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD value is 10 because the bit
> 10 indicates if the features is set or not.
> 
> The proper way to check for the presence or absence of this feature is
> to shift 1 by the value of this constant and then mask it with the
> actual bitmask representing the supported protocol features.
> 
> This patch aims to fix the current code as it was not doing the
> shifting, but instead it was masking directly with the value of the
> constant itself.
> 
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index fb61142bcc..8ff387deff 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -71,7 +71,7 @@
> 
>  /* The version of the protocol we support */
>  #define VHOST_USER_VERSION 1
> -#define LIBVHOST_USER_DEBUG 0
> +#define LIBVHOST_USER_DEBUG 1
> 
>  #define DPRINT(...)                             \
>      do {                                        \
> @@ -1112,7 +1112,8 @@ bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,
> 
>      vmsg.fd_num = fd_num;
> 
> -    if ((dev->protocol_features & VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD) == 0) {
> +    if ((dev->protocol_features &
> +        (1ULL << VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)) == 0) {
>          return false;
>      }
> 
> @@ -2537,7 +2538,8 @@ int64_t vu_fs_cache_request(VuDev *dev, VhostUserSlaveRequest req, int fd,
> 
>      vmsg.fd_num = fd_num;
> 
> -    if ((dev->protocol_features & VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD) == 0) {
> +    if ((dev->protocol_features &
> +        (1ULL << VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)) == 0) {
>          return -EINVAL;
>      }
> 
> --
> 2.17.1
> 
> ________________________________________
> From: Boeuf, Sebastien
> Sent: Wednesday, August 07, 2019 9:24 AM
> To: dgilbert@redhat.com
> Cc: marcandre.lureau@redhat.com; qemu-devel@nongnu.org
> Subject: Re: libvhost-user: Fix the VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD check
> 
> On Wed, 2019-08-07 at 17:09 +0100, Dr. David Alan Gilbert wrote:
> > * Boeuf, Sebastien (sebastien.boeuf@intel.com) wrote:
> > > From 0a53a81db6dd069f9b7bcdcd386845bceb3a2ac6 Mon Sep 17 00:00:00
> > > 2001
> > > From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > > Date: Wed, 7 Aug 2019 07:15:32 -0700
> > > Subject: [PATCH] libvhost-user: Fix the
> > > VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD
> > >  check
> > >
> > > Vhost user protocol features are set as a bitmask. And the
> > > following
> > > constant VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD value is 10 because
> > > the
> > > bit
> > > 10 indicates if the features is set or not.
> > >
> > > The proper way to check for the presence or absence of this feature
> > > is
> > > to shift 1 by the value of this constant and then mask it with the
> > > actual bitmask representing the supported protocol features.
> > >
> > > This patch aims to fix the current code as it was not doing the
> > > shifting, but instead it was masking directly with the value of the
> > > constant itself.
> > >
> > > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> >
> > Nicely spotted.
> >
> > Two things;
> >   a) I think your mail client has wrapped the lines at some point.
> >   b) I think this is why the has_feature() functione exists, so does
> >      that become
> >
> >       if (!has_feature(dev->protocol_features,
> > VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD))
> 
> Ah yes but that's because I forgot to check the patch format first :(
> 
> I'm going to update the patch.
> 
> Thanks,
> Sebastien
> >
> > Dave
> >
> > > ---
> > >  contrib/libvhost-user/libvhost-user.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/contrib/libvhost-user/libvhost-user.c
> > > b/contrib/libvhost-
> > > user/libvhost-user.c
> > > index fb61142bcc..11909fb7c1 100644
> > > --- a/contrib/libvhost-user/libvhost-user.c
> > > +++ b/contrib/libvhost-user/libvhost-user.c
> > > @@ -1112,7 +1112,7 @@ bool vu_set_queue_host_notifier(VuDev *dev,
> > > VuVirtq *vq, int fd,
> > >
> > >      vmsg.fd_num = fd_num;
> > >
> > > -    if ((dev->protocol_features &
> > > VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)
> > > == 0) {
> > > +    if ((dev->protocol_features & (1ULL <<
> > > VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)) == 0) {
> > >          return false;
> > >      }
> > >
> > > @@ -2537,7 +2537,7 @@ int64_t vu_fs_cache_request(VuDev *dev,
> > > VhostUserSlaveRequest req, int fd,
> > >
> > >      vmsg.fd_num = fd_num;
> > >
> > > -    if ((dev->protocol_features &
> > > VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)
> > > == 0) {
> > > +    if ((dev->protocol_features & (1ULL <<
> > > VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)) == 0) {
> > >          return -EINVAL;
> > >      }
> > >
> > > --
> > > 2.17.1
> >
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

