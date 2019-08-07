Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BADDC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EFE12229C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFE12229C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvPeu-0000Ys-JJ
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 13:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54019)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sebastien.boeuf@intel.com>) id 1hvPeU-0008QN-5q
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sebastien.boeuf@intel.com>) id 1hvPeS-0003En-MP
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:23:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:28661)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sebastien.boeuf@intel.com>)
 id 1hvPeS-000398-Dr
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:23:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Aug 2019 10:23:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,358,1559545200"; 
 d="scan'208,223";a="192955844"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
 by fmsmga001.fm.intel.com with ESMTP; 07 Aug 2019 10:23:00 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 7 Aug 2019 10:23:00 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.6]) by
 ORSMSX112.amr.corp.intel.com ([169.254.3.253]) with mapi id 14.03.0439.000;
 Wed, 7 Aug 2019 10:23:00 -0700
From: "Boeuf, Sebastien" <sebastien.boeuf@intel.com>
To: "dgilbert@redhat.com" <dgilbert@redhat.com>
Thread-Topic: libvhost-user: Fix the VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD check
Thread-Index: AQHVTSw+I7kmgADAmUOtvYF7P6PObabwT+2AgAAETwD//42QwYAADVrn
Date: Wed, 7 Aug 2019 17:23:00 +0000
Message-ID: <1E91073893EF8F498411079ED374F912460D551D@ORSMSX115.amr.corp.intel.com>
References: <8df105774471bc72bca1397b4058ecc66d963848.camel@intel.com>
 <20190807160917.GI2867@work-vm>,
 <e99d520edca6deca1ff6b838fd43f1bde00761ee.camel@intel.com>,
 <1E91073893EF8F498411079ED374F912460D54E7@ORSMSX115.amr.corp.intel.com>
In-Reply-To: <1E91073893EF8F498411079ED374F912460D54E7@ORSMSX115.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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

From 734625fe0c031d26e612800cd9331235f58ae2e0 Mon Sep 17 00:00:00 2001=0A=
From: Sebastien Boeuf <sebastien.boeuf@intel.com>=0A=
Date: Wed, 7 Aug 2019 07:15:32 -0700=0A=
Subject: [PATCH] libvhost-user: Fix the VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD=
=0A=
 check=0A=
=0A=
Vhost user protocol features are set as a bitmask. And the following=0A=
constant VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD value is 10 because the bit=0A=
10 indicates if the features is set or not.=0A=
=0A=
The proper way to check for the presence or absence of this feature is=0A=
to shift 1 by the value of this constant and then mask it with the=0A=
actual bitmask representing the supported protocol features.=0A=
=0A=
This patch aims to fix the current code as it was not doing the=0A=
shifting, but instead it was masking directly with the value of the=0A=
constant itself.=0A=
=0A=
Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>=0A=
---=0A=
 contrib/libvhost-user/libvhost-user.c | 6 ++++--=0A=
 1 file changed, 4 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/=
libvhost-user.c=0A=
index fb61142bcc..d75a9c86ed 100644=0A=
--- a/contrib/libvhost-user/libvhost-user.c=0A=
+++ b/contrib/libvhost-user/libvhost-user.c=0A=
@@ -1112,7 +1112,8 @@ bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *=
vq, int fd,=0A=
 =0A=
     vmsg.fd_num =3D fd_num;=0A=
 =0A=
-    if ((dev->protocol_features & VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD) =3D=
=3D 0) {=0A=
+    if ((dev->protocol_features &=0A=
+        (1ULL << VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)) =3D=3D 0) {=0A=
         return false;=0A=
     }=0A=
 =0A=
@@ -2537,7 +2538,8 @@ int64_t vu_fs_cache_request(VuDev *dev, VhostUserSlav=
eRequest req, int fd,=0A=
 =0A=
     vmsg.fd_num =3D fd_num;=0A=
 =0A=
-    if ((dev->protocol_features & VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD) =3D=
=3D 0) {=0A=
+    if ((dev->protocol_features &=0A=
+        (1ULL << VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)) =3D=3D 0) {=0A=
         return -EINVAL;=0A=
     }=0A=
 =0A=
-- =0A=
2.17.1=0A=
=0A=
________________________________________=0A=
From: Boeuf, Sebastien=0A=
Sent: Wednesday, August 07, 2019 9:35 AM=0A=
To: dgilbert@redhat.com=0A=
Cc: marcandre.lureau@redhat.com; qemu-devel@nongnu.org=0A=
Subject: RE: libvhost-user: Fix the VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD che=
ck=0A=
=0A=
From 950c62dd450c8f6c3fc04269bbefa3a368bb39b6 Mon Sep 17 00:00:00 2001=0A=
From: Sebastien Boeuf <sebastien.boeuf@intel.com>=0A=
Date: Wed, 7 Aug 2019 07:15:32 -0700=0A=
Subject: [PATCH] libvhost-user: Fix the VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD=
=0A=
 check=0A=
=0A=
Vhost user protocol features are set as a bitmask. And the following=0A=
constant VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD value is 10 because the bit=0A=
10 indicates if the features is set or not.=0A=
=0A=
The proper way to check for the presence or absence of this feature is=0A=
to shift 1 by the value of this constant and then mask it with the=0A=
actual bitmask representing the supported protocol features.=0A=
=0A=
This patch aims to fix the current code as it was not doing the=0A=
shifting, but instead it was masking directly with the value of the=0A=
constant itself.=0A=
=0A=
Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>=0A=
---=0A=
 contrib/libvhost-user/libvhost-user.c | 8 +++++---=0A=
 1 file changed, 5 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/=
libvhost-user.c=0A=
index fb61142bcc..8ff387deff 100644=0A=
--- a/contrib/libvhost-user/libvhost-user.c=0A=
+++ b/contrib/libvhost-user/libvhost-user.c=0A=
@@ -71,7 +71,7 @@=0A=
=0A=
 /* The version of the protocol we support */=0A=
 #define VHOST_USER_VERSION 1=0A=
-#define LIBVHOST_USER_DEBUG 0=0A=
+#define LIBVHOST_USER_DEBUG 1=0A=
=0A=
 #define DPRINT(...)                             \=0A=
     do {                                        \=0A=
@@ -1112,7 +1112,8 @@ bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *=
vq, int fd,=0A=
=0A=
     vmsg.fd_num =3D fd_num;=0A=
=0A=
-    if ((dev->protocol_features & VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD) =3D=
=3D 0) {=0A=
+    if ((dev->protocol_features &=0A=
+        (1ULL << VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)) =3D=3D 0) {=0A=
         return false;=0A=
     }=0A=
=0A=
@@ -2537,7 +2538,8 @@ int64_t vu_fs_cache_request(VuDev *dev, VhostUserSlav=
eRequest req, int fd,=0A=
=0A=
     vmsg.fd_num =3D fd_num;=0A=
=0A=
-    if ((dev->protocol_features & VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD) =3D=
=3D 0) {=0A=
+    if ((dev->protocol_features &=0A=
+        (1ULL << VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)) =3D=3D 0) {=0A=
         return -EINVAL;=0A=
     }=0A=
=0A=
--=0A=
2.17.1=0A=
=0A=
________________________________________=0A=
From: Boeuf, Sebastien=0A=
Sent: Wednesday, August 07, 2019 9:24 AM=0A=
To: dgilbert@redhat.com=0A=
Cc: marcandre.lureau@redhat.com; qemu-devel@nongnu.org=0A=
Subject: Re: libvhost-user: Fix the VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD che=
ck=0A=
=0A=
On Wed, 2019-08-07 at 17:09 +0100, Dr. David Alan Gilbert wrote:=0A=
> * Boeuf, Sebastien (sebastien.boeuf@intel.com) wrote:=0A=
> > From 0a53a81db6dd069f9b7bcdcd386845bceb3a2ac6 Mon Sep 17 00:00:00=0A=
> > 2001=0A=
> > From: Sebastien Boeuf <sebastien.boeuf@intel.com>=0A=
> > Date: Wed, 7 Aug 2019 07:15:32 -0700=0A=
> > Subject: [PATCH] libvhost-user: Fix the=0A=
> > VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD=0A=
> >  check=0A=
> >=0A=
> > Vhost user protocol features are set as a bitmask. And the=0A=
> > following=0A=
> > constant VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD value is 10 because=0A=
> > the=0A=
> > bit=0A=
> > 10 indicates if the features is set or not.=0A=
> >=0A=
> > The proper way to check for the presence or absence of this feature=0A=
> > is=0A=
> > to shift 1 by the value of this constant and then mask it with the=0A=
> > actual bitmask representing the supported protocol features.=0A=
> >=0A=
> > This patch aims to fix the current code as it was not doing the=0A=
> > shifting, but instead it was masking directly with the value of the=0A=
> > constant itself.=0A=
> >=0A=
> > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>=0A=
>=0A=
> Nicely spotted.=0A=
>=0A=
> Two things;=0A=
>   a) I think your mail client has wrapped the lines at some point.=0A=
>   b) I think this is why the has_feature() functione exists, so does=0A=
>      that become=0A=
>=0A=
>       if (!has_feature(dev->protocol_features,=0A=
> VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD))=0A=
=0A=
Ah yes but that's because I forgot to check the patch format first :(=0A=
=0A=
I'm going to update the patch.=0A=
=0A=
Thanks,=0A=
Sebastien=0A=
>=0A=
> Dave=0A=
>=0A=
> > ---=0A=
> >  contrib/libvhost-user/libvhost-user.c | 4 ++--=0A=
> >  1 file changed, 2 insertions(+), 2 deletions(-)=0A=
> >=0A=
> > diff --git a/contrib/libvhost-user/libvhost-user.c=0A=
> > b/contrib/libvhost-=0A=
> > user/libvhost-user.c=0A=
> > index fb61142bcc..11909fb7c1 100644=0A=
> > --- a/contrib/libvhost-user/libvhost-user.c=0A=
> > +++ b/contrib/libvhost-user/libvhost-user.c=0A=
> > @@ -1112,7 +1112,7 @@ bool vu_set_queue_host_notifier(VuDev *dev,=0A=
> > VuVirtq *vq, int fd,=0A=
> >=0A=
> >      vmsg.fd_num =3D fd_num;=0A=
> >=0A=
> > -    if ((dev->protocol_features &=0A=
> > VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)=0A=
> > =3D=3D 0) {=0A=
> > +    if ((dev->protocol_features & (1ULL <<=0A=
> > VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)) =3D=3D 0) {=0A=
> >          return false;=0A=
> >      }=0A=
> >=0A=
> > @@ -2537,7 +2537,7 @@ int64_t vu_fs_cache_request(VuDev *dev,=0A=
> > VhostUserSlaveRequest req, int fd,=0A=
> >=0A=
> >      vmsg.fd_num =3D fd_num;=0A=
> >=0A=
> > -    if ((dev->protocol_features &=0A=
> > VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)=0A=
> > =3D=3D 0) {=0A=
> > +    if ((dev->protocol_features & (1ULL <<=0A=
> > VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD)) =3D=3D 0) {=0A=
> >          return -EINVAL;=0A=
> >      }=0A=
> >=0A=
> > --=0A=
> > 2.17.1=0A=
>=0A=
> --=0A=
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK=0A=

