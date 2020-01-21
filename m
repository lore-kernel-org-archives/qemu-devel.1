Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C852C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCD1B24653
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TH9n9mcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD1B24653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itwhI-0008BC-MV
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 11:48:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1itweW-0005Ul-Qd
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:45:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1itweT-0005NY-AR
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:45:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52986
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1itweT-0005NL-5D
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579625116;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EadVOx6vaBDt3Dvc4C2hH8faqMEPNFUzTLMRf+b/9Dw=;
 b=TH9n9mcOcCSs6/tEJm04+70+kiqS8I6Unf2R5K8jPACBE7RsVtWEEeeFXQ2df9ZGc/VqxD
 J+/yBOZUxxsjp54YxUzw8qEVDwvPPVbBCVYvyFrAKk5vKYI4vJpUMKO1TF1gNDXjskKzfL
 v05sRhlJjH1sJcvIPAxjcv4g3Py0md8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-ESOdSp5gP5-4LDXrlJiA6w-1; Tue, 21 Jan 2020 11:45:14 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 108B1B0AC8
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 16:45:13 +0000 (UTC)
Received: from redhat.com (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 872CB60FC1;
 Tue, 21 Jan 2020 16:45:11 +0000 (UTC)
Date: Tue, 21 Jan 2020 16:45:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kashyap Chamarthy <kchamart@redhat.com>
Subject: Re: [PATCH] docs: qemu-cpu-models: Document '-noTSX' variants and
 'mds-no'
Message-ID: <20200121164508.GB635404@redhat.com>
References: <20200116173639.28524-1-kchamart@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200116173639.28524-1-kchamart@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ESOdSp5gP5-4LDXrlJiA6w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 16, 2020 at 06:36:38PM +0100, Kashyap Chamarthy wrote:
> - Add the -noTSX variants for CascadeLake and SkyLake.
>=20
> - Add a note aboute the 'mds-no' MSR.  Two confusing things about this:
>=20
>   (1) The 'mds-no' will _not_ show up in the guest's /proc/cpuinfo.
>       Rather it is used to fill in the guest's sysfs:
>=20
>         sys/devices/system/cpu/vulnerabilities/mds:Not affected
>=20
>       Paolo confirmed on IRC as such.
>=20
>   (2) There are _three_ variants[+] of CascadeLake CPUs, with different
>       stepping levels: 5, 6, and 7.  To quite wikichip.org[*]:
>=20
>         "note that while steppings 6 & 7 are fully mitigated, earlier
>         stepping 5 is not protected against MSBDS, MLPDS, nor MDSUM"
>=20
>       The above is also indicated in the Intel's manual itself[+], as
>       indicated by "No" under the three columns of MFBDS, MSBDS, and
>       MLPDS.
>=20
>       [+] https://software.intel.com/security-software-guidance/insights/=
processors-affected-microarchitectural-data-sampling
>       [*] https://en.wikichip.org/wiki/intel/microarchitectures/cascade_l=
ake#Key_changes_from_Skylake
>=20
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
> TODO:
>  - I think I also need to add a note about 'tsx-ctrl' bit.  Here too,
>    same question as above -- does it show up in /proc/cpuinfo/?
> ---
>  docs/qemu-cpu-models.texi | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>=20
> diff --git a/docs/qemu-cpu-models.texi b/docs/qemu-cpu-models.texi
> index f88a1def0d042cc25213259172a648f0a9c514dc..e6c4058e764a81988d6bc9745=
7c668cb0ad2ea37 100644
> --- a/docs/qemu-cpu-models.texi
> +++ b/docs/qemu-cpu-models.texi
> @@ -72,14 +72,30 @@ between machines, if live migration compatibility is =
required, use the newest
>  CPU model that is compatible across all desired hosts.
> =20
>  @table @option
> +
> +@item @code{Cascadelake-Server-noTSX}

Also needs

   @item @code{Cascadelake-Server}

> +
> +Intell Xeon Processor (Cascade Lake, 2019-2020), with "stepping" levels

s/Intell/Intel/

s/-2020//  as we only need the initial year of introduction IMHO.

> +6 or 7 only.  (The Cascade Lake Xeon processor with @b{stepping 5 is
> +vulnerable to MDS variants}; refer below.)
> +
> +@code{/proc/cpuinfo}.
> +
> +The @code{mds-no} bit does not show up under @code{/proc/cpuinfo}.
> +Rather it shows up under the @code{sysfs}, as
> +@code{/sys/devices/system/cpu/vulnerabilities/mds:Not affected}

We already talk about this later on we I thin kwe can trim the
/proc/cpinfo bit

>  @item @code{Skylake-Server}
>  @item @code{Skylake-Server-IBRS}
> +@item @code{Skylake-Server-noTSX-IBRS}
> =20
>  Intel Xeon Processor (Skylake, 2016)
> =20
> =20
>  @item @code{Skylake-Client}
>  @item @code{Skylake-Client-IBRS}
> +@item @code{Skylake-Client-noTSX-IBRS}
> =20
>  Intel Core Processor (Skylake, 2015)
> =20
> @@ -214,9 +230,28 @@ Must be explicitly turned on for all Intel CPU model=
s.
> =20
>  Requires the host CPU microcode to support this feature before it
>  can be used for guest CPUs.
> +
> +@item @code{mds-no}
> +
> +This is an MSR (Model-Specific Register) used by QEMU to indicate that
> +the host is @i{not} vulnerable to any of the MDS variants ([MFBDS]
> +CVE-2018-12130, [MLPDS] CVE-2018-12127, [MSBDS] CVE-2018-12126).
> +
> +Note that there are @i{three} versions of Intel's Cascade Lake
> +processor, as distinguished by their "stepping" levels 5, 6, and 7.  The
> +CPU with stepping "5" is @b{vulnerable to MDS variants}; and the CPUs
> +with steppings "6" and "7" are @b{not vulnerable} to the above mentioned
> +MDS variants.  The processor "stepping" is reported in
> +@code{/proc/cpuinfo}.
> +
> +Confusingly, the @code{mds-no} bit does not show up under
> +@code{/proc/cpuinfo} inside the guest.  Rather the kernel uses it to
> +fill in the @code{sysfs}, as
> +@code{/sys/devices/system/cpu/vulnerabilities/mds: Not affected},
> +assuming the processor is running with stepping 6 or 7.

I think we can simplify this a little - we don't need to talk
about CPU steppings - the user simply needs to know whether the
sysfs file reports vulnerable or not.

So perhaps this text:

  Recommended to inform the guest OS that the host is @i{not]
  vulnerable to any of the MDS variants ([MFBDS]
  CVE-2018-12130, [MLPDS] CVE-2018-12127, [MSBDS] CVE-2018-12126).

  This is a MSR feature rather than a CPUID feature, so will not
  appear in the Linux @code{/proc/cpuinfo} in the host or guest.

  It should only be enabled for VMs if the host reports
  @code{Not affected} in the
  @code{/sys/devices/system/cpu/vulnerabilities/mds} file.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


